From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: ad7879 - make sure we set up drvdata
Date: Tue, 28 Feb 2017 14:08:45 -0800
Message-ID: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The conversion to devm accidentally removed setting up of I2C client data
upon successful probe of the touchscreen. Let's move this setting into the
core, so we do not forger about it again.

Fixes: 381f688eee3d ("Input: ad7879 - use more devm interfaces")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ad7879-spi.c | 2 --
 drivers/input/touchscreen/ad7879.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index c73798297b98..59486ccba37d 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -49,8 +49,6 @@ static int ad7879_spi_probe(struct spi_device *spi)
 	if (IS_ERR(ts))
 		return PTR_ERR(ts);
 
-	spi_set_drvdata(spi, ts);
-
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 1bd870277e1a..52daaa4edc67 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -680,6 +680,8 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
 	if (err)
 		return ERR_PTR(err);
 
+	dev_set_drvdata(dev, ts);
+
 	return 0;
 }
 EXPORT_SYMBOL(ad7879_probe);
-- 
2.11.0.483.g087da7b7c-goog
