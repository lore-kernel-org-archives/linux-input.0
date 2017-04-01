From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 16/33] docs: input/iforce-protocol: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:59 -0300
Message-ID: <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
 <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file seems to be using some other markup language,
(maybe mediawiki?). Manually convert it to ReST markup,
with is the one we're using along the Kernel documentaiton.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/iforce-protocol.txt | 495 ++++++++++++++++++++------------
 1 file changed, 309 insertions(+), 186 deletions(-)

diff --git a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.txt
index 66287151c54a..8634beac3fdb 100644
--- a/Documentation/input/iforce-protocol.txt
+++ b/Documentation/input/iforce-protocol.txt
@@ -1,4 +1,17 @@
-** Introduction
+===============
+Iforce Protocol
+===============
+
+:Author: Johann Deneux <johann.deneux@gmail.com>
+
+Home page at `<http://web.archive.org/web/*/http://www.esil.univ-mrs.fr>`_
+
+:Additions: by Vojtech Pavlik.
+
+
+Introduction
+============
+
 This document describes what I managed to discover about the protocol used to
 specify force effects to I-Force 2.0 devices.  None of this information comes
 from Immerse. That's why you should not trust what is written in this
@@ -6,238 +19,350 @@ document. This document is intended to help understanding the protocol.
 This is not a reference. Comments and corrections are welcome.  To contact me,
 send an email to: johann.deneux@gmail.com
 
-** WARNING **
-I shall not be held responsible for any damage or harm caused if you try to
-send data to your I-Force device based on what you read in this document.
+.. warning::
+
+    I shall not be held responsible for any damage or harm caused if you try to
+    send data to your I-Force device based on what you read in this document.
+
+Preliminary Notes
+=================
 
-** Preliminary Notes:
 All values are hexadecimal with big-endian encoding (msb on the left). Beware,
 values inside packets are encoded using little-endian.  Bytes whose roles are
 unknown are marked ???  Information that needs deeper inspection is marked (?)
 
-** General form of a packet **
+General form of a packet
+------------------------
+
 This is how packets look when the device uses the rs232 to communicate.
+
+== == === ==== ==
 2B OP LEN DATA CS
+== == === ==== ==
+
 CS is the checksum. It is equal to the exclusive or of all bytes.
 
 When using USB:
+
+== ====
 OP DATA
-The 2B, LEN and CS fields have disappeared, probably because USB handles frames and
-data corruption is handled or unsignificant.
+== ====
+
+The 2B, LEN and CS fields have disappeared, probably because USB handles
+frames and data corruption is handled or unsignificant.
 
 First, I describe effects that are sent by the device to the computer
 
-** Device input state
+Device input state
+==================
+
 This packet is used to indicate the state of each button and the value of each
-axis
-OP= 01 for a joystick, 03 for a wheel
-LEN= Varies from device to device
-00 X-Axis lsb
-01 X-Axis msb
-02 Y-Axis lsb, or gas pedal for a wheel
-03 Y-Axis msb, or brake pedal for a wheel
-04 Throttle
-05 Buttons
-06 Lower 4 bits: Buttons
-   Upper 4 bits: Hat
-07 Rudder
-
-** Device effects states
-OP= 02
-LEN= Varies
-00 ? Bit 1 (Value 2) is the value of the deadman switch
-01 Bit 8 is set if the effect is playing. Bits 0 to 7 are the effect id.
-02 ??
-03 Address of parameter block changed (lsb)
-04 Address of parameter block changed (msb)
-05 Address of second parameter block changed (lsb)
-... depending on the number of parameter blocks updated
-
-** Force effect **
-OP=  01
-LEN= 0e
-00 Channel (when playing several effects at the same time, each must be assigned a channel)
-01 Wave form
-	Val 00 Constant
-	Val 20 Square
-	Val 21 Triangle
-	Val 22 Sine
-	Val 23 Sawtooth up
-	Val 24 Sawtooth down
-	Val 40 Spring (Force = f(pos))
-	Val 41 Friction (Force = f(velocity)) and Inertia (Force = f(acceleration))
-
-
-02 Axes affected and trigger
-	Bits 4-7: Val 2 = effect along one axis. Byte 05 indicates direction
-	          Val 4 = X axis only. Byte 05 must contain 5a
-	          Val 8 = Y axis only. Byte 05 must contain b4
-	          Val c = X and Y axes. Bytes 05 must contain 60
-	Bits 0-3: Val 0 = No trigger
-	          Val x+1 = Button x triggers the effect
-	When the whole byte is 0, cancel the previously set trigger
-
-03-04 Duration of effect (little endian encoding, in ms)
-
-05 Direction of effect, if applicable. Else, see 02 for value to assign.
-
-06-07 Minimum time between triggering.
-
-08-09 Address of periodicity or magnitude parameters
-0a-0b Address of attack and fade parameters, or ffff if none.
-*or*
-08-09 Address of interactive parameters for X-axis, or ffff if not applicable
-0a-0b Address of interactive parameters for Y-axis, or ffff if not applicable
-
-0c-0d Delay before execution of effect (little endian encoding, in ms)
-
-
-** Time based parameters **
-
-*** Attack and fade ***
-OP=  02
-LEN= 08
-00-01 Address where to store the parameters
-02-03 Duration of attack (little endian encoding, in ms)
-04 Level at end of attack. Signed byte.
-05-06 Duration of fade.
-07 Level at end of fade.
-
-*** Magnitude ***
-OP=  03
-LEN= 03
-00-01 Address
-02 Level. Signed byte.
-
-*** Periodicity ***
-OP=  04
-LEN= 07
-00-01 Address
-02 Magnitude. Signed byte.
-03 Offset. Signed byte.
-04 Phase. Val 00 = 0 deg, Val 40 = 90 degs.
-05-06 Period (little endian encoding, in ms)
-
-** Interactive parameters **
-OP=  05
-LEN= 0a
-00-01 Address
-02 Positive Coeff
-03 Negative Coeff
-04+05 Offset (center)
-06+07 Dead band (Val 01F4 = 5000 (decimal))
-08 Positive saturation (Val 0a = 1000 (decimal) Val 64 = 10000 (decimal))
-09 Negative saturation
+axis::
+
+    OP= 01 for a joystick, 03 for a wheel
+    LEN= Varies from device to device
+    00 X-Axis lsb
+    01 X-Axis msb
+    02 Y-Axis lsb, or gas pedal for a wheel
+    03 Y-Axis msb, or brake pedal for a wheel
+    04 Throttle
+    05 Buttons
+    06 Lower 4 bits: Buttons
+       Upper 4 bits: Hat
+    07 Rudder
+
+Device effects states
+=====================
+
+::
+
+    OP= 02
+    LEN= Varies
+    00 ? Bit 1 (Value 2) is the value of the deadman switch
+    01 Bit 8 is set if the effect is playing. Bits 0 to 7 are the effect id.
+    02 ??
+    03 Address of parameter block changed (lsb)
+    04 Address of parameter block changed (msb)
+    05 Address of second parameter block changed (lsb)
+    ... depending on the number of parameter blocks updated
+
+Force effect
+------------
+
+::
+
+    OP=  01
+    LEN= 0e
+    00 Channel (when playing several effects at the same time, each must
+                be assigned a channel)
+    01 Wave form
+	    Val 00 Constant
+	    Val 20 Square
+	    Val 21 Triangle
+	    Val 22 Sine
+	    Val 23 Sawtooth up
+	    Val 24 Sawtooth down
+	    Val 40 Spring (Force = f(pos))
+	    Val 41 Friction (Force = f(velocity)) and Inertia
+	           (Force = f(acceleration))
+
+
+    02 Axes affected and trigger
+	    Bits 4-7: Val 2 = effect along one axis. Byte 05 indicates direction
+		    Val 4 = X axis only. Byte 05 must contain 5a
+		    Val 8 = Y axis only. Byte 05 must contain b4
+		    Val c = X and Y axes. Bytes 05 must contain 60
+	    Bits 0-3: Val 0 = No trigger
+		    Val x+1 = Button x triggers the effect
+	    When the whole byte is 0, cancel the previously set trigger
+
+    03-04 Duration of effect (little endian encoding, in ms)
+
+    05 Direction of effect, if applicable. Else, see 02 for value to assign.
+
+    06-07 Minimum time between triggering.
+
+    08-09 Address of periodicity or magnitude parameters
+    0a-0b Address of attack and fade parameters, or ffff if none.
+    *or*
+    08-09 Address of interactive parameters for X-axis,
+          or ffff if not applicable
+    0a-0b Address of interactive parameters for Y-axis,
+	  or ffff if not applicable
+
+    0c-0d Delay before execution of effect (little endian encoding, in ms)
+
+
+Time based parameters
+---------------------
+
+Attack and fade
+^^^^^^^^^^^^^^^
+
+::
+
+    OP=  02
+    LEN= 08
+    00-01 Address where to store the parameters
+    02-03 Duration of attack (little endian encoding, in ms)
+    04 Level at end of attack. Signed byte.
+    05-06 Duration of fade.
+    07 Level at end of fade.
+
+Magnitude
+^^^^^^^^^
+
+::
+
+    OP=  03
+    LEN= 03
+    00-01 Address
+    02 Level. Signed byte.
+
+Periodicity
+^^^^^^^^^^^
+
+::
+
+    OP=  04
+    LEN= 07
+    00-01 Address
+    02 Magnitude. Signed byte.
+    03 Offset. Signed byte.
+    04 Phase. Val 00 = 0 deg, Val 40 = 90 degs.
+    05-06 Period (little endian encoding, in ms)
+
+Interactive parameters
+----------------------
+
+::
+
+    OP=  05
+    LEN= 0a
+    00-01 Address
+    02 Positive Coeff
+    03 Negative Coeff
+    04+05 Offset (center)
+    06+07 Dead band (Val 01F4 = 5000 (decimal))
+    08 Positive saturation (Val 0a = 1000 (decimal) Val 64 = 10000 (decimal))
+    09 Negative saturation
 
 The encoding is a bit funny here: For coeffs, these are signed values. The
 maximum value is 64 (100 decimal), the min is 9c.
 For the offset, the minimum value is FE0C, the maximum value is 01F4.
 For the deadband, the minimum value is 0, the max is 03E8.
 
-** Controls **
-OP=  41
-LEN= 03
-00 Channel
-01 Start/Stop
-	Val 00: Stop
-	Val 01: Start and play once.
-	Val 41: Start and play n times (See byte 02 below)
-02 Number of iterations n.
-
-** Init **
-
-*** Querying features ***
-OP=  ff
-Query command. Length varies according to the query type.
-The general format of this packet is:
-ff 01 QUERY [INDEX] CHECKSUM
-responses are of the same form:
-FF LEN QUERY VALUE_QUERIED CHECKSUM2
-where LEN = 1 + length(VALUE_QUERIED)
-
-**** Query ram size ****
-QUERY = 42 ('B'uffer size)
+Controls
+--------
+
+::
+
+    OP=  41
+    LEN= 03
+    00 Channel
+    01 Start/Stop
+	    Val 00: Stop
+	    Val 01: Start and play once.
+	    Val 41: Start and play n times (See byte 02 below)
+    02 Number of iterations n.
+
+Init
+----
+
+
+Querying features
+^^^^^^^^^^^^^^^^^
+::
+
+    OP=  ff
+    Query command. Length varies according to the query type.
+    The general format of this packet is:
+    ff 01 QUERY [INDEX] CHECKSUM
+    responses are of the same form:
+    FF LEN QUERY VALUE_QUERIED CHECKSUM2
+    where LEN = 1 + length(VALUE_QUERIED)
+
+Query ram size
+~~~~~~~~~~~~~~
+
+::
+
+    QUERY = 42 ('B'uffer size)
+
 The device should reply with the same packet plus two additional bytes
 containing the size of the memory:
 ff 03 42 03 e8 CS would mean that the device has 1000 bytes of ram available.
 
-**** Query number of effects ****
-QUERY = 4e ('N'umber of effects)
+Query number of effects
+~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    QUERY = 4e ('N'umber of effects)
+
 The device should respond by sending the number of effects that can be played
 at the same time (one byte)
 ff 02 4e 14 CS would stand for 20 effects.
 
-**** Vendor's id ****
-QUERY = 4d ('M'anufacturer)
+Vendor's id
+~~~~~~~~~~~
+
+::
+
+    QUERY = 4d ('M'anufacturer)
+
 Query the vendors'id (2 bytes)
 
-**** Product id *****
-QUERY = 50 ('P'roduct)
+Product id
+~~~~~~~~~~
+
+::
+
+    QUERY = 50 ('P'roduct)
+
 Query the product id (2 bytes)
 
-**** Open device ****
-QUERY = 4f ('O'pen)
+Open device
+~~~~~~~~~~~
+
+::
+
+    QUERY = 4f ('O'pen)
+
 No data returned.
 
-**** Close device *****
-QUERY = 43 ('C')lose
+Close device
+~~~~~~~~~~~~
+
+::
+
+    QUERY = 43 ('C')lose
+
 No data returned.
 
-**** Query effect ****
-QUERY = 45 ('E')
+Query effect
+~~~~~~~~~~~~
+
+::
+
+    QUERY = 45 ('E')
+
 Send effect type.
 Returns nonzero if supported (2 bytes)
 
-**** Firmware Version ****
-QUERY = 56 ('V'ersion)
+Firmware Version
+~~~~~~~~~~~~~~~~
+
+::
+
+    QUERY = 56 ('V'ersion)
+
 Sends back 3 bytes - major, minor, subminor
 
-*** Initialisation of the device ***
-
-**** Set Control ****
-!!! Device dependent, can be different on different models !!!
-OP=  40 <idx> <val> [<val>]
-LEN= 2 or 3
-00 Idx
-   Idx 00 Set dead zone (0..2048)
-   Idx 01 Ignore Deadman sensor (0..1)
-   Idx 02 Enable comm watchdog (0..1)
-   Idx 03 Set the strength of the spring (0..100)
-   Idx 04 Enable or disable the spring (0/1)
-   Idx 05 Set axis saturation threshold (0..2048)
-
-**** Set Effect State ****
-OP=  42 <val>
-LEN= 1
-00 State
-   Bit 3 Pause force feedback
-   Bit 2 Enable force feedback
-   Bit 0 Stop all effects
-
-**** Set overall gain ****
-OP=  43 <val>
-LEN= 1
-00 Gain
-   Val 00 = 0%
-   Val 40 = 50%
-   Val 80 = 100%
-
-** Parameter memory **
+Initialisation of the device
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Set Control
+~~~~~~~~~~~
+
+.. note::
+    Device dependent, can be different on different models!
+
+::
+
+    OP=  40 <idx> <val> [<val>]
+    LEN= 2 or 3
+    00 Idx
+       Idx 00 Set dead zone (0..2048)
+       Idx 01 Ignore Deadman sensor (0..1)
+       Idx 02 Enable comm watchdog (0..1)
+       Idx 03 Set the strength of the spring (0..100)
+       Idx 04 Enable or disable the spring (0/1)
+       Idx 05 Set axis saturation threshold (0..2048)
+
+Set Effect State
+~~~~~~~~~~~~~~~~
+
+::
+
+    OP=  42 <val>
+    LEN= 1
+    00 State
+       Bit 3 Pause force feedback
+       Bit 2 Enable force feedback
+       Bit 0 Stop all effects
+
+Set overall
+~~~~~~~~~~~
+
+::
+
+    OP=  43 <val>
+    LEN= 1
+    00 Gain
+       Val 00 = 0%
+       Val 40 = 50%
+       Val 80 = 100%
+
+Parameter memory
+----------------
 
 Each device has a certain amount of memory to store parameters of effects.
 The amount of RAM may vary, I encountered values from 200 to 1000 bytes. Below
 is the amount of memory apparently needed for every set of parameters:
+
  - period : 0c
  - magnitude : 02
  - attack and fade : 0e
  - interactive : 08
 
-** Appendix: How to study the protocol ? **
+Appendix: How to study the protocol?
+====================================
 
-1. Generate effects using the force editor provided with the DirectX SDK, or 
-use Immersion Studio (freely available at their web site in the developer section: 
+1. Generate effects using the force editor provided with the DirectX SDK, or
+use Immersion Studio (freely available at their web site in the developer section:
 www.immersion.com)
-2. Start a soft spying RS232 or USB (depending on where you connected your 
+2. Start a soft spying RS232 or USB (depending on where you connected your
 joystick/wheel). I used ComPortSpy from fCoder (alpha version!)
 3. Play the effect, and watch what happens on the spy screen.
 
@@ -246,13 +371,11 @@ At first glance, this software seems, hum, well... buggy. In fact, data appear w
 few seconds latency. Personally, I restart it every time I play an effect.
 Remember it's free (as in free beer) and alpha!
 
-** URLS **
-Check www.immerse.com for Immersion Studio, and www.fcoder.com for ComPortSpy.
+URLS
+====
 
-** Author of this document **
-Johann Deneux <johann.deneux@gmail.com>
-Home page at http://web.archive.org/web/*/http://www.esil.univ-mrs.fr
+Check http://www.immerse.com for Immersion Studio,
+and http://www.fcoder.com for ComPortSpy.
 
-Additions by Vojtech Pavlik.
 
 I-Force is trademark of Immersion Corp.
-- 
2.9.3


