From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: remove a duplicative NULL test
Date: Fri, 21 Feb 2014 11:55:06 +0300
Message-ID: <20140221085506.GB13185@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26424 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbaBUIzT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Feb 2014 03:55:19 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

"pdata" is non-NULL here.  We verified that at the start of the
function.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a70400754e92..40abe90cc924 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1146,7 +1146,7 @@ static int mxt_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	data->is_tp = pdata && pdata->is_tp;
+	data->is_tp = pdata->is_tp;
 
 	input_dev->name = (data->is_tp) ? "Atmel maXTouch Touchpad" :
 					  "Atmel maXTouch Touchscreen";
