From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 03/33] docs: input/amijoy: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:46 -0300
Message-ID: <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file contains lots of tables, but none formatted using
the ReST syntax. Adjust them to match the ReST syntax
and add a title for the document.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/amijoy.txt | 165 +++++++++++++++++++++++++++++------------
 1 file changed, 118 insertions(+), 47 deletions(-)

diff --git a/Documentation/input/amijoy.txt b/Documentation/input/amijoy.txt
index 7dc4f175943c..25f516888a29 100644
--- a/Documentation/input/amijoy.txt
+++ b/Documentation/input/amijoy.txt
@@ -1,67 +1,100 @@
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Amiga joystick extensions
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+
 Amiga 4-joystick parport extension
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 Parallel port pins:
 
- (2) - Up1	 (6) - Up2
- (3) - Down1	 (7) - Down2
- (4) - Left1	 (8) - Left2
- (5) - Right1	 (9) - Right2
-(13) - Fire1	(11) - Fire2
-(18) - Gnd1	(18) - Gnd2
+
+=====  ======== ====   ==========
+Pin    Meaning  Pin    Meaning
+=====  ======== ====   ==========
+ 2     Up1	 6     Up2
+ 3     Down1	 7     Down2
+ 4     Left1	 8     Left2
+ 5     Right1	 9     Right2
+13     Fire1	11     Fire2
+18     Gnd1	18     Gnd2
+=====  ======== ====   ==========
 
 Amiga digital joystick pinout
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(1) - Up
-(2) - Down
-(3) - Left
-(4) - Right
-(5) - n/c
-(6) - Fire button
-(7) - +5V (50mA)
-(8) - Gnd
-(9) - Thumb button
+
+=== ============
+Pin Meaning
+=== ============
+1   Up
+2   Down
+3   Left
+4   Right
+5   n/c
+6   Fire button
+7   +5V (50mA)
+8   Gnd
+9   Thumb button
+=== ============
 
 Amiga mouse pinout
 ~~~~~~~~~~~~~~~~~~
-(1) - V-pulse
-(2) - H-pulse
-(3) - VQ-pulse
-(4) - HQ-pulse
-(5) - Middle button
-(6) - Left button
-(7) - +5V (50mA)
-(8) - Gnd
-(9) - Right button
+
+=== ============
+Pin Meaning
+=== ============
+1   V-pulse
+2   H-pulse
+3   VQ-pulse
+4   HQ-pulse
+5   Middle button
+6   Left button
+7   +5V (50mA)
+8   Gnd
+9   Right button
+=== ============
 
 Amiga analog joystick pinout
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(1) - Top button
-(2) - Top2 button
-(3) - Trigger button
-(4) - Thumb button
-(5) - Analog X
-(6) - n/c
-(7) - +5V (50mA)
-(8) - Gnd
-(9) - Analog Y
+
+=== ==============
+Pin Meaning
+=== ==============
+1   Top button
+2   Top2 button
+3   Trigger button
+4   Thumb button
+5   Analog X
+6   n/c
+7   +5V (50mA)
+8   Gnd
+9   Analog Y
+=== ==============
 
 Amiga lightpen pinout
 ~~~~~~~~~~~~~~~~~~~~~
-(1) - n/c
-(2) - n/c
-(3) - n/c
-(4) - n/c
-(5) - Touch button
-(6) - /Beamtrigger
-(7) - +5V (50mA)
-(8) - Gnd
-(9) - Stylus button
+
+=== =============
+Pin Meaning
+=== =============
+1   n/c
+2   n/c
+3   n/c
+4   n/c
+5   Touch button
+6   /Beamtrigger
+7   +5V (50mA)
+8   Gnd
+9   Stylus button
+=== =============
 
 -------------------------------------------------------------------------------
 
+======== === ==== ==== ====== ========================================
 NAME     rev ADDR type chip   Description
 JOY0DAT      00A   R   Denise Joystick-mouse 0 data (left vert, horiz)
 JOY1DAT      00C   R   Denise Joystick-mouse 1 data (right vert,horiz)
+======== === ==== ==== ====== ========================================
 
         These addresses each read a 16 bit register. These in turn
         are loaded from the MDAT serial stream and are clocked in on
@@ -71,12 +104,16 @@ JOY1DAT      00C   R   Denise Joystick-mouse 1 data (right vert,horiz)
         controller ports (8 total) plus 8 miscellaneous control bits
         which are new for LISA and can be read in upper 8 bits of
         LISAID.
+
         Register bits are as follows:
-        Mouse counter usage (pins  1,3 =Yclock, pins 2,4 =Xclock)
 
+        - Mouse counter usage (pins  1,3 =Yclock, pins 2,4 =Xclock)
+
+======== === === === === === === === === ====== === === === === === === ===
     BIT#  15  14  13  12  11  10  09  08     07  06  05  04  03  02  01  00
 JOY0DAT   Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
 JOY1DAT   Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
+======== === === === === === === === === ====== === === === === === === ===
 
         0=LEFT CONTROLLER PAIR, 1=RIGHT CONTROLLER PAIR.
         (4 counters total). The bit usage for both left and right
@@ -88,12 +125,19 @@ JOY1DAT   Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
          | Serial | Bit Name | Description                             |
          +--------+----------+-----------------------------------------+
          |   0    | M0H      | JOY0DAT Horizontal Clock                |
+         +--------+----------+-----------------------------------------+
          |   1    | M0HQ     | JOY0DAT Horizontal Clock (quadrature)   |
+         +--------+----------+-----------------------------------------+
          |   2    | M0V      | JOY0DAT Vertical Clock                  |
+         +--------+----------+-----------------------------------------+
          |   3    | M0VQ     | JOY0DAT Vertical Clock  (quadrature)    |
+         +--------+----------+-----------------------------------------+
          |   4    | M1V      | JOY1DAT Horizontal Clock                |
+         +--------+----------+-----------------------------------------+
          |   5    | M1VQ     | JOY1DAT Horizontal Clock (quadrature)   |
+         +--------+----------+-----------------------------------------+
          |   6    | M1V      | JOY1DAT Vertical Clock                  |
+         +--------+----------+-----------------------------------------+
          |   7    | M1VQ     | JOY1DAT Vertical Clock (quadrature)     |
          +--------+----------+-----------------------------------------+
 
@@ -106,44 +150,59 @@ JOY1DAT   Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
          | Directions | Pin# | Counter bits                    |
          +------------+------+---------------------------------+
          | Forward    |  1   | Y1 xor Y0 (BIT#09 xor BIT#08)   |
+         +------------+------+---------------------------------+
          | Left       |  3   | Y1                              |
+         +------------+------+---------------------------------+
          | Back       |  2   | X1 xor X0 (BIT#01 xor BIT#00)   |
+         +------------+------+---------------------------------+
          | Right      |  4   | X1                              |
          +------------+------+---------------------------------+
 
 -------------------------------------------------------------------------------
 
+========  === ==== ==== ====== =================================================
 NAME      rev ADDR type chip    Description
 JOYTEST       036   W   Denise  Write to all 4  joystick-mouse counters at once.
+========  === ==== ==== ====== =================================================
 
                   Mouse counter write test data:
+
+========= === === === === === === === === ====== === === === === === === ===
      BIT#  15  14  13  12  11  10  09  08     07  06  05  04  03  02  01  00
   JOYxDAT  Y7  Y6  Y5  Y4  Y3  Y2  xx  xx     X7  X6  X5  X4  X3  X2  xx  xx
   JOYxDAT  Y7  Y6  Y5  Y4  Y3  Y2  xx  xx     X7  X6  X5  X4  X3  X2  xx  xx
+========= === === === === === === === === ====== === === === === === === ===
 
 -------------------------------------------------------------------------------
 
+======= === ==== ==== ====== ========================================
 NAME    rev ADDR type chip   Description
 POT0DAT  h  012   R   Paula  Pot counter data left pair (vert, horiz)
 POT1DAT  h  014   R   Paula  Pot counter data right pair (vert,horiz)
+======= === ==== ==== ====== ========================================
 
         These addresses each read a pair of 8 bit pot counters.
         (4 counters total). The bit assignment for both
         addresses is shown below. The counters are stopped by signals
         from 2 controller connectors (left-right) with 2 pins each.
 
+====== === === === === === === === === ====== === === === === === === ===
   BIT#  15  14  13  12  11  10  09  08     07  06  05  04  03  02  01  00
  RIGHT  Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
   LEFT  Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
+====== === === === === === === === === ====== === === === === === === ===
 
          +--------------------------+-------+
          | CONNECTORS               | PAULA |
          +-------+------+-----+-----+-------+
          | Loc.  | Dir. | Sym | pin | pin   |
-         +-------+------+-----+-----+-------+
+         +=======+======+=====+=====+=======+
          | RIGHT | Y    | RX  | 9   | 33    |
+         +-------+------+-----+-----+-------+
          | RIGHT | X    | RX  | 5   | 32    |
+         +-------+------+-----+-----+-------+
          | LEFT  | Y    | LY  | 9   | 36    |
+         +-------+------+-----+-----+-------+
          | LEFT  | X    | LX  | 5   | 35    |
          +-------+------+-----+-----+-------+
 
@@ -155,13 +214,18 @@ POT1DAT  h  014   R   Paula  Pot counter data right pair (vert,horiz)
 
 -------------------------------------------------------------------------------
 
+====== === ==== ==== ====== ================================================
 NAME   rev ADDR type chip   Description
-POTGO      034   W   Paula  Pot port (4 bit) bi-direction and data, and pot counter start.
+POTGO      034   W   Paula  Pot port (4 bit) bi-direction and data, and pot
+			    counter start.
+====== === ==== ==== ====== ================================================
 
 -------------------------------------------------------------------------------
 
+====== === ==== ==== ====== ================================================
 NAME   rev ADDR type chip   Description
 POTINP     016   R   Paula  Pot pin data read
+====== === ==== ==== ====== ================================================
 
         This register controls a 4 bit bi-direction I/O port
         that shares the same 4 pins as the 4 pot counters above.
@@ -170,15 +234,22 @@ POTINP     016   R   Paula  Pot pin data read
          | BIT#  | FUNCTION | DESCRIPTION                                 |
          +-------+----------+---------------------------------------------+
          | 15    | OUTRY    | Output enable for Paula pin 33              |
+         +-------+----------+---------------------------------------------+
          | 14    | DATRY    | I/O data Paula pin 33                       |
+         +-------+----------+---------------------------------------------+
          | 13    | OUTRX    | Output enable for Paula pin 32              |
+         +-------+----------+---------------------------------------------+
          | 12    | DATRX    | I/O data Paula pin 32                       |
+         +-------+----------+---------------------------------------------+
          | 11    | OUTLY    | Out put enable for Paula pin 36             |
+         +-------+----------+---------------------------------------------+
          | 10    | DATLY    | I/O data Paula pin 36                       |
+         +-------+----------+---------------------------------------------+
          | 09    | OUTLX    | Output enable for Paula pin 35              |
+         +-------+----------+---------------------------------------------+
          | 08    | DATLX    | I/O data  Paula pin 35                      |
+         +-------+----------+---------------------------------------------+
          | 07-01 |   X      | Not used                                    |
+         +-------+----------+---------------------------------------------+
          | 00    | START    | Start pots (dump capacitors,start counters) |
          +-------+----------+---------------------------------------------+
-
--------------------------------------------------------------------------------
-- 
2.9.3


