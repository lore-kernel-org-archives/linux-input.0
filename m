From: yegorslists@googlemail.com
Subject: [PATCH 3/3] tps6507x-ts: add DT bindings description
Date: Fri, 24 Feb 2017 16:42:26 +0100
Message-ID: <1487950946-18590-4-git-send-email-yegorslists@googlemail.com>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35361 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdBXPmz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Feb 2017 10:42:55 -0500
Received: by mail-wr0-f194.google.com with SMTP id q39so2752663wrb.2
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2017 07:42:54 -0800 (PST)
In-Reply-To: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Provide description for following properties:

- ti,poll-period
- ti,min-pressure
- ti,vendor
- ti,product
- ti,version

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Documentation/devicetree/bindings/mfd/tps6507x.txt | 30 ++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
index 8fffa3c..eb654ef 100644
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
@@ -30,6 +34,23 @@ Regulator Optional properties:
 			1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
   If this property is not defined, it defaults to 0 (not enabled).
 
+Touchscreen Optional properties:
+- ti,poll-period: Time at which touch input is getting sampled in ms.
+		  Default value: 30 ms.
+- ti,min-pressure: Minimum pressure value to trigger touch.
+		   Default value: 0x30.
+		   This property has to be a '/bits/ 16' value
+
+Entries below describe the input_id structure [1] for the touch device:
+- ti,vendor: Touchscreen vendor id.
+	     This property has to be a '/bits/ 16' value
+- ti,product: Touchscreen product id.
+	      This property has to be a '/bits/ 16' value
+- ti,version: Touchscreen version id.
+	      This property has to be a '/bits/ 16' value
+
+[1] include/uapi/linux/input.h
+
 Example:
 
 	pmu: tps6507x@48 {
@@ -40,6 +61,12 @@ Example:
 		vindcdc3-supply = <...>;
 		vinldo1_2-supply = <...>;
 
+		ti,poll-period = <30>;
+		ti,min-pressure = /bits/ 16 <0x30>;
+		ti,vendor = /bits/ 16 <0>;
+		ti,product = /bits/ 16 <65070>;
+		ti,version = /bits/ 16 <0x100>;
+
 		regulators {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -87,5 +114,4 @@ Example:
 				regulator-boot-on;
 			};
 		};
-
 	};
-- 
2.1.4

