From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 08/11] media: tda1004x: switch to i2c_lock_segment
Date: Fri, 15 Jun 2018 12:15:03 +0200
Message-ID: <20180615101506.8012-9-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-input@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_segment. If the device does not sit behind a mux-locked mux,
the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/dvb-frontends/tda1004x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda1004x.c b/drivers/media/dvb-frontends/tda1004x.c
index 58e3beff5adc..1e5c183cdd86 100644
--- a/drivers/media/dvb-frontends/tda1004x.c
+++ b/drivers/media/dvb-frontends/tda1004x.c
@@ -329,7 +329,7 @@ static int tda1004x_do_upload(struct tda1004x_state *state,
 	tda1004x_write_byteI(state, dspCodeCounterReg, 0);
 	fw_msg.addr = state->config->demod_address;
 
-	i2c_lock_adapter(state->i2c);
+	i2c_lock_segment(state->i2c);
 	buf[0] = dspCodeInReg;
 	while (pos != len) {
 		// work out how much to send this time
@@ -342,14 +342,14 @@ static int tda1004x_do_upload(struct tda1004x_state *state,
 		fw_msg.len = tx_size + 1;
 		if (__i2c_transfer(state->i2c, &fw_msg, 1) != 1) {
 			printk(KERN_ERR "tda1004x: Error during firmware upload\n");
-			i2c_unlock_adapter(state->i2c);
+			i2c_unlock_segment(state->i2c);
 			return -EIO;
 		}
 		pos += tx_size;
 
 		dprintk("%s: fw_pos=0x%x\n", __func__, pos);
 	}
-	i2c_unlock_adapter(state->i2c);
+	i2c_unlock_segment(state->i2c);
 
 	/* give the DSP a chance to settle 03/10/05 Hac */
 	msleep(100);
-- 
2.11.0
