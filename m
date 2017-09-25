From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5 v2] input: mouse: Add DT bindings for GPIO mice
Date: Mon, 25 Sep 2017 18:34:28 +0200
Message-ID: <20170925163430.22397-3-linus.walleij@linaro.org>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170925163430.22397-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds DT bindings for simple mice attached to GPIO lines.
As the properties are very general and pertains to all mice I
can think of, we use very generic names for the 4-7 GPIO lines,
"up", "down" etc.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Collect Hand-Christian's ACK
- Uses 5-7 lines rather than 4-7 lines
- Add suffix "-ms" to the scan interval property
- Fix compatible string in the example
---
 .../devicetree/bindings/input/gpio-mouse.txt       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-mouse.txt b/Documentation/devicetree/bindings/input/gpio-mouse.txt
new file mode 100644
index 000000000000..519510a11af9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-mouse.txt
@@ -0,0 +1,32 @@
+Device-Tree bindings for GPIO attached mice
+
+This simply uses standard GPIO handles to define a simple mouse connected
+to 5-7 GPIO lines.
+
+Required properties:
+	- compatible: must be "gpio-mouse"
+	- scan-interval-ms: The scanning interval in milliseconds
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
+	compatible = "gpio-mouse";
+	scan-interval-ms = <50>;
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
