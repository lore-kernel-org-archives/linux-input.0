From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] Input: i8042 - introduce noaux dmi quirk for MSI AE2220
Date: Tue, 23 Mar 2010 15:50:24 +0100
Message-ID: <20100323155025.3a541cbd@destiny.ordissimo>
References: <20100319103450.56c6e278@destiny.ordissimo>
	<20100322043924.GD31621@core.coreip.homeip.net>
	<20100322144514.45391412@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:61889 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab0CWOvG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Mar 2010 10:51:06 -0400
Received: by pxi14 with SMTP id 14so4058640pxi.15
        for <linux-input@vger.kernel.org>; Tue, 23 Mar 2010 07:51:06 -0700 (PDT)
In-Reply-To: <20100322144514.45391412@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


This computer does no have an external PS2 port, and booting without
i8042.noaux induces a 10 second boot delay, until the AUX port detection
timeouts.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

This patch is against 2.6.34-rc2 and has been tested with kernel 2.6.33.1

Regards,

Anisse


 drivers/input/serio/i8042-x86ia64io.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index ead0494..de7af20 100644
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
@@ -857,6 +871,9 @@ static int __init i8042_platform_init(void)
 
 	if (dmi_check_system(i8042_dmi_dritek_table))
 		i8042_dritek = true;
+
+	if (dmi_check_system(i8042_dmi_noaux_table))
+		i8042_noaux = true;
 #endif /* CONFIG_X86 */
 
 	return retval;
-- 
1.6.5.7

