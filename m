From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] input: arizona-haptics - Add device property for HAP_ACT
Date: Thu, 16 Feb 2017 17:35:58 +0000
Message-ID: <1487266558-19040-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds a device property for setting the configuration for the
HAP_ACT register field so that the connected actuator type can be
configured on systems that are not using pdata.

Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/input/arizona-haptics.txt | 10 ++++++++++
 MAINTAINERS                                                 |  1 +
 drivers/input/misc/arizona-haptics.c                        |  7 +++++++
 3 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/arizona-haptics.txt

diff --git a/Documentation/devicetree/bindings/input/arizona-haptics.txt b/Documentation/devicetree/bindings/input/arizona-haptics.txt
new file mode 100644
index 0000000..a3e767b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/arizona-haptics.txt
@@ -0,0 +1,10 @@
+Cirrus Logic Arizona class audio SoCs
+
+This document lists haptics bindings for these codecs.
+Also see the primary binding document:
+  ../mfd/arizona.txt
+
+Optional properties:
+  - wlf,hap-act : Single value defining the actuator type, as per the HAP_ACT
+    register field. See the codec datasheet for the available HAP_ACT values
+    and their meaning.
diff --git a/MAINTAINERS b/MAINTAINERS
index 26edd83..be4ea3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13377,6 +13377,7 @@ W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/hwmon/wm83??
 F:	Documentation/devicetree/bindings/extcon/extcon-arizona.txt
+F:	Documentation/devicetree/bindings/input/arizona*.txt
 F:	Documentation/devicetree/bindings/regulator/arizona-regulator.txt
 F:	Documentation/devicetree/bindings/mfd/arizona.txt
 F:	arch/arm/mach-s3c64xx/mach-crag6410*
diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 21dc1b8..0264d95 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/property.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -164,6 +165,12 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 
 	haptics->arizona = arizona;
 
+	if (!dev_get_platdata(arizona->dev))
+		device_property_read_u32(arizona->dev, "wlf,hap-act",
+					 &arizona->pdata.hap_act);
+
+	dev_dbg(arizona->dev, "hap_act=%u\n", arizona->pdata.hap_act);
+
 	ret = regmap_update_bits(arizona->regmap, ARIZONA_HAPTICS_CONTROL_1,
 				 ARIZONA_HAP_ACT, arizona->pdata.hap_act);
 	if (ret != 0) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
