From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v5 1/2] devicetree: i2c-hid: Add regulator support
Date: Thu,  9 Feb 2017 18:03:56 -0800
Message-ID: <20170210020357.10679-1-briannorris@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Document a "vdd-supply" and an initialization delay. Can be used for
powering on/off a HID.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Sorry for the delay on resending this. I *think* I've addressed all the
concerns from last time though?

v2:
 * add compatible property for wacom, per Rob's request
 * name the regulator property specifically (VDD)

v3:
 * remove wacom property, per Benjamin's request
 * add delay property

v4: no change

v5:
 * change name to "post-power-on-delay-ms"
 * reword to describe how the power sequencing properties require a
   specific 'compatible' property
---
 Documentation/devicetree/bindings/input/hid-over-i2c.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index 488edcb264c4..28e8bd8b7d64 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -17,6 +17,22 @@ Required properties:
 - interrupt-parent: the phandle for the interrupt controller
 - interrupts: interrupt line
 
+Additional optional properties:
+
+Some devices may support additional optional properties to help with, e.g.,
+power sequencing. The following properties can be supported by one or more
+device-specific compatible properties, which should be used in addition to the
+"hid-over-i2c" string.
+
+- compatible:
+  * "wacom,w9013" (Wacom W9013 digitizer). Supports:
+    - vdd-supply
+    - post-power-on-delay-ms
+
+- vdd-supply: phandle of the regulator that provides the supply voltage.
+- post-power-on-delay-ms: time required by the device after enabling its regulators
+  before it is ready for communication. Must be used with 'vdd-supply'.
+
 Example:
 
 	i2c-hid-dev@2c {
-- 
2.11.0.483.g087da7b7c-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
