From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/8] MFD: twl6040: Cache the vibra control
	registers
Date: Thu, 15 Sep 2011 15:59:15 +0300
Message-ID: <1316091561-30899-3-git-send-email-peter.ujfalusi@ti.com>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: linux-input@vger.kernel.org

The vibra control register will be used from the ASoC codec driver as well.
In order to avoid latency issues caused by I2C read access, cache the two
control register within the core driver, so we do not need to reach out
to the chip to read it back.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040-core.c  |   19 +++++++++++++++----
 include/linux/mfd/twl6040.h |    1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index 7dc8c47..75987c8 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -34,16 +34,24 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/twl6040.h>
 
+#define VIBRACTRL_MEMBER(reg) ((reg == TWL6040_REG_VIBCTLL) ? 0 : 1)
+
 int twl6040_reg_read(struct twl6040 *twl6040, unsigned int reg)
 {
 	int ret;
 	u8 val = 0;
 
 	mutex_lock(&twl6040->io_mutex);
-	ret = twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, reg);
-	if (ret < 0) {
-		mutex_unlock(&twl6040->io_mutex);
-		return ret;
+	/* Vibra control registers from cache */
+	if (unlikely(reg == TWL6040_REG_VIBCTLL ||
+		     reg == TWL6040_REG_VIBCTLR)) {
+		val = twl6040->vibra_ctrl_cache[VIBRACTRL_MEMBER(reg)];
+	} else {
+		ret = twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, reg);
+		if (ret < 0) {
+			mutex_unlock(&twl6040->io_mutex);
+			return ret;
+		}
 	}
 	mutex_unlock(&twl6040->io_mutex);
 
@@ -57,6 +65,9 @@ int twl6040_reg_write(struct twl6040 *twl6040, unsigned int reg, u8 val)
 
 	mutex_lock(&twl6040->io_mutex);
 	ret = twl_i2c_write_u8(TWL_MODULE_AUDIO_VOICE, val, reg);
+	/* Cache the vibra control registers */
+	if (reg == TWL6040_REG_VIBCTLL || reg == TWL6040_REG_VIBCTLR)
+		twl6040->vibra_ctrl_cache[VIBRACTRL_MEMBER(reg)] = val;
 	mutex_unlock(&twl6040->io_mutex);
 
 	return ret;
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 6059935..3ec9591 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -185,6 +185,7 @@ struct twl6040 {
 	int audpwron;
 	int power_count;
 	int rev;
+	u8 vibra_ctrl_cache[2];
 
 	int pll;
 	unsigned int sysclk;
-- 
1.7.6.1
