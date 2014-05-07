From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 13/13] Input: zforce - Make of_device_id array const
Date: Wed, 07 May 2014 18:26:25 +0900
Message-ID: <023a01cf69d6$6b46beb0$41d43c10$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28908 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427AbaEGJ0m (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:26:42 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700HR8683EL90@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:26:27 +0900 (KST)
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
 drivers/input/touchscreen/zforce_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 01d30ce..feea85b 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -880,7 +880,7 @@ static struct i2c_device_id zforce_idtable[] = {
 MODULE_DEVICE_TABLE(i2c, zforce_idtable);
 
 #ifdef CONFIG_OF
-static struct of_device_id zforce_dt_idtable[] = {
+static const struct of_device_id zforce_dt_idtable[] = {
 	{ .compatible = "neonode,zforce" },
 	{},
 };
-- 
1.7.10.4


