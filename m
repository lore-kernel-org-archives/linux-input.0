From: Rezwanul Kabir <Rezwanul_Kabir@dell.com>
Subject: [RESEND PATCH]: Add support for Intellimouse Mode in ALPS touchpad on Dell E2 series Laptops
Date: Tue, 23 Nov 2010 14:15:14 -0600
Message-ID: <1290543314-1114-1-git-send-email-Rezwanul_Kabir@dell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:22925 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0KWUOV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 15:14:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rezwanul_Kabir@dell.com

Resending modified patch to fix suspend/resume issues and restricting the
quirks to Dell portables only.

Dell E2 series laptops ( M4500, E6510, E6410 etc.) have ALPS touchpads
which are enabled by default as 3-byte generic PS/2 mouse mode. This
patch enables the 4-byte "Intellimouse Mode" ( e.g scrolling support).

Signed-off-by: Rezwanul_Kabir <Rezwanul_Kabir@dell.com>
---

diff -urNp a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c	2010-08-06 12:43:11.000000000 -0500
+++ b/drivers/input/mouse/alps.c	2010-09-20 15:42:26.000000000 -0500
@@ -15,6 +15,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/serio.h>
@@ -63,6 +64,8 @@ static const struct alps_model_info alps
 	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
 	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
+	/* Dell Precision 4500 */
+	{ { 0x73, 0x02, 0x64 }, 0x80, 0x80, 0 },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshiba Tecra A11-11L */
@@ -111,6 +114,92 @@ static const struct alps_model_info alps
  * on a dualpoint, etc.
  */
 
+static const struct dmi_system_id dell_quirk_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"),
+		},
+	},
+	{ }
+};
+
+int alps_model_quirk_enabled;
+static void dell_e2_model_init(void *data);
+
+ /* Magic Sequence to enable Intellimouse Mode on Dell E2 Touchpads*/
+
+static int dell_e2_setup_intellimouse_mode(void *data)
+{
+	struct psmouse *psmouse = (struct psmouse *)(data);
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[] = {0, 0, 0};
+
+	if (!dmi_check_system(dell_quirk_table))
+		return -1;
+
+	if (ps2_command(ps2dev, param, 0x00f5) ||
+		ps2_command(ps2dev, param, 0x00ea) ||
+		ps2_command(ps2dev, param, 0x00ec) ||
+		ps2_command(ps2dev, param, 0x00ec) ||
+		ps2_command(ps2dev, param, 0x00ec) ||
+		ps2_command(ps2dev, param, 0x03e9))
+			return -1;
+
+	dbg("alps:dell_e2_setup: param[0]: %x,"
+		"param[1]: %x, param[2]: %x\n", param[0],
+					param[1], param[2]);
+ /* Check for supported model to continue */
+
+	if (!((param[0] == 0x88) && (param[1] == 0x07)
+		&& ((param[2] == 0x9D) || (param[2] == 0x9B))))
+		return -1;
+
+	if (ps2_command(ps2dev, NULL, 0x00ec) ||
+		ps2_command(ps2dev, NULL, 0x00f0) ||
+		ps2_command(ps2dev, NULL, 0x00f0) ||
+		ps2_command(ps2dev, NULL, 0x00f0) ||
+		ps2_command(ps2dev, NULL, 0x00f3) ||
+		ps2_command(ps2dev, NULL, 0x0028) ||
+		ps2_command(ps2dev, NULL, 0x00f0) ||
+		ps2_command(ps2dev, NULL, 0x00f6) ||
+		ps2_command(ps2dev, NULL, 0x00ea) ||
+		ps2_command(ps2dev, NULL, 0x00f4))
+			return -1;
+
+	return 0;
+}
+
+static const struct alps_model_quirk alps_model_init_quirk_tbl[] = {
+
+	{ {0x73, 0x02, 0x64}, dell_e2_setup_intellimouse_mode, dell_e2_model_init }
+};
+
+static int alps_model_hw_init_quirk(struct psmouse *psmouse,
+					const struct alps_model_info *model)
+{
+	int rc = 1;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(alps_model_init_quirk_tbl); i++) {
+		if (!memcmp(model->signature,
+			alps_model_init_quirk_tbl[i].signature,
+			    sizeof(alps_model_init_quirk_tbl[i].signature))) {
+				rc = alps_model_init_quirk_tbl[i].alps_model_quirk_hw_init(psmouse);
+				alps_model_quirk_enabled = i + 1;
+				break;
+		}
+	}
+
+	return rc;
+}
+
 static bool alps_is_valid_first_byte(const struct alps_model_info *model,
 				     unsigned char data)
 {
@@ -599,6 +688,10 @@ static int alps_hw_init(struct psmouse *
 	struct alps_data *priv = psmouse->private;
 	const struct alps_model_info *model = priv->i;
 
+	if (alps_model_hw_init_quirk(psmouse, model)) {
+		alps_model_quirk_enabled = 0;
+	}
+
 	if ((model->flags & ALPS_PASS) &&
 	    alps_passthrough_mode(psmouse, true)) {
 		return -1;
@@ -651,6 +744,21 @@ static void alps_disconnect(struct psmou
 	kfree(priv);
 }
 
+static void dell_e2_model_init(void *data)
+{
+	struct psmouse *psmouse = (struct psmouse *)(data);
+	struct input_dev *dev = psmouse->dev;
+
+	__set_bit(BTN_MIDDLE, dev->keybit);
+	__set_bit(REL_WHEEL, dev->relbit);
+
+	psmouse->pktsize = 4;
+	psmouse->type = PSMOUSE_IMPS;
+	psmouse->disconnect = alps_disconnect;
+	psmouse->reconnect = alps_reconnect;
+
+}
+
 int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
@@ -677,6 +785,12 @@ int alps_init(struct psmouse *psmouse)
 	if (alps_hw_init(psmouse))
 		goto init_fail;
 
+	if (alps_model_quirk_enabled) {
+		printk(KERN_WARNING "alps.c: Enabled hardware quirk, falling back to psmouse-core\n");
+		alps_model_init_quirk_tbl[alps_model_quirk_enabled-1].alps_model_quirk_init(psmouse);
+		return 0;
+	}
+
 	/*
 	 * Undo part of setup done for us by psmouse core since touchpad
 	 * is not a relative device.
diff -urNp a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
--- a/drivers/input/mouse/alps.h	2010-08-06 12:43:06.000000000 -0500
+++ b/drivers/input/mouse/alps.h	2010-09-20 03:20:07.000000000 -0500
@@ -26,6 +26,12 @@ struct alps_data {
 	struct timer_list timer;
 };
 
+struct alps_model_quirk {
+unsigned char signature[3];
+int (*alps_model_quirk_hw_init)(void *data);
+void (*alps_model_quirk_init)(void *data);
+};
+
 #ifdef CONFIG_MOUSE_PS2_ALPS
 int alps_detect(struct psmouse *psmouse, bool set_properties);
 int alps_init(struct psmouse *psmouse);
diff -urNp a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2010-08-06 12:42:57.000000000 -0500
+++ b/drivers/input/mouse/psmouse-base.c	2010-09-20 15:20:35.000000000 -0500
@@ -659,7 +659,8 @@ static int psmouse_extensions(struct psm
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 		if (alps_detect(psmouse, set_properties) == 0) {
 			if (!set_properties || alps_init(psmouse) == 0)
-				return PSMOUSE_ALPS;
+/* If ALPS model quirk was applied, don't change the settings */
+				return psmouse->type ? psmouse->type : PSMOUSE_ALPS;
 /*
  * Init failed, try basic relative protocols
  */
