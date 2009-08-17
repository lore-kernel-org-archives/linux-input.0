From: Eugeniy Meshcheryakov <eugen@debian.org>
Subject: [PATCH] input: i8042 - add Acer Aspire 5536 to the noloop list
Date: Mon, 17 Aug 2009 03:03:22 +0200
Message-ID: <1250471002-20780-1-git-send-email-eugen@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.tu-cottbus.de ([141.43.99.248]:34412 "EHLO
	smtp2.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQBOS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Aug 2009 21:14:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eugeniy Meshcheryakov <eugen@debian.org>

Without this patch it is not possible to reenable touchpad
after disabling it using disable button.
---
 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index ae04d8a..e6d0890 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -167,6 +167,14 @@ static struct dmi_system_id __initdata i8042_dmi_noloop_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
 		},
 	},
+	{
+		.ident = "Acer Aspire 5536",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+		},
+	},
 	{ }
 };
 
-- 
1.6.3.3

