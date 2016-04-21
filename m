From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 4/4] input: twl6040-vibra: fix atomic schedule panic
Date: Thu, 21 Apr 2016 13:43:50 +0200
Message-ID: <c94be1210a0aef20c78d47eec1da17291b864cda.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

commit c6f39257c952 ("mfd: twl6040: Use regmap for register cache")

did remove the private cache for the vibra control registers and replaced
access within twl6040_get_vibralr_status() by calls to regmap. This is ok,
as long as twl6040_get_vibralr_status() uses already cached values or is
not called from interrupt context. But we call this in vibra_play() for checking
that the vibrator is not configured for audio mode.

The result is a "BUG: scheduling while atomic" if the first use of the
twl6040 is a vibra effect, because the first fetch is by reading the
twl6040 registers through (blocking) i2c and not from the cache.

As soon as the regmap has cached the status, further calls are fine.

The solution is to move the condition to the work() function which
runs in context that can block.

The original code returns -EBUSY, but the return value of ->play()
functions is ignored anyways. Hence, we do not loose functionality
by not returning an error but just reporting the issue to INFO loglevel.

Tested-on: Pyra (omap5) prototype
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/twl6040-vibra.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index f4384b7..5690eb7 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -181,6 +181,14 @@ static void vibra_play_work(struct work_struct *work)
 {
 	struct vibra_info *info = container_of(work,
 				struct vibra_info, play_work);
+	int ret;
+
+	/* Do not allow effect, while the routing is set to use audio */
+	ret = twl6040_get_vibralr_status(info->twl6040);
+	if (ret & TWL6040_VIBSEL) {
+		dev_info(info->dev, "Vibra is configured for audio\n");
+		return;
+	}
 
 	if (info->weak_speed || info->strong_speed) {
 		if (!info->enabled)
@@ -196,14 +204,6 @@ static int vibra_play(struct input_dev *input, void *data,
 		      struct ff_effect *effect)
 {
 	struct vibra_info *info = input_get_drvdata(input);
-	int ret;
-
-	/* Do not allow effect, while the routing is set to use audio */
-	ret = twl6040_get_vibralr_status(info->twl6040);
-	if (ret & TWL6040_VIBSEL) {
-		dev_info(&input->dev, "Vibra is configured for audio\n");
-		return -EBUSY;
-	}
 
 	info->weak_speed = effect->u.rumble.weak_magnitude;
 	info->strong_speed = effect->u.rumble.strong_magnitude;
-- 
2.7.3
