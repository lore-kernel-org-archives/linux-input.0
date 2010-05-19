From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Subject: [PATCH] AD7879: Fix spi word size
Date: Wed, 19 May 2010 12:01:14 +0200
Message-ID: <1274263274.6138.6.camel@mhenneri-D02.ad.analog.com>
Reply-To: michael.hennerich@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:4133 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0ESKGU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 06:06:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org


Similar patch as reported by Oskar Schirmer <os@emlix.com> for the
AD7877.

With no word size given in the users platform data, a generic spi host
controller driver will assume a default word size of eight bit.
Ensure spi->bits_per_word is set for 16-bit transfers.

Signed-off-by: Michael Hennerich <Michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7879.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c
b/drivers/input/touchscreen/ad7879.c
index 794d070..ff490c0 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -715,6 +715,16 @@ static int __devinit ad7879_probe(struct spi_device
*spi)
 		return -EINVAL;
 	}
 
+	if (spi->bits_per_word != 16) {
+		spi->bits_per_word = 16;
+		error = spi_setup(spi);
+		if (error) {
+			dev_dbg(&spi->dev,
+				"spi master doesn't support 16 bits/word\n");
+			return error;
+		}
+	}   
+
 	ts = kzalloc(sizeof(struct ad7879), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
-- 
1.6.0.2


