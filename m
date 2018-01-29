From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/pressure: Delete an error message for a failed memory
 allocation in hid_press_probe()
Date: Mon, 29 Jan 2018 22:04:11 +0100
Message-ID: <e7dfe444-616a-e156-31d5-8ed626434d1f@users.sourceforge.net>
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
Date: Mon, 29 Jan 2018 21:55:08 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/pressure/hid-sensor-press.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 4c437918f1d2..9de7590d50b0 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -280,10 +280,8 @@ static int hid_press_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
 				      GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = press_parse_report(pdev, hsdev,
 				 (struct iio_chan_spec *)indio_dev->channels,
-- 
2.16.1
