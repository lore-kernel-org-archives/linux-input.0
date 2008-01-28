From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] Input: i8042 - add Dritek quirk for Acer Aspire 9110
Date: Mon, 28 Jan 2008 17:40:28 +0000
Message-ID: <20080128174028.10644.93685.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:36632 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1751770AbYA1SFV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jan 2008 13:05:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

The Acer Aspire 9110 series also requires the Dritek quirk to enable the
extra scancodes.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 4f6384d..0ceb84d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -310,6 +310,13 @@ static struct dmi_system_id __initdata i8042_dmi_dritek_table[] = {
 		},
 	},
 	{
+		.ident = "Acer Aspire 9110",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
+		},
+	},
+	{
 		.ident = "Acer TravelMate 2490",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

