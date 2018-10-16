From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 1/7] dt-bindings: input: touchscreen: sx8654: add reset-gpio property
Date: Tue, 16 Oct 2018 11:16:47 +0200
Message-ID: <20181016091653.26896-2-richard.leitner@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016091653.26896-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

Document the reset-gpio property for the sx8654 touchscreen controller
driver.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
index 4886c4aa2906..ca521d8f7d65 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
@@ -5,6 +5,9 @@ Required properties:
 - reg: i2c slave address
 - interrupts: touch controller interrupt
 
+Optional properties:
+ - reset-gpios: GPIO specification for the NRST input
+
 Example:
 
 	sx8654@48 {
@@ -12,4 +15,5 @@ Example:
 		reg = <0x48>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 	};
-- 
2.11.0
