From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Sun, 29 Mar 2015 16:36:19 +0200
Message-ID: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38626 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbbC2Ogw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Mar 2015 10:36:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch fixes commit 61579ba83934 ("Input: atkbd - expand Latitude's=
 force
release quirk to other Dells"). Before that commit release quirks were =
called
for all Dell Latitude models. After that commit only for Portable Dell =
devices.
But lot of Latitude models are Laptop or Notebook DMI devices so quirks=
 are not
called.

Release quirks are still needed also for new Dell Latitude models, so t=
his patch
enables quirks for all Portable, Laptop, Notebook and Sub-Notebook Dell=
 devices.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/keyboard/atkbd.c |   48 ++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/at=
kbd.c
index 387c51f..3188493 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1664,6 +1664,30 @@ static const struct dmi_system_id atkbd_dmi_quir=
k_table[] __initconst =3D {
 	},
 	{
 		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
+		},
+		.callback =3D atkbd_setup_forced_release,
+		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+		.callback =3D atkbd_setup_forced_release,
+		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
+		},
+		.callback =3D atkbd_setup_forced_release,
+		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
+	},
+	{
+		.matches =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
 		},
@@ -1672,6 +1696,30 @@ static const struct dmi_system_id atkbd_dmi_quir=
k_table[] __initconst =3D {
 	},
 	{
 		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
+		},
+		.callback =3D atkbd_setup_forced_release,
+		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+		.callback =3D atkbd_setup_forced_release,
+		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
+		},
+		.callback =3D atkbd_setup_forced_release,
+		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
+	},
+	{
+		.matches =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 2133"),
 		},
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
