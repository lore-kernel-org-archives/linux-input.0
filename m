From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 03/10] input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date: Wed, 20 Jun 2018 07:17:56 +0200
Message-ID: <20180620051803.12206-4-peda@axentia.se>
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
 drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index bda0500c9b57..714affdd742f 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
 	msg[1].len = len;
 	msg[1].buf = buf;
 
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 
 	for (i = 0; i < 2; i++) {
 		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
@@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
 		}
 	}
 
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
 	return ret;
 }
-- 
2.11.0
