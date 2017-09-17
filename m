From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] input: mouse: Add DT bindings for GPIO mice
Date: Sun, 17 Sep 2017 13:14:43 +0200
Message-ID: <20170917111445.30880-4-linus.walleij@linaro.org>
References: <20170917111445.30880-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:46290 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdIQLPF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Sep 2017 07:15:05 -0400
Received: by mail-lf0-f43.google.com with SMTP id m199so5674083lfe.3
        for <linux-input@vger.kernel.org>; Sun, 17 Sep 2017 04:15:04 -0700 (PDT)
In-Reply-To: <20170917111445.30880-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org

This adds DT bindings for simple mice attached to GPIO lines.
As the properties are very general and pertains to all mice I
can think of, we use very generic names for the 4-7 GPIO lines,
"up", "down" etc.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch is inspired by the existance of a GPIO mouse driver
with no in-kernel users.
---
 .../devicetree/bindings/input/gpio-mouse.txt       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-mouse.txt b/Documentation/devicetree/bindings/input/gpio-mouse.txt
new file mode 100644
index 000000000000..82622a439745
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-mouse.txt
@@ -0,0 +1,32 @@
+Device-Tree bindings for GPIO attached mice
+
+This simply uses standard GPIO handles to define a simple mouse connected
+to 4-7 GPIO lines.
+
+Required properties:
+	- compatible: must be "gpio-mouse"
+	- scan-interval: The scanning interval in milliseconds
+	- up-gpios: GPIO line phandle to the line indicating "up"
+	- down-gpios: GPIO line phandle to the line indicating "down"
+	- left-gpios: GPIO line phandle to the line indicating "left"
+	- right-gpios: GPIO line phandle to the line indicating "right"
+
+Optional properties:
+	- button-left-gpios: GPIO line handle to the left mouse button
+	- button-middle-gpios: GPIO line handle to the middle mouse button
+	- button-right-gpios: GPIO line handle to the right mouse button
+Example:
+
+#include <dt-bindings/gpio/gpio.h>
+
+gpio-mouse {
+	compatible = "gpio-keys";
+	scan-interval = <50>;
+	up-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+	down-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+	left-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+	right-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+	button-left-gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+	button-middle-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+	button-right-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+};
-- 
2.13.5

