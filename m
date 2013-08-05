From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/4] Input: eeti_ts: add CONFIG_PM_SLEEP to suspend/resume
Date: Mon, 05 Aug 2013 15:56:44 +0900
Message-ID: <001901ce91a8$f241b9d0$d6c52d70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11527 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab3HEG4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Aug 2013 02:56:45 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR100IGMPYKSNC0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 05 Aug 2013 15:56:44 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the build
warnings when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SET_SYSTEM_SLEEP_PM_OPS are only used
when the CONFIG_PM_SLEEP is enabled.

drivers/input/touchscreen/eeti_ts.c:268:12: warning: 'eeti_ts_suspend' defined but not used [-Wunused-function]
drivers/input/touchscreen/eeti_ts.c:287:12: warning: 'eeti_ts_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/eeti_ts.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 8fe5086..a6453b1 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -264,7 +264,7 @@ static int eeti_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int eeti_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -315,7 +315,7 @@ MODULE_DEVICE_TABLE(i2c, eeti_ts_id);
 static struct i2c_driver eeti_ts_driver = {
 	.driver = {
 		.name = "eeti_ts",
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 		.pm = &eeti_ts_pm,
 #endif
 	},
-- 
1.7.10.4


