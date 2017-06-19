From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] Input: i8042 - add Fujitsu Lifebook AH544 to notimeout list
Date: Mon, 19 Jun 2017 11:41:57 -0600
Message-ID: <20170619174157.3385-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35352 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdFSRmF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 13:42:05 -0400
Received: by mail-ua0-f169.google.com with SMTP id j53so50134406uaa.2
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 10:42:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux@endlessm.com

Without this quirk, the touchpad is not responsive on this product, with
the following message repeated in the logs:

 psmouse serio1: bad data from KBC - timeout

Add it to the notimeout list alongside other similar Fujitsu laptops.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 09720d950686..f932a83b4990 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -723,6 +723,13 @@ static const struct dmi_system_id __initconst i8042_dmi_notimeout_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
 		},
 	},
+	{
+		/* Fujitsu UH554 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
+		},
+	},
 	{ }
 };
 
-- 
2.11.0

