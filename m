From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: i2c-hid: add iBall Aer3 to descriptor override
Date: Mon, 22 Apr 2019 14:57:04 +0800
Message-ID: <20190422065704.27234-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

This device uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override
list.

BugLink: https://bugs.launchpad.net/bugs/1825718
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index fd1b6eea6d2f..75078c83be1a 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -354,6 +354,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "iBall Aer3",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "iBall"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Aer3"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{ }	/* Terminate list */
 };
 
-- 
2.17.1
