From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] Input: i8042 - add Dritek quirk for Acer Aspire 5720
Date: Sat, 05 Jul 2008 08:59:17 +0100
Message-ID: <20080705075917.5040.21057.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:53248 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1750797AbYGEIxx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Jul 2008 04:53:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

The Acer Aspire 5720 series also requires the Dritek quirk to enable the
extra scancodes.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 0941254..b103a16 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -329,6 +329,13 @@ static struct dmi_system_id __initdata i8042_dmi_dritek_table[] = {
 		},
 	},
 	{
+		.ident = "Acer Aspire 5720",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+		},
+	},
+	{
 		.ident = "Acer Aspire 5680",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

