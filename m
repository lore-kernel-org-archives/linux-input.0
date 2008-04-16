From: Vernon Sauder <vernoninhand@gmail.com>
Subject: [PATCH] UCB1400 IRQ Probe fix
Date: Wed, 16 Apr 2008 13:43:17 -0400
Message-ID: <48063AB5.60605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34193 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYDPRmz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 13:42:55 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2503966fgb.17
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 10:42:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Nicolas Pitre <nico@marvell.com>

I am resending this because it didn't seem to get to the list.

---

The UCB1400 driver IRQ probe code fails to find an interrupt if all
the interrupts in the range 0-31 are nonprobe-able. This patch
removes the check of the return value so interrupts above 31 can be
detected.

This change may also be useful in drivers/mfd/ucb1x0-core.c but I
cannot test that on my hardware.

This patch is against 2.6.24.4. Tested on InHand Fingertip4 PXA270
board.

Signed-off-by: Vernon Sauder <vsauder@inhand.com>
Acked-by: Nicolas Pitre <nico@marvell.com>

---

diff -ur linux.orig/drivers/input/touchscreen/ucb1400_ts.c
linux.new/drivers/input/touchscreen/ucb1400_ts.c
--- linux.orig/drivers/input/touchscreen/ucb1400_ts.c	2008-03-24
14:49:18.000000000 -0400
+++ linux.new/drivers/input/touchscreen/ucb1400_ts.c	2008-04-03
21:40:43.000000000 -0400
@@ -429,10 +429,6 @@
   	unsigned long mask, timeout;

   	mask = probe_irq_on();
-	if (!mask) {
-		probe_irq_off(mask);
-		return -EBUSY;
-	}

   	/* Enable the ADC interrupt. */
   	ucb1400_reg_write(ucb, UCB_IE_RIS, UCB_IE_ADC);





