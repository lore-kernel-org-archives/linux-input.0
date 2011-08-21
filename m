From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: ad714xx-spi - force SPI bus into the default 8-bit mode
Date: Sun, 21 Aug 2011 13:09:02 -0700
Message-ID: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53698 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab1HUUJK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 16:09:10 -0400
Received: by yie30 with SMTP id 30so3182615yie.19
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 13:09:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/ad714x-spi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 4120dd5..da83ac9 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -54,6 +54,12 @@ static int ad714x_spi_write(struct device *dev, unsigned short reg,
 static int __devinit ad714x_spi_probe(struct spi_device *spi)
 {
 	struct ad714x_chip *chip;
+	int err;
+
+	spi->bits_per_word = 8;
+	err = spi_setup(spi);
+	if (err < 0)
+		return err;
 
 	chip = ad714x_probe(&spi->dev, BUS_SPI, spi->irq,
 			    ad714x_spi_read, ad714x_spi_write);
-- 
1.7.6

