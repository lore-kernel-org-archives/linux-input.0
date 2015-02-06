From: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] Documentation: Device Tree binding information for gpio-joy driver
Date: Fri,  6 Feb 2015 10:32:01 +0100
Message-ID: <1423215122-19947-2-git-send-email-hans.holmberg@intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423215122-19947-1-git-send-email-hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This document describes the Device Tree bindings for the gpio-joy
driver.

Signed-off-by: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/input/gpio-joy.txt         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-joy.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-joy.txt b/Documentation/devicetree/bindings/input/gpio-joy.txt
new file mode 100644
index 0000000..ef8ad09
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-joy.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for input/joystick/gpio_joy.c joystick driver
+
+This driver can be used for connecting i.e. C64 and Atari joysticks.
+
+Required properties:
+	- compatible    = "gpio-joy";
+
+	- left-gpio     : gpio connected to the "left" joystick signal
+	- right-gpio    : gpio connected to the "right" joystick signal
+	- up-gpio       : gpio connected to the "up" joystick signal
+	- down-gpio     : gpio connected to the "down" joystick signal
+	- button-gpio   : gpio connected to the "button" joystick signal
+		See OF device-tree gpio specification.
+
+Optional properties:
+	- debounce-interval-ms: debounce interval in milliseconds for connected pins
+		Default is 10 milliseconds
+
+Example node:
+
+joystick {
+	compatible = "gpio-joy";
+	left-gpio = <&gpio 24 GPIO_ACTIVE_LOW>;
+	right-gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
+	up-gpio	= <&gpio 3 GPIO_ACTIVE_LOW>;
+	down-gpio = <&gpio 27 GPIO_ACTIVE_LOW>;
+	button-gpio = <&gpio 2 GPIO_ACTIVE_LOW>;
+};
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
