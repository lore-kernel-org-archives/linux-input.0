From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 03/11] i2c: mux: pca9541: switch to i2c_lock_segment
Date: Fri, 15 Jun 2018 12:14:58 +0200
Message-ID: <20180615101506.8012-4-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Crt Mori <cmo@melexis.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Peter Huewe <peterhuewe@gmx.de>, Michael Krufky <mkrufky@linuxtv.org>, Lee Jones <lee.jones@linaro.org>, Antti Palosaari <crope@iki.fi>, linux-samsung-soc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-input@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Haavard Skinnemoen <hskinnemoen@gm>
List-Id: linux-input@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_segment. If the device does not sit behind a mux-locked mux,
the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..74c560ed44cc 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -345,11 +345,11 @@ static int pca9541_probe(struct i2c_client *client,
 
 	/*
 	 * I2C accesses are unprotected here.
-	 * We have to lock the adapter before releasing the bus.
+	 * We have to lock the I2C segment before releasing the bus.
 	 */
-	i2c_lock_adapter(adap);
+	i2c_lock_segment(adap);
 	pca9541_release_bus(client);
-	i2c_unlock_adapter(adap);
+	i2c_unlock_segment(adap);
 
 	/* Create mux adapter */
 
-- 
2.11.0
