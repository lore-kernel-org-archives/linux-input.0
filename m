From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 4/5] input: misc: bma150: Drop platform data
Date: Sat,  2 Feb 2019 16:18:05 +0100
Message-ID: <20190202151806.9064-5-pawel.mikolaj.chmiel@gmail.com>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

bma150 supports DT now and as there are no in-kernel users of
the platform data, remove it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 27 +++++----------------------
 include/linux/bma150.h      |  5 -----
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index e86df79490ad..1cdc8ce97968 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -567,8 +567,6 @@ int bma150_cfg_from_of(struct device_node *np)
 static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	const struct bma150_platform_data *pdata =
-			dev_get_platdata(&client->dev);
 	const struct bma150_cfg *cfg;
 	struct bma150_data *bma150;
 	int chip_id;
@@ -592,27 +590,12 @@ static int bma150_probe(struct i2c_client *client,
 
 	bma150->client = client;
 
-	if (pdata) {
-		if (pdata->irq_gpio_cfg) {
-			error = pdata->irq_gpio_cfg();
-			if (error) {
-				dev_err(&client->dev,
-					"IRQ GPIO conf. error %d, error %d\n",
-					client->irq, error);
-				return error;
-			}
-		}
-		cfg = &pdata->cfg;
-	} else if (client->dev.of_node) {
-		error = bma150_cfg_from_of(client->dev.of_node);
-		if (error) {
-			dev_err(&client->dev, "Failed to parse of data\n");
-			return error;
-		}
-		cfg = &default_cfg;
-	} else {
-		cfg = &default_cfg;
+	error = bma150_cfg_from_of(client->dev.of_node);
+	if (error) {
+		dev_err(&client->dev, "Failed to parse of data\n");
+		return error;
 	}
+	cfg = &default_cfg;
 
 	error = bma150_initialize(bma150, cfg);
 	if (error)
diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index ad19dc7a30d7..650ffe9fa4cf 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -41,9 +41,4 @@ struct bma150_cfg {
 	u32 bandwidth;			/* one of BMA0150_BW_xxx */
 };
 
-struct bma150_platform_data {
-	struct bma150_cfg cfg;
-	int (*irq_gpio_cfg)(void);
-};
-
 #endif /* _BMA150_H_ */
-- 
2.17.1
