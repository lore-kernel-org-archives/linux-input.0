From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Wed, 25 Jun 2014 11:42:43 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34650 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314AbaFYJmp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jun 2014 05:42:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
misbehaves rather randomly.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

---

Hi Dmitry,

I've come across this a few year old patch originating from our internal 
bugzilla, which was apparently been lost between the cracks somewhere. 
We've been carrying it in our kernel tree for quite some time ... could 
you please apply it? Thanks.

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -371,6 +371,13 @@ static const struct dmi_system_id __init
 		},
 	},
 	{
+		/* Acer Aspire 5710 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
+		},
+	},
+	{
 		/* Gericom Bellagio */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),

-- 
Jiri Kosina
SUSE Labs
