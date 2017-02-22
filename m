From: <michael.hennerich@analog.com>
Subject: [PATCH 3/4] Documentation: Add SPI example
Date: Wed, 22 Feb 2017 17:14:37 +0100
Message-ID: <1487780078-18510-4-git-send-email-michael.hennerich@analog.com>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:13894
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754620AbdBVQOZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 11:14:25 -0500
In-Reply-To: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../devicetree/bindings/input/touchscreen/ad7879.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
index 323b609..3c8614c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
@@ -52,3 +52,21 @@ Example:
 		adi,averaging = /bits/ 8 <1>;
 		adi,conversion-interval = /bits/ 8 <255>;
 	};
+
+	ad7879@1 {
+		compatible = "adi,ad7879";
+		spi-max-frequency = <5000000>;
+		reg = <1>;
+		spi-cpol;
+		spi-cpha;
+		gpio-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-max-pressure = <4096>;
+		adi,resistance-plate-x = <120>;
+		adi,first-conversion-delay = /bits/ 8 <3>;
+		adi,acquisition-time = /bits/ 8 <1>;
+		adi,median-filter-size = /bits/ 8 <2>;
+		adi,averaging = /bits/ 8 <1>;
+		adi,conversion-interval = /bits/ 8 <255>;
+	};
-- 
2.7.4

