From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 09/13] Input: auo-pixcir-ts - Make of_device_id array const
Date: Wed, 07 May 2014 18:22:10 +0900
Message-ID: <023601cf69d5$d2f7f610$78e7e230$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49882 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaEGJWQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:22:16 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N57002NL60YR270@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:22:10 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, =?ISO-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/auo-pixcir-ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index d3f9f6b..7f3c947 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -679,7 +679,7 @@ static const struct i2c_device_id auo_pixcir_idtable[] = {
 MODULE_DEVICE_TABLE(i2c, auo_pixcir_idtable);
 
 #ifdef CONFIG_OF
-static struct of_device_id auo_pixcir_ts_dt_idtable[] = {
+static const struct of_device_id auo_pixcir_ts_dt_idtable[] = {
 	{ .compatible = "auo,auo_pixcir_ts" },
 	{},
 };
-- 
1.7.10.4


