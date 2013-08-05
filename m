From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/4] Input: max7359: add CONFIG_PM_SLEEP to suspend/resume
Date: Mon, 05 Aug 2013 15:55:25 +0900
Message-ID: <000f01ce91a8$c2f2ac20$48d80460$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43359 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab3HEGz0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Aug 2013 02:55:26 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR100C76PW6B3C0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Mon, 05 Aug 2013 15:55:25 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the build
warnings when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SET_SYSTEM_SLEEP_PM_OPS are only used
when the CONFIG_PM_SLEEP is enabled.

drivers/input/keyboard/max7359_keypad.c:275:12: warning: 'max7359_suspend' defined but not used [-Wunused-function]
drivers/input/keyboard/max7359_keypad.c:287:12: warning: 'max7359_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/keyboard/max7359_keypad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 7c7af2b..bc2cdaf 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -271,7 +271,7 @@ static int max7359_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int max7359_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-- 
1.7.10.4


