From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFT V2 1/3] iio: mxs-lradc: simplify TS registration
Date: Thu, 21 Apr 2016 20:11:16 +0000
Message-ID: <1461269478-449-2-git-send-email-stefan.wahren@i2se.com>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58485 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcDUUMX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2016 16:12:23 -0400
In-Reply-To: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Juergen Borleis <jbe@pengutronix.de>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch simplifies the TS registration of mxs-lradc by
using devm_input_allocate_device.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/adc/mxs-lradc.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index ad26da1..223650b 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1120,12 +1120,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 {
 	struct input_dev *input;
 	struct device *dev = lradc->dev;
-	int ret;
 
 	if (!lradc->use_touchscreen)
 		return 0;
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
 
@@ -1146,11 +1145,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 
 	lradc->ts_input = input;
 	input_set_drvdata(input, lradc);
-	ret = input_register_device(input);
-	if (ret)
-		input_free_device(lradc->ts_input);
 
-	return ret;
+	return input_register_device(input);
 }
 
 static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
@@ -1159,7 +1155,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
 		return;
 
 	mxs_lradc_disable_ts(lradc);
-	input_unregister_device(lradc->ts_input);
 }
 
 /*
-- 
1.7.9.5

