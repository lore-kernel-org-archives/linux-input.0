From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 01/17] Input: tsc2005 - use spi_get/set_drvdata()
Date: Wed, 16 Mar 2011 00:18:04 -0700
Message-ID: <20110316071803.25664.84531.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59828 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1CPHSI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:08 -0400
Received: by yxs7 with SMTP id 7so546675yxs.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:08 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Instead of peeking into underlying device and using dev_get/set_drvdata(),
let's use SPI layer's implementation to access driver-private data
(which may be different from driver-core private data).

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index f95f968..5dad30a 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -366,7 +366,8 @@ static void tsc2005_enable(struct tsc2005 *ts)
 static ssize_t tsc2005_disable_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct spi_device *spi = to_spi_device(dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
 
 	return sprintf(buf, "%u\n", ts->disabled);
 }
@@ -375,7 +376,8 @@ static ssize_t tsc2005_disable_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct spi_device *spi = to_spi_device(dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
 	unsigned long res;
 	int i;
 
@@ -401,7 +403,8 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct spi_device *spi = to_spi_device(dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
 	u16 temp_high;
 	u16 temp_high_orig;
 	u16 temp_high_test;
@@ -620,7 +623,7 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 	if (ts == NULL)
 		return -ENOMEM;
 
-	dev_set_drvdata(&spi->dev, ts);
+	spi_set_drvdata(spi, ts);
 	ts->spi = spi;
 	spi->dev.power.power_state = PMSG_ON;
 	spi->mode = SPI_MODE_0;
@@ -637,7 +640,7 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 
 static int __devexit tsc2005_remove(struct spi_device *spi)
 {
-	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
 
 	mutex_lock(&ts->mutex);
 	tsc2005_disable(ts);
@@ -661,7 +664,8 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 #ifdef CONFIG_PM
 static int tsc2005_suspend(struct spi_device *spi, pm_message_t mesg)
 {
-	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
+	struct spi_device *spi = to_spi_device(dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
 
 	mutex_lock(&ts->mutex);
 	tsc2005_disable(ts);
@@ -672,7 +676,8 @@ static int tsc2005_suspend(struct spi_device *spi, pm_message_t mesg)
 
 static int tsc2005_resume(struct spi_device *spi)
 {
-	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
+	struct spi_device *spi = to_spi_device(dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
 
 	mutex_lock(&ts->mutex);
 	tsc2005_enable(ts);

