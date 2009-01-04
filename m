From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: add Dell Vostro 1510 to nomux list
Date: Sun, 4 Jan 2009 23:40:10 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901042339150.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50163 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751097AbZADWkM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 4 Jan 2009 17:40:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Robert Kiwanuka <robert.kiwanuka@gmail.com>


Dell Vostro needs 'nomux' quirk, otherwise the touchpad misbehaves.

Reported-by: Robert Kiwanuka <robert.kiwanuka@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 29e6863..660d783 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -351,6 +351,13 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
 		},
 	},
+	{
+		.ident = "Dell Vostro 1510",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
+		},
+	},
 	{ }
 };
 
