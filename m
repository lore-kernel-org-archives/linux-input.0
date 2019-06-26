From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 01/51] HID: i2c-hid: add iBall Aer3 to descriptor override
Date: Tue, 25 Jun 2019 23:40:17 -0400
Message-ID: <20190626034117.23247-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit eb6964fa6509b4f1152313f1e0bb67f0c54a6046 ]

This device uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override
list.

BugLink: https://bugs.launchpad.net/bugs/1825718
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.20.1
