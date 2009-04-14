From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Input: ad7877.c and ad7879.c: Remove depreciated IRQF_SAMPLE_RANDOM flag
Date: Tue, 14 Apr 2009 11:57:58 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D0A257B96@limkexm3.ad.analog.com>
References: <1236310491-24387-1-git-send-email-cooloney@kernel.org> <8A42379416420646B9BFAC9682273B6D0A1CB1DB@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:37965 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbZDNK6D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2009 06:58:03 -0400
Content-Class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Dmitry,

Please ignore my last email.
 
This patch removes depreciated IRQF_SAMPLE_RANDOM flags from drivers
currently queued in Dmitry's input subsystem tree. 

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

---
 drivers/input/touchscreen/ad7877.c |    4 ++--                       
 drivers/input/touchscreen/ad7879.c |    3 +--                        
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c
b/drivers/input/touchscreen/ad7877.c
index 047bb57..dae7357 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -739,8 +739,8 @@ static int __devinit ad7877_probe(struct spi_device
*spi)
 
 	/* Request AD7877 /DAV GPIO interrupt */
 
-	err = request_irq(spi->irq, ad7877_irq, IRQF_TRIGGER_FALLING |
-			IRQF_SAMPLE_RANDOM, spi->dev.driver->name, ts);
+	err = request_irq(spi->irq, ad7877_irq, IRQF_TRIGGER_FALLING,
+			spi->dev.driver->name, ts);
 	if (err) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		goto err_free_mem;
diff --git a/drivers/input/touchscreen/ad7879.c
b/drivers/input/touchscreen/ad7879.c
index 59fad2f..2eb40ee 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -448,8 +448,7 @@ static int __devinit ad7879_construct(bus_device
*bus, struct ad7879 *ts)
 	ad7879_setup(ts);
 
 	err = request_irq(bus->irq, ad7879_irq,
-			  IRQF_TRIGGER_FALLING | IRQF_SAMPLE_RANDOM,
-			  bus->dev.driver->name, ts);
+			  IRQF_TRIGGER_FALLING, bus->dev.driver->name,
ts);
 
 	if (err) {
 		dev_err(&bus->dev, "irq %d busy?\n", bus->irq);



>-----Original Message-----
>From: Hennerich, Michael
>Sent: Tuesday, April 14, 2009 12:45 PM
>To: 'dmitry.torokhov@gmail.com'
>Cc: 'linux-input@vger.kernel.org'; 'linux-kernel@vger.kernel.org';
'Robin Getz'; Hennerich, Michael
>Subject: [PATCH] Input: ad7877.c and ad7879.c: Remove depreciated
IRQF_SAMPLE_RANDOM flag
>
>From: Michael Hennerich <michael.hennerich@analog.com>
>
>This patch removes depreciated IRQF_SAMPLE_RANDOM flags
>from drivers currently queued in Dmitry's input subsystem tree.
>
>Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>
>---
> drivers/input/touchscreen/ad7877.c |    4 ++--
> drivers/input/touchscreen/ad7879.c |    3 +--
> 2 files changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/input/joystick/bfin_rotary.c
b/drivers/input/joystick/bfin_rotary.c
>index c318849..7e91bff 100644
>--- a/drivers/input/joystick/bfin_rotary.c
>+++ b/drivers/input/joystick/bfin_rotary.c
>@@ -138,7 +138,7 @@ static int __devinit bfin_rotary_probe(struct
platform_device *pdev)
>                goto out2;
>
>        ret = request_irq(rotary->irq, bfin_rotary_isr,
>-                                IRQF_SAMPLE_RANDOM,
dev_name(&pdev->dev), pdev);
>+                                0 , dev_name(&pdev->dev), pdev);
>        if (ret) {
>                dev_err(&pdev->dev,
>                        "unable to claim irq %d; error %d\n",
>diff --git a/drivers/input/keyboard/adp5588_keys.c
b/drivers/input/keyboard/adp5588_keys.c
>index b424ce4..1da7000 100644
>--- a/drivers/input/keyboard/adp5588_keys.c
>+++ b/drivers/input/keyboard/adp5588_keys.c
>@@ -308,7 +308,7 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
>        }
>
>        ret = request_irq(client->irq, adp5588_irq,
IRQF_TRIGGER_FALLING |
>-               IRQF_SAMPLE_RANDOM | IRQF_DISABLED,
>+               IRQF_DISABLED,
>                client->dev.driver->name, kpad);
>        if (ret) {
>                dev_err(&client->dev, "irq %d busy?\n", client->irq);
