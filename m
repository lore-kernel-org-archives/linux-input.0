From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] input: AD7879 Touchscreen driver cleanup
Date: Thu, 30 Oct 2008 17:47:44 +0800
Message-ID: <1225360064-20436-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:9088 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbYJ3Jq6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2008 05:46:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru, akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

 - Rename ad7879_destruct() to ad7879_destroy()
 - Test flag with spinlock hold

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/input/touchscreen/ad7879.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6865974..8e62f8a 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -242,10 +242,12 @@ static void ad7879_disable(struct ad7879 *ts)
 {
 	unsigned long flags;
 
-	if (ts->disabled)
+	spin_lock_irqsave(&ts->lock, flags);
+	if (ts->disabled) {
+		spin_unlock_irqrestore(&ts->lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&ts->lock, flags);
 	ts->disabled = 1;
 	disable_irq(ts->bus->irq);
 	spin_unlock_irqrestore(&ts->lock, flags);
@@ -264,10 +266,11 @@ static void ad7879_enable(struct ad7879 *ts)
 {
 	unsigned long flags;
 
-	if (!ts->disabled)
-		return;
-
 	spin_lock_irqsave(&ts->lock, flags);
+	if (ts->disabled) {
+		spin_unlock_irqrestore(&ts->lock, flags);
+		return;
+	}
 	ts->disabled = 0;
 	enable_irq(ts->bus->irq);
 	spin_unlock_irqrestore(&ts->lock, flags);
@@ -485,7 +488,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit ad7879_destruct(bus_device *bus, struct ad7879 *ts)
+static int __devexit ad7879_destroy(bus_device *bus, struct ad7879 *ts)
 {
 	ad7879_disable(ts);
 	ad7879_write(ts->bus, AD7879_REG_CTRL2,
@@ -667,7 +670,7 @@ static int __devexit ad7879_remove(struct spi_device *spi)
 {
 	struct ad7879 *ts = dev_get_drvdata(&spi->dev);
 
-	ad7879_destruct(spi, ts);
+	ad7879_destroy(spi, ts);
 	dev_set_drvdata(&spi->dev, NULL);
 	kfree(ts);
 	return 0;
@@ -753,7 +756,7 @@ static int __devexit ad7879_remove(struct i2c_client *client)
 {
 	struct ad7879 *ts = dev_get_drvdata(&client->dev);
 
-	ad7879_destruct(client, ts);
+	ad7879_destroy(client, ts);
 	i2c_set_clientdata(client, NULL);
 	kfree(ts);
 	return 0;
-- 
1.5.6
