From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 10/13] Input: egalax_ts - Make of_device_id array const
Date: Wed, 07 May 2014 18:23:32 +0900
Message-ID: <023701cf69d6$03a81a60$0af84f20$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28017 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbaEGJXd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:23:33 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700ID66388I80@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:23:32 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Zhang Jiejing' <jiejing.zhang@freescale.com>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/egalax_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index e6bcb13..c805784 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -262,7 +262,7 @@ static int egalax_ts_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(egalax_ts_pm_ops, egalax_ts_suspend, egalax_ts_resume);
 
-static struct of_device_id egalax_ts_dt_ids[] = {
+static const struct of_device_id egalax_ts_dt_ids[] = {
 	{ .compatible = "eeti,egalax_ts" },
 	{ /* sentinel */ }
 };
-- 
1.7.10.4


