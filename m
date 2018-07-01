From: Jun Bo Bi <jambonmcyeah@gmail.com>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add touchscreen platform data for the Onda V820w tablet
Date: Sun,  1 Jul 2018 17:47:14 -0400
Message-ID: <20180701214714.2522-1-jambonmcyeah@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jambonmcyeah@gmail.com, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, dvhart@infradead.org, andy@infradead.org
List-Id: linux-input@vger.kernel.org

Add touchscreen platform data for the Onda V820w tablet

Signed-off-by: Jun Bo Bi <jambonmcyeah@gmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 6284946cb0d1..a8e083db0369 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -204,6 +204,22 @@ static const struct ts_dmi_data onda_obook_20_plus_data = {
 	.properties	= onda_obook_20_plus_props,
 };
 
+static const struct property_entry onda_v820w_32g_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1680-onda-v820w-32g.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_v820w_32g_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v820w_32g_props,
+};
+
 static const struct property_entry onda_v891w_v1_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
 	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
@@ -470,6 +486,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
 		},
 	},
+	{
+		/* ONDA V820w DualOS */
+		.driver_data = (void *)&onda_v820w_32g_data,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "V820w DualOS")
+		},
+	},
 	{
 		/* ONDA V891w revision P891WBEBV1B00 aka v1 */
 		.driver_data = (void *)&onda_v891w_v1_data,
-- 
2.18.0
