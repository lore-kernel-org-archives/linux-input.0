From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/9] dt-bindings: gpio-axp209: Add AXP803 GPIOs compatible (w/ AXP813 fallback)
Date: Mon,  3 Dec 2018 15:45:39 +0530
Message-ID: <20181203101547.16835-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

AXP803 PMIC has two GPIO's which is similar to the one in
AXP813 PMIC.

Add a compatible string for it with AXP813 fallback compatible string, in
this case the AXP813 driver can be used.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index fc42b2caa06d..c8c5d20856c9 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -12,6 +12,7 @@ Required properties:
 - compatible: Should be one of:
 	- "x-powers,axp209-gpio"
 	- "x-powers,axp813-gpio"
+	- "x-powers,axp803-gpio", "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
 - gpio-controller: Marks the device node as a GPIO controller.
-- 
2.18.0.321.gffc6fa0e3
