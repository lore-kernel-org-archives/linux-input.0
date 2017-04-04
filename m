From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 08/37] docs: input/cma3000_d0x: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:08 -0300
Message-ID: <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34545
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752133AbdDDMW7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:22:59 -0400
In-Reply-To: <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
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
 Documentation/input/cma3000_d0x.txt | 72 ++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/Documentation/input/cma3000_d0x.txt b/Documentation/input/cma3000_d0x.txt
index 29d088db4afd..6f40c17c1aca 100644
--- a/Documentation/input/cma3000_d0x.txt
+++ b/Documentation/input/cma3000_d0x.txt
@@ -1,30 +1,37 @@
 Kernel driver for CMA3000-D0x
-============================
+=============================
 
 Supported chips:
 * VTI CMA3000-D0x
+
 Datasheet:
   CMA3000-D0X Product Family Specification 8281000A.02.pdf
   <http://www.vti.fi/en/>
 
-Author: Hemanth V <hemanthv@ti.com>
+:Author: Hemanth V <hemanthv@ti.com>
 
 
 Description
 -----------
+
 CMA3000 Tri-axis accelerometer supports Motion detect, Measurement and
 Free fall modes.
 
-Motion Detect Mode: Its the low power mode where interrupts are generated only
-when motion exceeds the defined thresholds.
+Motion Detect Mode:
+    Its the low power mode where interrupts are generated only
+    when motion exceeds the defined thresholds.
 
-Measurement Mode: This mode is used to read the acceleration data on X,Y,Z
-axis and supports 400, 100, 40 Hz sample frequency.
+Measurement Mode:
+    This mode is used to read the acceleration data on X,Y,Z
+    axis and supports 400, 100, 40 Hz sample frequency.
 
-Free fall Mode: This mode is intended to save system resources.
+Free fall Mode:
+    This mode is intended to save system resources.
 
-Threshold values: Chip supports defining threshold values for above modes
-which includes time and g value. Refer product specifications for more details.
+Threshold values:
+    Chip supports defining threshold values for above modes
+    which includes time and g value. Refer product specifications for
+    more details.
 
 CMA3000 chip supports mutually exclusive I2C and SPI interfaces for
 communication, currently the driver supports I2C based communication only.
@@ -38,28 +45,40 @@ Platform data need to be configured for initial default values.
 
 Platform Data
 -------------
-fuzz_x: Noise on X Axis
 
-fuzz_y: Noise on Y Axis
+fuzz_x:
+    Noise on X Axis
 
-fuzz_z: Noise on Z Axis
+fuzz_y:
+    Noise on Y Axis
 
-g_range: G range in milli g i.e 2000 or 8000
+fuzz_z:
+    Noise on Z Axis
 
-mode: Default Operating mode
+g_range:
+    G range in milli g i.e 2000 or 8000
 
-mdthr: Motion detect g range threshold value
+mode:
+    Default Operating mode
 
-mdfftmr: Motion detect and free fall time threshold value
+mdthr:
+    Motion detect g range threshold value
 
-ffthr: Free fall g range threshold value
+mdfftmr:
+    Motion detect and free fall time threshold value
+
+ffthr:
+    Free fall g range threshold value
 
 Input Interface
---------------
+---------------
+
 Input driver version is 1.0.0
 Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
 Input device name: "cma3000-accelerometer"
-Supported events:
+
+Supported events::
+
   Event type 0 (Sync)
   Event type 3 (Absolute)
     Event code 0 (X)
@@ -87,7 +106,8 @@ Supported events:
 Register/Platform parameters Description
 ----------------------------------------
 
-mode:
+mode::
+
 	0: power down mode
 	1: 100 Hz Measurement mode
 	2: 400 Hz Measurement mode
@@ -97,19 +117,23 @@ mode:
 	6: 40 Hz Free fall mode
 	7: Power off mode
 
-grange:
+grange::
+
 	2000: 2000 mg or 2G Range
 	8000: 8000 mg or 8G Range
 
-mdthr:
+mdthr::
+
 	X: X * 71mg (8G Range)
 	X: X * 18mg (2G Range)
 
-mdfftmr:
+mdfftmr::
+
 	X: (X & 0x70) * 100 ms (MDTMR)
 	   (X & 0x0F) * 2.5 ms (FFTMR 400 Hz)
 	   (X & 0x0F) * 10 ms  (FFTMR 100 Hz)
 
-ffthr:
+ffthr::
+
        X: (X >> 2) * 18mg (2G Range)
        X: (X & 0x0F) * 71 mg (8G Range)
-- 
2.9.3

