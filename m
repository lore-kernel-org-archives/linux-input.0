From: akpm@linux-foundation.org
Subject: [patch 2/5] ads7846: pin change interrupt support
Date: Wed, 10 Jun 2009 12:48:15 -0700
Message-ID: <200906101948.n5AJmFOf002604@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34074 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759175AbZFJTs3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2009 15:48:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, mroth@nessie.de, imre.deak@nokia.com

From: Michael Roth <mroth@nessie.de>

Some SoC supports only pin change interrupts on GPIO pins used as irq
lines.

The ads7846 core is not affected from the additional irqs on the rising
edge because the code accounts touch bounce anyway by kicking in a timer
and disabling the irq after the first request and reenabling the irq after
a timeout when there is no longer pen down detected.

Signed-off-by: Michael Roth <mroth@nessie.de>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/ads7846.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff -puN drivers/input/touchscreen/ads7846.c~ads7846-pin-change-interrupt-support drivers/input/touchscreen/ads7846.c
--- a/drivers/input/touchscreen/ads7846.c~ads7846-pin-change-interrupt-support
+++ a/drivers/input/touchscreen/ads7846.c
@@ -1150,9 +1150,15 @@ static int __devinit ads7846_probe(struc
 
 	if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FALLING,
 			spi->dev.driver->name, ts)) {
-		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-		err = -EBUSY;
-		goto err_free_gpio;
+		dev_info(&spi->dev,
+			"trying pin change workaround on irq %d\n", spi->irq);
+		if (request_irq(spi->irq, ads7846_irq,
+				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				spi->dev.driver->name, ts)) {
+			dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
+			err = -EBUSY;
+			goto err_free_gpio;
+		}
 	}
 
 	err = ads784x_hwmon_register(spi, ts);
_
