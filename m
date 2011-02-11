From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] Input: adxl34x - Fix references to adx134x
Date: Fri, 11 Feb 2011 15:33:42 +0000
Message-ID: <1297438422-25838-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297438422-25838-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58818 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754076Ab1BKPdX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:33:23 -0500
In-Reply-To: <1297438422-25838-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

The adxl34x SPI driver has what appears to be a typo referring to the
device as adx134x with the numeral 1 rather than letter l. This appears
to be an error so convert.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/adxl34x-spi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 5231add..f29de22 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -58,7 +58,7 @@ static int adxl34x_spi_read_block(struct device *dev,
 	return (status < 0) ? status : 0;
 }
 
-static const struct adxl34x_bus_ops adx134x_spi_bops = {
+static const struct adxl34x_bus_ops adxl34x_spi_bops = {
 	.bustype	= BUS_SPI,
 	.write		= adxl34x_spi_write,
 	.read		= adxl34x_spi_read,
@@ -77,7 +77,7 @@ static int __devinit adxl34x_spi_probe(struct spi_device *spi)
 
 	ac = adxl34x_probe(&spi->dev, spi->irq,
 			   spi->max_speed_hz > MAX_FREQ_NO_FIFODELAY,
-			   &adx134x_spi_bops);
+			   &adxl34x_spi_bops);
 
 	if (IS_ERR(ac))
 		return PTR_ERR(ac);
-- 
1.7.2.3

