From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: Add Fujitsu-Siemens Amilo Pro V2030 to nomux table
Date: Wed, 4 Jun 2008 00:20:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806040016400.10085@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:59901 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753514AbYFCWUJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jun 2008 18:20:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Mleziva <jmleziva@tiscali.cz>

Fujitsu Siemens Amilo Pro V2030 needs nomux table entry, in addition to 
already existing entry for V2010 model (note that Fujitsu-Siemens changed 
the capitalization in the DMI data for product).

Tested-by: Jiri Mleziva <jmleziva@tiscali.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 
 drivers/input/serio/i8042-x86ia64io.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 9aafa96..66068c9 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -190,6 +190,12 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
+	},
+	{
+		.ident = "Fujitsu-Siemens Amilo Pro 2030",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
 		},
 	},
 	{
