From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 25/33] docs: input/sentelic: convert it to ReST format
Date: Tue,  4 Apr 2017 07:52:35 -0300
Message-ID: <226042dcaf8bc66f46abe97d235904dce8962bd1.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491302719.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491302719.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491302719.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491302719.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491302719.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491302719.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491302719.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491302719.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491302719.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491302719.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491302719.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491302719.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491302719.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491302719.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491302719.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491302719.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491302719.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491302719.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491302719.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491302719.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491302719.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491302719.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491302719.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491302719.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3552e3986d3848001b89449926d04f44930c681e.1491302719.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file has its own particular format that doesn't match any
markup one.

Manually change it to get something that would be readable
using ReST markup language.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/sentelic.txt | 1000 ++++++++++++++++++++------------------
 1 file changed, 514 insertions(+), 486 deletions(-)

diff --git a/Documentation/input/sentelic.txt b/Documentation/input/sentelic.txt
index 89251e2a3eba..d1a476f973b1 100644
--- a/Documentation/input/sentelic.txt
+++ b/Documentation/input/sentelic.txt
@@ -1,411 +1,437 @@
-Copyright (C) 2002-2011 Sentelic Corporation.
-Last update: Dec-07-2011
+.. include:: <isonum.txt>
+
+===============
+Sentelic Driver
+===============
+
+
+:Copyright: |copy| 2002-2011 Sentelic Corporation.
+
+:Last update: Dec-07-2011
+
+Finger Sensing Pad Intellimouse Mode(scrolling wheel, 4th and 5th buttons)
+==========================================================================
 
-==============================================================================
-* Finger Sensing Pad Intellimouse Mode(scrolling wheel, 4th and 5th buttons)
-==============================================================================
 A) MSID 4: Scrolling wheel mode plus Forward page(4th button) and Backward
    page (5th button)
-@1. Set sample rate to 200;
-@2. Set sample rate to 200;
-@3. Set sample rate to 80;
-@4. Issuing the "Get device ID" command (0xF2) and waits for the response;
-@5. FSP will respond 0x04.
-
-Packet 1
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |Y|X|y|x|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 | | |B|F|W|W|W|W|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7 => Y overflow
-        Bit6 => X overflow
-        Bit5 => Y sign bit
-        Bit4 => X sign bit
-        Bit3 => 1
-        Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X Movement(9-bit 2's complement integers)
-Byte 3: Y Movement(9-bit 2's complement integers)
-Byte 4: Bit3~Bit0 => the scrolling wheel's movement since the last data report.
-                     valid values, -8 ~ +7
-        Bit4 => 1 = 4th mouse button is pressed, Forward one page.
-                0 = 4th mouse button is not pressed.
-        Bit5 => 1 = 5th mouse button is pressed, Backward one page.
-                0 = 5th mouse button is not pressed.
-
-B) MSID 6: Horizontal and Vertical scrolling.
-@ Set bit 1 in register 0x40 to 1
-
-# FSP replaces scrolling wheel's movement as 4 bits to show horizontal and
-  vertical scrolling.
-
-Packet 1
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |Y|X|y|x|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 | | |B|F|r|l|u|d|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7 => Y overflow
-        Bit6 => X overflow
-        Bit5 => Y sign bit
-        Bit4 => X sign bit
-        Bit3 => 1
-        Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X Movement(9-bit 2's complement integers)
-Byte 3: Y Movement(9-bit 2's complement integers)
-Byte 4: Bit0 => the Vertical scrolling movement downward.
-	Bit1 => the Vertical scrolling movement upward.
-	Bit2 => the Horizontal scrolling movement leftward.
-	Bit3 => the Horizontal scrolling movement rightward.
-        Bit4 => 1 = 4th mouse button is pressed, Forward one page.
-                0 = 4th mouse button is not pressed.
-        Bit5 => 1 = 5th mouse button is pressed, Backward one page.
-                0 = 5th mouse button is not pressed.
-
-C) MSID 7:
-# FSP uses 2 packets (8 Bytes) to represent Absolute Position.
-  so we have PACKET NUMBER to identify packets.
+
+1. Set sample rate to 200;
+2. Set sample rate to 200;
+3. Set sample rate to 80;
+4. Issuing the "Get device ID" command (0xF2) and waits for the response;
+5. FSP will respond 0x04.
+
+::
+
+    Packet 1
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |Y|X|y|x|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 | | |B|F|W|W|W|W|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7 => Y overflow
+	    Bit6 => X overflow
+	    Bit5 => Y sign bit
+	    Bit4 => X sign bit
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X Movement(9-bit 2's complement integers)
+    Byte 3: Y Movement(9-bit 2's complement integers)
+    Byte 4: Bit3~Bit0 => the scrolling wheel's movement since the last data report.
+			valid values, -8 ~ +7
+	    Bit4 => 1 = 4th mouse button is pressed, Forward one page.
+		    0 = 4th mouse button is not pressed.
+	    Bit5 => 1 = 5th mouse button is pressed, Backward one page.
+		    0 = 5th mouse button is not pressed.
+
+B) MSID 6: Horizontal and Vertical scrolling
+
+- Set bit 1 in register 0x40 to 1
+
+FSP replaces scrolling wheel's movement as 4 bits to show horizontal and
+vertical scrolling.
+
+::
+
+    Packet 1
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |Y|X|y|x|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 | | |B|F|r|l|u|d|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7 => Y overflow
+	    Bit6 => X overflow
+	    Bit5 => Y sign bit
+	    Bit4 => X sign bit
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X Movement(9-bit 2's complement integers)
+    Byte 3: Y Movement(9-bit 2's complement integers)
+    Byte 4: Bit0 => the Vertical scrolling movement downward.
+	    Bit1 => the Vertical scrolling movement upward.
+	    Bit2 => the Horizontal scrolling movement leftward.
+	    Bit3 => the Horizontal scrolling movement rightward.
+	    Bit4 => 1 = 4th mouse button is pressed, Forward one page.
+		    0 = 4th mouse button is not pressed.
+	    Bit5 => 1 = 5th mouse button is pressed, Backward one page.
+		    0 = 5th mouse button is not pressed.
+
+C) MSID 7
+
+FSP uses 2 packets (8 Bytes) to represent Absolute Position.
+so we have PACKET NUMBER to identify packets.
+
   If PACKET NUMBER is 0, the packet is Packet 1.
   If PACKET NUMBER is 1, the packet is Packet 2.
   Please count this number in program.
 
-# MSID6 special packet will be enable at the same time when enable MSID 7.
-
-==============================================================================
-* Absolute position for STL3886-G0.
-==============================================================================
-@ Set bit 2 or 3 in register 0x40 to 1
-@ Set bit 6 in register 0x40 to 1
-
-Packet 1 (ABSOLUTE POSITION)
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|V|1|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|d|u|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordination packet
-                  => 10, Notify packet
-        Bit5 => valid bit
-        Bit4 => 1
-        Bit3 => 1
-        Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-        Bit3~Bit2 => X coordinate (ypos[1:0])
-        Bit4 => scroll up
-        Bit5 => scroll down
-        Bit6 => scroll left
-        Bit7 => scroll right
-
-Notify Packet for G0
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |1|0|0|1|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |M|M|M|M|M|M|M|M|  4 |0|0|0|0|0|0|0|0|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordination packet
-                  => 10, Notify packet
-        Bit5 => 0
-        Bit4 => 1
-        Bit3 => 1
-        Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: Message Type => 0x5A (Enable/Disable status packet)
-        Mode Type => 0xA5 (Normal/Icon mode status)
-Byte 3: Message Type => 0x00 (Disabled)
-                     => 0x01 (Enabled)
-        Mode Type    => 0x00 (Normal)
-                     => 0x01 (Icon)
-Byte 4: Bit7~Bit0 => Don't Care
-
-==============================================================================
-* Absolute position for STL3888-Ax.
-==============================================================================
-Packet 1 (ABSOLUTE POSITION)
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|V|A|1|L|0|1|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |x|x|y|y|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordination packet
-                  => 10, Notify packet
-                  => 11, Normal data packet with on-pad click
-        Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
-                When both fingers are up, the last two reports have zero valid
-                bit.
-        Bit4 => arc
-        Bit3 => 1
-        Bit2 => Left Button, 1 is pressed, 0 is released.
-        Bit1 => 0
-        Bit0 => 1
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-        Bit3~Bit2 => X coordinate (ypos[1:0])
-        Bit5~Bit4 => y1_g
-        Bit7~Bit6 => x1_g
-
-Packet 2 (ABSOLUTE POSITION)
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|V|A|1|R|1|0|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |x|x|y|y|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordinates packet
-                  => 10, Notify packet
-                  => 11, Normal data packet with on-pad click
-        Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
-                When both fingers are up, the last two reports have zero valid
-                bit.
-        Bit4 => arc
-        Bit3 => 1
-        Bit2 => Right Button, 1 is pressed, 0 is released.
-        Bit1 => 1
-        Bit0 => 0
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-        Bit3~Bit2 => X coordinate (ypos[1:0])
-        Bit5~Bit4 => y2_g
-        Bit7~Bit6 => x2_g
-
-Notify Packet for STL3888-Ax
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |1|0|1|P|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |0|0|F|F|0|0|0|i|  4 |r|l|d|u|0|0|0|0|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordinates packet
-                  => 10, Notify packet
-                  => 11, Normal data packet with on-pad click
-        Bit5 => 1
-        Bit4 => when in absolute coordinates mode (valid when EN_PKT_GO is 1):
-                0: left button is generated by the on-pad command
-                1: left button is generated by the external button
-        Bit3 => 1
-        Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: Message Type => 0xB7 (Multi Finger, Multi Coordinate mode)
-Byte 3: Bit7~Bit6 => Don't care
-        Bit5~Bit4 => Number of fingers
-        Bit3~Bit1 => Reserved
-        Bit0 => 1: enter gesture mode; 0: leaving gesture mode
-Byte 4: Bit7 => scroll right button
-        Bit6 => scroll left button
-        Bit5 => scroll down button
-        Bit4 => scroll up button
-            * Note that if gesture and additional button (Bit4~Bit7)
-              happen at the same time, the button information will not
-              be sent.
-        Bit3~Bit0 => Reserved
+MSID6 special packet will be enable at the same time when enable MSID 7.
+
+Absolute position for STL3886-G0
+================================
+
+1. Set bit 2 or 3 in register 0x40 to 1
+2. Set bit 6 in register 0x40 to 1
+
+::
+
+    Packet 1 (ABSOLUTE POSITION)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|V|1|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|d|u|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordination packet
+		    => 10, Notify packet
+	    Bit5 => valid bit
+	    Bit4 => 1
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit4 => scroll up
+	    Bit5 => scroll down
+	    Bit6 => scroll left
+	    Bit7 => scroll right
+
+    Notify Packet for G0
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |1|0|0|1|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |M|M|M|M|M|M|M|M|  4 |0|0|0|0|0|0|0|0|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordination packet
+		    => 10, Notify packet
+	    Bit5 => 0
+	    Bit4 => 1
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: Message Type => 0x5A (Enable/Disable status packet)
+	    Mode Type => 0xA5 (Normal/Icon mode status)
+    Byte 3: Message Type => 0x00 (Disabled)
+			=> 0x01 (Enabled)
+	    Mode Type    => 0x00 (Normal)
+			=> 0x01 (Icon)
+    Byte 4: Bit7~Bit0 => Don't Care
+
+Absolute position for STL3888-Ax
+================================
+
+::
+
+    Packet 1 (ABSOLUTE POSITION)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|V|A|1|L|0|1|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |x|x|y|y|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordination packet
+		    => 10, Notify packet
+		    => 11, Normal data packet with on-pad click
+	    Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
+		    When both fingers are up, the last two reports have zero valid
+		    bit.
+	    Bit4 => arc
+	    Bit3 => 1
+	    Bit2 => Left Button, 1 is pressed, 0 is released.
+	    Bit1 => 0
+	    Bit0 => 1
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit5~Bit4 => y1_g
+	    Bit7~Bit6 => x1_g
+
+    Packet 2 (ABSOLUTE POSITION)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|V|A|1|R|1|0|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |x|x|y|y|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordinates packet
+		    => 10, Notify packet
+		    => 11, Normal data packet with on-pad click
+	    Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
+		    When both fingers are up, the last two reports have zero valid
+		    bit.
+	    Bit4 => arc
+	    Bit3 => 1
+	    Bit2 => Right Button, 1 is pressed, 0 is released.
+	    Bit1 => 1
+	    Bit0 => 0
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit5~Bit4 => y2_g
+	    Bit7~Bit6 => x2_g
+
+    Notify Packet for STL3888-Ax
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |1|0|1|P|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |0|0|F|F|0|0|0|i|  4 |r|l|d|u|0|0|0|0|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordinates packet
+		    => 10, Notify packet
+		    => 11, Normal data packet with on-pad click
+	    Bit5 => 1
+	    Bit4 => when in absolute coordinates mode (valid when EN_PKT_GO is 1):
+		    0: left button is generated by the on-pad command
+		    1: left button is generated by the external button
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: Message Type => 0xB7 (Multi Finger, Multi Coordinate mode)
+    Byte 3: Bit7~Bit6 => Don't care
+	    Bit5~Bit4 => Number of fingers
+	    Bit3~Bit1 => Reserved
+	    Bit0 => 1: enter gesture mode; 0: leaving gesture mode
+    Byte 4: Bit7 => scroll right button
+	    Bit6 => scroll left button
+	    Bit5 => scroll down button
+	    Bit4 => scroll up button
+		* Note that if gesture and additional button (Bit4~Bit7)
+		happen at the same time, the button information will not
+		be sent.
+	    Bit3~Bit0 => Reserved
 
 Sample sequence of Multi-finger, Multi-coordinate mode:
 
 	notify packet (valid bit == 1), abs pkt 1, abs pkt 2, abs pkt 1,
 	abs pkt 2, ..., notify packet (valid bit == 0)
 
-==============================================================================
-* Absolute position for STL3888-B0.
-==============================================================================
-Packet 1(ABSOLUTE POSITION)
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|V|F|1|0|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|u|d|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordinates packet
-                  => 10, Notify packet
-                  => 11, Normal data packet with on-pad click
-        Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
-                When both fingers are up, the last two reports have zero valid
-                bit.
-        Bit4 => finger up/down information. 1: finger down, 0: finger up.
-        Bit3 => 1
-        Bit2 => finger index, 0 is the first finger, 1 is the second finger.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-        Bit3~Bit2 => X coordinate (ypos[1:0])
-        Bit4 => scroll down button
-        Bit5 => scroll up button
-        Bit6 => scroll left button
-        Bit7 => scroll right button
-
-Packet 2 (ABSOLUTE POSITION)
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|V|F|1|1|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|u|d|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordination packet
-                  => 10, Notify packet
-                  => 11, Normal data packet with on-pad click
-        Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
-                When both fingers are up, the last two reports have zero valid
-                bit.
-        Bit4 => finger up/down information. 1: finger down, 0: finger up.
-        Bit3 => 1
-        Bit2 => finger index, 0 is the first finger, 1 is the second finger.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-        Bit3~Bit2 => X coordinate (ypos[1:0])
-        Bit4 => scroll down button
-        Bit5 => scroll up button
-        Bit6 => scroll left button
-        Bit7 => scroll right button
-
-Notify Packet for STL3888-B0
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |1|0|1|P|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |0|0|F|F|0|0|0|i|  4 |r|l|u|d|0|0|0|0|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordination packet
-                  => 10, Notify packet
-                  => 11, Normal data packet with on-pad click
-        Bit5 => 1
-        Bit4 => when in absolute coordinates mode (valid when EN_PKT_GO is 1):
-                0: left button is generated by the on-pad command
-                1: left button is generated by the external button
-        Bit3 => 1
-        Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-        Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-        Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: Message Type => 0xB7 (Multi Finger, Multi Coordinate mode)
-Byte 3: Bit7~Bit6 => Don't care
-        Bit5~Bit4 => Number of fingers
-        Bit3~Bit1 => Reserved
-        Bit0 => 1: enter gesture mode; 0: leaving gesture mode
-Byte 4: Bit7 => scroll right button
-        Bit6 => scroll left button
-        Bit5 => scroll up button
-        Bit4 => scroll down button
-            * Note that if gesture and additional button(Bit4~Bit7)
-              happen at the same time, the button information will not
-              be sent.
-        Bit3~Bit0 => Reserved
+Absolute position for STL3888-B0
+================================
+
+::
+
+    Packet 1(ABSOLUTE POSITION)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|V|F|1|0|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|u|d|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordinates packet
+		    => 10, Notify packet
+		    => 11, Normal data packet with on-pad click
+	    Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
+		    When both fingers are up, the last two reports have zero valid
+		    bit.
+	    Bit4 => finger up/down information. 1: finger down, 0: finger up.
+	    Bit3 => 1
+	    Bit2 => finger index, 0 is the first finger, 1 is the second finger.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit4 => scroll down button
+	    Bit5 => scroll up button
+	    Bit6 => scroll left button
+	    Bit7 => scroll right button
+
+    Packet 2 (ABSOLUTE POSITION)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|V|F|1|1|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|u|d|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordination packet
+		    => 10, Notify packet
+		    => 11, Normal data packet with on-pad click
+	    Bit5 => Valid bit, 0 means that the coordinate is invalid or finger up.
+		    When both fingers are up, the last two reports have zero valid
+		    bit.
+	    Bit4 => finger up/down information. 1: finger down, 0: finger up.
+	    Bit3 => 1
+	    Bit2 => finger index, 0 is the first finger, 1 is the second finger.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit4 => scroll down button
+	    Bit5 => scroll up button
+	    Bit6 => scroll left button
+	    Bit7 => scroll right button
+
+Notify Packet for STL3888-B0::
+
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |1|0|1|P|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |0|0|F|F|0|0|0|i|  4 |r|l|u|d|0|0|0|0|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordination packet
+		    => 10, Notify packet
+		    => 11, Normal data packet with on-pad click
+	    Bit5 => 1
+	    Bit4 => when in absolute coordinates mode (valid when EN_PKT_GO is 1):
+		    0: left button is generated by the on-pad command
+		    1: left button is generated by the external button
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: Message Type => 0xB7 (Multi Finger, Multi Coordinate mode)
+    Byte 3: Bit7~Bit6 => Don't care
+	    Bit5~Bit4 => Number of fingers
+	    Bit3~Bit1 => Reserved
+	    Bit0 => 1: enter gesture mode; 0: leaving gesture mode
+    Byte 4: Bit7 => scroll right button
+	    Bit6 => scroll left button
+	    Bit5 => scroll up button
+	    Bit4 => scroll down button
+		* Note that if gesture and additional button(Bit4~Bit7)
+		happen at the same time, the button information will not
+		be sent.
+	    Bit3~Bit0 => Reserved
 
 Sample sequence of Multi-finger, Multi-coordinate mode:
 
 	notify packet (valid bit == 1), abs pkt 1, abs pkt 2, abs pkt 1,
 	abs pkt 2, ..., notify packet (valid bit == 0)
 
-==============================================================================
-* Absolute position for STL3888-Cx and STL3888-Dx.
-==============================================================================
-Single Finger, Absolute Coordinate Mode (SFAC)
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|0|P|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|B|F|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordinates packet
-                  => 10, Notify packet
-	Bit5 => Coordinate mode(always 0 in SFAC mode):
-		0: single-finger absolute coordinates (SFAC) mode
-		1: multi-finger, multiple coordinates (MFMC) mode
-	Bit4 => 0: The LEFT button is generated by on-pad command (OPC)
-		1: The LEFT button is generated by external button
-		Default is 1 even if the LEFT button is not pressed.
-	Bit3 => Always 1, as specified by PS/2 protocol.
-	Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-	Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-	Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-	Bit3~Bit2 => X coordinate (ypos[1:0])
-	Bit4 => 4th mouse button(forward one page)
-	Bit5 => 5th mouse button(backward one page)
-	Bit6 => scroll left button
-	Bit7 => scroll right button
-
-Multi Finger, Multiple Coordinates Mode (MFMC):
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |0|1|1|P|1|F|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|B|F|X|X|Y|Y|
-      |---------------|     |---------------|    |---------------|    |---------------|
-
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordination packet
-                  => 10, Notify packet
-	Bit5 => Coordinate mode (always 1 in MFMC mode):
-		0: single-finger absolute coordinates (SFAC) mode
-		1: multi-finger, multiple coordinates (MFMC) mode
-	Bit4 => 0: The LEFT button is generated by on-pad command (OPC)
-		1: The LEFT button is generated by external button
-		Default is 1 even if the LEFT button is not pressed.
-	Bit3 => Always 1, as specified by PS/2 protocol.
-	Bit2 => Finger index, 0 is the first finger, 1 is the second finger.
-		If bit 1 and 0 are all 1 and bit 4 is 0, the middle external
-		button is pressed.
-	Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-	Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: X coordinate (xpos[9:2])
-Byte 3: Y coordinate (ypos[9:2])
-Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
-	Bit3~Bit2 => X coordinate (ypos[1:0])
-	Bit4 => 4th mouse button(forward one page)
-	Bit5 => 5th mouse button(backward one page)
-	Bit6 => scroll left button
-	Bit7 => scroll right button
-
-  When one of the two fingers is up, the device will output four consecutive
+Absolute position for STL3888-Cx and STL3888-Dx
+===============================================
+
+::
+
+    Single Finger, Absolute Coordinate Mode (SFAC)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|0|P|1|M|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|B|F|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordinates packet
+		    => 10, Notify packet
+	    Bit5 => Coordinate mode(always 0 in SFAC mode):
+		    0: single-finger absolute coordinates (SFAC) mode
+		    1: multi-finger, multiple coordinates (MFMC) mode
+	    Bit4 => 0: The LEFT button is generated by on-pad command (OPC)
+		    1: The LEFT button is generated by external button
+		    Default is 1 even if the LEFT button is not pressed.
+	    Bit3 => Always 1, as specified by PS/2 protocol.
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit4 => 4th mouse button(forward one page)
+	    Bit5 => 5th mouse button(backward one page)
+	    Bit6 => scroll left button
+	    Bit7 => scroll right button
+
+    Multi Finger, Multiple Coordinates Mode (MFMC):
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |0|1|1|P|1|F|R|L|  2  |X|X|X|X|X|X|X|X|  3 |Y|Y|Y|Y|Y|Y|Y|Y|  4 |r|l|B|F|X|X|Y|Y|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordination packet
+		    => 10, Notify packet
+	    Bit5 => Coordinate mode (always 1 in MFMC mode):
+		    0: single-finger absolute coordinates (SFAC) mode
+		    1: multi-finger, multiple coordinates (MFMC) mode
+	    Bit4 => 0: The LEFT button is generated by on-pad command (OPC)
+		    1: The LEFT button is generated by external button
+		    Default is 1 even if the LEFT button is not pressed.
+	    Bit3 => Always 1, as specified by PS/2 protocol.
+	    Bit2 => Finger index, 0 is the first finger, 1 is the second finger.
+		    If bit 1 and 0 are all 1 and bit 4 is 0, the middle external
+		    button is pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: X coordinate (xpos[9:2])
+    Byte 3: Y coordinate (ypos[9:2])
+    Byte 4: Bit1~Bit0 => Y coordinate (xpos[1:0])
+	    Bit3~Bit2 => X coordinate (ypos[1:0])
+	    Bit4 => 4th mouse button(forward one page)
+	    Bit5 => 5th mouse button(backward one page)
+	    Bit6 => scroll left button
+	    Bit7 => scroll right button
+
+When one of the two fingers is up, the device will output four consecutive
 MFMC#0 report packets with zero X and Y to represent 1st finger is up or
 four consecutive MFMC#1 report packets with zero X and Y to represent that
 the 2nd finger is up.  On the other hand, if both fingers are up, the device
 will output four consecutive single-finger, absolute coordinate(SFAC) packets
 with zero X and Y.
 
-Notify Packet for STL3888-Cx/Dx
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |1|0|0|P|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |0|0|F|F|0|0|0|i|  4 |r|l|u|d|0|0|0|0|
-      |---------------|     |---------------|    |---------------|    |---------------|
+Notify Packet for STL3888-Cx/Dx::
 
-Byte 1: Bit7~Bit6 => 00, Normal data packet
-                  => 01, Absolute coordinates packet
-                  => 10, Notify packet
-	Bit5 => Always 0
-	Bit4 => 0: The LEFT button is generated by on-pad command(OPC)
-		1: The LEFT button is generated by external button
-		Default is 1 even if the LEFT button is not pressed.
-	Bit3 => 1
-	Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
-	Bit1 => Right Button, 1 is pressed, 0 is not pressed.
-	Bit0 => Left Button, 1 is pressed, 0 is not pressed.
-Byte 2: Message type:
-	0xba => gesture information
-	0xc0 => one finger hold-rotating gesture
-Byte 3: The first parameter for the received message:
-	0xba => gesture ID (refer to the 'Gesture ID' section)
-	0xc0 => region ID
-Byte 4: The second parameter for the received message:
-	0xba => N/A
-	0xc0 => finger up/down information
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |1|0|0|P|1|M|R|L|  2  |C|C|C|C|C|C|C|C|  3 |0|0|F|F|0|0|0|i|  4 |r|l|u|d|0|0|0|0|
+	  |---------------|     |---------------|    |---------------|    |---------------|
+
+    Byte 1: Bit7~Bit6 => 00, Normal data packet
+		    => 01, Absolute coordinates packet
+		    => 10, Notify packet
+	    Bit5 => Always 0
+	    Bit4 => 0: The LEFT button is generated by on-pad command(OPC)
+		    1: The LEFT button is generated by external button
+		    Default is 1 even if the LEFT button is not pressed.
+	    Bit3 => 1
+	    Bit2 => Middle Button, 1 is pressed, 0 is not pressed.
+	    Bit1 => Right Button, 1 is pressed, 0 is not pressed.
+	    Bit0 => Left Button, 1 is pressed, 0 is not pressed.
+    Byte 2: Message type:
+	    0xba => gesture information
+	    0xc0 => one finger hold-rotating gesture
+    Byte 3: The first parameter for the received message:
+	    0xba => gesture ID (refer to the 'Gesture ID' section)
+	    0xc0 => region ID
+    Byte 4: The second parameter for the received message:
+	    0xba => N/A
+	    0xc0 => finger up/down information
 
 Sample sequence of Multi-finger, Multi-coordinates mode:
 
@@ -416,50 +442,51 @@ Sample sequence of Multi-finger, Multi-coordinates mode:
 	That is, when the device is in MFMC mode, the host will receive
 	interleaved absolute coordinate packets for each finger.
 
-==============================================================================
-* FSP Enable/Disable packet
-==============================================================================
-   Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
-BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
-  1   |Y|X|0|0|1|M|R|L|  2  |0|1|0|1|1|0|1|E|  3 | | | | | | | | |  4 | | | | | | | | |
-      |---------------|     |---------------|    |---------------|    |---------------|
+FSP Enable/Disable packet
+=========================
 
-FSP will send out enable/disable packet when FSP receive PS/2 enable/disable
-command. Host will receive the packet which Middle, Right, Left button will
-be set. The packet only use byte 0 and byte 1 as a pattern of original packet.
-Ignore the other bytes of the packet.
+::
 
-Byte 1: Bit7 => 0, Y overflow
-        Bit6 => 0, X overflow
-	Bit5 => 0, Y sign bit
-        Bit4 => 0, X sign bit
-	Bit3 => 1
-	Bit2 => 1, Middle Button
-        Bit1 => 1, Right Button
-        Bit0 => 1, Left Button
-Byte 2: Bit7~1 => (0101101b)
-        Bit0 => 1 = Enable
-		0 = Disable
-Byte 3: Don't care
-Byte 4: Don't care (MOUSE ID 3, 4)
-Byte 5~8: Don't care (Absolute packet)
+    Bit 7 6 5 4 3 2 1 0       7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0      7 6 5 4 3 2 1 0
+    BYTE  |---------------|BYTE |---------------|BYTE|---------------|BYTE|---------------|
+      1   |Y|X|0|0|1|M|R|L|  2  |0|1|0|1|1|0|1|E|  3 | | | | | | | | |  4 | | | | | | | | |
+	  |---------------|     |---------------|    |---------------|    |---------------|
 
-==============================================================================
-* PS/2 Command Set
-==============================================================================
+    FSP will send out enable/disable packet when FSP receive PS/2 enable/disable
+    command. Host will receive the packet which Middle, Right, Left button will
+    be set. The packet only use byte 0 and byte 1 as a pattern of original packet.
+    Ignore the other bytes of the packet.
+
+    Byte 1: Bit7 => 0, Y overflow
+	    Bit6 => 0, X overflow
+	    Bit5 => 0, Y sign bit
+	    Bit4 => 0, X sign bit
+	    Bit3 => 1
+	    Bit2 => 1, Middle Button
+	    Bit1 => 1, Right Button
+	    Bit0 => 1, Left Button
+    Byte 2: Bit7~1 => (0101101b)
+	    Bit0 => 1 = Enable
+		    0 = Disable
+    Byte 3: Don't care
+    Byte 4: Don't care (MOUSE ID 3, 4)
+    Byte 5~8: Don't care (Absolute packet)
+
+PS/2 Command Set
+================
 
 FSP supports basic PS/2 commanding set and modes, refer to following URL for
 details about PS/2 commands:
 
 http://www.computer-engineering.org/ps2mouse/
 
-==============================================================================
-* Programming Sequence for Determining Packet Parsing Flow
-==============================================================================
+Programming Sequence for Determining Packet Parsing Flow
+========================================================
+
 1. Identify FSP by reading device ID(0x00) and version(0x01) register
 
-2a. For FSP version < STL3888 Cx, determine number of buttons by reading
-    the 'test mode status' (0x20) register:
+2. For FSP version < STL3888 Cx, determine number of buttons by reading
+   the 'test mode status' (0x20) register::
 
 	buttons = reg[0x20] & 0x30
 
@@ -476,25 +503,24 @@ http://www.computer-engineering.org/ps2mouse/
 		Refer to 'Finger Sensing Pad PS/2 Mouse Intellimouse'
 		section A for packet parsing detail
 
-2b. For FSP version >= STL3888 Cx:
+3. For FSP version >= STL3888 Cx:
 	Refer to 'Finger Sensing Pad PS/2 Mouse Intellimouse'
 	section A for packet parsing detail (ignore byte 4, bit ~ 7)
 
-==============================================================================
-* Programming Sequence for Register Reading/Writing
-==============================================================================
+Programming Sequence for Register Reading/Writing
+=================================================
 
 Register inversion requirement:
 
-  Following values needed to be inverted(the '~' operator in C) before being
-sent to FSP:
+Following values needed to be inverted(the '~' operator in C) before being
+sent to FSP::
 
 	0xe8, 0xe9, 0xee, 0xf2, 0xf3 and 0xff.
 
 Register swapping requirement:
 
-  Following values needed to have their higher 4 bits and lower 4 bits being
-swapped before being sent to FSP:
+Following values needed to have their higher 4 bits and lower 4 bits being
+swapped before being sent to FSP::
 
 	10, 20, 40, 60, 80, 100 and 200.
 
@@ -512,33 +538,33 @@ Register reading sequence:
 	inverted(refer to the 'Register inversion requirement' section),
 	goto step 6
 
-	5a. send 0x68 PS/2 command to FSP;
+	  a. send 0x68 PS/2 command to FSP;
 
-	5b. send the inverted register address to FSP and goto step 8;
+	  b. send the inverted register address to FSP and goto step 8;
 
 	6. if the register address being to read is not required to be
 	swapped(refer to the 'Register swapping requirement' section),
 	goto step 7
 
-	6a. send 0xcc PS/2 command to FSP;
+	  a. send 0xcc PS/2 command to FSP;
 
-	6b. send the swapped register address to FSP and goto step 8;
+	  b. send the swapped register address to FSP and goto step 8;
 
 	7. send 0x66 PS/2 command to FSP;
 
-	7a. send the original register address to FSP and goto step 8;
+	  a. send the original register address to FSP and goto step 8;
 
 	8. send 0xe9(status request) PS/2 command to FSP;
 
 	9. the 4th byte of the response read from FSP should be the
-	requested register value(?? indicates don't care byte):
+	requested register value(?? indicates don't care byte)::
 
 		host: 0xe9
 		3888: 0xfa (??) (??) (val)
 
 	* Note that since the Cx release, the hardware will return 1's
-	complement of the register value at the 3rd byte of status request
-	result:
+	  complement of the register value at the 3rd byte of status request
+	  result::
 
 		host: 0xe9
 		3888: 0xfa (??) (~val) (val)
@@ -551,21 +577,21 @@ Register writing sequence:
 	inverted(refer to the 'Register inversion requirement' section),
 	goto step 3
 
-	2a. send 0x74 PS/2 command to FSP;
+	  a. send 0x74 PS/2 command to FSP;
 
-	2b. send the inverted register address to FSP and goto step 5;
+	  b. send the inverted register address to FSP and goto step 5;
 
 	3. if the register address being to write is not required to be
 	swapped(refer to the 'Register swapping requirement' section),
 	goto step 4
 
-	3a. send 0x77 PS/2 command to FSP;
+	  a. send 0x77 PS/2 command to FSP;
 
-	3b. send the swapped register address to FSP and goto step 5;
+	  b. send the swapped register address to FSP and goto step 5;
 
 	4. send 0x55 PS/2 command to FSP;
 
-	4a. send the register address to FSP and goto step 5;
+	  a. send the register address to FSP and goto step 5;
 
 	5. send 0xf3 PS/2 command to FSP;
 
@@ -573,43 +599,42 @@ Register writing sequence:
 	inverted(refer to the 'Register inversion requirement' section),
 	goto step 7
 
-	6a. send 0x47 PS/2 command to FSP;
+	  a. send 0x47 PS/2 command to FSP;
 
-	6b. send the inverted register value to FSP and goto step 9;
+	  b. send the inverted register value to FSP and goto step 9;
 
 	7. if the register value being to write is not required to be
 	swapped(refer to the 'Register swapping requirement' section),
 	goto step 8
 
-	7a. send 0x44 PS/2 command to FSP;
+	  a. send 0x44 PS/2 command to FSP;
 
-	7b. send the swapped register value to FSP and goto step 9;
+	  b. send the swapped register value to FSP and goto step 9;
 
 	8. send 0x33 PS/2 command to FSP;
 
-	8a. send the register value to FSP;
+	  a. send the register value to FSP;
 
 	9. the register writing sequence is completed.
 
-	* Note that since the Cx release, the hardware will return 1's
-	complement of the register value at the 3rd byte of status request
-	result. Host can optionally send another 0xe9 (status request) PS/2
-	command to FSP at the end of register writing to verify that the
-	register writing operation is successful (?? indicates don't care
-	byte):
+	* Since the Cx release, the hardware will return 1's
+	  complement of the register value at the 3rd byte of status request
+	  result. Host can optionally send another 0xe9 (status request) PS/2
+	  command to FSP at the end of register writing to verify that the
+	  register writing operation is successful (?? indicates don't care
+	  byte)::
 
 		host: 0xe9
 		3888: 0xfa (??) (~val) (val)
 
-==============================================================================
-* Programming Sequence for Page Register Reading/Writing
-==============================================================================
+Programming Sequence for Page Register Reading/Writing
+======================================================
 
-  In order to overcome the limitation of maximum number of registers
+In order to overcome the limitation of maximum number of registers
 supported, the hardware separates register into different groups called
 'pages.' Each page is able to include up to 255 registers.
 
-  The default page after power up is 0x82; therefore, if one has to get
+The default page after power up is 0x82; therefore, if one has to get
 access to register 0x8301, one has to use following sequence to switch
 to page 0x83, then start reading/writing from/to offset 0x01 by using
 the register read/write sequence described in previous section.
@@ -632,6 +657,7 @@ Page register reading sequence:
 
 	8. the response read from FSP should be the requested page value.
 
+
 Page register writing sequence:
 
 	1. send 0xf3 PS/2 command to FSP;
@@ -646,17 +672,17 @@ Page register writing sequence:
 	inverted(refer to the 'Register inversion requirement' section),
 	goto step 6
 
-	5a. send 0x47 PS/2 command to FSP;
+	  a. send 0x47 PS/2 command to FSP;
 
-	5b. send the inverted page address to FSP and goto step 9;
+	  b. send the inverted page address to FSP and goto step 9;
 
 	6. if the page address being written is not required to be
 	swapped(refer to the 'Register swapping requirement' section),
 	goto step 7
 
-	6a. send 0x44 PS/2 command to FSP;
+	  a. send 0x44 PS/2 command to FSP;
 
-	6b. send the swapped page address to FSP and goto step 9;
+	  b. send the swapped page address to FSP and goto step 9;
 
 	7. send 0x33 PS/2 command to FSP;
 
@@ -664,16 +690,17 @@ Page register writing sequence:
 
 	9. the page register writing sequence is completed.
 
-==============================================================================
-* Gesture ID
-==============================================================================
+Gesture ID
+==========
 
-  Unlike other devices which sends multiple fingers' coordinates to host,
+Unlike other devices which sends multiple fingers' coordinates to host,
 FSP processes multiple fingers' coordinates internally and convert them
 into a 8 bits integer, namely 'Gesture ID.'  Following is a list of
 supported gesture IDs:
 
+	======= ==================================
 	ID	Description
+	======= ==================================
 	0x86	2 finger straight up
 	0x82	2 finger straight down
 	0x80	2 finger straight right
@@ -687,38 +714,38 @@ supported gesture IDs:
 	0x28	3 finger straight right
 	0x2c	3 finger straight left
 	0x38	palm
+	======= ==================================
 
-==============================================================================
-* Register Listing
-==============================================================================
+Register Listing
+================
 
-  Registers are represented in 16 bits values. The higher 8 bits represent
+Registers are represented in 16 bits values. The higher 8 bits represent
 the page address and the lower 8 bits represent the relative offset within
 that particular page.  Refer to the 'Programming Sequence for Page Register
 Reading/Writing' section for instructions on how to change current page
-address.
+address::
 
-offset	width		default	r/w	name
-0x8200	bit7~bit0	0x01	RO	device ID
+ offset	width		default	r/w	name
+ 0x8200	bit7~bit0	0x01	RO	device ID
 
-0x8201	bit7~bit0		RW	version ID
+ 0x8201	bit7~bit0		RW	version ID
 					0xc1: STL3888 Ax
 					0xd0 ~ 0xd2: STL3888 Bx
 					0xe0 ~ 0xe1: STL3888 Cx
 					0xe2 ~ 0xe3: STL3888 Dx
 
-0x8202	bit7~bit0	0x01	RO	vendor ID
+ 0x8202	bit7~bit0	0x01	RO	vendor ID
 
-0x8203	bit7~bit0	0x01	RO	product ID
+ 0x8203	bit7~bit0	0x01	RO	product ID
 
-0x8204	bit3~bit0	0x01	RW	revision ID
+ 0x8204	bit3~bit0	0x01	RW	revision ID
 
-0x820b					test mode status 1
+ 0x820b					test mode status 1
 	bit3		1	RO	0: rotate 180 degree
 					1: no rotation
 					*only supported by H/W prior to Cx
 
-0x820f					register file page control
+ 0x820f					register file page control
 	bit2		0	RW	1: rotate 180 degree
 					0: no rotation
 					*supported since Cx
@@ -726,7 +753,7 @@ offset	width		default	r/w	name
 	bit0		0	RW	1 to enable page 1 register files
 					*only supported by H/W prior to Cx
 
-0x8210				RW	system control 1
+ 0x8210				RW	system control 1
 	bit0		1	RW	Reserved, must be 1
 	bit1		0	RW	Reserved, must be 0
 	bit4		0	RW	Reserved, must be 0
@@ -737,7 +764,7 @@ offset	width		default	r/w	name
 	40 41 42 43.  In addition to that, this bit must be 1 when gesture
 	mode is enabled)
 
-0x8220					test mode status
+ 0x8220					test mode status
 	bit5~bit4		RO	number of buttons
 					11 => 2, lbtn/rbtn
 					10 => 4, lbtn/rbtn/scru/scrd
@@ -745,13 +772,13 @@ offset	width		default	r/w	name
 					00 => 6, lbtn/rbtn/scru/scrd/fbtn/bbtn
 					*only supported by H/W prior to Cx
 
-0x8231				RW	on-pad command detection
+ 0x8231				RW	on-pad command detection
 	bit7		0	RW	on-pad command left button down tag
 					enable
 					0: disable, 1: enable
 					*only supported by H/W prior to Cx
 
-0x8234				RW	on-pad command control 5
+ 0x8234				RW	on-pad command control 5
 	bit4~bit0	0x05	RW	XLO in 0s/4/1, so 03h = 0010.1b = 2.5
 	(Note that position unit is in 0.5 scanline)
 					*only supported by H/W prior to Cx
@@ -760,22 +787,22 @@ offset	width		default	r/w	name
 					0: disable, 1: enable
 					*only supported by H/W prior to Cx
 
-0x8235				RW	on-pad command control 6
+ 0x8235				RW	on-pad command control 6
 	bit4~bit0	0x1d	RW	XHI in 0s/4/1, so 19h = 1100.1b = 12.5
 	(Note that position unit is in 0.5 scanline)
 					*only supported by H/W prior to Cx
 
-0x8236				RW	on-pad command control 7
+ 0x8236				RW	on-pad command control 7
 	bit4~bit0	0x04	RW	YLO in 0s/4/1, so 03h = 0010.1b = 2.5
 	(Note that position unit is in 0.5 scanline)
 					*only supported by H/W prior to Cx
 
-0x8237				RW	on-pad command control 8
+ 0x8237				RW	on-pad command control 8
 	bit4~bit0	0x13	RW	YHI in 0s/4/1, so 11h = 1000.1b = 8.5
 	(Note that position unit is in 0.5 scanline)
 					*only supported by H/W prior to Cx
 
-0x8240				RW	system control 5
+ 0x8240				RW	system control 5
 	bit1		0	RW	FSP Intellimouse mode enable
 					0: disable, 1: enable
 					*only supported by H/W prior to Cx
@@ -813,7 +840,7 @@ offset	width		default	r/w	name
 					0: disable, 1: enable
 					*only supported by H/W prior to Cx
 
-0x8243				RW	on-pad control
+ 0x8243				RW	on-pad control
 	bit0		0	RW	on-pad control enable
 					0: disable, 1: enable
 	(Note that if this bit is cleared, bit 3/5 will be ineffective)
@@ -827,7 +854,7 @@ offset	width		default	r/w	name
 					0: disable, 1: enable
 					*only supported by H/W prior to Cx
 
-0x8290				RW	software control register 1
+ 0x8290				RW	software control register 1
 	bit0		0	RW	absolute coordination mode
 					0: disable, 1: enable
 					*supported since Cx
@@ -856,16 +883,17 @@ offset	width		default	r/w	name
 					*supported since Cx
 
 	bit7		0	RW	Bx packet output compatible mode
-					0: disable, 1: enable					*supported since Cx
+					0: disable, 1: enable
+					*supported since Cx
 					*supported since Cx
 
 
-0x833d				RW	on-pad command control 1
+ 0x833d				RW	on-pad command control 1
 	bit7		1	RW	on-pad command detection enable
 					0: disable, 1: enable
 					*supported since Cx
 
-0x833e				RW	on-pad command detection
+ 0x833e				RW	on-pad command detection
 	bit7		0	RW	on-pad command left button down tag
 					enable. Works only in H/W based PS/2
 					data packet mode.
-- 
2.9.3


