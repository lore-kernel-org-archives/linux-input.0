From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: lm8323 - missing error check in lm8323_set_disable()
Date: Wed, 3 Dec 2014 00:17:10 +0300
Message-ID: <20141202211710.GA19955@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:19769 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707AbaLBVRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Dec 2014 16:17:35 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Johan Hovold <johan@kernel.org>, Bryan Wu <cooloney@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The missing error handling here is not especially harmful but static
checkers complain that "i" can be used uninitialized.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index cb32e2b..21bea52 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -616,6 +616,8 @@ static ssize_t lm8323_set_disable(struct device *dev,
 	unsigned int i;
 
 	ret = kstrtouint(buf, 10, &i);
+	if (ret)
+		return ret;
 
 	mutex_lock(&lm->lock);
 	lm->kp_enabled = !i;
