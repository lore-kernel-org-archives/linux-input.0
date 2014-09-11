From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i8042: Add nomux quirk for Avatar AVIU-145A6
Date: Thu, 11 Sep 2014 10:46:53 +0200
Message-ID: <1410425213-7777-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hugo P <saurosii@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The sys_vendor / product_name are somewhat generic unfortunately, so this
may lead to some false positives. But nomux usually does no harm, where as
not having it clearly is causing problems on the Avatar AVIU-145A6.

https://bugzilla.kernel.org/show_bug.cgi?id=77391

Cc: stable@vger.kernel.org
Reported-by: Hugo P <saurosii@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 2f08daa..713e3dd 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -465,6 +465,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
 		},
 	},
+	{
+		/* Avatar AVIU-145A6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.0
