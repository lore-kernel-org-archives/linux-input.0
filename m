From: Mario Limonciello <mario_limonciello@dell.com>
Subject: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Wed, 18 Feb 2015 19:43:00 -0600
Message-ID: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:56218 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbBSBxK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 20:53:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>

When the touchpad for the Dell XPS 13 is running in PS/2 mode the
EC has a tendency to glitch causing the driver to receive bad data.
This doesn't affect the usage of the touchpad until enough bad data
is received that causes the driver to reset and "freeze".

Signed-off-by: Mario Limonciello <mario_limonciello@dell.com>
---
 drivers/input/mouse/synaptics.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7e705ee..4dc456c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1244,6 +1244,21 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 	return 0;
 }
 
+static bool dell_ec_glitch;
+
+static const struct dmi_system_id dell_dmi_table[] __initconst = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* XPS 13 (2015) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
+		},
+	},
+	{ }
+#endif
+};
+
 static bool impaired_toshiba_kbc;
 
 static const struct dmi_system_id toshiba_dmi_table[] __initconst = {
@@ -1334,6 +1349,8 @@ void __init synaptics_module_init(void)
 	 * so we have to resort to checking DMI.
 	 */
 	is_forcepad = dmi_check_system(forcepad_dmi_table);
+	dell_ec_glitch = dmi_check_system(dell_dmi_table);
+
 }
 
 static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
@@ -1426,6 +1443,17 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		psmouse->rate = 40;
 	}
 
+	/*
+	 * Some Dell touchpads have a problem where the EC will glitch causing
+	 * bad packets that are otherwise harmless unless they cause psmouse
+	 * to reset.
+	 */
+	if (psmouse->resetafter > 0 && dell_ec_glitch) {
+		psmouse_info(psmouse, "Dell %s detected, disabling tpad reset.\n",
+			dmi_get_system_info(DMI_PRODUCT_NAME));
+		psmouse->resetafter = 0;
+	}
+
 	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity)) {
 		err = device_create_file(&psmouse->ps2dev.serio->dev,
 					 &psmouse_attr_disable_gesture.dattr);
-- 
1.9.1

