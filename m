From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 1/6] elantech: Describe further the protocol
Date: Sat, 14 May 2011 08:44:42 +0200
Message-ID: <4DCE24DA.6050101@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:39764 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab1ENLIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

=46or some Dell laptops, Ubuntu had a special version of the elantech
driver with more knowledge on the devices. It can be found there:
http://zinc.ubuntu.com/git?p=3Dmid-team/hardy-netbook.git;a=3Dblob;f=3D=
drivers/input/mouse/elantech.c;h=3Dd0e2cafed162428f72e3654f4dda85e08ea4=
86b3;hb=3Drefs/heads/abi-22

By inspecting the source code, and doing some test on a real hardware, =
I
have completed the protocol specification (especially for the 6 bytes
protocol). It also adds information about the mapping between the
version reported by the device and the protocol to use.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 Documentation/input/elantech.txt |  122 ++++++++++++++++++++++++++++++=
-------
 1 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/ela=
ntech.txt
index 56941ae..437e8c1 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -34,7 +34,8 @@ Contents
 Currently the Linux Elantech touchpad driver is aware of two different
 hardware versions unimaginatively called version 1 and version 2. Vers=
ion 1
 is found in "older" laptops and uses 4 bytes per packet. Version 2 see=
ms to
-be introduced with the EeePC and uses 6 bytes per packet.
+be introduced with the EeePC and uses 6 bytes per packet, and provides
+additional features such as position of two fingers, and width of the =
touch.
=20
 The driver tries to support both hardware versions and should be compa=
tible
 with the Xorg Synaptics touchpad driver and its graphical configuratio=
n
@@ -94,18 +95,44 @@ Currently the Linux Elantech touchpad driver provid=
es two extra knobs under
    can check these bits and reject any packet that appears corrupted. =
Using
    this knob you can bypass that check.
=20
-   It is not known yet whether hardware version 2 provides the same pa=
rity
-   bits. Hence checking is disabled by default. Currently even turning=
 it on
-   will do nothing.
-
+   Hardware version 2 does not provide the same parity bits. Only some=
 basic
+   data consistency checking can be done. For now checking is disabled=
 by
+   default. Currently even turning it on will do nothing.
=20
 //////////////////////////////////////////////////////////////////////=
///////
=20
+3. Differentiating hardware versions
+   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To detect the hardware version, read the version number as param[0].pa=
ram[1].param[2]
+
+ 4 bytes version: (after the arrow is the name given in the Dell-provi=
ded driver)
+ 02.00.22 =3D> EF013
+ 02.06.00 =3D> EF019
+In the wild, there appear to be more versions, such as 00.01.64, 01.00=
=2E21,
+02.00.00, 02.00.04, 02.00.06.
+
+ 6 bytes:
+ 02.00.30 =3D> EF113
+ 02.08.00 =3D> EF023
+ 02.08.XX =3D> EF123
+ 02.0B.00 =3D> EF215
+ 04.01.XX =3D> Scroll_EF051
+ 04.02.XX =3D> EF051
+In the wild, there appear to be more versions, such as 04.03.01, 04.04=
=2E11. There
+appear to be almost no difference excepted the EF113 which do not repo=
rt
+pressure/width and has different data consistency checking.
+
+Probably all the versions with param[0] <=3D 01 can be considered as
+4 bytes/firmware 1. The versions < 02.08.00, with the exception of 02.=
00.30, as
+4 bytes/firmware 2. Everything >=3D 02.08.00 can be considered as 6 by=
tes.
+
+//////////////////////////////////////////////////////////////////////=
///////
=20
-3. Hardware version 1
+4. Hardware version 1
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-3.1 Registers
+4.1 Registers
     ~~~~~~~~~
=20
 By echoing a hexadecimal value to a register it contents can be altere=
d.
@@ -168,7 +195,7 @@ For example:
          smart edge activation area width?
=20
=20
-3.2 Native relative mode 4 byte packet format
+4.2 Native relative mode 4 byte packet format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
 byte 0:
@@ -226,9 +253,13 @@ byte 3:
                        positive =3D down
=20
=20
-3.3 Native absolute mode 4 byte packet format
+4.3 Native absolute mode 4 byte packet format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
+EF013 and EF019 have a special behaviour (due to a bug in the firmware=
?), and
+when 1 finger is touching, the first 2 position reports must be discar=
ded.
+This counting is reset whenever a different number of fingers is repor=
ted.
+
 byte 0:
    firmware version 1.x:
=20
@@ -279,11 +310,11 @@ byte 3:
 //////////////////////////////////////////////////////////////////////=
///////
=20
=20
-4. Hardware version 2
+5. Hardware version 2
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
-4.1 Registers
+5.1 Registers
     ~~~~~~~~~
=20
 By echoing a hexadecimal value to a register it contents can be altere=
d.
@@ -316,16 +347,41 @@ For example:
                                    0x7f =3D never i.e. tap again to re=
lease)
=20
=20
-4.2 Native absolute mode 6 byte packet format
+5.2 Native absolute mode 6 byte packet format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-4.2.1 One finger touch
+5.2.1 Parity checking and packet re-synchronization
+There is no parity checking, however some consistency checks can be pe=
rformed.
+
+For instance for EF113:
+        SA1=3D packet[0];
+        A1 =3D packet[1];
+        B1 =3D packet[2];
+        SB1=3D packet[3];
+        C1 =3D packet[4];
+        D1 =3D packet[5];
+        if( (((SA1 & 0x3C) !=3D 0x3C) && ((SA1 & 0xC0) !=3D 0x80)) || =
// check Byte 1
+            (((SA1 & 0x0C) !=3D 0x0C) && ((SA1 & 0xC0) =3D=3D 0x80)) |=
| // check Byte 1 (one finger pressed)
+            (((SA1 & 0xC0) !=3D 0x80) && (( A1 & 0xF0) !=3D 0x00)) || =
// check Byte 2
+            (((SB1 & 0x3E) !=3D 0x38) && ((SA1 & 0xC0) !=3D 0x80)) || =
// check Byte 4
+            (((SB1 & 0x0E) !=3D 0x08) && ((SA1 & 0xC0) =3D=3D 0x80)) |=
| // check Byte 4 (one finger pressed)
+            (((SA1 & 0xC0) !=3D 0x80) && (( C1 & 0xF0) !=3D 0x00))  ) =
// check Byte 5
+		// error detected
+
+For all the other ones, there are just a few constant bits:
+        if( ((packet[0] & 0x0C) !=3D 0x04) ||
+            ((packet[3] & 0x0f) !=3D 0x02) )
+		// error detected
+
+
+In case an error is detected, all the packets are shifted by one (and =
packet[0] is discarded).
+
+5.2.1 One/Three finger touch
       ~~~~~~~~~~~~~~~~
=20
 byte 0:
=20
    bit   7   6   5   4   3   2   1   0
-        n1  n0   .   .   .   .   R   L
+        n1  n0  w3  w2   .   .   R   L
=20
          L, R =3D 1 when Left, Right mouse button pressed
          n1..n0 =3D numbers of fingers on touchpad
@@ -333,24 +389,39 @@ byte 0:
 byte 1:
=20
    bit   7   6   5   4   3   2   1   0
-         .   .   .   .   .  x10 x9  x8
+         p7  p6  p5  p4  .  x10 x9  x8
=20
 byte 2:
=20
    bit   7   6   5   4   3   2   1   0
-        x7  x6  x5  x4  x4  x2  x1  x0
+        x7  x6  x5  x4  x3  x2  x1  x0
=20
          x10..x0 =3D absolute x value (horizontal)
=20
 byte 3:
=20
    bit   7   6   5   4   3   2   1   0
-         .   .   .   .   .   .   .   .
+        n4  vf  w1  w0   .   .   .  b2
+
+         n4 =3D set if more than 3 fingers (only in 3 fingers mode)
+	 vf =3D a kind of flag ? (only on EF123, 0 when finger is over one of=
 the buttons, 1 otherwise)
+	 w3..w0 =3D width of the finger touch (not EF113)
+	 b2 (on EF113 only, 0 otherwise), b2.R.L indicates one button pressed=
:
+		0 =3D none
+		1 =3D Left
+		2 =3D Right
+		3 =3D Middle (Left and Right)
+		4 =3D Forward
+		5 =3D Back
+		6 =3D Another one
+		7 =3D Another one
=20
 byte 4:
=20
    bit   7   6   5   4   3   2   1   0
-         .   .   .   .   .   .  y9  y8
+        p3  p1  p2  p0   .   .  y9  y8
+
+	 p7..p0 =3D pressure (not EF113)
=20
 byte 5:
=20
@@ -363,6 +434,11 @@ byte 5:
 4.2.2 Two finger touch
       ~~~~~~~~~~~~~~~~
=20
+Note that the two pairs of coordinates are not exactly the coordinates=
 of the
+two fingers, but only the pair of the lower-left and upper-right coord=
inates.
+So the actual fingers might be situated on the other diagonal of the s=
quare
+defined by these two points.
+
 byte 0:
=20
    bit   7   6   5   4   3   2   1   0
@@ -376,14 +452,14 @@ byte 1:
    bit   7   6   5   4   3   2   1   0
         ax7 ax6 ax5 ax4 ax3 ax2 ax1 ax0
=20
-         ax8..ax0 =3D first finger absolute x value
+         ax8..ax0 =3D lower-left finger absolute x value
=20
 byte 2:
=20
    bit   7   6   5   4   3   2   1   0
         ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0
=20
-         ay8..ay0 =3D first finger absolute y value
+         ay8..ay0 =3D lower-left finger absolute y value
=20
 byte 3:
=20
@@ -395,11 +471,11 @@ byte 4:
    bit   7   6   5   4   3   2   1   0
         bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
=20
-         bx8..bx0 =3D second finger absolute x value
+         bx8..bx0 =3D upper-right finger absolute x value
=20
 byte 5:
=20
    bit   7   6   5   4   3   2   1   0
         by7 by8 by5 by4 by3 by2 by1 by0
=20
-         by8..by0 =3D second finger absolute y value
+         by8..by0 =3D upper-right finger absolute y value
--=20
1.7.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
