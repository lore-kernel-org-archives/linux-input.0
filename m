From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH 2/2] Input: atkbd - remove duplicated release key list quirks for some machines
Date: Fri, 16 Oct 2009 19:18:15 -0300
Message-ID: <1255731495-27552-2-git-send-email-herton@mandriva.com.br>
References: <1255731495-27552-1-git-send-email-herton@mandriva.com.br>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:59466 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbZJPWlf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2009 18:41:35 -0400
In-Reply-To: <1255731495-27552-1-git-send-email-herton@mandriva.com.br>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>

Some machines share same key list for volume up/down release key quirks,
use only one key list.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 drivers/input/keyboard/atkbd.c |   51 +++++++++++-----------------------------
 1 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 296f1fd..bddc55a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -852,29 +852,6 @@ static unsigned int atkbd_hp_forced_release_keys[] = {
 };
 
 /*
- * Inventec system with broken key release on volume keys
- */
-static unsigned int atkbd_inventec_forced_release_keys[] = {
-	0xae, 0xb0, -1U
-};
-
-/*
- * Perform fixup for HP Pavilion ZV6100 laptop that doesn't generate release
- * for its volume buttons
- */
-static unsigned int atkbd_hp_zv6100_forced_release_keys[] = {
-	0xae, 0xb0, -1U
-};
-
-/*
- * Perform fixup for HP (Compaq) Presario R4000 R4100 R4200 that don't generate
- * release for their volume buttons
- */
-static unsigned int atkbd_hp_r4000_forced_release_keys[] = {
-	0xae, 0xb0, -1U
-};
-
-/*
  * Samsung NC10,NC20 with Fn+F? key release not working
  */
 static unsigned int atkbd_samsung_forced_release_keys[] = {
@@ -882,14 +859,6 @@ static unsigned int atkbd_samsung_forced_release_keys[] = {
 };
 
 /*
- * The volume up and volume down special keys on a Fujitsu Amilo PA 1510 laptop
- * do not generate release events so we have to do it ourselves.
- */
-static unsigned int atkbd_amilo_pa1510_forced_release_keys[] = {
-	0xb0, 0xae, -1U
-};
-
-/*
  * Amilo Pi 3525 key release for Fn+Volume keys not working
  */
 static unsigned int atkbd_amilo_pi3525_forced_release_keys[] = {
@@ -904,6 +873,14 @@ static unsigned int atkbd_amilo_xi3650_forced_release_keys[] = {
 };
 
 /*
+ * Many notebooks don't send key release event for volume up/down
+ * keys, with key list below common among them
+ */
+static unsigned int atkbd_volume_forced_release_keys[] = {
+	0xae, 0xb0, -1U
+};
+
+/*
  * Many notebooks don't send key release event for volume up/down/mute
  * keys, with key list below common among them
  */
@@ -1549,7 +1526,7 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion ZV6100"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkbd_hp_zv6100_forced_release_keys,
+		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
 		.ident = "HP Presario R4000",
@@ -1558,7 +1535,7 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Presario R4000"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkbd_hp_r4000_forced_release_keys,
+		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
 		.ident = "HP Presario R4100",
@@ -1567,7 +1544,7 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Presario R4100"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkbd_hp_r4000_forced_release_keys,
+		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
 		.ident = "HP Presario R4200",
@@ -1576,7 +1553,7 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Presario R4200"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkbd_hp_r4000_forced_release_keys,
+		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
 		.ident = "Inventec Symphony",
@@ -1585,7 +1562,7 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "SYMPHONY 6.0/7.0"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkbd_inventec_forced_release_keys,
+		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
 		.ident = "Samsung NC10",
@@ -1621,7 +1598,7 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 1510"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkbd_amilo_pa1510_forced_release_keys,
+		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
 		.ident = "Fujitsu Amilo Pi 3525",
-- 
1.6.4.4

