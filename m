From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: add Lenovo 3000 N100 to nomux blacklist
Date: Fri, 29 Feb 2008 15:37:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802291534420.3391@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42598 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750831AbYB2Ohi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Feb 2008 09:37:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Christopher Desjardins <cddesjardins@gmail.com>

Lenovo 3000 N100 needs entry in nomux blacklist.

Reported-by: Christopher Desjardins <cddesjardins@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 662e844..60931ac 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -277,6 +277,13 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
 		},
 	},
+	{
+		.ident = "Lenovo 3000 n100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
+		},
+	},
 	{ }
 };
 
