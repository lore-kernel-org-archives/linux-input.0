From: Alberto Ponces <ponces26@gmail.com>
Subject: [PATCH] Add touchscreen platform data for the Teclast X3 Plus tablet.
Date: Tue, 23 Jan 2018 11:18:07 +0000
Message-ID: <1516706288-177-1-git-send-email-ponces26@gmail.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: ponces26@gmail.com, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add touchscreen platform data for the Teclast X3 Plus tablet.

Signed-off-by: Alberto Ponces <ponces26@gmail.com>
---
 drivers/platform/x86/silead_dmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 266535c..d4c1190 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -171,6 +171,20 @@ static const struct silead_ts_dmi_data digma_citi_e200_data = {
 	.properties	= digma_citi_e200_props,
 };
 
+static const struct property_entry teclast_x3_plus_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-teclast-x3-plus.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data teclast_x3_plus_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= teclast_x3_plus_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -271,6 +285,15 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		},
 	},
+	{
+		/* Teclast X3 Plus */
+		.driver_data = (void *)&teclast_x3_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X3 Plus"),
+			DMI_MATCH(DMI_BOARD_NAME, "X3 Plus"),
+		},
+	},
 	{ },
 };
 
-- 
2.7.4
