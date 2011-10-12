From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/5] Input: twl6040-vibra: Check the
	selected path for vibra
Date: Wed, 12 Oct 2011 11:57:56 +0300
Message-ID: <1318409877-21681-5-git-send-email-peter.ujfalusi@ti.com>
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

The VIBSELL/R bit in the VIBCTLL/R register tells the source of the data,
which is going to be used to drive the attached motor(s).
Do not allow effect execution if any of the channels are set to receive
audio data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/twl6040-vibra.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index cb74185..2a828e5 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -201,6 +201,13 @@ static int vibra_play(struct input_dev *input, void *data,
 	struct vibra_info *info = input_get_drvdata(input);
 	int ret;
 
+	/* Do not allow effect, while the routing is set to use audio */
+	ret = twl6040_get_vibralr_status(info->twl6040);
+	if (ret & TWL6040_VIBSEL) {
+		dev_info(&input->dev, "Vibra is configured for audio\n");
+		return -EBUSY;
+	}
+
 	info->weak_speed = effect->u.rumble.weak_magnitude;
 	info->strong_speed = effect->u.rumble.strong_magnitude;
 	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 1 : -1;
-- 
1.7.7
