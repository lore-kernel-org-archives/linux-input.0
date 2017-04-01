From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 09/33] docs: input/cs461x: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:52 -0300
Message-ID: <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/cs461x.txt | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/input/cs461x.txt b/Documentation/input/cs461x.txt
index 202e9dbacec3..1450436dcc9e 100644
--- a/Documentation/input/cs461x.txt
+++ b/Documentation/input/cs461x.txt
@@ -1,36 +1,40 @@
-Preface.
+Crystal SoundFusion CS4610/CS4612/CS461 joystick
+================================================
+
+Preface
+-------
 
 This is a new low-level driver to support analog joystick attached to
-Crystal SoundFusion CS4610/CS4612/CS4615. This code is based upon 
+Crystal SoundFusion CS4610/CS4612/CS4615. This code is based upon
 Vortex/Solo drivers as an example of decoration style, and ALSA
 0.5.8a kernel drivers as an chipset documentation and samples.
 
-This version does not have cooked mode support; the basic code 
-is present here, but have not tested completely. The button analysis 
-is completed in this mode, but the axis movement is not. 
+This version does not have cooked mode support; the basic code
+is present here, but have not tested completely. The button analysis
+is completed in this mode, but the axis movement is not.
 
 Raw mode works fine with analog joystick front-end driver and cs461x
-driver as a backend. I've tested this driver with CS4610, 4-axis and 
+driver as a backend. I've tested this driver with CS4610, 4-axis and
 4-button joystick; I mean the jstest utility. Also I've tried to
 play in xracer game using joystick, and the result is better than
 keyboard only mode.
 
 The sensitivity and calibrate quality have not been tested; the two
-reasons are performed: the same hardware cannot work under Win95 (blue 
-screen in VJOYD); I have no documentation on my chip; and the existing 
-behavior in my case was not raised the requirement of joystick calibration. 
+reasons are performed: the same hardware cannot work under Win95 (blue
+screen in VJOYD); I have no documentation on my chip; and the existing
+behavior in my case was not raised the requirement of joystick calibration.
 So the driver have no code to perform hardware related calibration.
 
 The patch contains minor changes of Config.in and Makefile files. All
 needed code have been moved to one separate file cs461x.c like ns558.c
 This driver have the basic support for PCI devices only; there is no
-ISA or PnP ISA cards supported. AFAIK the ns558 have support for Crystal 
+ISA or PnP ISA cards supported. AFAIK the ns558 have support for Crystal
 ISA and PnP ISA series.
 
 The driver works with ALSA drivers simultaneously. For example, the xracer
 uses joystick as input device and PCM device as sound output in one time.
 There are no sound or input collisions detected. The source code have
-comments about them; but I've found the joystick can be initialized 
+comments about them; but I've found the joystick can be initialized
 separately of ALSA modules. So, you can use only one joystick driver
 without ALSA drivers. The ALSA drivers are not needed to compile or
 run this driver.
@@ -38,7 +42,7 @@ run this driver.
 There are no debug information print have been placed in source, and no
 specific options required to work this driver. The found chipset parameters
 are printed via printk(KERN_INFO "..."), see the /var/log/messages to
-inspect cs461x: prefixed messages to determine possible card detection 
+inspect cs461x: prefixed messages to determine possible card detection
 errors.
 
 Regards,
-- 
2.9.3


