From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH v2] Input: i8042 - add mux quirk for HP EliteBook
Date: Tue, 28 Oct 2014 22:27:12 +0000
Message-ID: <1414535232-4780-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This laptop requires active multiplexing to be enabled in order to be able
to separate the PS/2 mouse and the touchpad.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index a0bcbb64d06d..2bd486e83b43 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -220,6 +220,13 @@ static const struct dmi_system_id __initconst i8042_dmi_mux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
 		},
 	},
+	{
+		/* HP EliteBook */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.0
