From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] Input: i8042 - Never reset on Sony VAIO VGN-CS series
Date: Mon,  9 Apr 2018 19:42:35 +0200
Message-ID: <20180409174235.28223-1-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Resetting i8042 breaks MUX on Sony VAIO VGN-CS. Never reset i8042 on
these machines to fix MUX after suspend.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 56644c74828c..34793e8bf636 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -544,16 +544,23 @@ static const struct dmi_system_id __initconst i8042_dmi_forcemux_table[] = {
 	{ }
 };
 
-/*
- * On some Asus laptops, just running self tests cause problems.
- */
 static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
 	{
+		/*
+		 * On some Asus laptops, just running self tests cause problems.
+		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
 	},
+	{
+		/* reset breaks MUX on Sony Vaio VGN-CS series */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+	},
 	{ }
 };
 static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
-- 
Ondrej Zary
