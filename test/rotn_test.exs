defmodule RotnTest do
  use ExUnit.Case
  doctest Rotn

  describe "encode" do
    test "shifts alphanumeric and symbol characters" do
      assert Rotn.encode("AaBbCc123$%^", 13) == {:ok, "NnOoPp>?@12k"}
    end

    test "ignores empty strings" do
      assert Rotn.encode("", 13) == {:ok, ""}
    end
    test "ignores non-space whitespace" do
      assert Rotn.encode("\d\t\n ", 13) == {:ok, "\d\t\n-"}
    end

    test "returns an error tuple if encode value is not a binary" do
      assert Rotn.encode(:not_binary, 13) == {:error, "Cannot encode non-binary"}
      assert Rotn.encode({:also, "not a binary"}, 13) == {:error, "Cannot encode non-binary"}
    end

    test "returns an error tuple if shift value is not an integer" do
      assert Rotn.encode("This should work", :not_integer) == {:error, "Incompatible shift value"}
      assert Rotn.encode("But it's not", 3.1415) == {:error, "Incompatible shift value"}
    end
  end

  describe "encode!" do
    test "returns a shifted string without the tuple wrapper" do
      assert Rotn.encode!("AaBbCc123$%^", 13) == "NnOoPp>?@12k"
    end

    test "raises argument error if value cannot be encoded" do
      assert_raise ArgumentError, "Cannot encode non-binary", fn -> Rotn.encode!(:not_binary, 13) end
      assert_raise ArgumentError, "Incompatible shift value", fn -> Rotn.encode!("This should work", 3.1415) end
    end
  end

  describe "decode" do
    test "returns a meaningful string from seeming gibberish" do
      assert Rotn.decode("NnOoPp>?@12k", 13) == {:ok, "AaBbCc123$%^"}
    end

    test "still doesn't accept non-binaries" do
      assert Rotn.decode(:"7dS_*0()n", 13) == {:error, "Cannot decode non-binary"}
    end

    test "still doesn't accept for an invalid shift key" do
      assert Rotn.decode("K$xr12*", 3.1415) == {:error, "Incompatible shift value"}
    end
  end

  describe "decode!" do
    test "returns an unshifted string without the tuple wrapper" do
      assert Rotn.decode!("NnOoPp>?@12k", 13) == "AaBbCc123$%^"
    end

    test "raises errors one might come to expect by now" do
      assert_raise ArgumentError, "Cannot decode non-binary", fn -> Rotn.decode!(:"7dS_*0()n", 13) end
      assert_raise ArgumentError, "Incompatible shift value", fn -> Rotn.decode!("K$xr12", 3.1415) end
    end
  end
end
