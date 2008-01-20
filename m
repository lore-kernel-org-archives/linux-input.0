From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: Add Fujitsu-Siemens Amilo Pro 2010 to nomux list
Date: Sun, 20 Jan 2008 22:09:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801202207340.15647@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:44362 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755691AbYATVKB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jan 2008 16:10:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Hans Aschauer <Hans.Aschauer@web.de>


Add Fujitsu-Siemens Amilo Pro 2010 to nomux list.

Reported-by: Hans Aschauer <Hans.Aschauer@web.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

---
 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -186,6 +186,13 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident = "Fujitsu-Siemens Amilo Pro 2010",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
+		},
+	},
+	{
 		/*
 		 * No data is coming from the touchscreen unless KBC
 		 * is in legacy mode.
