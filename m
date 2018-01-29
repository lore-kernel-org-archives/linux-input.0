From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/orientation: Delete an error message for a failed memory
 allocation in two functions
Date: Mon, 29 Jan 2018 22:26:15 +0100
Message-ID: <ebf6c923-d641-8bf8-5544-630a5ee39980@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:61956 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbeA2V0i (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 16:26:38 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Jan 2018 22:20:07 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 4 +---
 drivers/iio/orientation/hid-sensor-rotation.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 1e5451d1ff88..742c0e0eb4cf 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -336,10 +336,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(incl_3d_channels,
 				      sizeof(incl_3d_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = incl_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index a69db2002414..cbf5e406b1ee 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -277,10 +277,8 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	indio_dev->channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
 					   sizeof(dev_rot_channels),
 					   GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = dev_rot_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
-- 
2.16.1

