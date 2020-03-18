;Copyright 2020 by M. Chowdhury. This code is copyrighted
;If you want to used this code or a later version of it
;then you are required to contact the author for permission
;note that this working code is not properly commented /properly finished and
;is an older version of the code used in the game.
;Uploaded 18/3/2020


PrintCharString equ &00A2;
LF	equ	&0A
CR	equ	&0D  
Printchar equ    &00A2
dummyvalue equ 0
TOLERANCE equ 8 
NOCOLLISION equ 123 ; 
COLLISION equ 1 ;

CHPUT	equ	&00A2	
ENASLT	equ	&0024
INIT32	equ	&006F
RSLREG	equ	&0138
BASICS equ &8000
POKEVR	equ	&004D
PEEKVR   equ	&004A
LOCATE	equ	&00C6
GETKEY	equ	&009F
GETINSTANTKEY	equ	321
 

VARMUSICTIMER equ	50000 ;
VARGEN	equ	50001;
VARMAN	equ	50002 ;
VARBOARDACROSS	equ	50003;
VARBOARDDOWN	equ	50004; 
VARTEMP	equ	50005; 
VARTEMP2	equ	50006; 
VARNEAR equ 50007;
VARP1COLLIDE equ 50008;
VARP1SCORE equ 50009;
VARP1FIRE equ 50010
VARH	equ	50050;
VARL	equ	50051;
 
SPRITEBASE0 equ 14336 ;
SPRITEBASE1 equ 14344 ;
SPRITEBASE2 equ 14352 ;
SPRITEBASE3 equ 14360 ;
SPRITEBASE4 equ 14368 ;
SPRITEBASE5 equ 14376 ;
SPRITEBASE6 equ 14384 ;
SPRITEBASE7 equ 14392 ;
SPRITEBASE8 equ 14400 ;
SPRITEBASE9 equ 14408 ;
COLLIDE equ 318;

SPRITE0X equ 6972;
SPRITE0Y equ 6973;
SPRITE0NUM equ 6974;
SPRITE0COL equ 6975;

SPRITE1X equ 6976;
SPRITE1Y equ 6977;
SPRITE1NUM equ 6978;
SPRITE1COL equ 6979;

SPRITE2X equ 6980;
SPRITE2Y equ 6981;
SPRITE2NUM equ 6982;
SPRITE2COL equ 6983;

SPRITE3X equ 6984;
SPRITE3Y equ 6985;
SPRITE3NUM equ 6986;
SPRITE3COL equ 6987;


SPRITE4X equ 6988;
SPRITE4Y equ 6989;
SPRITE4NUM equ 6990;
SPRITE4COL equ 6991;

SPRITE5X equ 6992;
SPRITE5Y equ 6993;
SPRITE5NUM equ 6994;
SPRITE5COL equ 6995;

SPRITE6X equ 6996;
SPRITE6Y equ 6997;
SPRITE6NUM equ 6998;
SPRITE6COL equ 6999;

SPRITE7X equ 7000;
SPRITE7Y equ 7001;
SPRITE7NUM equ 7002;
SPRITE7COL equ 7003;

SPRITE8X equ 7004;
SPRITE8Y equ 7005;
SPRITE8NUM equ 7006;
SPRITE8COL equ 7007;

SPRITE9X equ 7008;
SPRITE9Y equ 7009;
SPRITE9NUM equ 7010;
SPRITE9COL equ 7011;

SPRITE10X equ 7012;
SPRITE10Y equ 7013;
SPRITE10NUM equ 7014;
SPRITE10COL equ 7015;

SPRITESOFFSETDOWN equ 112;
SPRITEMIN equ 8;
SPRITEMAX equ 247;the right most value of sprite on screen
SPRITEHEIGHT equ 8;sprite is 8d pixels high or 16d pixels high whare using 8 
SPRITEINITACROSSUNIT equ 12;this sets the initial spacing between the sprites 

LIGHTRED equ 9;
LIGHTYELLOW equ 11;
LIGHTGREEN equ 3;
LIGHTBLUE equ 5;

DARKRED equ 6;
DARKYELLOW equ 10;
DARKGREEN equ 12;
DARKBLUE equ 4;
BLACK equ 1;


INKCOLOUR equ &0F3E9;onk the the colour of the text
BACKGROUNDCOLOUR equ &0F3EA;
BORDERCOLOUR equ &0F3EB;


PageSize equ &4000	; 16kB

LINL32	equ	&0F3AF
EXPTBL	equ	&0FCC1		; 

REG1SOUND equ &00A0
REG2SOUND equ &00A1



	org &4000
	db "AB"
	dw INIT
	db 00,00,00,00,00,00




INIT:	; Program code entry point label
	ld a,32
	call Printchar
 
	ld	a,32
	ld	(LINL32),a	; 32 columns
	
	ld	a,LIGHTYELLOW;grey 
	ld	(BACKGROUNDCOLOUR),a	; 32 columns
	
	ld	a,LIGHTRED;grey
	ld	(BORDERCOLOUR),a	; 32 columns
	
	
		ld	a,5;white
	ld	(INKCOLOUR),a	; 32 columns
	
	
	call	INIT32		; SCREEN 1


	call	RSLREG
	rrca
	rrca
	and	3	
	ld	c,a
	ld	b,0
	ld	hl,EXPTBL
	add	hl,bc
	ld	a,(hl)
	and	&80
	or	c
	ld	c,a
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	and	&0C
	or	c
	ld	h,&080
	call	ENASLT		



	ld a,1
 	   di
  	  out (#99),a
   	 ld a, 128
    	ei
    	out (#99),a

	ld a,32
	call Printchar
	ld a,32
	call Printchar
	ld a,32
	call Printchar
	ld a,32
	call Printchar
	ld a,32
	call Printchar
	ld hl,VARMAN;
	ld a,1;
	ld (HL),a
	call Loadsprite0
	call Loadsprite1
	

   jp initsprites

      macro Readp1score,dummy15
	ld hl,VARP1SCORE;
	ld a,(HL);
      endm;


     macro ResetP1score,dummy28
	ld hl,VARP1SCORE;
	ld (HL),0;
     endm;

     macro Storep1scoreinc,demmy18
	Readp1score 0;
	inc a;
	ld hl,VARP1SCORE;
	ld (HL),a;
     endm;


      macro Readp1collide,dummy15
	ld hl,VARP1COLLIDE;
	ld a,(HL);
      endm;


     macro Storep1collide,colldummy
	ld hl,VARP1COLLIDE;
	ld (HL),a;
     endm;

resetp1score:
    ResetP1score 0;
    ret

readp1score:
    Readp1score 0;
    ret

Storep1scoreinc:
    Storep1scoreinc 0;
    ret


 


      macro ReadP1FIREFLAG,dummy12
	ld hl,VARP1FIRE;
	ld a,(HL);
      endm;


     macro StoreP1FIREFLAG,thevalue
	ld hl,VARP1FIRE;
	ld a,\thevalue;
	ld (HL),a;stores the value in the memory
     endm;


;------------------------------------------------------
Vpeek:
 	call PEEKVR;
  ret
;------------------------------------------------------
Vpoke:
	call POKEVR;
  ret
;------------------------------------------------------

   macro Resetscorebase255,dummy96
	StoreL 0;
	StoreH 0;
     endm;

  macro INCscorebase255,dummy97
	ReadL 0;
	ld d,a;becuase above corrupts H so use d as temp variable
	ReadH 0;
	ld h,a;
	ld l,d;
	ld b,0;
	ld c,1;
	add hl,bc;
	ld d,h;becuase below corrupts H so use d as temp variable
	ld a,l;
	StoreL a;/stores L
	ld a,d;		
	StoreH a;stores H
 	endm

	macro loadscorebase255intoHL,dummy99
	ReadL 0;
	ld d,a;becuase above corrupts H so use d as temp variable
	ReadH 0;
	ld h,a;
	ld l,d;
	endm

	macro Displayscorebase255,dummy98
	Locatecursor 8 , 8; this is a macro to set location
	ReadH 0;
	call DisplayAindecimal; this diplays at chosen above location

	Locatecursor 12 , 8; this is a macro to set location
	ReadL 0;
	call DisplayAindecimal; this diplays at chosen above location
	endm
;---------------------------------------------------------------------------
Loadsprite0:
 	ld hl,SPRITEBASE0;
 	ld a,32; 1st byte
 	call Vpoke;
 	inc hl;2nd byte
 	ld a,80;
 	call Vpoke;
 	 inc hl;3rd byte
 	ld a,136;
 	call Vpoke;
  	inc hl;4th byte
 	ld a,136;
 	call Vpoke;
  	inc hl;5th byte
 	ld a,248;
 	call Vpoke;
  	inc hl;6th byte
 	ld a,136;
 	call Vpoke;
  	inc hl;
 	ld a,136;7th byte
 	call Vpoke;
 	inc hl;
 	ld a,0;8th byte
 	call Vpoke;
 
  	ld hl,SPRITE0X;
  	ld a,SPRITESOFFSETDOWN+SPRITEHEIGHT*1;xpos
  	call Vpoke;
   	ld hl,SPRITE0Y;
  	ld a,SPRITEINITACROSSUNIT*1;ypos
  	ld a,0;
   	call Vpoke;
    	ld hl,SPRITE0NUM;
  	ld a,0;spritenumber
   	call Vpoke;
   	ld hl,SPRITE0COL;
  	ld a,DARKRED;colour
   	call Vpoke;
  	inc hl;
   ret
		; Call the routine Print below

;---------------------------------------------------
 Loadsprite1:;player 2
 	ld hl,SPRITEBASE1;
 	ld a,32; 1st byte
 	call Vpoke;
 	inc hl;2nd byte
 	ld a,80;
 	call Vpoke;
  	inc hl;3rd byte
 	ld a,136;
 	call Vpoke;
  	inc hl;4th byte
 	ld a,136;
 	call Vpoke;
  	inc hl;5th byte
 	ld a,248;
 	call Vpoke;
  	inc hl;6th byte
 	ld a,136;
 	call Vpoke;
  	inc hl;
 	ld a,136;7th byte
 	call Vpoke;
  	 inc hl;
 	ld a,0;8th byte
 	call Vpoke;
 
  	ld hl,SPRITE1X;
  	ld a,SPRITESOFFSETDOWN+SPRITEHEIGHT*2;xpos
  	call Vpoke;
   	ld hl,SPRITE1Y;
  	ld a,SPRITEINITACROSSUNIT*1;ypos
	ld a,0;
   	call Vpoke;
    	ld hl,SPRITE1NUM;
  	ld a,1;spritenumber
   	call Vpoke;
   	ld hl,SPRITE1COL;
  	ld a,DARKBLUE;colour
   	call Vpoke;
  	inc hl;
   ret



resetYsprite0:
	ld a,180;
  ret
resetXsprite0:
	ld a,180;
  ret


Movesprite0:
	ld hl,SPRITE0X;
	call Vpeek;now a contains the current x value
	dec a;
	cp 10;
	call z,resetXsprite0;
	ld hl,SPRITE0X;
	call Vpoke;
   ret
;--------------------------------------------
     macro Movespriteup,SPRITE0X
	ld hl,\SPRITE0X;
	call Vpeek;now a contains the current x value
	dec a;
	cp 10;
	call z,resetXsprite0;
	ld hl,\SPRITE0X;
	call Vpoke;
     endm;

;--------------------------------------------
     macro Movespriteright,SPRITE0Y
	ld hl,\SPRITE0Y;
	call Vpeek;now a contains the current x value
	dec a;
	cp 10;
	call z,resetYsprite0;
	ld hl,\SPRITE0Y;
	call Vpoke;
     endm;



;------------------------------------------------------

     macro Moveenemyspriteup,SPRITE0X , SPEED
	ld hl,\SPRITE0X;
	call Vpeek;now a contains the current x value
	sub a,\SPEED;
	cp 10;
	call z,resetXsprite0;
	ld hl,\SPRITE0X;
	call Vpoke;
     endm;

;--------------------------------------------
     macro Moveenemyspriteright,SPRITE0Y
	ld hl,\SPRITE0Y;
	call Vpeek;now a contains the current x value
	dec a;
	cp 10;
	call z,resetYsprite0;
	ld hl,\SPRITE0Y;
	call Vpoke;
     endm;

;--------------------------------------------
     macro p1fire,SPRITE0Y
	ld hl,\SPRITE0Y;
	call Vpeek;
	add a,4;
	cp 210;
	call z,p1fireflagsetfalse;
	cp 210;
	call z,resetYsprite0;
	cp 211;
	call z,p1fireflagsetfalse;
	cp 211;
	call z,resetYsprite0;
	cp 212;
	call z,p1fireflagsetfalse;
	cp 212;
	call z,resetYsprite0;
	cp 213;
	call z,p1fireflagsetfalse;
	cp 213;
	call z,resetYsprite0;
	ld hl,\SPRITE0Y;
	call Vpoke;
     endm;

;------------------------------------------------------
moveit:
   Movespriteup SPRITE0X
 ret

movep1up:
   Movespriteup SPRITE0X
 ret

movep1right:
   Movespriteright SPRITE0Y
 ret

movep1bullet:
    p1fire SPRITE0Y
  ret

p1fireflagsettrue:
	StoreP1FIREFLAG 1
  ret

p1fireflagsetfalse:
	StoreP1FIREFLAG 0
  ret

ReadMAN:
	ld hl,VARMAN;
	ld a,(HL);
   ret


;---------------------------------------------------
     
       macro Loadsprite,thesprnum , thesprcol , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8  , SPRITEHEIGHT , SPRITEINITACROSSUNIT , SPRITE1NUM , SPRITE1COL , SPRITEBASE , SPRITE1X , SPRITE1Y  
 	ld hl,\SPRITEBASE;
 	ld a,\1; 1st byte
 	call Vpoke;
 	inc hl;2nd byte
 	ld a,\2;
 	call Vpoke;
  	inc hl;3rd byte
 	ld a,\3;
 	call Vpoke;
  	inc hl;4th byte
 	ld a,\4;
 	call Vpoke;
  	inc hl;5th byte
 	ld a,\5;
 	call Vpoke;
  	inc hl;6th byte
 	ld a,\6;
 	call Vpoke;
  	inc hl;
 	ld a,\7;7th byte
 	call Vpoke;
  	 inc hl;
 	ld a,\8;8th byte
 	call Vpoke ;set the attributes x,y,spriteno,colour
  	ld hl,\SPRITE1X;
  	ld a,\SPRITEHEIGHT;xpos
  	call Vpoke;
   	ld hl,\SPRITE1Y;
  	ld a,\SPRITEINITACROSSUNIT*1;ypos
   	call Vpoke;
    	ld hl,\SPRITE1NUM;
  	ld a,\thesprnum;spritenumber
   	call Vpoke;
   	ld hl,\SPRITE1COL;
  	ld a,\thesprcol;colour
   	call Vpoke;
  	inc hl;
       endm

     macro StoreMAN,thevalue , secondval
	ld hl,VARMAN;
	ld a,\thevalue;
	ld a,\secondval;
	ld (HL),a;stores the value in the memory
     endm;
 
      macro ReadGEN,dummy1
	ld hl,VARGEN;
	ld a,(HL);
      endm;


     macro StoreGEN,thevalue
	ld hl,VARGEN;
	ld a,\thevalue;
	ld (HL),a;stores the value in the memory
     endm;


      macro ReadH,dummy1
	ld hl,VARH;
	ld a,(HL);
      endm;


     macro StoreH,thevalueH
	ld hl,VARH;
	ld a,\thevalueH;
	ld (HL),a;stores the value in the memory
     endm;

      macro ReadL,dummy1
	ld hl,VARL;
	ld a,(HL);
      endm;


     macro StoreL,thevalueH
	ld hl,VARL;
	ld a,\thevalueH;
	ld (HL),a;stores the value in the memory
     endm;
;--------------------------------------------------
     macro Show16bitscoretest,dummy100
	;scores using 16 bits are implement but not called by the maingameloop 
	INCscorebase255 0; increases the score by 1	max score is max value HL can hold
	Displayscorebase255 0; this diaplys the score in 2 digits in base 255 on the screen

	Locatecursor 9 , 9; 
	loadscorebase255intoHL 0;
	call DisplayHLindecimal;
     endm

;-------------------------------------
     macro Locatecursor,across, down
	ld h,\across; h  is across in screen 1
	ld l,\down;
	call LOCATE;
     endm
;------------------------------------------------------
  DisplayHLindecimal:
	ld	bc,-10000
	call	NumOne
	ld	bc,-1000
	call	NumOne
	ld	bc,-100
	call	NumOne
	ld	c,-10
	call	NumOne
	ld	c,-1
NumOne:	ld	a,'0'-1
NumTwo:	inc	a
	add	hl,bc
	jr	c,NumTwo
	sbc	hl,bc
	call CHPUT;
	ret 
;-----------------------------------------
 DisplayAindecimal:
	ld	c,-100
	call	Na1
	ld	c,-10
	call	Na1
	ld	c,-1
Na1:	ld	b,'0'-1
Na2:	inc	b
	add	a,c
	jr	c,Na2
	sub	c		;works as add 100/10/1
	push af		;safer than ld c,a
	ld	a,b		;char is in b
		call CHPUT;	;plot a char. Replace with bcall(_PutC) or similar.
	pop af		;safer than ld a,c
	ret
 
	

     macro spritecollision,NUM0 , NUM1 , SPRITE0X , SPRITE1X , SPRITE0Y , SPRITE1Y
	ld hl,\SPRITE1X;
	call Vpeek;
	ld d,a;
	ld b,0;
	ld c,0;
  	ld hl,\SPRITE0X;
	call Vpeek;
	ld b,a;
	ld hl,\SPRITE1X;
	call Vpeek;
	sub a,b;
	call absA;
	StoreGEN a;

	ld b,0;
	ld c,0;
  	ld hl,\SPRITE0Y;
	call Vpeek;
	ld b,a;
	ld hl,\SPRITE1Y;
	call Vpeek;
	sub a,b;
	call absA;
	ld c,a;

	ReadGEN dummyvalue;//in a, GEN is used to store cumaltive tolearance
	add a,c;
	sub a,TOLERANCE;
	call c, collflagaddscore; this changes d and a

	call readp1score;
	Locatecursor 2 , 2; this is a macro to set location
	call DisplayAindecimal; this diplays at chosen above location 

	ld hl,\SPRITE1X;
  	ld a,d;xpos reload -changed if d changed nn collval below
  	call Vpoke;	

    endm


 

collflagaddscore:
	call c,Storep1scoreinc;
	ld a,0;
	ld d,254; reset the sprite vertically
	ret			
;------------------------------

Stopsprite:
   ld a,0;
   StoreMAN 0,0;
   ret

   macro delay,delayvalue
delay:
 ld b,1;  use registers a and b to give a delay built out of a double loop b=1 gives shortest delay
delayouter: ; change below for slower-ld b,1 above is used instead of NOP
 ld b,\delayvalue;b cant be zero since b=1 is smallest value
delayoutersub:
delayinner:
 ld a,128;a can take any value between 1 and 255 here
delayinnersub: dec a;
 jp nz,delayinnersub;
 dec b;
 ld a,b;
 jp nz,delayoutersub;
  endm
;----------------------------------------
Printstring:
	ld a,(hl)		;Load the next character
	cp 255			
	ret z			;Return if it's 255
	inc hl			;Otherwise print it to screen
	call Printchar 		;Do it again
    jr Printstring
	       
P1score: db 'P1 Score',255	;String - ends with 255
P2score: db 'P2 Score',255	;String - ends with 255
;------------------------------------------------------

Locateposver2:
	ld h,16; h  is across in screen 1
	ld l,12;
	call LOCATE;
	ret
;--------------------------------------------------------------
;--------------------------------------------------------------
DispAindecimalver2:
 	push af;
 	call Locateposver2;defines where to show contents of A
 	pop af;
	ld	c,-100
	call	Na1ver2
	ld	c,-10
	call	Na1ver2
	ld	c,-1
Na1ver2:	ld	b,'0'-1
Na2ver2:	inc	b
	add	a,c
	jr	c,Na2ver2
	sub	c	
	push af		
	ld	a,b		
		call CHPUT
	pop af		
	ret
   absA:; gives the absolute value
        or a
        ret p
        neg
        ret
	

initsprites: 
	StoreP1FIREFLAG 0;
	ResetP1score 0;
	;will add in a  loop later to shorten the code
	Loadsprite 2,DARKGREEN,255,1,15,15 ,2,1,1,255,100,30,SPRITE2NUM,SPRITE2COL,SPRITEBASE2,SPRITE2X,SPRITE2Y
        Loadsprite 3,BLACK,255,1,15,15 ,2,1,1,255,100,55,SPRITE3NUM,SPRITE3COL,SPRITEBASE3,SPRITE3X,SPRITE3Y
	Loadsprite 4,DARKGREEN,255,1,15,15 ,2,1,1,255,100,80,SPRITE4NUM,SPRITE4COL,SPRITEBASE4,SPRITE4X,SPRITE4Y
       Loadsprite 5,DARKGREEN,255,1,15,15 ,2,1,1,255,100,105,SPRITE5NUM,SPRITE5COL,SPRITEBASE5,SPRITE5X,SPRITE5Y

	Loadsprite 6,DARKGREEN,255,1,15,15 ,2,1,1,255,130,130,SPRITE6NUM,SPRITE6COL,SPRITEBASE6,SPRITE6X,SPRITE6Y
        Loadsprite 7,DARKGREEN,255,1,15,15 ,2,1,1,255,130,155,SPRITE7NUM,SPRITE7COL,SPRITEBASE7,SPRITE7X,SPRITE7Y
	Loadsprite 8,DARKGREEN,255,1,15,15 ,2,1,1,255,130,180,SPRITE8NUM,SPRITE8COL,SPRITEBASE8,SPRITE8X,SPRITE8Y
        Loadsprite 9,DARKGREEN,255,1,15,15 ,2,1,1,255,130,205,SPRITE9NUM,SPRITE9COL,SPRITEBASE9,SPRITE9X,SPRITE9Y
	
	Locatecursor 1 , 1;
        ld hl,P1score;
        call Printstring;
	
	Resetscorebase255 0;

   jp mainloop:

mainloop:
	delay 40;
   	ld a,8;
  	call GETINSTANTKEY; A now stores answer
	bit 4,a;left key  p60
	call z, movep1up;
	
	
        ld a,8;//need to load a with 8 to detect key
  	call GETINSTANTKEY; A now stores answer
	bit 7,a;
	call z, movep1right;


        ld a,8;//need to load a with 8 to detect key
  	call GETINSTANTKEY; A now stores answer
	bit 5,a;up key
	call z, p1fireflagsettrue;
	
        ReadP1FIREFLAG 0;//0 is dummy
	cp 1;
	call z, movep1bullet;

	;will add in a  loop later to shorten the code
	spritecollision 0,1,SPRITE0X, SPRITE1X, SPRITE0Y, SPRITE1Y
	spritecollision 0,2,SPRITE0X, SPRITE2X, SPRITE0Y, SPRITE2Y
        spritecollision 0,3,SPRITE0X, SPRITE3X, SPRITE0Y, SPRITE3Y
        spritecollision 0,4,SPRITE0X, SPRITE4X, SPRITE0Y, SPRITE4Y
        spritecollision 0,5,SPRITE0X, SPRITE5X, SPRITE0Y, SPRITE5Y
        spritecollision 0,6,SPRITE0X, SPRITE6X, SPRITE0Y, SPRITE6Y
        spritecollision 0,7,SPRITE0X, SPRITE7X, SPRITE0Y, SPRITE7Y
        spritecollision 0,8,SPRITE0X, SPRITE8X, SPRITE0Y, SPRITE8Y
        spritecollision 0,9,SPRITE0X, SPRITE9X, SPRITE0Y, SPRITE9Y
        ;will add in a  loop later to shorten the code
	Moveenemyspriteup SPRITE2X,1
	Moveenemyspriteup SPRITE3X,2
	Moveenemyspriteup SPRITE4X,1
	Moveenemyspriteup SPRITE5X,2
	Moveenemyspriteup SPRITE6X,1
	Moveenemyspriteup SPRITE7X,2
	Moveenemyspriteup SPRITE8X,1
	Moveenemyspriteup SPRITE9X,2

	;Show16bitscoretest 0; this os an "upgrade" for the cuurent socore (using 8 bits) to 16 bits scores
	; or simply put using the above allows larger scores to be used
					
dontmove:
    jp mainloop
        org &C000 
