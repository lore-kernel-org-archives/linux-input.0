From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i8042: Add noloop quirk for Asus X750LN
Date: Sat, 11 Oct 2014 15:09:06 +0200
Message-ID: <1413032946-19748-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaJKNJO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2014 09:09:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Without this the aux port does not get detected, and consequently the touchpad
will not work.

https://bugzilla.redhat.com/show_bug.cgi?id=1110011

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 40b7d6c..4a6d05d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -101,6 +101,12 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
 	},
 	{
 		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
+		},
+	},
+	{
+		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
 			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
-- 
2.1.0

