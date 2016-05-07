From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 3/3] input: rmi4: Remove set_page() call before core is initialized
Date: Fri,  6 May 2016 21:40:08 -0700
Message-ID: <1462596008-21381-4-git-send-email-bjorn.andersson@linaro.org>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34962 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbcEGEkQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 May 2016 00:40:16 -0400
Received: by mail-pf0-f174.google.com with SMTP id 77so56174946pfv.2
        for <linux-input@vger.kernel.org>; Fri, 06 May 2016 21:40:15 -0700 (PDT)
In-Reply-To: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

In the case of the chip not already being powered we can't call
set_page() before we're letting the core driver enable power to the
chip.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/input/rmi4/rmi_i2c.c | 11 ++---------
 drivers/input/rmi4/rmi_spi.c | 11 ++---------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 18f6a9f4aeef..3e32b320c8d2 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -215,15 +215,8 @@ static int rmi_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, rmi_i2c);
 
-	/*
-	 * Setting the page to zero will (a) make sure the PSR is in a
-	 * known state, and (b) make sure we can talk to the device.
-	 */
-	retval = rmi_set_page(rmi_i2c, 0);
-	if (retval) {
-		dev_err(&client->dev, "Failed to set page select to 0.\n");
-		return retval;
-	}
+	/* Invalidate current page to force rmi_set_page() on next access */
+	rmi_i2c->page = -1;
 
 	retval = rmi_register_transport_device(&rmi_i2c->xport);
 	if (retval) {
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index f3e9e488635c..36c6912685a7 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -410,15 +410,8 @@ static int rmi_spi_probe(struct spi_device *spi)
 	if (retval)
 		return retval;
 
-	/*
-	 * Setting the page to zero will (a) make sure the PSR is in a
-	 * known state, and (b) make sure we can talk to the device.
-	 */
-	retval = rmi_set_page(rmi_spi, 0);
-	if (retval) {
-		dev_err(&spi->dev, "Failed to set page select to 0.\n");
-		return retval;
-	}
+	/* Invalidate current page to force rmi_set_page() on next access */
+	rmi_spi->page = -1;
 
 	retval = rmi_register_transport_device(&rmi_spi->xport);
 	if (retval) {
-- 
2.5.0

