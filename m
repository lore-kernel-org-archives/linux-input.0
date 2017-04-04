From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 24/37] docs: input/rotary-encoder: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:24 -0300
Message-ID: <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
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
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34592
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753340AbdDDMXE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:04 -0400
In-Reply-To: <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
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
 Documentation/input/rotary-encoder.txt | 74 +++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 46a74f0c551a..4695bea67f9b 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -1,8 +1,11 @@
+============================================================
 rotary-encoder - a generic driver for GPIO connected devices
-Daniel Mack <daniel@caiaq.de>, Feb 2009
+============================================================
 
-0. Function
------------
+:Author: Daniel Mack <daniel@caiaq.de>, Feb 2009
+
+Function
+--------
 
 Rotary encoders are devices which are connected to the CPU or other
 peripherals with two wires. The outputs are phase-shifted by 90 degrees
@@ -13,7 +16,7 @@ Some encoders have both outputs low in stable states, others also have
 a stable state with both outputs high (half-period mode) and some have
 a stable state in all steps (quarter-period mode).
 
-The phase diagram of these two outputs look like this:
+The phase diagram of these two outputs look like this::
 
                   _____       _____       _____
                  |     |     |     |     |     |
@@ -40,8 +43,8 @@ For more information, please see
 	https://en.wikipedia.org/wiki/Rotary_encoder
 
 
-1. Events / state machine
--------------------------
+Events / state machine
+----------------------
 
 In half-period mode, state a) and c) above are used to determine the
 rotational direction based on the last stable state. Events are reported in
@@ -65,16 +68,16 @@ d) Falling edge on channel B, channel A in low state
 	should have happened, unless it flipped back on half the way. The
 	'armed' state tells us about that.
 
-2. Platform requirements
-------------------------
+Platform requirements
+---------------------
 
 As there is no hardware dependent call in this driver, the platform it is
 used with must support gpiolib. Another requirement is that IRQs must be
 able to fire on both edges.
 
 
-3. Board integration
---------------------
+Board integration
+-----------------
 
 To use this driver in your system, register a platform_device with the
 name 'rotary-encoder' and associate the IRQs and some specific platform
@@ -93,34 +96,33 @@ the configuration.
 Because GPIO to IRQ mapping is platform specific, this information must
 be given in separately to the driver. See the example below.
 
----------<snip>---------
+::
 
-/* board support file example */
+    /* board support file example */
 
-#include <linux/input.h>
-#include <linux/rotary_encoder.h>
+    #include <linux/input.h>
+    #include <linux/rotary_encoder.h>
 
-#define GPIO_ROTARY_A 1
-#define GPIO_ROTARY_B 2
+    #define GPIO_ROTARY_A 1
+    #define GPIO_ROTARY_B 2
 
-static struct rotary_encoder_platform_data my_rotary_encoder_info = {
-	.steps		= 24,
-	.axis		= ABS_X,
-	.relative_axis	= false,
-	.rollover	= false,
-	.gpio_a		= GPIO_ROTARY_A,
-	.gpio_b		= GPIO_ROTARY_B,
-	.inverted_a	= 0,
-	.inverted_b	= 0,
-	.half_period	= false,
-	.wakeup_source	= false,
-};
-
-static struct platform_device rotary_encoder_device = {
-	.name		= "rotary-encoder",
-	.id		= 0,
-	.dev		= {
-		.platform_data = &my_rotary_encoder_info,
-	}
-};
+    static struct rotary_encoder_platform_data my_rotary_encoder_info = {
+	    .steps		= 24,
+	    .axis		= ABS_X,
+	    .relative_axis	= false,
+	    .rollover	= false,
+	    .gpio_a		= GPIO_ROTARY_A,
+	    .gpio_b		= GPIO_ROTARY_B,
+	    .inverted_a	= 0,
+	    .inverted_b	= 0,
+	    .half_period	= false,
+	    .wakeup_source	= false,
+    };
 
+    static struct platform_device rotary_encoder_device = {
+	    .name		= "rotary-encoder",
+	    .id		= 0,
+	    .dev		= {
+		    .platform_data = &my_rotary_encoder_info,
+	    }
+    };
-- 
2.9.3

