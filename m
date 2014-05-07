From: Jingoo Han <jg1.han@samsung.com>
Subject: PATCH 11/13] Input: lpc32xx_ts - Make of_device_id array const
Date: Wed, 07 May 2014 18:24:57 +0900
Message-ID: <023801cf69d6$36ce6ed0$a46b4c70$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:21762 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaEGJZC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:25:02 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700K2S65MAX70@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:24:58 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Roland Stigge' <stigge@antcom.de>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/lpc32xx_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 2058253..bb47d34 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -384,7 +384,7 @@ static const struct dev_pm_ops lpc32xx_ts_pm_ops = {
 #endif
 
 #ifdef CONFIG_OF
-static struct of_device_id lpc32xx_tsc_of_match[] = {
+static const struct of_device_id lpc32xx_tsc_of_match[] = {
 	{ .compatible = "nxp,lpc3220-tsc", },
 	{ },
 };
-- 
1.7.10.4


