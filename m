From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 02/33] docs: input/alps: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:45 -0300
Message-ID: <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ben Gamari <ben@smart-cactus.org>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/alps.txt | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
index 8d1341ccde64..76a71a146e50 100644
--- a/Documentation/input/alps.txt
+++ b/Documentation/input/alps.txt
@@ -1,3 +1,4 @@
+----------------------
 ALPS Touchpad Protocol
 ----------------------
 
@@ -78,7 +79,7 @@ of the EC response.
 Packet Format
 -------------
 
-In the following tables, the following notation is used.
+In the following tables, the following notation is used::
 
  CAPITALS = stick, miniscules = touchpad
 
@@ -88,6 +89,8 @@ extra buttons, stick buttons on a dualpoint, etc.
 PS/2 packet format
 ------------------
 
+::
+
  byte 0:  0    0 YSGN XSGN    1    M    R    L
  byte 1: X7   X6   X5   X4   X3   X2   X1   X0
  byte 2: Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
@@ -99,7 +102,9 @@ are on the touchpad, the M R L bits signal the combined status of both the
 pointingstick and touchpad buttons.
 
 ALPS Absolute Mode - Protocol Version 1
---------------------------------------
+---------------------------------------
+
+::
 
  byte 0:  1    0    0    0    1   x9   x8   x7
  byte 1:  0   x6   x5   x4   x3   x2   x1   x0
@@ -111,6 +116,8 @@ ALPS Absolute Mode - Protocol Version 1
 ALPS Absolute Mode - Protocol Version 2
 ---------------------------------------
 
+::
+
  byte 0:  1    ?    ?    ?    1  PSM  PSR  PSL
  byte 1:  0   x6   x5   x4   x3   x2   x1   x0
  byte 2:  0  x10   x9   x8   x7    ?  fin  ges
@@ -127,6 +134,8 @@ and PSL bits.
 Dualpoint device -- interleaved packet format
 ---------------------------------------------
 
+::
+
  byte 0:    1    1    0    0    1    1    1    1
  byte 1:    0   x6   x5   x4   x3   x2   x1   x0
  byte 2:    0  x10   x9   x8   x7    0  fin  ges
@@ -149,7 +158,7 @@ ALPS protocol version 3 has three different packet formats. The first two are
 associated with touchpad events, and the third is associated with trackstick
 events.
 
-The first type is the touchpad position packet.
+The first type is the touchpad position packet::
 
  byte 0:    1    ?   x1   x0    1    1    1    1
  byte 1:    0  x10   x9   x8   x7   x6   x5   x4
@@ -165,7 +174,7 @@ The second packet type contains bitmaps representing the x and y axes. In the
 bitmaps a given bit is set if there is a finger covering that position on the
 given axis. Thus the bitmap packet can be used for low-resolution multi-touch
 data, although finger tracking is not possible.  This packet also encodes the
-number of contacts (f1 and f0 in the table below).
+number of contacts (f1 and f0 in the table below)::
 
  byte 0:    1    1   x1   x0    1    1    1    1
  byte 1:    0   x8   x7   x6   x5   x4   x3   x2
@@ -178,7 +187,7 @@ This packet only appears after a position packet with the mt bit set, and
 usually only appears when there are two or more contacts (although
 occasionally it's seen with only a single contact).
 
-The final v3 packet type is the trackstick packet.
+The final v3 packet type is the trackstick packet::
 
  byte 0:    1    1   x7   y7    1    1    1    1
  byte 1:    0   x6   x5   x4   x3   x2   x1   x0
@@ -190,7 +199,7 @@ The final v3 packet type is the trackstick packet.
 ALPS Absolute Mode - Protocol Version 4
 ---------------------------------------
 
-Protocol version 4 has an 8-byte packet format.
+Protocol version 4 has an 8-byte packet format::
 
  byte 0:    1    ?   x1   x0    1    1    1    1
  byte 1:    0  x10   x9   x8   x7   x6   x5   x4
@@ -203,7 +212,7 @@ Protocol version 4 has an 8-byte packet format.
 
 The last two bytes represent a partial bitmap packet, with 3 full packets
 required to construct a complete bitmap packet.  Once assembled, the 6-byte
-bitmap packet has the following format:
+bitmap packet has the following format::
 
  byte 0:    0    1   x7   x6   x5   x4   x3   x2
  byte 1:    0   x1   x0   y4   y3   y2   y1   y0
@@ -238,7 +247,7 @@ decode.  It uses the same alps_process_touchpad_packet_v3 call with a
 specialized decode_fields function pointer to correctly interpret the
 packets.  This appears to only be used by the Dolphin devices.
 
-For single-touch, the 6-byte packet format is:
+For single-touch, the 6-byte packet format is::
 
  byte 0:    1    1    0    0    1    0    0    0
  byte 1:    0   x6   x5   x4   x3   x2   x1   x0
@@ -247,7 +256,7 @@ For single-touch, the 6-byte packet format is:
  byte 4:   y10  y9   y8   y7  x10   x9   x8   x7
  byte 5:    0   z6   z5   z4   z3   z2   z1   z0
 
-For mt, the format is:
+For mt, the format is::
 
  byte 0:    1    1    1    n3   1   n2   n1   x24
  byte 1:    1   y7   y6    y5  y4   y3   y2    y1
@@ -259,7 +268,7 @@ For mt, the format is:
 ALPS Absolute Mode - Protocol Version 6
 ---------------------------------------
 
-For trackstick packet, the format is:
+For trackstick packet, the format is::
 
  byte 0:    1    1    1    1    1    1    1    1
  byte 1:    0   X6   X5   X4   X3   X2   X1   X0
@@ -268,7 +277,7 @@ For trackstick packet, the format is:
  byte 4:   Z7   Z6   Z5   Z4   Z3   Z2   Z1   Z0
  byte 5:    0    1    1    1    1    1    1    1
 
-For touchpad packet, the format is:
+For touchpad packet, the format is::
 
  byte 0:    1    1    1    1    1    1    1    1
  byte 1:    0    0    0    0   x3   x2   x1   x0
@@ -282,7 +291,7 @@ For touchpad packet, the format is:
 ALPS Absolute Mode - Protocol Version 7
 ---------------------------------------
 
-For trackstick packet, the format is:
+For trackstick packet, the format is::
 
  byte 0:    0    1    0    0    1    0    0    0
  byte 1:    1    1    *    *    1    M    R    L
@@ -291,7 +300,7 @@ For trackstick packet, the format is:
  byte 4:   Y7    0   Y5   Y4   Y3    1    1    0
  byte 5:  T&P    0   Z5   Z4   Z3   Z2   Z1   Z0
 
-For touchpad packet, the format is:
+For touchpad packet, the format is::
 
          packet-fmt     b7     b6     b5     b4     b3     b2     b1     b0
  byte 0: TWO & MULTI     L      1      R      M      1   Y0-2   Y0-1   Y0-0
@@ -328,7 +337,7 @@ Spoken by SS4 (73 03 14) and SS5 (73 03 28) hardware.
 
 The packet type is given by the APD field, bits 4-5 of byte 3.
 
-Touchpad packet (APD = 0x2):
+Touchpad packet (APD = 0x2)::
 
            b7   b6   b5   b4   b3   b2   b1   b0
  byte 0:  SWM  SWR  SWL    1    1    0    0   X7
@@ -340,7 +349,7 @@ Touchpad packet (APD = 0x2):
 
 SWM, SWR, SWL: Middle, Right, and Left button states
 
-Touchpad 1 Finger packet (APD = 0x0):
+Touchpad 1 Finger packet (APD = 0x0)::
 
            b7   b6   b5   b4   b3   b2   b1   b0
  byte 0:  SWM  SWR  SWL    1    1   X2   X1   X0
@@ -353,7 +362,7 @@ Touchpad 1 Finger packet (APD = 0x0):
 TAPF: ???
 LFB:  ???
 
-Touchpad 2 Finger packet (APD = 0x1):
+Touchpad 2 Finger packet (APD = 0x1)::
 
            b7   b6   b5   b4   b3   b2   b1   b0
  byte 0:  SWM  SWR  SWL    1    1  AX6  AX5  AX4
@@ -365,7 +374,7 @@ Touchpad 2 Finger packet (APD = 0x1):
 
 CONT: A 3-or-4 Finger packet is to follow
 
-Touchpad 3-or-4 Finger packet (APD = 0x3):
+Touchpad 3-or-4 Finger packet (APD = 0x3)::
 
            b7   b6   b5   b4   b3   b2   b1   b0
  byte 0:  SWM  SWR  SWL    1    1  AX6  AX5  AX4
-- 
2.9.3


