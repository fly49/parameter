defmodule Parameter.Schema.CompilerTest do
  use ExUnit.Case

  alias Parameter.Field
  alias Parameter.Schema.Compiler

  describe "compile_schema!/1" do
    test "compile empty schema should work" do
      assert [] == Compiler.compile_schema!(%{})
    end

    test "compile simple schema" do
      assert [
               %Field{
                 name: :first_name,
                 key: "firstName",
                 required: true
               }
             ] ==
               Compiler.compile_schema!(%{
                 first_name: [key: "firstName", required: true]
               })
    end
  end

  describe "validate_nested_opts/1" do
    test "don't compile options for nested fields" do
      assert_raise ArgumentError, "on_load cannot be used on nested fields", fn ->
        Compiler.validate_nested_opts!(on_load: nil)
      end

      assert_raise ArgumentError, "on_dump cannot be used on nested fields", fn ->
        Compiler.validate_nested_opts!(on_dump: nil)
      end

      assert_raise ArgumentError, "validator cannot be used on nested fields", fn ->
        Compiler.validate_nested_opts!(validator: nil)
      end

      assert [other_opts: nil] == Compiler.validate_nested_opts!(other_opts: nil)
    end
  end
end
