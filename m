From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 08/33] docs: input/cma3000_d0x: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:51 -0300
Message-ID: <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43931 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdDASQf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:35 -0400
In-Reply-To: <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
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


