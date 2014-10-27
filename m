From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Mon, 27 Oct 2014 21:32:58 +0900
Message-ID: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38604 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaJ0Mcl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 08:32:41 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE3000GWS6GHF40@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 27 Oct 2014 21:32:40 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>

Add CONFIG_PM_SLEEP to suspend/resume functions

Add CONFIG_PM_SLEEP to suspend/resume functions instead of
CONFIG_PM to fix the following build warning when CONFIG_PM_SLEEP
is not selected and CONFIG_PM is selected. This is because sleep
PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when the
CONFIG_PM_SLEEP is enabled.

drivers/input/keyboard/spear-keyboard.c:292:12: warning: 'spear_kbd_suspend' defined but not used [-Wunused-function]
drivers/input/keyboard/spear-keyboard.c:345:12: warning: 'spear_kbd_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/keyboard/spear-keyboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 258af10..fc93e79 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -288,7 +288,7 @@ static int spear_kbd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int spear_kbd_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-- 
1.7.9.5


