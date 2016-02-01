From: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Subject: [PATCH 1/3] Input: tps6507x-ts - add binding for tps6507x-ts
Date: Mon, 1 Feb 2016 11:58:47 +0530
Message-ID: <1454308130-12452-2-git-send-email-sushaanth.s@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35558 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbcBAG3w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Feb 2016 01:29:52 -0500
In-Reply-To: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Sushaanth Srirangapathi <sushaanth.s@ti.com>

add binding information for tps6507x touchscreen input.

"ti,min-pressure" was added as TI specific binding because it
was specific to tps6507x IP and not applicable or relevant for
other touchscreen drivers.

Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 Documentation/devicetree/bindings/mfd/tps6507x.txt |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
index 8fffa3c..52df806 100644
--- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
+++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
@@ -23,6 +23,8 @@ Required properties:
        vindcdc1_2-supply: VDCDC1 and VDCDC2 input.
        vindcdc3-supply  : VDCDC3 input.
        vldo1_2-supply   : VLDO1 and VLDO2 input.
+- touchscreen: This is the child node that specifes the touchscreen
+  properties.
 
 Regulator Optional properties:
 - defdcdc_default: It's property of DCDC2 and DCDC3 regulators.
@@ -30,6 +32,10 @@ Regulator Optional properties:
 			1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
   If this property is not defined, it defaults to 0 (not enabled).
 
+Touchscreen Optional properties:
+- ti,min-pressure : pressure level above which the event is considered as a
+		    valid touch.
+
 Example:
 
 	pmu: tps6507x@48 {
@@ -87,5 +93,7 @@ Example:
 				regulator-boot-on;
 			};
 		};
-
+		touchscreen {
+			ti,min-pressure = <0x30>;
+		};
 	};
-- 
1.7.9.5

