From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] HID: i2c-hid: add Trekstor Primebook C11B to descriptor override
Date: Mon,  7 Oct 2019 20:56:26 +0200
Message-ID: <20191007185626.247959-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Primebook C11B uses the SIPODEV SP1064 touchpad. There are 2 versions
of this 2-in-1 and the touchpad in the older version does not supply
descriptors, so it has to be added to the override list.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 75078c83be1a..d31ea82b84c1 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -322,6 +322,25 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		/*
+		 * There are at least 2 Primebook C11B versions, the older
+		 * version has a product-name of "Primebook C11B", and a
+		 * bios version / release / firmware revision of:
+		 * V2.1.2 / 05/03/2018 / 18.2
+		 * The new version has "PRIMEBOOK C11B" as product-name and a
+		 * bios version / release / firmware revision of:
+		 * CFALKSW05_BIOS_V1.1.2 / 11/19/2018 / 19.2
+		 * Only the older version needs this quirk, note the newer
+		 * version will not match as it has a different product-name.
+		 */
+		.ident = "Trekstor Primebook C11B",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Primebook C11B"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Direkt-Tek DTLAPY116-2",
 		.matches = {
-- 
2.23.0
