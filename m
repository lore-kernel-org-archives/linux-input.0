From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: intel-ish-hid: Fix potential race condition
Date: Mon, 28 Nov 2016 11:23:35 -0800
Message-ID: <1480361015-8148-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41355 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbcK1TXj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 14:23:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Although unlikely but it is possible that when a connect or disconnect
request is issued to the firmware, before the response comes, user
terminates the client session. In this case when the response is arrived
there is no matching client instance in the list of currently active
clients. In this case, don't issue call to wake up a waiting client.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

This issue is not reported. This was found during code reviews for fault
tolerance.
So not a fix for 4.9.rc release.


 drivers/hid/intel-ish-hid/ishtp/hbm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index 74bffee..59460b6 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -378,11 +378,10 @@ static void ishtp_hbm_cl_disconnect_res(struct ishtp_device *dev,
 	list_for_each_entry(cl, &dev->cl_list, link) {
 		if (!rs->status && ishtp_hbm_cl_addr_equal(cl, rs)) {
 			cl->state = ISHTP_CL_DISCONNECTED;
+			wake_up_interruptible(&cl->wait_ctrl_res);
 			break;
 		}
 	}
-	if (cl)
-		wake_up_interruptible(&cl->wait_ctrl_res);
 	spin_unlock_irqrestore(&dev->cl_list_lock, flags);
 }
 
@@ -431,11 +430,10 @@ static void ishtp_hbm_cl_connect_res(struct ishtp_device *dev,
 				cl->state = ISHTP_CL_DISCONNECTED;
 				cl->status = -ENODEV;
 			}
+			wake_up_interruptible(&cl->wait_ctrl_res);
 			break;
 		}
 	}
-	if (cl)
-		wake_up_interruptible(&cl->wait_ctrl_res);
 	spin_unlock_irqrestore(&dev->cl_list_lock, flags);
 }
 
-- 
2.7.4

