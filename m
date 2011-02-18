From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 13/29] twl4030: mfd_cell is now implicitly
	available to drivers (v2)
Date: Thu, 17 Feb 2011 19:07:20 -0800
Message-ID: <1297998456-7615-14-git-send-email-dilinger@queued.net>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1297998456-7615-1-git-send-email-dilinger@queued.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org

The cell's platform_data is now accessed with a helper function;
change clients to use that, and remove the now-unused data_size.

v2: add some missing mfd/core.h includes.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/input/misc/twl4030-vibra.c |    3 ++-
 drivers/mfd/twl4030-codec.c        |    2 --
 sound/soc/codecs/twl4030.c         |    6 ++++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 014dd4a..6a11694 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -29,6 +29,7 @@
 #include <linux/workqueue.h>
 #include <linux/i2c/twl.h>
 #include <linux/mfd/twl4030-codec.h>
+#include <linux/mfd/core.h>
 #include <linux/input.h>
 #include <linux/slab.h>
 
@@ -196,7 +197,7 @@ static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
 
 static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
 {
-	struct twl4030_codec_vibra_data *pdata = pdev->dev.platform_data;
+	struct twl4030_codec_vibra_data *pdata = mfd_get_data(pdev);
 	struct vibra_info *info;
 	int ret;
 
diff --git a/drivers/mfd/twl4030-codec.c b/drivers/mfd/twl4030-codec.c
index 9a4b196..0f57426 100644
--- a/drivers/mfd/twl4030-codec.c
+++ b/drivers/mfd/twl4030-codec.c
@@ -209,14 +209,12 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 		cell = &codec->cells[childs];
 		cell->name = "twl4030-codec";
 		cell->platform_data = pdata->audio;
-		cell->data_size = sizeof(*pdata->audio);
 		childs++;
 	}
 	if (pdata->vibra) {
 		cell = &codec->cells[childs];
 		cell->name = "twl4030-vibra";
 		cell->platform_data = pdata->vibra;
-		cell->data_size = sizeof(*pdata->vibra);
 		childs++;
 	}
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e4d464b..8512800 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -26,6 +26,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/core.h>
 #include <linux/i2c/twl.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -732,7 +733,8 @@ static int aif_event(struct snd_soc_dapm_widget *w,
 
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
-	struct twl4030_codec_audio_data *pdata = codec->dev->platform_data;
+	struct twl4030_codec_audio_data *pdata =
+			mfd_get_data(to_platform_device(codec->dev));
 	unsigned char hs_gain, hs_pop;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
@@ -2297,7 +2299,7 @@ static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 
 static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 {
-	struct twl4030_codec_audio_data *pdata = pdev->dev.platform_data;
+	struct twl4030_codec_audio_data *pdata = mfd_get_data(pdev);
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "platform_data is missing\n");
-- 
1.7.2.3
