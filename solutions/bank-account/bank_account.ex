defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  def init(state) do
    {:ok, state}
  end

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank do
    {:ok, pid} = GenServer.start_link(__MODULE__, {true, 0})

    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.cast(account, :close)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    validate_account(
      account,
      fn -> GenServer.call(account, :balance) end
    )
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    validate_account(
      account,
      fn -> GenServer.cast(account, {:update, amount}) end
    )
  end

  def validate_account(account, callback) do
    case GenServer.call(account, :status) do
      true -> callback.()
      _ -> {:error, :account_closed}
    end
  end

  def handle_call(:balance, _from, {status, balance}) do
    {:reply, balance, {status, balance}}
  end

  def handle_call(:status, _from, {status, balance}) do
    {:reply, status, {status, balance}}
  end

  def handle_cast({:update, amount}, {status, balance}) do
    {:noreply, {status, balance + amount}}
  end

  def handle_cast(:close, {_, balance}) do
    {:noreply, {false, balance}}
  end
end