From: yegorslists@googlemail.com
Subject: [PATCH v2 3/3] tps6507x-ts: add DT bindings description
Date: Thu,  9 Mar 2017 15:31:09 +0100
Message-ID: <1489069869-3849-4-git-send-email-yegorslists@googlemail.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33601 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754648AbdCIOcH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 09:32:07 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so8137791wrg.0
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 06:31:44 -0800 (PST)
In-Reply-To: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, nsekhar@ti.com, khilman@baylibre.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Provide description for following properties:

- ti,poll-period
- ti,min-pressure

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Documentation/devicetree/bindings/mfd/tps6507x.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
index 8fffa3c..8875662 100644
--- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
+++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
@@ -1,4 +1,8 @@
-TPS6507x Power Management Integrated Circuit
+TPS6507x Multifunctional Device.
+
+Features provided by TPS6507x:
+        1. Power Management Integrated Circuit.
+        2. Touch-Screen.
 
 Required properties:
 - compatible: "ti,tps6507x"
@@ -30,6 +34,12 @@ Regulator Optional properties:
 			1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
   If this property is not defined, it defaults to 0 (not enabled).
 
+Touchscreen Optional properties:
+- ti,poll-period: Time at which touch input is getting sampled in ms.
+		  Default value: 30 ms.
+- ti,min-pressure: Minimum pressure value to trigger touch.
+		   Default value: 0x30.
+
 Example:
 
 	pmu: tps6507x@48 {
@@ -40,6 +50,9 @@ Example:
 		vindcdc3-supply = <...>;
 		vinldo1_2-supply = <...>;
 
+		ti,poll-period = <30>;
+		ti,min-pressure = <0x30>;
+
 		regulators {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -87,5 +100,4 @@ Example:
 				regulator-boot-on;
 			};
 		};
-
 	};
-- 
2.1.4

