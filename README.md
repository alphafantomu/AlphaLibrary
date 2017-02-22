# About
AlphaLibrary is a module loader, that runs sublibaries installed in the libary. The Library is a database containing sublibaries that 
contain code for the server and client, which is intended to support game development on Roblox.

## Features 
* **Simple Loading** - AlphaLibrary can be easily used and installed.
  * Can be easily installed, just paste [Installer code]() into studio command bar.
  * Loader only contains 65 lines!
* **Require to-load** - Libaries will not load unless, requested to. This won't impact game performance.
* **Built for Roblox** - Made specifically for Roblox.
* **Open Source** - AlphaLibrary is an open source, you can use all the modules you want!

# Get AlphaLibrary
In-order to install AlphaLibrary, paste the code below in your studio command bar.

```lua
  local Http = game:service'HttpService';
  local SavedHttp = Http.HttpEnabled;
  Http.HttpEnabled = true;
  local Install = 'https://raw.githubusercontent.com/alphafantomu/AlphaLibrary/master/Install.lua';
  loadstring(Http:GetAsync(Install))();
  Http.HttpEnabled = SavedHttp;
```
## What you just got:

* The main library module "AlphaLibrary" in 'ReplicatedStorage'
* All the modules in 'game' or 'DataModel'

Please note that installing AlphaLibrary will **not** change any behavior in your game. AlphaLibrary does not affect preexisting code.

# Updating AlphaLibrary

To update AlphaLibrary, make sure to **back up your place file** and run the install code above. Existing code will not be tempered
with, AlphaLibrary's default libaries will be overriden.

## Usage

To load AlphaLibrary on your server and client, use the following code:

```lua
  local ReplicatedStorage = game:service'ReplicatedStorage';
  local Library = require(ReplicatedStorage:WaitForChild('AlphaLibrary', 10));
  
```
### Loading a Library

Usually using Library:LoadLibrary(argumentOne, argumentTwo), argumentTwo should be either 0 or 1, 0 making just search for a library 
of that name, 1 being directly accessing the library.
```lua
  Library:LoadLibrary('library_example', 0)
```

Currently, an example cannot be made as the Library got revamped.

## Update / Change Log

For help or questions, you can contact me @[hyperionGM](https://www.roblox.com/users/21905318/profile). 
You might have to follow me to message me!

##### February 22nd, 2017 [0.2.0.0]
  - Revamped the entire module system, better and easier installation.
  - Libaries currently have not be implemented.

######
P.S I didn't know how to do text formatting, so I looked at Nevermore library as a guide. You can find the Nevermore Library here! 
[NevermoreEngine](https://github.com/Quenty/NevermoreEngine)
