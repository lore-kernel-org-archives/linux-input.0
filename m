From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 7/8] iio: adc: ti_am335x_adc: use variable names for sizeof() operator
Date: Tue, 31 May 2016 12:00:12 -0500
Message-ID: <20160531170013.2649-8-afd@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:41867 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448AbcEaRAh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 13:00:37 -0400
In-Reply-To: <20160531170013.2649-1-afd@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Fix the code formatting to use the kernel preferred style
of using the actual variables to determize the size using
the sizeof() operator.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 18af71d..8a36875 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -326,8 +326,7 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 	int i;
 
 	indio_dev->num_channels = channels;
-	chan_array = kcalloc(channels,
-			sizeof(struct iio_chan_spec), GFP_KERNEL);
+	chan_array = kcalloc(channels, sizeof(*chan_array), GFP_KERNEL);
 	if (chan_array == NULL)
 		return -ENOMEM;
 
@@ -467,8 +466,7 @@ static int tiadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct tiadc_device));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*indio_dev));
 	if (indio_dev == NULL) {
 		dev_err(&pdev->dev, "failed to allocate iio device\n");
 		return -ENOMEM;
-- 
2.8.3

