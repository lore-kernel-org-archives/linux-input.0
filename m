From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 04/10] media: af9013: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date: Wed, 20 Jun 2018 07:17:57 +0200
Message-ID: <20180620051803.12206-5-peda@axentia.se>
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
 drivers/media/dvb-frontends/af9013.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/af9013.c b/drivers/media/dvb-frontends/af9013.c
index 482bce49819a..99361c113bca 100644
--- a/drivers/media/dvb-frontends/af9013.c
+++ b/drivers/media/dvb-frontends/af9013.c
@@ -1312,10 +1312,10 @@ static int af9013_wregs(struct i2c_client *client, u8 cmd, u16 reg,
 	memcpy(&buf[3], val, len);
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = __i2c_transfer(client->adapter, msg, 1);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 1) {
@@ -1353,10 +1353,10 @@ static int af9013_rregs(struct i2c_client *client, u8 cmd, u16 reg,
 	buf[2] = cmd;
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = __i2c_transfer(client->adapter, msg, 2);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 2) {
-- 
2.11.0
