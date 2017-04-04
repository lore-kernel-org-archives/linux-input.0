From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 09/37] docs: input/cs461x: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:09 -0300
Message-ID: <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34553
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752909AbdDDMXA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:00 -0400
In-Reply-To: <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

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

