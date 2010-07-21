From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] [resend] Input: i8042 - introduce noaux dmi quirk for MSI
 AE2220
Date: Wed, 21 Jul 2010 18:16:25 +0200
Message-ID: <20100721181625.286f147c@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63609 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760660Ab0GUQRO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jul 2010 12:17:14 -0400
Received: by eya25 with SMTP id 25so1713656eya.19
        for <linux-input@vger.kernel.org>; Wed, 21 Jul 2010 09:17:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>


This computer does no have an external PS2 port, and booting without
i8042.noaux induces a 10 second boot delay, until the AUX port detection
timeouts.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/input/serio/i8042-x86ia64io.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 6168469..f5f81e2 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -479,6 +479,20 @@ static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id __initconst i8042_dmi_noaux_table[] = {
+	{
+		/*
+		 * MSI AE2220
+		 * Timeout (10 sec) at boot if not passed noaux
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MS-6657"),
+		},
+	},
+	{ }
+};
+
 #ifdef CONFIG_PNP
 static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
 	{
@@ -871,6 +885,9 @@ static int __init i8042_platform_init(void)
 
 	if (dmi_check_system(i8042_dmi_dritek_table))
 		i8042_dritek = true;
+
+	if (dmi_check_system(i8042_dmi_noaux_table))
+		i8042_noaux = true;
 #endif /* CONFIG_X86 */
 
 	return retval;
-- 
1.7.0.6

