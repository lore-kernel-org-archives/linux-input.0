From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 24/33] docs: input/rotary-encoder: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:07 -0300
Message-ID: <74a6c5b672275a8a40317a76c72845a939089c89.1491069870.git.mchehab@s-opensource.com>
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
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <355358d79dca250017195f1e0309d64edd432a07.1491069870.git.mchehab@s-opensource.com>
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
 Documentation/input/rotary-encoder.txt | 73 ++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 46a74f0c551a..432de0f67277 100644
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
@@ -93,34 +96,34 @@ the configuration.
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
 
-static struct platform_device rotary_encoder_device = {
-	.name		= "rotary-encoder",
-	.id		= 0,
-	.dev		= {
-		.platform_data = &my_rotary_encoder_info,
-	}
-};
+    static struct platform_device rotary_encoder_device = {
+	    .name		= "rotary-encoder",
+	    .id		= 0,
+	    .dev		= {
+		    .platform_data = &my_rotary_encoder_info,
+	    }
+    };
 
-- 
2.9.3


