From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: [PATCH] Add touchscreen platform data for the Onda oBook 20 Plus tablet.
Date: Mon, 11 Dec 2017 00:02:13 +0200
Message-ID: <20171210220213.19290-1-nerijus@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Nerijus Baliunas <nerijus@users.sourceforge.net>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nerijus Baliūnas <nerijus@users.sourceforge.net>
---
 drivers/platform/x86/silead_dmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 266535c2a72f..414293e8c448 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -171,6 +171,23 @@ static const struct silead_ts_dmi_data digma_citi_e200_data = {
 	.properties	= digma_citi_e200_props,
 };
 
+static const struct property_entry onda_obook_20_plus_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-onda-obook-20-plus.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_obook_20_plus_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_obook_20_plus_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -271,6 +288,14 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		},
 	},
+	{
+		/* Onda oBook 20 Plus */
+		.driver_data = (void *)&onda_obook_20_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ONDA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
+		},
+	},
 	{ },
 };
 
-- 
2.14.3
