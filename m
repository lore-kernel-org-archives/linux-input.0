From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: Add i8042.nopnp for Intel D845PESV
Date: Tue, 27 May 2008 17:15:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805271710240.6718@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:54651 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754717AbYE0PP5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2008 11:15:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Input: Add i8042.nopnp for Intel D845PESV

This patch introduces i8042_dmi_nopnp_table to make it possible to perform 
DMI matches for systems that need 'i8042.nopnp' to work correctly, and 
introduces such an entry for Intel D845PESV -- this system doesn't 
detect PS2 mouse reliably without this option, as reported by Robert 
Lewis.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 drivers/input/serio/i8042-x86ia64io.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 5ece9f5..709c9d9 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -287,7 +287,16 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 	{ }
 };
 
-
+static struct dmi_system_id __initdata i8042_dmi_nopnp_table[] = {
+	{
+		.ident = "Intel MBO Desktop D845PESV",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+		},
+	},
+	{ }
+};
 
 #endif
 
@@ -569,6 +578,10 @@ static int __init i8042_platform_init(void)
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
+#if defined(__i386__) || defined(__x86_64__)
+	if (dmi_check_system(i8042_dmi_nopnp_table))
+		i8042_nopnp = 1;
+#endif
 	retval = i8042_pnp_init();
 	if (retval)
 		return retval;
