From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ims-pcu - fix dead code in
 ims_pcu_ofn_reg_addr_store()
Date: Fri, 24 Oct 2014 15:28:43 -0700
Message-ID: <20141024222843.GA36854@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37280 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaJXW2s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 18:28:48 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Coverity pointed out that at return point error is always 0 so the
conditional is not needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 719410f..afed8e2 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1381,7 +1381,7 @@ static ssize_t ims_pcu_ofn_reg_addr_store(struct device *dev,
 	pcu->ofn_reg_addr = value;
 	mutex_unlock(&pcu->cmd_mutex);
 
-	return error ?: count;
+	return count;
 }
 
 static DEVICE_ATTR(reg_addr, S_IRUGO | S_IWUSR,
-- 
2.1.0.rc2.206.gedb03e5


-- 
Dmitry
