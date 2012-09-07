From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: picoLCD: fix a NULL test in picolcd_raw_cir()
Date: Fri, 7 Sep 2012 09:47:41 +0300
Message-ID: <20120907064740.GB12028@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:46335 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2IGGrz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Sep 2012 02:47:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Smatch complains that the NULL checking in this function is not
consistent and could lead to a NULL dereference.  The comments say that
we should return here if rc_dev is NULL so I've changed the test to
match the comment.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.  This is a static checker fix and I don't
have the hardware to test it.  Please review carefully.

diff --git a/drivers/hid/hid-picolcd_cir.c b/drivers/hid/hid-picolcd_cir.c
index 14c5ce0..13ca919 100644
--- a/drivers/hid/hid-picolcd_cir.c
+++ b/drivers/hid/hid-picolcd_cir.c
@@ -51,7 +51,7 @@ int picolcd_raw_cir(struct picolcd_data *data,
 
 	/* ignore if rc_dev is NULL or status is shunned */
 	spin_lock_irqsave(&data->lock, flags);
-	if (data->rc_dev && (data->status & PICOLCD_CIR_SHUN)) {
+	if (!data->rc_dev || (data->status & PICOLCD_CIR_SHUN)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return 1;
 	}
