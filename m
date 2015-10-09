From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 2/3] input: rotary-encoder: Introduce new 'steps-per-period' property
Date: Fri,  9 Oct 2015 10:46:55 -0300
Message-ID: <1444398416-3073-3-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36849 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbbJINvM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 09:51:12 -0400
Received: by qkht68 with SMTP id t68so32551779qkh.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 06:51:11 -0700 (PDT)
In-Reply-To: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ariel@vanguardiasur.com.ar, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

This commit deprecates the 'half-period' property and introduces
a new property 'steps-per-period'. This property specifies the
number of steps (stable states) produced by the rotary encoder
for each GPIO period.

Such a property is required to accurately describe all kinds of
rotary-encoders devices.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 Documentation/devicetree/bindings/input/rotary-encoder.txt | 9 +++++++++
 Documentation/input/rotary-encoder.txt                     | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 331549593ed5..5715ad70d28e 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -14,7 +14,16 @@ Optional properties:
   device, hence no steps need to be passed.
 - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
+- rotary-encoder,steps-per-period: Number of steps (stable states) per period.
+  The values have the following meaning:
+  1: Full-period mode (default)
+  2: Half-period mode
+  4: Quarter-period mode
+
+Deprecated properties:
 - rotary-encoder,half-period: Makes the driver work on half-period mode.
+  This property is deprecated. Instead, a 'steps-per-period ' value should
+  be used, such as "rotary-encoder,steps-per-period = <2>".
 
 See Documentation/input/rotary-encoder.txt for more information.
 
diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 5737e3590adb..00acf88e4064 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -9,8 +9,9 @@ peripherals with two wires. The outputs are phase-shifted by 90 degrees
 and by triggering on falling and rising edges, the turn direction can
 be determined.
 
-Some encoders have both outputs low in stable states, whereas others also have
-a stable state with both outputs high (half-period mode).
+Some encoders have both outputs low in stable states, others also have
+a stable state with both outputs high (half-period mode) and some have
+a stable state in all steps (quarter-period mode).
 
 The phase diagram of these two outputs look like this:
 
@@ -32,6 +33,9 @@ The phase diagram of these two outputs look like this:
                 |<-->|
 	          one step (half-period mode)
 
+                |<>|
+	          one step (quarter-period mode)
+
 For more information, please see
 	https://en.wikipedia.org/wiki/Rotary_encoder
 
-- 
2.5.2

