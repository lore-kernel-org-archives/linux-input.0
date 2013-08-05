From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/4] Input: pwm-beeper: add CONFIG_PM_SLEEP to suspend/resume
Date: Mon, 05 Aug 2013 15:57:01 +0900
Message-ID: <001a01ce91a8$fc8b8ba0$f5a2a2e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45712 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab3HEG5D (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Aug 2013 02:57:03 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR1001PZPXJTXC0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Mon, 05 Aug 2013 15:57:02 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the build
warnings when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SET_SYSTEM_SLEEP_PM_OPS are only used
when the CONFIG_PM_SLEEP is enabled.

drivers/input/misc/pwm-beeper.c:147:12: warning: 'pwm_beeper_suspend' defined but not used [-Wunused-function]
drivers/input/misc/pwm-beeper.c:157:12: warning: 'pwm_beeper_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/pwm-beeper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index a37f0c9..2ff4d1c 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -143,7 +143,7 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
-- 
1.7.10.4


