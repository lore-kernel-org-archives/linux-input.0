From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/6] mrst-touchscreen: Fix use before initialize in mrst_touch
	[Fix bug 2561]
Date: Fri, 23 Jul 2010 14:52:12 +0100
Message-ID: <20100723135210.19151.19238.stgit@localhost.localdomain>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34234 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab0GWOYj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 10:24:39 -0400
In-Reply-To: <20100723134852.19151.6999.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

From: Arjan van de Ven <arjan@linux.intel.com>

The mrst touch screen driver, in mrstouch_adc_init does

                 dev_err(&tsdev->spi->dev, "Unable to read PMIC id\n");

which does not work very well since the tsdev->spi member does not get
initialized until after the call to mrstouch_adc_init

this patch makes sure the ->spi member is initialized prior to the call
to mrstouch_adc_init

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>


--- linux-2.6.34/drivers/staging/mrst-touchscreen/intel-mid-touch.c~
  2010-06-23 03:13:39.000000000 +0000
+++ linux-2.6.34/drivers/staging/mrst-touchscreen/intel-mid-touch.c
  2010-06-23 03:14:47.736742734 +0000
@@ -759,6 +759,8 @@
      tsdev->irq = myirq;
      mrstouchdevp = tsdev;

+    tsdev->spi = mrstouch_spi;
+
      err = mrstouch_adc_init(tsdev);
      if (err) {
          dev_err(&mrstouch_spi->dev, "ADC init failed\n");
@@ -766,7 +768,6 @@
      }

      dev_set_drvdata(&mrstouch_spi->dev, tsdev);
-    tsdev->spi = mrstouch_spi;

      err = ts_input_dev_init(tsdev, mrstouch_spi);
      if (err) {


--------------030606040305060606070104
Content-Type: text/plain;
 name="Q"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Q"

--- linux-2.6.34/drivers/staging/mrst-touchscreen/intel-mid-touch.c~	2010-06-23 03:13:39.000000000 +0000
+++ linux-2.6.34/drivers/staging/mrst-touchscreen/intel-mid-touch.c	2010-06-23 03:14:47.736742734 +0000
@@ -759,6 +759,8 @@
 	tsdev->irq = myirq;
 	mrstouchdevp = tsdev;

+	tsdev->spi = mrstouch_spi;
+
 	err = mrstouch_adc_init(tsdev);
 	if (err) {
 		dev_err(&mrstouch_spi->dev, "ADC init failed\n");
@@ -766,7 +768,6 @@
 	}

 	dev_set_drvdata(&mrstouch_spi->dev, tsdev);
-	tsdev->spi = mrstouch_spi;

 	err = ts_input_dev_init(tsdev, mrstouch_spi);
 	if (err) {

--------------030606040305060606070104--
---

 drivers/staging/mrst-touchscreen/intel-mid-touch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/staging/mrst-touchscreen/intel-mid-touch.c b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
index 7e77737..c41989b 100644
--- a/drivers/staging/mrst-touchscreen/intel-mid-touch.c
+++ b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
@@ -651,6 +651,8 @@ static int __devinit mrstouch_probe(struct spi_device *spi)
 	snprintf(tsdev->phys, sizeof(tsdev->phys),
 		 "%s/input0", dev_name(&spi->dev));
 
+	tsdev->spi = mrstouch_spi;
+
 	err = mrstouch_adc_init(tsdev);
 	if (err) {
 		dev_err(&spi->dev, "ADC initialization failed\n");

