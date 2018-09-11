From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/9] hid: intel-ish-hid: use helper function to access client buffer
Date: Tue, 11 Sep 2018 16:44:16 -0700
Message-ID: <20180911234421.10691-5-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

From: Even Xu <even.xu@intel.com>

ishtp bus driver exposed helper functions for client buffer accessing,
so change to use these functions in ishtp-hid-client driver to avoid
access client buffer directly.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 11ce54fcd098..bb8402f10831 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -323,20 +323,11 @@ static void ish_cl_event_cb(struct ishtp_cl_device *device)
 	struct ishtp_cl	*hid_ishtp_cl = ishtp_get_drvdata(device);
 	struct ishtp_cl_rb *rb_in_proc;
 	size_t r_length;
-	unsigned long flags;
 
 	if (!hid_ishtp_cl)
 		return;
 
-	spin_lock_irqsave(&hid_ishtp_cl->in_process_spinlock, flags);
-	while (!list_empty(&hid_ishtp_cl->in_process_list.list)) {
-		rb_in_proc = list_entry(
-			hid_ishtp_cl->in_process_list.list.next,
-			struct ishtp_cl_rb, list);
-		list_del_init(&rb_in_proc->list);
-		spin_unlock_irqrestore(&hid_ishtp_cl->in_process_spinlock,
-			flags);
-
+	while ((rb_in_proc = ishtp_cl_rx_get_rb(hid_ishtp_cl)) != NULL) {
 		if (!rb_in_proc->buffer.data)
 			return;
 
@@ -346,9 +337,7 @@ static void ish_cl_event_cb(struct ishtp_cl_device *device)
 		process_recv(hid_ishtp_cl, rb_in_proc->buffer.data, r_length);
 
 		ishtp_cl_io_rb_recycle(rb_in_proc);
-		spin_lock_irqsave(&hid_ishtp_cl->in_process_spinlock, flags);
 	}
-	spin_unlock_irqrestore(&hid_ishtp_cl->in_process_spinlock, flags);
 }
 
 /**
-- 
2.17.1
