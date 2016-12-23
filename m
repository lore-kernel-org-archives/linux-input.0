From: Even Xu <even.xu@intel.com>
Subject: [PATCH 3/7] hid: intel-ish-hid: ishtp: add helper functions for client buffer operation
Date: Fri, 23 Dec 2016 09:22:25 +0800
Message-ID: <1482456149-4841-3-git-send-email-even.xu@intel.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965774AbcLWBXf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Dec 2016 20:23:35 -0500
In-Reply-To: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, andriy.shevchenko@intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>

Add helper ishtp_cl_tx_empty() and ishtp_cl_rx_get_rb() to hide internal
details from callers, who needs this functionality.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/client-buffers.c | 45 ++++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.h         |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
index b9b917d..12d6130 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
@@ -255,3 +255,48 @@ int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb)
 	return	rets;
 }
 EXPORT_SYMBOL(ishtp_cl_io_rb_recycle);
+
+/**
+ * ishtp_cl_tx_empty() -test whether client device tx buffer is empty
+ * @cl: Pointer to client device instance
+ *
+ * Look client device tx buffer list, and check whether this list is empty
+ *
+ * Return: true if client tx buffer list is empty else false
+ */
+bool ishtp_cl_tx_empty(struct ishtp_cl *cl)
+{
+	int tx_list_empty;
+	unsigned long tx_flags;
+
+	spin_lock_irqsave(&cl->tx_list_spinlock, tx_flags);
+	tx_list_empty = list_empty(&cl->tx_list.list);
+	spin_unlock_irqrestore(&cl->tx_list_spinlock, tx_flags);
+
+	return !!tx_list_empty;
+}
+EXPORT_SYMBOL(ishtp_cl_tx_empty);
+
+/**
+ * ishtp_cl_rx_get_rb() -Get a rb from client device rx buffer list
+ * @cl: Pointer to client device instance
+ *
+ * Check client device in-processing buffer list and get a rb from it.
+ *
+ * Return: rb pointer if buffer list isn't empty else NULL
+ */
+struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl)
+{
+	unsigned long rx_flags;
+	struct ishtp_cl_rb *rb;
+
+	spin_lock_irqsave(&cl->in_process_spinlock, rx_flags);
+	rb = list_first_entry_or_null(&cl->in_process_list.list,
+				struct ishtp_cl_rb, list);
+	if (rb)
+		list_del_init(&rb->list);
+	spin_unlock_irqrestore(&cl->in_process_spinlock, rx_flags);
+
+	return rb;
+}
+EXPORT_SYMBOL(ishtp_cl_rx_get_rb);
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h b/drivers/hid/intel-ish-hid/ishtp/client.h
index 444d069..8ab2833 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.h
+++ b/drivers/hid/intel-ish-hid/ishtp/client.h
@@ -178,5 +178,7 @@ int ishtp_cl_flush_queues(struct ishtp_cl *cl);
 
 /* exported functions from ISHTP client buffer management scope */
 int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb);
+bool ishtp_cl_tx_empty(struct ishtp_cl *cl);
+struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl);
 
 #endif /* _ISHTP_CLIENT_H_ */
-- 
2.7.4

