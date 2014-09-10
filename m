From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i8042: Add Fujitsu U574 to no_timeout dmi table
Date: Wed, 10 Sep 2014 20:33:55 +0200
Message-ID: <1410374035-5461-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=69731

Cc: stable@vger.kernel.org
Reported-by: Jason Robinson <mail@jasonrobinson.me>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 136b7b20..2f08daa 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -608,6 +608,14 @@ static const struct dmi_system_id __initconst i8042_dmi_notimeout_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
 		},
 	},
+	{
+		/* Fujitsu U574 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.0
