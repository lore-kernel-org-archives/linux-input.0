From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] Input: i8042 - Add Dritek quirk for Acer TravelMate 4280
Date: Wed, 06 Aug 2008 19:16:09 +0100
Message-ID: <20080806181608.5883.89155.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:57528 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1754309AbYHFSQM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Aug 2008 14:16:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Reported-by: Mattias Jernberg <nostrad@gmail.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index fe732a5..3282b74 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -394,6 +394,13 @@ static struct dmi_system_id __initdata i8042_dmi_dritek_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
 		},
 	},
+	{
+		.ident = "Acer TravelMate 4280",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
+		},
+	},
 	{ }
 };
 

