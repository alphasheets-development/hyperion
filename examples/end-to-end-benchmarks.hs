#!/usr/bin/env stack
-- stack --no-nix-pure runghc --package hyperion

{-# LANGUAGE OverloadedLists #-}

module Main where

import Hyperion.Benchmark
import Hyperion.Run
import Hyperion.Main
import System.Process (system)

benchmarks :: [Benchmark]
benchmarks =
    [ bgroup "roundrip"
        [ bench "ping" (nfIO (system "ping -c1 8.8.8.8 > /dev/null")) ]
    ]

main :: IO ()
main = defaultMainWith config "hyperion-example-end-to-end" benchmarks
  where
    config = defaultConfig
      { configMonoidSamplingStrategy = return $ timeBound (5 * secs) (repeat 10)
      }
    secs = 10^(9::Int) * nanos where nanos = 1
