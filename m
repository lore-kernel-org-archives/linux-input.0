From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: fix buffer allocations
Date: Sat,  1 Feb 2014 23:23:10 -0500
Message-ID: <1391314990-29046-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When using hid_output_report(), the buffer should be allocated by hid_alloc_report_buf(),
not a custom malloc.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c       | 2 +-
 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d50e731..a713e62 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1178,7 +1178,7 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	/* fall back to generic raw-output-report */
 	len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
-	buf = kmalloc(len, GFP_KERNEL);
+	buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index e914f27..ce68a12 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -582,7 +582,7 @@ static void i2c_hid_request(struct hid_device *hid, struct hid_report *rep,
 	int ret;
 	int len = i2c_hid_get_report_length(rep) - 2;
 
-	buf = kzalloc(len, GFP_KERNEL);
+	buf = hid_alloc_report_buf(rep, GFP_KERNEL);
 	if (!buf)
 		return;
 
-- 
1.8.3.1
