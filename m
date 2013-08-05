From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/4] Input: cy8ctmg110_ts: add CONFIG_PM_SLEEP to suspend/resume
Date: Mon, 05 Aug 2013 15:56:27 +0900
Message-ID: <001801ce91a8$e7dfa510$b79eef30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11477 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab3HEG42 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Aug 2013 02:56:28 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR100KX0PXS7NB0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 05 Aug 2013 15:56:27 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the build
warnings when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SET_SYSTEM_SLEEP_PM_OPS are only used
when the CONFIG_PM_SLEEP is enabled.

drivers/input/touchscreen/cy8ctmg110_ts.c:295:12: warning: 'cy8ctmg110_suspend' defined but not used [-Wunused-function]
drivers/input/touchscreen/cy8ctmg110_ts.c:309:12: warning: 'cy8ctmg110_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/cy8ctmg110_ts.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 96e0eedc..093c274 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -291,7 +291,7 @@ err_free_mem:
 	return err;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int cy8ctmg110_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -351,7 +351,7 @@ static struct i2c_driver cy8ctmg110_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= CY8CTMG110_DRIVER_NAME,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 		.pm	= &cy8ctmg110_pm,
 #endif
 	},
-- 
1.7.10.4


