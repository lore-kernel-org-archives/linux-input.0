From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: intel-ish-hid: use list_move_tail instead of list_del/list_add_tail
Date: Sun, 21 Aug 2016 15:27:29 +0000
Message-ID: <1471793249-23714-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35686 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcHUP1z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Aug 2016 11:27:55 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so6496070pad.2
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2016 08:27:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Using list_move_tail() instead of list_del() + list_add_tail().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 851029b..e2517c1 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -448,8 +448,7 @@ static int ish_fw_reset_handler(struct ishtp_device *dev)
 	spin_lock_irqsave(&dev->wr_processing_spinlock, flags);
 	list_for_each_entry_safe(processing, next,
 			&dev->wr_processing_list_head.link, link) {
-		list_del(&processing->link);
-		list_add_tail(&processing->link, &dev->wr_free_list_head.link);
+		list_move_tail(&processing->link, &dev->wr_free_list_head.link);
 	}
 	spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
 



