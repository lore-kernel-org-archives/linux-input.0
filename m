From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] Input: i8042 - add Lenovo LaVie Z to the i8042 reset list
Date: Thu,  5 Jul 2018 21:08:49 +0800
Message-ID: <20180705130849.10479-1-wens@csie.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Lenovo LaVie Z laptop requires i8042 to be reset in order to
consistently detect its Elantech touchpad. The nomux and kbdreset
quirks are not sufficient.

It's possible the other LaVie Z models from NEC require this as well.

Cc: stable@vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index b353d494ad40..136f6e7bf797 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -527,6 +527,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
 		},
 	},
+	{
+		/* Lenovo LaVie Z */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
+		},
+	},
 	{ }
 };
 
-- 
2.18.0
