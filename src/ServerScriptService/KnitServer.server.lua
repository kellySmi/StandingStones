local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
-- Load all services (the Deep version scans all descendants of the passed instance):
Knit.AddServicesDeep(script.Parent.Services)

Knit.Start():catch(warn)