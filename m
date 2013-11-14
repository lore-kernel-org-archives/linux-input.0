From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: hp_sdc_rtc - unlock on error in
 hp_sdc_rtc_read_i8042timer()
Date: Thu, 14 Nov 2013 11:18:08 +0300
Message-ID: <20131114081808.GA8150@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46825 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3KNIS1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Nov 2013 03:18:27 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Helge Deller <deller@gmx.de>, David Howells <dhowells@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The transaction task here is hp_sdc_tasklet() and it releases the lock.
The problem is if we aren't able to queue the transaction then we need
to release the lock ourselves.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 86b8228..45e0e3e 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -180,7 +180,10 @@ static int64_t hp_sdc_rtc_read_i8042timer (uint8_t loadcmd, int numreg)
 	if (WARN_ON(down_interruptible(&i8042tregs)))
 		return -1;
 
-	if (hp_sdc_enqueue_transaction(&t)) return -1;
+	if (hp_sdc_enqueue_transaction(&t)) {
+		up(&i8042tregs);
+		return -1;
+	}
 	
 	/* Sleep until results come back. */
 	if (WARN_ON(down_interruptible(&i8042tregs)))
