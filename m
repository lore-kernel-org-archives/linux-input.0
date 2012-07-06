From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] input: touchscreen ad7879 add option to correct xy axis
Date: Fri, 6 Jul 2012 12:03:57 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917715256F0270F@LIMKCMBX1.ad.analog.com>
References: <1338547021-2931-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [216.32.181.183] ([216.32.181.183]:6125 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933187Ab2GFLFO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Jul 2012 07:05:14 -0400
In-Reply-To: <1338547021-2931-1-git-send-email-michael.hennerich@analog.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "sebastian.zenker@gmx.de" <sebastian.zenker@gmx.de>

Hi Dmitry,

Do you have plans to pick this patch?

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif

-----Original Message-----
From: michael.hennerich@analog.com [mailto:michael.hennerich@analog.com] 
Sent: Freitag, 1. Juni 2012 12:37
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org; sebastian.zenker@gmx.de; Hennerich, Michael
Subject: [PATCH] input: touchscreen ad7879 add option to correct xy axis

From: Michael Hennerich <michael.hennerich@analog.com>

Sebastian Zenker reported that driver swaps x and y samples when the touchscreen leads are connected in accordance with the datasheet specification.
Transposed axis can be typically corrected by touch screen calibration however this bug also negatively influences touch pressure measurements.

Add an option to correct x and y axis.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Reported-and-tested-by: Sebastian Zenker <sebastian.zenker@gmx.de>
---
 drivers/input/touchscreen/ad7879.c |    5 +++++
 include/linux/spi/ad7879.h         |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e2482b4..e607092 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -118,6 +118,7 @@ struct ad7879 {
 	unsigned int		irq;
 	bool			disabled;	/* P: input->mutex */
 	bool			suspended;	/* P: input->mutex */
+	bool			swap_xy;
 	u16			conversion_data[AD7879_NR_SENSE];
 	char			phys[32];
 	u8			first_conversion_delay;
@@ -161,6 +162,9 @@ static int ad7879_report(struct ad7879 *ts)
 	z1 = ts->conversion_data[AD7879_SEQ_Z1] & MAX_12BIT;
 	z2 = ts->conversion_data[AD7879_SEQ_Z2] & MAX_12BIT;
 
+	if (ts->swap_xy)
+		swap(x, y);
+
 	/*
 	 * The samples processed here are already preprocessed by the AD7879.
 	 * The preprocessing function consists of a median and an averaging @@ -520,6 +524,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	ts->dev = dev;
 	ts->input = input_dev;
 	ts->irq = irq;
+	ts->swap_xy = pdata->swap_xy;
 
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
 
diff --git a/include/linux/spi/ad7879.h b/include/linux/spi/ad7879.h index 6334cee..9113a59 100644
--- a/include/linux/spi/ad7879.h
+++ b/include/linux/spi/ad7879.h
@@ -12,6 +12,7 @@ struct ad7879_platform_data {
 	u16	y_min, y_max;
 	u16	pressure_min, pressure_max;
 
+	bool	swap_xy;		/* swap x and y axes */
 	/* [0..255] 0=OFF Starts at 1=550us and goes
 	 * all the way to 9.440ms in steps of 35us.
 	 */
--
1.7.0.4


