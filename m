From: ohaibuzzle@gmail.com
Subject: [PATCH] platform/x86: silead_dmi: Add touchscreen platform data for the Chuwi Surbook Mini tablet
Date: Sat,  3 Aug 2019 08:22:38 +0700
Message-ID: <20190803012238.4099-1-ohaibuzzle@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com
Cc: dvhart@infradead.org, andy@infradead.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Buzzle <ohaibuzzle@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Buzzle <ohaibuzzle@gmail.com>

---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 4370e4add83a..72535b0268eb 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -136,6 +136,22 @@ static const struct ts_dmi_data chuwi_vi10_data = {
 	.properties     = chuwi_vi10_props,
 };
 
+static const struct property_entry chuwi_surbook_mini_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 88),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 13),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 2040),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1524),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-surbook-mini.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_surbook_mini_data = {
+	.acpi_name      = "MSSL1680:00",
+	.properties     = chuwi_surbook_mini_props,
+};
+
 static const struct property_entry connect_tablet9_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 9),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 10),
@@ -646,6 +662,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "S165"),
 		},
 	},
+	{
+		/* Chuwi Surbook Mini (CWI540) */
+		.driver_data = (void *)&chuwi_surbook_mini_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C3W6_AP108_4G"),
+		},
+	},
 	{
 		/* Connect Tablet 9 */
 		.driver_data = (void *)&connect_tablet9_data,
-- 
2.22.0
