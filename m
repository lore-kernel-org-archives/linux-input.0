From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] input/serio/i8042-x86ia64io.h: Fix Asus X450LCP touchpad detection
Date: Tue, 23 Sep 2014 12:24:33 -0300
Message-ID: <1411485873-4245-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Tom Gundersen <teg@jklm.no>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Gundersen <teg@jklm.no>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 136b7b20..ec6cb72 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -465,6 +465,15 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
 		},
 	},
+	{
+		/* Asus X450LCP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
+		},
+	},
+
+
 	{ }
 };
 
-- 
1.9.3
