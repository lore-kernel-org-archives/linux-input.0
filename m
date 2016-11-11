From: Even Xu <even.xu@intel.com>
Subject: [PATCH 3/3] hid: intel-ish-hid: ipc: use msleep_interrupt() for wait
Date: Fri, 11 Nov 2016 09:40:33 +0800
Message-ID: <1478828433-31779-1-git-send-email-even.xu@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28419 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbcKKBkN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 20:40:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@intel.com, Even Xu <even.xu@intel.com>

set_current_task() must be called before schedule_timeout(), for this
driver, in order to avoid incorrect usage, use msleep_interrupt()
instead.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 8194c35..86a36eb 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -539,6 +539,8 @@ static int ish_fw_reset_handler(struct ishtp_device *dev)
 	return	0;
 }
 
+#define TIMEOUT_FOR_HW_RDY_MS			300
+
 /**
  * ish_fw_reset_work_fn() - FW reset worker function
  * @unused: not used
@@ -552,7 +554,7 @@ static void fw_reset_work_fn(struct work_struct *unused)
 	rv = ish_fw_reset_handler(ishtp_dev);
 	if (!rv) {
 		/* ISH is ILUP & ISHTP-ready. Restart ISHTP */
-		schedule_timeout(HZ / 3);
+		msleep_interruptible(TIMEOUT_FOR_HW_RDY_MS);
 		ishtp_dev->recvd_hw_ready = 1;
 		wake_up_interruptible(&ishtp_dev->wait_hw_ready);
 
-- 
2.7.4

