From: Alberto Ponces <ponces26@gmail.com>
Subject: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform data for the Teclast X3 Plus tablet
Date: Tue, 23 Jan 2018 18:33:38 +0000
Message-ID: <1516732419-125-1-git-send-email-ponces26@gmail.com>
References: <1516706288-177-1-git-send-email-ponces26@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516706288-177-1-git-send-email-ponces26@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: ponces26@gmail.com, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add touchscreen platform data for the Teclast X3 Plus tablet.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Alberto Ponces <ponces26@gmail.com>
---
 drivers/platform/x86/silead_dmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 048a82f..3a62409 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -263,6 +263,20 @@ static const struct silead_ts_dmi_data teclast_x98plus2_data = {
 	.properties	= teclast_x98plus2_props,
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
@@ -423,6 +437,15 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
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
