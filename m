From: Kai Renzig <k.renzig@gmail.com>
Subject: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform data for the Chuwi Hi8 Air tablet
Date: Sun,  3 Feb 2019 19:34:23 +0100
Message-ID: <20190203183423.7661-1-k.renzig@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Kai Renzig <k.renzig@gmail.com>
List-Id: linux-input@vger.kernel.org

Add touchscreen platform data for the Chuwi Hi8 Air tablet.

Signed-off-by: Kai Renzig <k.renzig@gmail.com>
---
Changes in v2:
 - Fix the firmware filename to match the actual touchscreen controller.

 drivers/platform/x86/touchscreen_dmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 8c5d47c0aea6..1f66405928a9 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -41,6 +41,20 @@ static const struct ts_dmi_data chuwi_hi8_data = {
 	.properties     = chuwi_hi8_props,
 };
 
+static const struct property_entry chuwi_hi8_air_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-chuwi-hi8-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_hi8_air_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= chuwi_hi8_air_props,
+};
+
 static const struct property_entry chuwi_hi8_pro_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
@@ -497,6 +511,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
 		},
 	},
+	{
+		/* Chuwi Hi8 Air (CWI543) */
+		.driver_data = (void *)&chuwi_hi8_air_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Hi8 Air"),
+		},
+	},
 	{
 		/* Chuwi Hi8 Pro (CWI513) */
 		.driver_data = (void *)&chuwi_hi8_pro_data,
-- 
2.19.1
