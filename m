From: youling257 <youling257@gmail.com>
Subject: [PATCH v1] platform/x86: silead_dmi: Add touchscreen info for the Onda V891w V3 tablet
Date: Sun, 17 Jun 2018 18:37:36 +0800
Message-ID: <20180617103736.1162-1-youling257@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, andy@infradead.org, dvhart@infradead.org, hdegoede@redhat.com, youling257 <youling257@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: youling257 <youling257@gmail.com>
---
 drivers/platform/x86/silead_dmi.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 853a7ce4601c..9e61182c8aff 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -326,6 +326,23 @@ static const struct silead_ts_dmi_data onda_v891w_v1_data = {
 	.properties	= onda_v891w_v1_props,
 };
 
+static const struct property_entry onda_v891w_v3_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "FW_I89_GSL3676B_19201200_.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_v891w_v3_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v891w_v3_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -554,6 +571,24 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
 		},
 	},
+	{
+		/* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
+		.driver_data = (void *)&onda_v891w_v3_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
+			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
+		},
+	},
+	{
+		/* ONDA V891w P891WBECV3A02121 32GB */
+		.driver_data = (void *)&onda_v891w_v3_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
+			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.1
