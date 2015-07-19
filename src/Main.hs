import Rules
import Development.Shake

main = shakeArgs shakeOptions{shakeFiles="_build/"} $ do
    oracleRules     -- see module Rules.Oracles
    packageRules    -- see module Rules
    autoconfRules   -- see module Config
    configureRules  -- see module Config
    generateTargets -- see module Rules
