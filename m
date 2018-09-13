From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in __hid_request()
Date: Thu, 13 Sep 2018 11:34:32 +0800
Message-ID: <20180913033432.16336-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-input@vger.kernel.org

hid_alloc_report_buf() has to be called with GFP_ATOMIC in 
__hid_request(), because there are the following callchains 
leading to __hid_request() being an atomic context:

picolcd_send_and_wait (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

picolcd_reset (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

lg4ff_play (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

lg4ff_set_autocenter_ffex (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Make the description more human readable.
  Thanks Jiri for good advice.
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3942ee61bd1c..c886af00c8c9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1442,7 +1442,7 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
 	int ret;
 	u32 len;
 
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	buf = hid_alloc_report_buf(report, GFP_ATOMIC);
 	if (!buf)
 		return;
 
-- 
2.17.0
