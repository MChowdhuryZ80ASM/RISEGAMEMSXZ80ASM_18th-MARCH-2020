# RISEGAMEMSXZ80ASM_18th-MARCH-2020

The MSX-1 8 bit home computers were conceived and sold in the early 1980s. This repository is for a small MSX-1 game I wrote, called Rise, in pure assembly language (i.e. it does not use BASIC or MSX BASIC). The game would be too slow to create in MSX-BASIC, or a similar high level language, one reason is because there are a lot of sprites to move on the screen- see the screenshot of the game below. In other words using MSX BASIC, or a similar high level language, it is impossible to make the game and have it running at the speed it does.

![Image description](https://github.com/MChowdhuryZ80ASM/RISEGAMEMSXZ80ASM_18th-MARCH-2020/blob/master/rimage3.JPG)

Another problem or limitation, which can be overcome using pure assembly , is the MSX1 video chip can not display more than 4 complete sprites on a scanline. However because the way I designed the game we can see 10 sprites on the screen without easy to notice visual artifacts.

Another limitation, which can be overcome using pure assembly , is the MSX1 video chip can only detect a collision between any two displayed sprites but it can't tell the programmer which two sprites have collided. In other words the video chip cannot distinguish if the "player sprite" collides with "two or more types of game defined sprites". These limitations apply to my game where the player 1 or 2 sprite collides with a black or non-black sprite. I overcame these MSX-1 video hardware limitations by using a custom pure assembly code for sprite collision.

Sound is only minimally implemented because it is only a beep when when some sprites collides. Adding more sound or music to the game is easy to do. We can think of this small game as a sprite tech-demo to show how to get past the video hardware limitations of the MSX-1 using pure assembly laguage. The game is given here as a .ROM file; the ROM can be played on an MSX-1 machine emulator. A ROM file is basically equivalent to a MSX-1 game cartridge.

Player 1 keys are left, right and up.
Player 2 keys are 1,2, and 3.

The working assembly code given for the game is actually an earlier version of the game (where the graphics are replaced by characters or numbers). In the final version of the code some of the macros and some of the subroutines are more complcated than the earlier versions. When I have properly commented and finised the final code I  will upload it-or if you want the latest version of the code then contact me. I may possibly add more levels or features to the game.

