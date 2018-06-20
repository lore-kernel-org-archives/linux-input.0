From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 06/10] media: rtl2830: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date: Wed, 20 Jun 2018 07:17:59 +0200
Message-ID: <20180620051803.12206-7-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>Crt Mori <c>
List-Id: linux-input@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/dvb-frontends/rtl2830.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index 7bbfe11d11ed..91d12e6a03d5 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -24,9 +24,9 @@ static int rtl2830_bulk_write(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = regmap_bulk_write(dev->regmap, reg, val, val_count);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 
@@ -36,9 +36,9 @@ static int rtl2830_update_bits(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = regmap_update_bits(dev->regmap, reg, mask, val);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 
@@ -48,9 +48,9 @@ static int rtl2830_bulk_read(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = regmap_bulk_read(dev->regmap, reg, val, val_count);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 
-- 
2.11.0
