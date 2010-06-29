From: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] ad7879: fix spi word size to 16 bit
Date: Tue, 29 Jun 2010 14:46:55 +0200
Message-ID: <1277815615.11338.5.camel@mhenneri-D02.ad.analog.com>
Reply-To: michael.hennerich@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:4890 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab0F2MwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 08:52:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, vapier@gentoo.org

ad7879: fix spi word size to 16 bit

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

 drivers/input/touchscreen/ad7879-spi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-spi.c
b/drivers/input/touchscreen/ad7879-spi.c
index 9fa8e5d..59c6e68 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -134,6 +134,7 @@ static const struct ad7879_bus_ops
ad7879_spi_bus_ops = {
 static int __devinit ad7879_spi_probe(struct spi_device *spi)
 {
 	struct ad7879 *ts;
+	int err;
 
 	/* don't exceed max specified SPI CLK frequency */
 	if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
@@ -141,6 +142,13 @@ static int __devinit ad7879_spi_probe(struct
spi_device *spi)
 		return -EINVAL;
 	}
 
+	spi->bits_per_word = 16;
+	err = spi_setup(spi);
+	if (err) {
+	        dev_dbg(&spi->dev, "spi master doesn't support 16 bits/word
\n");
+	        return err;
+	}
+
 	ts = ad7879_probe(&spi->dev, AD7879_DEVID, spi->irq,
&ad7879_spi_bus_ops);
 	if (IS_ERR(ts))
 		return PTR_ERR(ts);



