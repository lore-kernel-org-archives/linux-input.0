From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 8/9] Input: synaptics - add support for Intertouch devices
Date: Sun, 19 Mar 2017 17:22:30 -0700
Message-ID: <20170320002231.31152-9-dmitry.torokhov@gmail.com>
References: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36406 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbdCTAWo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 19 Mar 2017 20:22:44 -0400
In-Reply-To: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Most of the Synaptics devices are connected through PS/2 and a different
bus (SMBus or HID over I2C). The secondary bus capability is indicated by
the InterTouch bit in extended capability 0x0C.

We only enable the InterTouch device to be created for the laptops
registered with the top software button property or those we know that are
functional. In the future, we might change the default to always rely on
the InterTouch bus. Currently, users can enable/disable the feature with
the psmouse parameter synaptics_intertouch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/Kconfig        |  12 +
 drivers/input/mouse/psmouse-base.c |  24 +-
 drivers/input/mouse/psmouse.h      |   1 +
 drivers/input/mouse/synaptics.c    | 554 +++++++++++++++++++++++++------------
 drivers/input/mouse/synaptics.h    |   5 +-
 5 files changed, 421 insertions(+), 175 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 87bde8a210c7..89ebb8f39fee 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -78,6 +78,18 @@ config MOUSE_PS2_SYNAPTICS
 
 	  If unsure, say Y.
 
+config MOUSE_PS2_SYNAPTICS_SMBUS
+	bool "Synaptics PS/2 SMbus companion" if EXPERT
+	default y
+	depends on MOUSE_PS2
+	depends on I2C=y || I2C=MOUSE_PS2
+	select MOUSE_PS2_SMBUS
+	help
+	  Say Y here if you have a Synaptics RMI4 touchpad connected to
+	  to an SMBus, but enumerated through PS/2.
+
+	  If unsure, say Y.
+
 config MOUSE_PS2_CYPRESS
        bool "Cypress PS/2 mouse protocol extension" if EXPERT
        default y
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index bdb48b2acc57..68aa00689c5d 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -773,7 +773,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.name		= "SynPS/2",
 		.alias		= "synaptics",
 		.detect		= synaptics_detect,
-		.init		= synaptics_init,
+		.init		= synaptics_init_absolute,
 	},
 	{
 		.type		= PSMOUSE_SYNAPTICS_RELATIVE,
@@ -783,6 +783,16 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.init		= synaptics_init_relative,
 	},
 #endif
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS
+	{
+		.type		= PSMOUSE_SYNAPTICS_SMBUS,
+		.name		= "SynSMBus",
+		.alias		= "synaptics-smbus",
+		.detect		= synaptics_detect,
+		.init		= synaptics_init_smbus,
+		.smbus_companion = true,
+	},
+#endif
 #ifdef CONFIG_MOUSE_PS2_ALPS
 	{
 		.type		= PSMOUSE_ALPS,
@@ -1011,6 +1021,7 @@ static int psmouse_extensions(struct psmouse *psmouse,
 			      unsigned int max_proto, bool set_properties)
 {
 	bool synaptics_hardware = false;
+	int ret;
 
 	/*
 	 * Always check for focaltech, this is safe as it uses pnp-id
@@ -1073,9 +1084,14 @@ static int psmouse_extensions(struct psmouse *psmouse,
 			 * enabled first, since we try detecting Synaptics
 			 * even when protocol is disabled.
 			 */
-			if (IS_ENABLED(CONFIG_MOUSE_PS2_SYNAPTICS) &&
-			    (!set_properties || synaptics_init(psmouse) == 0)) {
-				return PSMOUSE_SYNAPTICS;
+			if (IS_ENABLED(CONFIG_MOUSE_PS2_SYNAPTICS) ||
+			    IS_ENABLED(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)) {
+				if (!set_properties)
+					return PSMOUSE_SYNAPTICS;
+
+				ret = synaptics_init(psmouse);
+				if (ret >= 0)
+					return ret;
 			}
 
 			/*
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 05110832109c..38855e425f01 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -66,6 +66,7 @@ enum psmouse_type {
 	PSMOUSE_FOCALTECH,
 	PSMOUSE_VMMOUSE,
 	PSMOUSE_BYD,
+	PSMOUSE_SYNAPTICS_SMBUS,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 0eb01d1e8802..20c329bba46a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -29,6 +29,8 @@
 #include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <linux/rmi.h>
+#include <linux/i2c.h>
 #include <linux/slab.h>
 #include "psmouse.h"
 #include "synaptics.h"
@@ -119,59 +121,8 @@ void synaptics_reset(struct psmouse *psmouse)
 	synaptics_mode_cmd(psmouse, 0);
 }
 
-#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
-
-static bool cr48_profile_sensor;
-
-#define ANY_BOARD_ID 0
-struct min_max_quirk {
-	const char * const *pnp_ids;
-	struct {
-		u32 min, max;
-	} board_id;
-	u32 x_min, x_max, y_min, y_max;
-};
-
-static const struct min_max_quirk min_max_pnpid_table[] = {
-	{
-		(const char * const []){"LEN0033", NULL},
-		{ANY_BOARD_ID, ANY_BOARD_ID},
-		1024, 5052, 2258, 4832
-	},
-	{
-		(const char * const []){"LEN0042", NULL},
-		{ANY_BOARD_ID, ANY_BOARD_ID},
-		1232, 5710, 1156, 4696
-	},
-	{
-		(const char * const []){"LEN0034", "LEN0036", "LEN0037",
-					"LEN0039", "LEN2002", "LEN2004",
-					NULL},
-		{ANY_BOARD_ID, 2961},
-		1024, 5112, 2024, 4832
-	},
-	{
-		(const char * const []){"LEN2000", NULL},
-		{ANY_BOARD_ID, ANY_BOARD_ID},
-		1024, 5113, 2021, 4832
-	},
-	{
-		(const char * const []){"LEN2001", NULL},
-		{ANY_BOARD_ID, ANY_BOARD_ID},
-		1024, 5022, 2508, 4832
-	},
-	{
-		(const char * const []){"LEN2006", NULL},
-		{2691, 2691},
-		1024, 5045, 2457, 4832
-	},
-	{
-		(const char * const []){"LEN2006", NULL},
-		{ANY_BOARD_ID, ANY_BOARD_ID},
-		1264, 5675, 1171, 4688
-	},
-	{ }
-};
+#if defined(CONFIG_MOUSE_PS2_SYNAPTICS) || \
+    defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)
 
 /* This list has been kindly provided by Synaptics. */
 static const char * const topbuttonpad_pnp_ids[] = {
@@ -211,37 +162,50 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	NULL
 };
 
-/* This list has been kindly provided by Synaptics. */
-static const char * const forcepad_pnp_ids[] = {
-	"SYN300D",
-	"SYN3014",
+static const char * const smbus_pnp_ids[] = {
+	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"LEN0048", /* X1 Carbon 3 */
+	"LEN0046", /* X250 */
+	"LEN004a", /* W541 */
+	"LEN200f", /* T450s */
 	NULL
 };
 
-/*****************************************************************************
- *	Synaptics communications functions
- ****************************************************************************/
-
 /*
- * Synaptics touchpads report the y coordinate from bottom to top, which is
- * opposite from what userspace expects.
- * This function is used to invert y before reporting.
+ * Send a command to the synpatics touchpad by special commands
  */
-static int synaptics_invert_y(int y)
+static int synaptics_send_cmd(struct psmouse *psmouse,
+			      unsigned char c, unsigned char *param)
 {
-	return YMAX_NOMINAL + YMIN_NOMINAL - y;
+	int error;
+
+	error = psmouse_sliced_command(psmouse, c);
+	if (error)
+		return error;
+
+	error = ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO);
+	if (error)
+		return error;
+
+	return 0;
 }
 
 /*
- * Send a command to the synpatics touchpad by special commands
+ * Identify Touchpad
+ * See also the SYN_ID_* macros
  */
-static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
+static int synaptics_identify(struct psmouse *psmouse,
+			      struct synaptics_device_info *info)
 {
-	if (psmouse_sliced_command(psmouse, c))
-		return -1;
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO))
-		return -1;
-	return 0;
+	unsigned char id[3];
+	int error;
+
+	error = synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id);
+	if (error)
+		return error;
+
+	info->identity = (id[0] << 16) | (id[1] << 8) | id[2];
+	return SYN_ID_IS_SYNAPTICS(info->identity) ? 0 : -ENXIO;
 }
 
 /*
@@ -262,6 +226,23 @@ static int synaptics_model_id(struct psmouse *psmouse,
 	return 0;
 }
 
+/*
+ * Read the firmware id from the touchpad
+ */
+static int synaptics_firmware_id(struct psmouse *psmouse,
+				 struct synaptics_device_info *info)
+{
+	unsigned char fwid[3];
+	int error;
+
+	error = synaptics_send_cmd(psmouse, SYN_QUE_FIRMWARE_ID, fwid);
+	if (error)
+		return error;
+
+	info->firmware_id = (fwid[0] << 16) | (fwid[1] << 8) | fwid[2];
+	return 0;
+}
+
 static int synaptics_more_extended_queries(struct psmouse *psmouse,
 					   struct synaptics_device_info *info)
 {
@@ -303,23 +284,6 @@ static int synaptics_query_modes(struct psmouse *psmouse,
 }
 
 /*
- * Read the firmware id from the touchpad
- */
-static int synaptics_firmware_id(struct psmouse *psmouse,
-				 struct synaptics_device_info *info)
-{
-	unsigned char fwid[3];
-	int error;
-
-	error = synaptics_send_cmd(psmouse, SYN_QUE_FIRMWARE_ID, fwid);
-	if (error)
-		return error;
-
-	info->firmware_id = (fwid[0] << 16) | (fwid[1] << 8) | fwid[2];
-	return 0;
-}
-
-/*
  * Read the capability-bits from the touchpad
  * see also the SYN_CAP_* macros
  */
@@ -380,28 +344,9 @@ static int synaptics_capability(struct psmouse *psmouse,
 }
 
 /*
- * Identify Touchpad
- * See also the SYN_ID_* macros
- */
-static int synaptics_identify(struct psmouse *psmouse,
-			      struct synaptics_device_info *info)
-{
-	unsigned char id[3];
-	int error;
-
-	error = synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id);
-	if (error)
-		return error;
-
-	info->identity = (id[0] << 16) | (id[1] << 8) | id[2];
-	return SYN_ID_IS_SYNAPTICS(info->identity) ? 0 : -ENXIO;
-}
-
-/*
  * Read touchpad resolution and maximum reported coordinates
  * Resolution is left zero if touchpad does not support the query
  */
-
 static int synaptics_resolution(struct psmouse *psmouse,
 				struct synaptics_device_info *info)
 {
@@ -460,10 +405,118 @@ static int synaptics_resolution(struct psmouse *psmouse,
 	return 0;
 }
 
+static int synaptics_query_hardware(struct psmouse *psmouse,
+				    struct synaptics_device_info *info)
+{
+	int error;
+
+	error = synaptics_identify(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_model_id(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_firmware_id(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_query_modes(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_capability(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_resolution(psmouse, info);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS || CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS */
+
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+
+static bool cr48_profile_sensor;
+
+#define ANY_BOARD_ID 0
+struct min_max_quirk {
+	const char * const *pnp_ids;
+	struct {
+		u32 min, max;
+	} board_id;
+	u32 x_min, x_max, y_min, y_max;
+};
+
+static const struct min_max_quirk min_max_pnpid_table[] = {
+	{
+		(const char * const []){"LEN0033", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
+		1024, 5052, 2258, 4832
+	},
+	{
+		(const char * const []){"LEN0042", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
+		1232, 5710, 1156, 4696
+	},
+	{
+		(const char * const []){"LEN0034", "LEN0036", "LEN0037",
+					"LEN0039", "LEN2002", "LEN2004",
+					NULL},
+		{ANY_BOARD_ID, 2961},
+		1024, 5112, 2024, 4832
+	},
+	{
+		(const char * const []){"LEN2000", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
+		1024, 5113, 2021, 4832
+	},
+	{
+		(const char * const []){"LEN2001", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
+		1024, 5022, 2508, 4832
+	},
+	{
+		(const char * const []){"LEN2006", NULL},
+		{2691, 2691},
+		1024, 5045, 2457, 4832
+	},
+	{
+		(const char * const []){"LEN2006", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
+		1264, 5675, 1171, 4688
+	},
+	{ }
+};
+
+/* This list has been kindly provided by Synaptics. */
+static const char * const forcepad_pnp_ids[] = {
+	"SYN300D",
+	"SYN3014",
+	NULL
+};
+
+/*****************************************************************************
+ *	Synaptics communications functions
+ ****************************************************************************/
+
+/*
+ * Synaptics touchpads report the y coordinate from bottom to top, which is
+ * opposite from what userspace expects.
+ * This function is used to invert y before reporting.
+ */
+static int synaptics_invert_y(int y)
+{
+	return YMAX_NOMINAL + YMIN_NOMINAL - y;
+}
+
 /*
  * Apply quirk(s) if the hardware matches
  */
-
 static void synaptics_apply_quirks(struct psmouse *psmouse,
 				   struct synaptics_device_info *info)
 {
@@ -494,38 +547,6 @@ static void synaptics_apply_quirks(struct psmouse *psmouse,
 	}
 }
 
-static int synaptics_query_hardware(struct psmouse *psmouse,
-				    struct synaptics_device_info *info)
-{
-	int error;
-
-	error = synaptics_identify(psmouse, info);
-	if (error)
-		return error;
-
-	error = synaptics_model_id(psmouse, info);
-	if (error)
-		return error;
-
-	error = synaptics_firmware_id(psmouse, info);
-	if (error)
-		return error;
-
-	error = synaptics_query_modes(psmouse, info);
-	if (error)
-		return error;
-
-	error = synaptics_capability(psmouse, info);
-	if (error)
-		return error;
-
-	error = synaptics_resolution(psmouse, info);
-	if (error)
-		return error;
-
-	return 0;
-}
-
 static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 {
 	static unsigned char param = 0xc8;
@@ -1350,6 +1371,12 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
+	/*
+	 * We might have left a breadcrumb when trying to
+	 * set up SMbus companion.
+	 */
+	psmouse_smbus_cleanup(psmouse);
+
 	if (!priv->absolute_mode &&
 			SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
 		device_remove_file(&psmouse->ps2dev.serio->dev,
@@ -1490,39 +1517,20 @@ void __init synaptics_module_init(void)
 	cr48_profile_sensor = dmi_check_system(cr48_dmi_table);
 }
 
-static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
+static int synaptics_init_ps2(struct psmouse *psmouse,
+			      struct synaptics_device_info *info,
+			      bool absolute_mode)
 {
 	struct synaptics_data *priv;
-	struct synaptics_device_info *info;
-	int err = -1;
+	int err;
 
-	/*
-	 * The OLPC XO has issues with Synaptics' absolute mode; the constant
-	 * packet spew overloads the EC such that key presses on the keyboard
-	 * are missed.  Given that, don't even attempt to use Absolute mode.
-	 * Relative mode seems to work just fine.
-	 */
-	if (absolute_mode && broken_olpc_ec) {
-		psmouse_info(psmouse,
-			     "OLPC XO detected, not enabling Synaptics protocol.\n");
-		return -ENODEV;
-	}
+	synaptics_apply_quirks(psmouse, info);
 
 	psmouse->private = priv = kzalloc(sizeof(struct synaptics_data), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	info = &priv->info;
-
-	psmouse_reset(psmouse);
-
-	if (synaptics_query_hardware(psmouse, info)) {
-		psmouse_err(psmouse, "Unable to query device.\n");
-		goto init_fail;
-	}
-
-	synaptics_apply_quirks(psmouse, info);
-
+	priv->info = *info;
 	priv->absolute_mode = absolute_mode;
 	if (SYN_ID_DISGEST_SUPPORTED(info->identity))
 		priv->disable_gesture = true;
@@ -1533,7 +1541,8 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	 */
 	priv->is_forcepad = psmouse_matches_pnp_id(psmouse, forcepad_pnp_ids);
 
-	if (synaptics_set_mode(psmouse)) {
+	err = synaptics_set_mode(psmouse);
+	if (err) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
 		goto init_fail;
 	}
@@ -1610,7 +1619,23 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	return err;
 }
 
-int synaptics_init(struct psmouse *psmouse)
+static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
+{
+	struct synaptics_device_info info;
+	int error;
+
+	psmouse_reset(psmouse);
+
+	error = synaptics_query_hardware(psmouse, &info);
+	if (error) {
+		psmouse_err(psmouse, "Unable to query device: %d\n", error);
+		return error;
+	}
+
+	return synaptics_init_ps2(psmouse, &info, absolute_mode);
+}
+
+int synaptics_init_absolute(struct psmouse *psmouse)
 {
 	return __synaptics_init(psmouse, true);
 }
@@ -1620,15 +1645,204 @@ int synaptics_init_relative(struct psmouse *psmouse)
 	return __synaptics_init(psmouse, false);
 }
 
+static int synaptics_setup_ps2(struct psmouse *psmouse,
+			       struct synaptics_device_info *info)
+{
+	bool absolute_mode = true;
+	int error;
+
+	/*
+	 * The OLPC XO has issues with Synaptics' absolute mode; the constant
+	 * packet spew overloads the EC such that key presses on the keyboard
+	 * are missed.  Given that, don't even attempt to use Absolute mode.
+	 * Relative mode seems to work just fine.
+	 */
+	if (broken_olpc_ec) {
+		psmouse_info(psmouse,
+			     "OLPC XO detected, forcing relative protocol.\n");
+		absolute_mode = false;
+	}
+
+	error = synaptics_init_ps2(psmouse, info, absolute_mode);
+	if (error)
+		return error;
+
+	return absolute_mode ? PSMOUSE_SYNAPTICS : PSMOUSE_SYNAPTICS_RELATIVE;
+}
+
 #else /* CONFIG_MOUSE_PS2_SYNAPTICS */
 
 void __init synaptics_module_init(void)
 {
 }
 
-int synaptics_init(struct psmouse *psmouse)
+static int __maybe_unused
+synaptics_setup_ps2(struct psmouse *psmouse,
+		    struct synaptics_device_info *info)
 {
 	return -ENOSYS;
 }
 
 #endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
+
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS
+
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
+static int synaptics_create_intertouch(struct psmouse *psmouse,
+				       struct synaptics_device_info *info,
+				       bool leave_breadcrumbs)
+{
+	bool topbuttonpad =
+		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
+		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
+	const struct rmi_device_platform_data pdata = {
+		.sensor_pdata = {
+			.sensor_type = rmi_sensor_touchpad,
+			.axis_align.flip_y = true,
+			/* to prevent cursors jumps: */
+			.kernel_tracking = true,
+			.topbuttonpad = topbuttonpad,
+		},
+		.f30_data = {
+			.buttonpad = SYN_CAP_CLICKPAD(info->ext_cap_0c),
+			.trackstick_buttons =
+				!!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10),
+		},
+	};
+	const struct i2c_board_info intertouch_board = {
+		I2C_BOARD_INFO("rmi4_smbus", 0x2c),
+		.flags = I2C_CLIENT_HOST_NOTIFY,
+	};
+
+	return psmouse_smbus_init(psmouse, &intertouch_board,
+				  &pdata, sizeof(pdata),
+				  leave_breadcrumbs);
+}
+
+/**
+ * synaptics_setup_intertouch - called once the PS/2 devices are enumerated
+ * and decides to instantiate a SMBus InterTouch device.
+ */
+static int synaptics_setup_intertouch(struct psmouse *psmouse,
+				      struct synaptics_device_info *info,
+				      bool leave_breadcrumbs)
+{
+	int error;
+
+	if (synaptics_intertouch == SYNAPTICS_INTERTOUCH_OFF)
+		return -ENXIO;
+
+	if (synaptics_intertouch == SYNAPTICS_INTERTOUCH_NOT_SET) {
+		if (!psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
+		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids))
+			return -ENXIO;
+	}
+
+	psmouse_info(psmouse, "Trying to set up SMBus access\n");
+
+	error = synaptics_create_intertouch(psmouse, info, leave_breadcrumbs);
+	if (error) {
+		if (error == -EAGAIN)
+			psmouse_info(psmouse, "SMbus companion is not ready yet\n");
+		else
+			psmouse_err(psmouse, "unable to create intertouch device\n");
+
+		return error;
+	}
+
+	return 0;
+}
+
+int synaptics_init_smbus(struct psmouse *psmouse)
+{
+	struct synaptics_device_info info;
+	int error;
+
+	psmouse_reset(psmouse);
+
+	error = synaptics_query_hardware(psmouse, &info);
+	if (error) {
+		psmouse_err(psmouse, "Unable to query device: %d\n", error);
+		return error;
+	}
+
+	if (!SYN_CAP_INTERTOUCH(info.ext_cap_0c))
+		return -ENXIO;
+
+	return synaptics_create_intertouch(psmouse, &info, false);
+}
+
+#else /* CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS */
+
+static int __maybe_unused
+synaptics_setup_intertouch(struct psmouse *psmouse,
+			   struct synaptics_device_info *info,
+			   bool leave_breadcrumbs)
+{
+	return -ENOSYS;
+}
+
+int synaptics_init_smbus(struct psmouse *psmouse)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS */
+
+#if defined(CONFIG_MOUSE_PS2_SYNAPTICS) || \
+    defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)
+
+int synaptics_init(struct psmouse *psmouse)
+{
+	struct synaptics_device_info info;
+	int error;
+	int retval;
+
+	psmouse_reset(psmouse);
+
+	error = synaptics_query_hardware(psmouse, &info);
+	if (error) {
+		psmouse_err(psmouse, "Unable to query device: %d\n", error);
+		return error;
+	}
+
+	if (SYN_CAP_INTERTOUCH(info.ext_cap_0c)) {
+		error = synaptics_setup_intertouch(psmouse, &info, true);
+		if (!error)
+			return PSMOUSE_SYNAPTICS_SMBUS;
+	}
+
+	retval = synaptics_setup_ps2(psmouse, &info);
+	if (retval < 0) {
+		/*
+		 * Not using any flavor of Synaptics support, so clean up
+		 * SMbus breadcrumbs, if any.
+		 */
+		psmouse_smbus_cleanup(psmouse);
+	}
+
+	return retval;
+}
+
+#else /* CONFIG_MOUSE_PS2_SYNAPTICS || CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS */
+
+int synaptics_init(struct psmouse *psmouse)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS || CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS */
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 4d1452718cbc..fc93481cf183 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -90,6 +90,7 @@
 #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
 #define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & 0x000400)
 #define SYN_CAP_IMAGE_SENSOR(ex0c)	((ex0c) & 0x000800)
+#define SYN_CAP_INTERTOUCH(ex0c)	((ex0c) & 0x004000)
 
 /*
  * The following descibes response for the 0x10 query.
@@ -204,8 +205,10 @@ struct synaptics_data {
 
 void synaptics_module_init(void);
 int synaptics_detect(struct psmouse *psmouse, bool set_properties);
-int synaptics_init(struct psmouse *psmouse);
+int synaptics_init_absolute(struct psmouse *psmouse);
 int synaptics_init_relative(struct psmouse *psmouse);
+int synaptics_init_smbus(struct psmouse *psmouse);
+int synaptics_init(struct psmouse *psmouse);
 void synaptics_reset(struct psmouse *psmouse);
 
 #endif /* _SYNAPTICS_H */
-- 
2.12.0.367.g23dc2f6d3c-goog

