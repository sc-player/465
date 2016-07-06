#!/usr/bin/env ruby
require 'ffi'

module CacaRuby
  extend FFI::Library
  ffi_lib FFI::Library::caca
end 
