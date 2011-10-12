From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 3/5] MFD: twl6040: function to query the
	vibra status for clients
Date: Wed, 12 Oct 2011 11:57:55 +0300
Message-ID: <1318409877-21681-4-git-send-email-peter.ujfalusi@ti.com>
References: <1318409877-21681-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1318409877-21681-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If the client only interested, if any of the vibra channels enabled, or
if any of the channels are set to receive audio data via PDM.

This function targets mainly the vibra driver, so it can check if it is
allowed to execute effects ot not.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
---
 drivers/mfd/twl6040-core.c  |   12 ++++++++++++
 include/linux/mfd/twl6040.h |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index 75987c8..268f80f 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -444,6 +444,18 @@ unsigned int twl6040_get_sysclk(struct twl6040 *twl6040)
 }
 EXPORT_SYMBOL(twl6040_get_sysclk);
 
+/* Get the combined status of the vibra control register */
+int twl6040_get_vibralr_status(struct twl6040 *twl6040)
+{
+	u8 status;
+
+	status = twl6040->vibra_ctrl_cache[0] | twl6040->vibra_ctrl_cache[1];
+	status &= (TWL6040_VIBENA | TWL6040_VIBSEL);
+
+	return status;
+}
+EXPORT_SYMBOL(twl6040_get_vibralr_status);
+
 static struct resource twl6040_vibra_rsrc[] = {
 	{
 		.flags = IORESOURCE_IRQ,
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 2f8585a..87a4778 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -209,10 +209,13 @@ int twl6040_get_pll(struct twl6040 *twl6040);
 unsigned int twl6040_get_sysclk(struct twl6040 *twl6040);
 int twl6040_irq_init(struct twl6040 *twl6040);
 void twl6040_irq_exit(struct twl6040 *twl6040);
+/* Get the combined status of the vibra control register */
+int twl6040_get_vibralr_status(struct twl6040 *twl6040);
 
 static inline int twl6040_get_revid(struct twl6040 *twl6040)
 {
 	return twl6040->rev;
 }
 
+
 #endif  /* End of __TWL6040_CODEC_H__ */
-- 
1.7.7
