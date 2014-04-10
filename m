From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: [patch]GPIO button is supposed to wake the system up if the wakeup
 attribute is set
Date: Thu, 10 Apr 2014 10:11:09 +0800
Message-ID: <5345FDBD.9090908@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62768 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933779AbaDJCLM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 22:11:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

When the wakeup attribute is set, GPIO button is supposed to set
irqflag - IRQF_NO_SUSPEND to request irq. So when the system enters
the suspend sleep mode, the GPIO irq keeps enabled and is able to
wake the system up.

The affected/tested machines include Dell Venue 11 Pro and Asus T100TA.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 drivers/input/keyboard/gpio_keys.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2db1324..40f3963 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -503,6 +503,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
+	if (button->wakeup)
+		irqflags |= IRQF_NO_SUSPEND;
+
 	error = request_any_context_irq(bdata->irq, isr, irqflags, desc, bdata);
 	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
-- 
1.7.10.4
