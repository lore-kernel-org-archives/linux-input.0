From: Jaime Velasco Juan <jsagarribay@gmail.com>
Subject: [PATCH] input: atkbd - Fix broken keyboard in another LG laptop
Date: Wed, 10 Sep 2014 19:06:14 +0100
Message-ID: <1410372374-11591-1-git-send-email-jsagarribay@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sheng-Liang Song <ssl@chromium.org>
List-Id: linux-input@vger.kernel.org

This model has the same quirk as others, see 3d725caa9dcc "Input:
atkbd - fix keyboard not working on some LG laptops"

Cc: stable@vger.kernel.org
Signed-off-by: Jaime Velasco Juan <jsagarribay@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sheng-Liang Song <ssl@chromium.org>
---
 drivers/input/keyboard/atkbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2dd1d0d..a58653c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1802,6 +1802,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LW60-F27B"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.1.0
