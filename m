From: weiyj_lk@163.com
Subject: [PATCH -next] Input: zforce - remove duplicated include from zforce_ts.c
Date: Thu, 16 Apr 2015 21:11:39 +0800
Message-ID: <1429189899-24255-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:36948 "EHLO m12-13.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbbDPNNS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 09:13:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Jingoo Han <jg1.han@samsung.com>, Heiko Stuebner <heiko.stuebner@bq.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/touchscreen/zforce_ts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 19880c7..f58a196 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -30,7 +30,6 @@
 #include <linux/input/mt.h>
 #include <linux/platform_data/zforce_ts.h>
 #include <linux/regulator/consumer.h>
-#include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 

