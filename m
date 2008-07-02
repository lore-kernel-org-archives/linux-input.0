From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: add Gericom Bellagio to nomux blacklist
Date: Wed, 2 Jul 2008 14:56:07 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807021454530.25376@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:51527 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751451AbYGBM4I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jul 2008 08:56:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Roland Kletzing <roland.kletzing@materna.de>, linux-input@vger.kernel.org

Gericom Bellagio needs to be added to nomux blacklist, otherwise its 
touchpad misbehaves.

Reported-by: Roland Kletzing <roland.kletzing@materna.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

---
  drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
  1 file changed, 7 insertions(+)

--- linux-2.6.25-SL110_BRANCH.orig/drivers/input/serio/i8042-x86ia64io.h
+++ linux-2.6.25-SL110_BRANCH/drivers/input/serio/i8042-x86ia64io.h
@@ -305,6 +305,13 @@ static struct dmi_system_id __initdata i
  			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
  		},
  	},
+	{
+		.ident = "Gericom Bellagio",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
+		},
+	},
  	{ }
  };

