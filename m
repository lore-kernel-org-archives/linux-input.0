From: Bibek Basu <bbasu@nvidia.com>
Subject: [PATCH] HID: i2c-hid: Stop querying for init reports
Date: Mon, 21 Oct 2013 09:59:13 +0530
Message-ID: <1382329753-15589-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@gmail.com
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bibek Basu <bbasu@nvidia.com>
List-Id: linux-input@vger.kernel.org

According to specifications, HID over I2C devices
are not bound to respond to query for INPUT
REPORTS. Thus dropping the call during init
as many devices does not respond causing error
messages during boot.

Signed-off-by: Bibek Basu <bbasu@nvidia.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index fd7ce37..ae48d18 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -455,10 +455,6 @@ static void i2c_hid_init_reports(struct hid_device *hid)
 	}
 
 	list_for_each_entry(report,
-		&hid->report_enum[HID_INPUT_REPORT].report_list, list)
-		i2c_hid_init_report(report, inbuf, ihid->bufsize);
-
-	list_for_each_entry(report,
 		&hid->report_enum[HID_FEATURE_REPORT].report_list, list)
 		i2c_hid_init_report(report, inbuf, ihid->bufsize);
 
-- 
1.8.1.5
