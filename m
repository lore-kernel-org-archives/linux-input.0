From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/light: Delete an error message for a failed memory
 allocation in two functions
Date: Wed, 31 Jan 2018 21:21:43 +0100
Message-ID: <377187b2-abb5-b693-2e95-8674748854c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Archana Patni <archana.patni@linux.intel.com>, Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:12:09 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/light/hid-sensor-als.c  | 4 +---
 drivers/iio/light/hid-sensor-prox.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index befd693a4a31..83654156d952 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -299,10 +299,8 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(als_channels,
 				      sizeof(als_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = als_parse_report(pdev, hsdev,
 			       (struct iio_chan_spec *)indio_dev->channels,
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 45107f7537b5..f4487620e08b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -277,10 +277,8 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(prox_channels, sizeof(prox_channels),
 				      GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = prox_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
-- 
2.16.1
