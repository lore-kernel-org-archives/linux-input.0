From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] hid: hid-core: Fix a sleep-in-atomic-context bug in __hid_request()
Date: Sat,  1 Sep 2018 20:16:59 +0800
Message-ID: <20180901121659.1257-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-input@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-picolcd_core.c, 111: 
	hid_hw_request in picolcd_send_and_wait
drivers/hid/hid-picolcd_core.c, 100: 
	_raw_spin_lock_irqsave in picolcd_send_and_wait

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-picolcd_core.c, 245: 
	hid_hw_request in picolcd_reset
drivers/hid/hid-picolcd_core.c, 235: 
	_raw_spin_lock_irqsave in picolcd_reset

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-picolcd_fb.c, 215: 
	hid_hw_request in picolcd_fb_reset
drivers/hid/hid-picolcd_fb.c, 206: 
	_raw_spin_lock_irqsave in picolcd_fb_reset

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-lg4ff.c, 465: 
	hid_hw_request in lg4ff_play
drivers/hid/hid-lg4ff.c, 441: 
	_raw_spin_lock_irqsave in lg4ff_play

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
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
