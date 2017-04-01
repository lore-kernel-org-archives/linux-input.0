From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 29/33] docs: input/yealink: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:12 -0300
Message-ID: <c73bfd1906e067331ed9717d62a2eae4aaf2ce9a.1491069870.git.mchehab@s-opensource.com>
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
 <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
 <011680ea06ad0b73922b17a6c453d5891bfd5386.1491069870.git.mchehab@s-opensource.com>
 <87be2676f773a689c9b39c4f79cd843fb3678133.1491069870.git.mchehab@s-opensource.com>
 <6730cd298d203d22aec9a5a708cd1d15982e624b.1491069870.git.mchehab@s-opensource.com>
 <b9b1a9e27971fd899876825f2ccfd638c6c62668.1491069870.git.mchehab@s-opensource.com>
 <07a688fbc69c47362aca5882a3bcf72329d0fe1a.1491069870.git.mchehab@s-opensource.com>
 <13245dfb9e3a0f34547925ef3e6efc87b8165ae2.1491069870.git.mchehab@s-opensource.com>
 <355358d79dca250017195f1e0309d64edd432a07.1491069870.git.mchehab@s-opensource.com>
 <74a6c5b672275a8a40317a76c72845a939089c89.1491069870.git.mchehab@s-opensource.com>
 <d55bc5210e28c8c0bb4179e58359a8ff7b234f41.1491069870.git.mchehab@s-opensource.com>
 <84c4c711e5b98aafca81460742d5c25fbb24474b.1491069870.git.mchehab@s-opensource.com>
 <2aece6cda8b5835832b4a3987c8818697aacc583.1491069870.git.mchehab@s-opensource.com>
 <4f55d4a177f311a1bc1c8ee5547ec53c3f92fefe.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4f55d4a177f311a1bc1c8ee5547ec53c3f92fefe.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Henk Vergonet <Henk.Vergonet@gmail.com>, usbb2k-api-dev@nongnu.org
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/yealink.txt | 159 +++++++++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 68 deletions(-)

diff --git a/Documentation/input/yealink.txt b/Documentation/input/yealink.txt
index 8277b76ec506..2683ba56a2da 100644
--- a/Documentation/input/yealink.txt
+++ b/Documentation/input/yealink.txt
@@ -1,8 +1,12 @@
+===============================================
 Driver documentation for yealink usb-p1k phones
+===============================================
+
+Status
+======
 
-0. Status
-~~~~~~~~~
 The p1k is a relatively cheap usb 1.1 phone with:
+
   - keyboard		full support, yealink.ko / input event API
   - LCD			full support, yealink.ko / sysfs API
   - LED			full support, yealink.ko / sysfs API
@@ -14,10 +18,11 @@ The p1k is a relatively cheap usb 1.1 phone with:
 For vendor documentation see http://www.yealink.com
 
 
-1. Compilation (stand alone version)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Compilation (stand alone version)
+=================================
+
 Currently only kernel 2.6.x.y versions are supported.
-In order to build the yealink.ko module do
+In order to build the yealink.ko module do::
 
   make
 
@@ -26,26 +31,28 @@ the Makefile is pointing to the location where your kernel sources
 are located, default /usr/src/linux.
 
 
-1.1 Troubleshooting
-~~~~~~~~~~~~~~~~~~~
-Q: Module yealink compiled and installed without any problem but phone
-   is not initialized and does not react to any actions.
-A: If you see something like:
-   hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
-   in dmesg, it means that the hid driver has grabbed the device first. Try to
-   load module yealink before any other usb hid driver. Please see the
-   instructions provided by your distribution on module configuration.
+Troubleshooting
+~~~~~~~~~~~~~~~
 
-Q: Phone is working now (displays version and accepts keypad input) but I can't
-   find the sysfs files.
-A: The sysfs files are located on the particular usb endpoint. On most
-   distributions you can do: "find /sys/ -name get_icons" for a hint.
+:Q: Module yealink compiled and installed without any problem but phone
+    is not initialized and does not react to any actions.
+:A: If you see something like:
+    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
+    in dmesg, it means that the hid driver has grabbed the device first. Try to
+    load module yealink before any other usb hid driver. Please see the
+    instructions provided by your distribution on module configuration.
 
+:Q: Phone is working now (displays version and accepts keypad input) but I can't
+    find the sysfs files.
+:A: The sysfs files are located on the particular usb endpoint. On most
+    distributions you can do: "find /sys/ -name get_icons" for a hint.
+
+
+keyboard features
+=================
 
-2. keyboard features
-~~~~~~~~~~~~~~~~~~~~
 The current mapping in the kernel is provided by the map_p1k_to_key
-function:
+function::
 
    Physical USB-P1K button layout	input events
 
@@ -60,14 +67,15 @@ function:
         7      8      9			7, 8, 9,
         *      0      #			*, 0, #,
 
-  The "up" and "down" keys, are symbolised by arrows on the button.
-  The "pickup" and "hangup" keys are symbolised by a green and red phone
-  on the button.
+The "up" and "down" keys, are symbolised by arrows on the button.
+The "pickup" and "hangup" keys are symbolised by a green and red phone
+on the button.
 
 
-3. LCD features
-~~~~~~~~~~~~~~~
-The LCD is divided and organised as a 3 line display:
+LCD features
+============
+
+The LCD is divided and organised as a 3 line display::
 
     |[]   [][]   [][]   [][]   in   |[][]
     |[] M [][] D [][] : [][]   out  |[][]
@@ -79,18 +87,19 @@ The LCD is divided and organised as a 3 line display:
     [] [] [] [] [] [] [] [] [] [] [] []
 
 
-Line 1	Format (see below)	: 18.e8.M8.88...188
-	Icon names		:   M  D  :  IN OUT STORE
-Line 2  Format			: .........
-	Icon name		: NEW REP SU MO TU WE TH FR SA
-Line 3  Format			: 888888888888
+  Line 1  Format (see below)	: 18.e8.M8.88...188
+	  Icon names		:   M  D  :  IN OUT STORE
+  Line 2  Format		: .........
+	  Icon name		: NEW REP SU MO TU WE TH FR SA
+  Line 3  Format		: 888888888888
 
 
 Format description:
   From a userspace perspective the world is separated into "digits" and "icons".
   A digit can have a character set, an icon can only be ON or OFF.
 
-  Format specifier
+  Format specifier::
+
     '8' :  Generic 7 segment digit with individual addressable segments
 
     Reduced capability 7 segment digit, when segments are hard wired together.
@@ -105,9 +114,11 @@ Format description:
 	  elements.
 
 
-4. Driver usage
-~~~~~~~~~~~~~~~
-For userland the following interfaces are available using the sysfs interface:
+Driver usage
+============
+
+For userland the following interfaces are available using the sysfs interface::
+
   /sys/.../
            line1	Read/Write, lcd line1
            line2	Read/Write, lcd line2
@@ -125,31 +136,36 @@ For userland the following interfaces are available using the sysfs interface:
 			races between async. and sync usb calls.
 
 
-4.1 lineX
-~~~~~~~~~
-Reading /sys/../lineX will return the format string with its current value:
+lineX
+~~~~~
 
-  Example:
-  cat ./line3
-  888888888888
-  Linux Rocks!
+Reading /sys/../lineX will return the format string with its current value.
+
+  Example::
+
+    cat ./line3
+    888888888888
+    Linux Rocks!
 
 Writing to /sys/../lineX will set the corresponding LCD line.
+
  - Excess characters are ignored.
  - If less characters are written than allowed, the remaining digits are
    unchanged.
  - The tab '\t'and '\n' char does not overwrite the original content.
  - Writing a space to an icon will always hide its content.
 
-  Example:
-  date +"%m.%e.%k:%M"  | sed 's/^0/ /' > ./line1
+  Example::
+
+    date +"%m.%e.%k:%M"  | sed 's/^0/ /' > ./line1
 
   Will update the LCD with the current date & time.
 
 
-4.2 get_icons
-~~~~~~~~~~~~~
-Reading will return all available icon names and its current settings:
+get_icons
+~~~~~~~~~
+
+Reading will return all available icon names and its current settings::
 
   cat ./get_icons
   on M
@@ -172,45 +188,52 @@ Reading will return all available icon names and its current settings:
      RINGTONE
 
 
-4.3 show/hide icons
-~~~~~~~~~~~~~~~~~~~
+show/hide icons
+~~~~~~~~~~~~~~~
+
 Writing to these files will update the state of the icon.
 Only one icon at a time can be updated.
 
 If an icon is also on a ./lineX the corresponding value is
 updated with the first letter of the icon.
 
-  Example - light up the store icon:
-  echo -n "STORE" > ./show_icon
+  Example - light up the store icon::
 
-  cat ./line1
-  18.e8.M8.88...188
-               S
+    echo -n "STORE" > ./show_icon
 
-  Example - sound the ringtone for 10 seconds:
-  echo -n RINGTONE > /sys/..../show_icon
-  sleep 10
-  echo -n RINGTONE > /sys/..../hide_icon
+    cat ./line1
+    18.e8.M8.88...188
+		  S
 
+  Example - sound the ringtone for 10 seconds::
+
+    echo -n RINGTONE > /sys/..../show_icon
+    sleep 10
+    echo -n RINGTONE > /sys/..../hide_icon
+
+
+Sound features
+==============
 
-5. Sound features
-~~~~~~~~~~~~~~~~~
 Sound is supported by the ALSA driver: snd_usb_audio
 
 One 16-bit channel with sample and playback rates of 8000 Hz is the practical
 limit of the device.
 
-  Example - recording test:
-  arecord -v -d 10 -r 8000 -f S16_LE -t wav  foobar.wav
+  Example - recording test::
 
-  Example - playback test:
-  aplay foobar.wav
+    arecord -v -d 10 -r 8000 -f S16_LE -t wav  foobar.wav
 
+  Example - playback test::
+
+    aplay foobar.wav
+
+
+Credits & Acknowledgments
+=========================
 
-6. Credits & Acknowledgments
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   - Olivier Vandorpe, for starting the usbb2k-api project doing much of
-	the reverse engineering.
+    the reverse engineering.
   - Martin Diehl, for pointing out how to handle USB memory allocation.
   - Dmitry Torokhov, for the numerous code reviews and suggestions.
 
-- 
2.9.3


