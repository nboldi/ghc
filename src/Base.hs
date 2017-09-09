module Base (
    -- * General utilities
    module Control.Applicative,
    module Control.Monad.Extra,
    module Data.List.Extra,
    module Data.Maybe,
    module Data.Semigroup,
    module Hadrian.Utilities,

    -- * Shake
    module Development.Shake,
    module Development.Shake.Classes,
    module Development.Shake.FilePath,
    module Development.Shake.Util,

    -- * Basic data types
    module Hadrian.Package,
    module Stage,
    module Way,

    -- * Paths
    hadrianPath, configPath, configFile, sourcePath, configH, shakeFilesDir,
    generatedDir, inplaceBinPath, inplaceLibBinPath, inplaceLibPath,
    inplaceLibCopyTargets, templateHscPath, stage0PackageDbDir,
    inplacePackageDbPath, packageDbStamp
    ) where

import Control.Applicative
import Control.Monad.Extra
import Control.Monad.Reader
import Data.List.Extra
import Data.Maybe
import Data.Semigroup
import Development.Shake hiding (parallel, unit, (*>), Normal)
import Development.Shake.Classes
import Development.Shake.FilePath
import Development.Shake.Util
import Hadrian.Utilities
import Hadrian.Package

import Stage
import Way

-- | Hadrian lives in the 'hadrianPath' directory of the GHC tree.
hadrianPath :: FilePath
hadrianPath = "hadrian"

-- TODO: Move this to build directory?
-- | Path to system configuration files, such as 'configFile'.
configPath :: FilePath
configPath = hadrianPath -/- "cfg"

-- | Path to the system configuration file generated by the @configure@ script.
configFile :: FilePath
configFile = configPath -/- "system.config"

-- | Path to source files of the build system, e.g. this file is located at
-- @sourcePath -/- "Base.hs"@. We use this to track some of the source files.
sourcePath :: FilePath
sourcePath = hadrianPath -/- "src"

-- TODO: Change @mk/config.h@ to @shake-build/cfg/config.h@.
-- | Path to the generated @mk/config.h@ file.
configH :: FilePath
configH = "mk/config.h"

-- | The directory in 'buildRoot' containing the Shake database and other
-- auxiliary files generated by Hadrian.
shakeFilesDir :: FilePath
shakeFilesDir = "hadrian"

-- | The directory in 'buildRoot' containing generated source files that are not
-- package-specific, e.g. @ghcplatform.h@.
generatedDir :: FilePath
generatedDir = "generated"

-- | The directory in 'buildRoot' containing the 'Stage0' package database.
stage0PackageDbDir :: FilePath
stage0PackageDbDir = "stage0/bootstrapping.conf"

-- | Path to the inplace package database used in 'Stage1' and later.
inplacePackageDbPath :: FilePath
inplacePackageDbPath = "inplace/lib/package.conf.d"

-- | We use a stamp file to track the existence of a package database.
packageDbStamp :: FilePath
packageDbStamp = ".stamp"

-- | Directory for binaries that are built "in place".
inplaceBinPath :: FilePath
inplaceBinPath = "inplace/bin"

-- | Directory for libraries that are built "in place".
inplaceLibPath :: FilePath
inplaceLibPath = "inplace/lib"

-- | Directory for binary wrappers, and auxiliary binaries such as @touchy@.
inplaceLibBinPath :: FilePath
inplaceLibBinPath = "inplace/lib/bin"

-- ref: ghc/ghc.mk:142
-- ref: driver/ghc.mk
-- ref: utils/hsc2hs/ghc.mk:35
-- | Files that need to be copied over to 'inplaceLibPath'.
inplaceLibCopyTargets :: [FilePath]
inplaceLibCopyTargets = map (inplaceLibPath -/-)
    [ "ghc-usage.txt"
    , "ghci-usage.txt"
    , "llvm-targets"
    , "platformConstants"
    , "settings"
    , "template-hsc.h" ]

-- | Path to hsc2hs template.
templateHscPath :: FilePath
templateHscPath = "inplace/lib/template-hsc.h"
