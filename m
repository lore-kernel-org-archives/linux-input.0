From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 12/13] Input: mms114 - Make of_device_id array const
Date: Wed, 07 May 2014 18:25:44 +0900
Message-ID: <023901cf69d6$52d45a40$f87d0ec0$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28715 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaEGJZq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:25:46 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700GW266XHZA0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:25:45 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Joonyoung Shim' <jy0922.shim@samsung.com>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/mms114.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 8a598c0..9d83413 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -570,7 +570,7 @@ static const struct i2c_device_id mms114_id[] = {
 MODULE_DEVICE_TABLE(i2c, mms114_id);
 
 #ifdef CONFIG_OF
-static struct of_device_id mms114_dt_match[] = {
+static const struct of_device_id mms114_dt_match[] = {
 	{ .compatible = "melfas,mms114" },
 	{ }
 };
-- 
1.7.10.4


