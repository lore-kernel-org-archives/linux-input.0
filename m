From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] HID: intel_ish-hid: fix potential uninitialized data usage
Date: Tue, 16 May 2017 13:09:03 +0200
Message-ID: <20170516110907.3545799-2-arnd@arndb.de>
References: <20170516110907.3545799-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:60129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdEPLJS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 May 2017 07:09:18 -0400
In-Reply-To: <20170516110907.3545799-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

gcc points out an uninialized pointer dereference that could happen
if we ever get to recv_ishtp_cl_msg_dma() or recv_ishtp_cl_msg()
with an empty &dev->read_list:

drivers/hid/intel-ish-hid/ishtp/client.c: In function 'recv_ishtp_cl_msg_dma':
drivers/hid/intel-ish-hid/ishtp/client.c:1049:3: error: 'cl' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The warning only appeared in very few randconfig builds, as the
spinlocks tend to prevent gcc from tracing the variables. I only
saw it in configurations that had neither SMP nor LOCKDEP enabled.

I have not been able to figure out whether this case can happen in
practice, but it's better to be defensive here and handle the case
explicitly by returning from the function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index aad61328f282..69c9d43612ec 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -829,6 +829,11 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
 	}
 
 	spin_lock_irqsave(&dev->read_list_spinlock, dev_flags);
+	if (list_empty(&dev->read_list.list)) {
+		spin_unlock_irqrestore(&dev->read_list_spinlock, dev_flags);
+		goto eoi;
+	}
+
 	rb_count = -1;
 	list_for_each_entry(rb, &dev->read_list.list, list) {
 		++rb_count;
@@ -954,6 +959,11 @@ void recv_ishtp_cl_msg_dma(struct ishtp_device *dev, void *msg,
 	unsigned long	flags;
 
 	spin_lock_irqsave(&dev->read_list_spinlock, dev_flags);
+	if (list_empty(&dev->read_list.list)) {
+		spin_unlock_irqrestore(&dev->read_list_spinlock, dev_flags);
+		goto eoi;
+	}
+
 	list_for_each_entry(rb, &dev->read_list.list, list) {
 		cl = rb->cl;
 		if (!cl || !(cl->host_client_id == hbm->host_client_id &&
-- 
2.9.0

