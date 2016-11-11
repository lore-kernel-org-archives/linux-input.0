From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] HID: intel_ish-hid: use list_move_tail in ishtp_cl_read_start
Date: Fri, 11 Nov 2016 20:26:42 +0800
Message-ID: <3bdae868a5ebd999c5610f5b19e6a085c51db059.1478858760.git.geliangtang@gmail.com>
References: <a23f3507ba7bad3d94ca8683d9021f1f565ec6aa.1478858593.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a23f3507ba7bad3d94ca8683d9021f1f565ec6aa.1478858593.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use list_move() instead of list_del() + list_add_tail() to simplify
the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index aad6132..0979e04 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -497,12 +497,8 @@ int ishtp_cl_read_start(struct ishtp_cl *cl)
 out:
 	/* if ishtp_hbm_cl_flow_control_req failed, return rb to free list */
 	if (rets && rb) {
-		spin_lock_irqsave(&dev->read_list_spinlock, dev_flags);
-		list_del(&rb->list);
-		spin_unlock_irqrestore(&dev->read_list_spinlock, dev_flags);
-
 		spin_lock_irqsave(&cl->free_list_spinlock, flags);
-		list_add_tail(&rb->list, &cl->free_rb_list.list);
+		list_move_tail(&rb->list, &cl->free_rb_list.list);
 		spin_unlock_irqrestore(&cl->free_list_spinlock, flags);
 	}
 	return rets;
-- 
2.9.3
