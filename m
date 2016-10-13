From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 14/18] Input: synaptics - allocate a Synaptics Intertouch device
Date: Thu, 13 Oct 2016 17:51:08 +0200
Message-ID: <1476373872-18027-15-git-send-email-benjamin.tissoires@redhat.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Most of the Synaptics devices are connected through PS/2 and a different
bus (SMBus or HID over I2C).
The secondary bus capability is indicated by the InterTouch bit in
extended capability 0x0C.

When we encounter such a device, we can create a platform device with
the information gathered through the PS/2 enumeration as some information
might be missing through the other bus. Using a platform device allows
to not add any dependency on the psmouse driver.

We only enable the InterTouch device to be created for the laptops
registered with the top software button property or those we know
that are functional.

In the future, we might change the default to always rely on the
InterTouch bus. Currently, users can enable/disable the feature
with the psmouse parameter synaptics_intertouch.

The SMBus devices keep their PS/2 connection alive. If the initialization
process goes too far (psmouse_activate called), the device disconnects
from the I2C bus and stays on the PS/2 bus. We need to be sure the psmouse
driver will stop communicating with the device (and the pass-through
trackstick too). This part is not addressed here but will be in a
following patch.

The HID over I2C devices are enumerated through the ACPI DSDT, and
their PS/2 device also exports the InterTouch bit in the extended
capability 0x0C. However, the firmware keeps its I2C connection open
even after going further in the PS/2 initialization. We don't need
to take extra precautions with those device, especially because they
block their PS/2 communication when HID over I2C is used.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

changes in v2:
- also forward the buttonpad information from PS/2 to RMI4 (doesn't
  change the resulting input node, but it seems more relevant)
---
 drivers/input/mouse/synaptics.c | 100 ++++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h |   4 ++
 2 files changed, 104 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 8781e23..e3c46f9 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -29,6 +29,8 @@
 #include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <linux/platform_device.h>
+#include <linux/rmi.h>
 #include <linux/slab.h>
 #include "psmouse.h"
 #include "synaptics.h"
@@ -70,6 +72,21 @@
 /* maximum ABS_MT_POSITION displacement (in mm) */
 #define DMAX 10
 
+/*
+ * The newest Synaptics device can use a secondary bus (called InterTouch) which
+ * provides a better bandwidth and allow a better control of the touchpads.
+ * This is used to decide if we need to use this bus or not.
+ */
+enum {
+	SYNAPTICS_INTERTOUCH_NOT_SET = -1,
+	SYNAPTICS_INTERTOUCH_OFF,
+	SYNAPTICS_INTERTOUCH_ON,
+};
+
+static int synaptics_intertouch = SYNAPTICS_INTERTOUCH_NOT_SET;
+module_param_named(synaptics_intertouch, synaptics_intertouch, int, 0644);
+MODULE_PARM_DESC(synaptics_intertouch, "Use a secondary bus for the Synaptics device.");
+
 /*****************************************************************************
  *	Stuff we need even when we do not want native Synaptics support
  ****************************************************************************/
@@ -218,6 +235,81 @@ static const char * const forcepad_pnp_ids[] = {
 	NULL
 };
 
+static const char * const smbus_pnp_ids[] = {
+	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"LEN0048", /* X1 Carbon 3 */
+	"LEN0046", /* X250 */
+	"LEN004a", /* W541 */
+	"LEN200f", /* T450s */
+};
+
+static int rmi4_id;
+
+static int synaptics_create_intertouch(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
+	struct rmi_device_platform_data pdata = {
+		.sensor_pdata = {
+			.sensor_type = rmi_sensor_touchpad,
+			.axis_align.flip_y = true,
+			/* to prevent cursors jumps: */
+			.kernel_tracking = true,
+		},
+		.f30_data = {
+			.buttonpad = SYN_CAP_CLICKPAD(priv->ext_cap_0c),
+			.trackstick_buttons =
+			  !!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10),
+		},
+	};
+
+	if (priv->intertouch)
+		return -EINVAL;
+
+	pdata.sensor_pdata.topbuttonpad =
+			psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
+			!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10);
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.name = "rmi4";
+	pdevinfo.id = rmi4_id++;
+	pdevinfo.data = &pdata;
+	pdevinfo.size_data = sizeof(pdata);
+	pdevinfo.parent = &psmouse->ps2dev.serio->dev;
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	priv->intertouch = pdev;
+
+	return 0;
+}
+
+/**
+ * synaptics_setup_intertouch - called once the PS/2 devices are enumerated
+ * and decides to instantiate a SMBus InterTouch device.
+ */
+static void synaptics_setup_intertouch(struct psmouse *psmouse)
+{
+	int ret;
+
+	if (synaptics_intertouch == SYNAPTICS_INTERTOUCH_OFF)
+		return;
+
+	if (synaptics_intertouch == SYNAPTICS_INTERTOUCH_NOT_SET) {
+		if (!psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
+		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids))
+			return;
+	}
+
+	psmouse_info(psmouse, "device also supported by an other bus.\n");
+	ret = synaptics_create_intertouch(psmouse);
+	if (ret)
+		psmouse_info(psmouse,
+			     "unable to create intertouch device.\n");
+}
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -1305,6 +1397,11 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 		device_remove_file(&psmouse->ps2dev.serio->dev,
 				   &psmouse_attr_disable_gesture.dattr);
 
+	if (priv->intertouch) {
+		platform_device_unregister(priv->intertouch);
+		priv->intertouch = NULL;
+	}
+
 	synaptics_reset(psmouse);
 	kfree(priv);
 	psmouse->private = NULL;
@@ -1547,6 +1644,9 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		}
 	}
 
+	if (SYN_CAP_INTERTOUCH(priv->ext_cap_0c))
+		synaptics_setup_intertouch(psmouse);
+
 	return 0;
 
  init_fail:
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 116ae25..b88755d 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -90,6 +90,7 @@
 #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
 #define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & 0x000400)
 #define SYN_CAP_IMAGE_SENSOR(ex0c)	((ex0c) & 0x000800)
+#define SYN_CAP_INTERTOUCH(ex0c)	((ex0c) & 0x004000)
 
 /*
  * The following descibes response for the 0x10 query.
@@ -196,6 +197,9 @@ struct synaptics_data {
 	bool					press;
 	bool					report_press;
 	bool					is_forcepad;
+
+	/* Intertouch handling */
+	struct platform_device *intertouch;
 };
 
 void synaptics_module_init(void);
-- 
2.7.4
