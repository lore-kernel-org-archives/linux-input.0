From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] dt-bindings: input: sitronix-st1232: document optional reset-gpios property
Date: Tue, 29 Jan 2019 11:23:46 +0100
Message-ID: <20190129102347.27754-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

The st1232 driver reads this via gpiod.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 .../devicetree/bindings/input/touchscreen/sitronix-st1232.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
index e73e826e0f2a..365b32d30d4b 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
@@ -8,7 +8,7 @@ Required properties:
 - interrupts: interrupt to which the chip is connected
 
 Optional properties:
-- gpios: a phandle to the reset GPIO
+- reset-gpios: a phandle to the reset GPIO
 
 Example:
 
@@ -19,7 +19,7 @@ Example:
 			compatible = "sitronix,st1232";
 			reg = <0x55>;
 			interrupts = <2 0>;
-			gpios = <&gpio1 166 0>;
+			reset-gpios = <&gpio1 166 0>;
 		};
 
 		/* ... */
-- 
2.20.1
