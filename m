From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 29/37] docs: input/yealink: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:29 -0300
Message-ID: <55d263f13237495276213de295ae1c6d67f0588b.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491308444.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491308444.git.mchehab@s-opensource.com>
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Henk Vergonet <Henk.Vergonet@gmail.com>, usbb2k-api-dev@nongnu.org
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/yealink.txt | 164 +++++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 71 deletions(-)

diff --git a/Documentation/input/yealink.txt b/Documentation/input/yealink.txt
index 8277b76ec506..b231d8baf4bb 100644
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
@@ -118,38 +129,43 @@ For userland the following interfaces are available using the sysfs interface:
 	   show_icon    Write, display the element by writing the icon name.
 
 	   map_seg7	Read/Write, the 7 segments char set, common for all
-	   		yealink phones. (see map_to_7segment.h)
+			yealink phones. (see map_to_7segment.h)
 
 	   ringtone	Write, upload binary representation of a ringtone,
-	   		see yealink.c. status EXPERIMENTAL due to potential
+			see yealink.c. status EXPERIMENTAL due to potential
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
@@ -172,45 +188,51 @@ Reading will return all available icon names and its current settings:
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
-
-- 
2.9.3

