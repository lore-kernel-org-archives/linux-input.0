From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] Input/keyboard: add uctional power management support to Blackfin BF54x keypad driver
Date: Fri, 15 Aug 2008 17:02:39 +0800
Message-ID: <1218790959-12694-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:33443 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbYHOJCp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 05:02:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Fix Bug: does nor properply resume after suspend mem
Fix for PM_SUSPEND_MEM: Save and restore peripheral base registers

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/input/keyboard/bf54x-keys.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 54ed8e2..f1d2081 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -8,7 +8,7 @@
  *
  *
  * Modified:
- *               Copyright 2007 Analog Devices Inc.
+ *               Copyright 2007-2008 Analog Devices Inc.
  *
  * Bugs:         Enter bugs at http://blackfin.uclinux.org/
  *
@@ -82,6 +82,9 @@ struct bf54x_kpad {
 	unsigned short *keycode;
 	struct timer_list timer;
 	unsigned int keyup_test_jiffies;
+	unsigned short kpad_msel;
+	unsigned short kpad_prescale;
+	unsigned short kpad_ctl;
 };
 
 static inline int bfin_kpad_find_key(struct bf54x_kpad *bf54x_kpad,
@@ -361,6 +364,10 @@ static int bfin_kpad_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
 
+	bf54x_kpad->kpad_msel = bfin_read_KPAD_MSEL();
+	bf54x_kpad->kpad_prescale = bfin_read_KPAD_PRESCALE();
+	bf54x_kpad->kpad_ctl = bfin_read_KPAD_CTL();
+
 	if (device_may_wakeup(&pdev->dev))
 		enable_irq_wake(bf54x_kpad->irq);
 
@@ -371,6 +378,10 @@ static int bfin_kpad_resume(struct platform_device *pdev)
 {
 	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
 
+	bfin_write_KPAD_MSEL(bf54x_kpad->kpad_msel);
+	bfin_write_KPAD_PRESCALE(bf54x_kpad->kpad_prescale);
+	bfin_write_KPAD_CTL(bf54x_kpad->kpad_ctl);
+
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(bf54x_kpad->irq);
 
-- 
1.5.6
