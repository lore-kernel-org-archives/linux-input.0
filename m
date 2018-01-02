From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] platform/x86: silead_dmi: Add entry for the Teclast X98 Plus II
Date: Tue,  2 Jan 2018 19:39:27 +0100
Message-ID: <20180102183928.15267-1-paul@crapouillou.net>
References: <20180102134239.3579-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102134239.3579-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-input@vger.kernel.org

Add touchscreen platform data for the Teclast X98 Plus II tablet.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

 v2: Rebased on top of http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 713446ee3b61..ee8d8e844eb0 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -247,6 +247,22 @@ static const struct silead_ts_dmi_data trekstor_primebook_c13_data = {
 	.properties	= trekstor_primebook_c13_props,
 };
 
+static const struct property_entry teclast_x98plus2_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 2048),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1686-teclast_x98plus2.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct silead_ts_dmi_data teclast_x98plus2_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= teclast_x98plus2_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -388,6 +404,14 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C13"),
 		},
 	},
+	{
+		/* Teclast X98 Plus II */
+		.driver_data = (void *)&teclast_x98plus2_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
+		},
+	},
 	{ },
 };
 
-- 
2.11.0
