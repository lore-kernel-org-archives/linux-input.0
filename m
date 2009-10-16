From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH 1/2] Input: atkbd - add forced release keys quirk for Positivo I30
Date: Fri, 16 Oct 2009 19:18:14 -0300
Message-ID: <1255731495-27552-1-git-send-email-herton@mandriva.com.br>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:59467 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZJPWld (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2009 18:41:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>

Positivo I30 doesn't send release key event for volume up/down/mute
keys. The key list is the same as previous added Soltech TA12 quirk,
so integrate this using same list.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 drivers/input/keyboard/atkbd.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 4709e15..296f1fd 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -904,9 +904,10 @@ static unsigned int atkbd_amilo_xi3650_forced_release_keys[] = {
 };
 
 /*
- * Soltech TA12 system with broken key release on volume keys and mute key
+ * Many notebooks don't send key release event for volume up/down/mute
+ * keys, with key list below common among them
  */
-static unsigned int atkdb_soltech_ta12_forced_release_keys[] = {
+static unsigned int atkbd_mute_volume_forced_release_keys[] = {
 	0xa0, 0xae, 0xb0, -1U
 };
 
@@ -1647,7 +1648,16 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "TA12"),
 		},
 		.callback = atkbd_setup_forced_release,
-		.driver_data = atkdb_soltech_ta12_forced_release_keys,
+		.driver_data = atkbd_mute_volume_forced_release_keys,
+	},
+	{
+		.ident = "Positivo I30",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "POSITIVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "I30"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_mute_volume_forced_release_keys,
 	},
 	{ }
 };
-- 
1.6.4.4

