From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: add Acer Aspire 1360 to nomux blacklist
Date: Wed, 2 Jul 2008 11:48:06 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807021147150.6375@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:44439 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753508AbYGBJsI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jul 2008 05:48:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Clark Tompsett <clarkt@cnsp.com>

Acer Aspire 1360 needs to be added to nomux blacklist, otherwise its 
touchpad misbehaves.

Reported-by: Clark Tompsett <clarkt@cnsp.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 78eb784..1d7b175 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -291,6 +291,13 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
  			DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
  		},
  	},
+	{
+		.ident = "Acer Aspire 1360",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
+		},
+	},
  	{ }
  };

