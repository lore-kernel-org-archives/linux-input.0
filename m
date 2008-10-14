From: Jiri Kosina <jkosina@suse.cz>
Subject: Input: Add Acer Aspire 5710 to nomux blacklist
Date: Tue, 14 Oct 2008 17:28:23 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810141727020.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:60528 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751318AbYJNP2Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 11:28:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Carlos Tonussi <tonussi@farmaco.ufsc.br>

From: Jiri Kosina <jkosina@suse.cz>

Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
misbehaves.

Reported-by: Carlos Tonussi <tonussi@farmaco.ufsc.br>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

Index: linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- linux-2.6.27.orig/drivers/input/serio/i8042-x86ia64io.h
+++ linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h
@@ -316,6 +316,13 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident = "Acer Aspire 5710",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
+		},
+	},
+	{
 		.ident = "Gericom Bellagio",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
