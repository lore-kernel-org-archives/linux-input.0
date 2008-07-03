From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] Add microphone and headset reporting
Date: Thu,  3 Jul 2008 10:52:11 +0100
Message-ID: <1215078731-8875-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080703095026.GA652@sirena.org.uk>
	<1215078731-8875-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1215078731-8875-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@insightbb.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add a new switch type to the input API for reporting microphone
insertion and extend the ALSA jack reporting API to include this.
Since a headset is a combination of a microphone and at least a mono
headphone a convenience defintion is provided for describing them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/input.h |    1 +
 include/sound/jack.h  |    4 +++-
 sound/core/jack.c     |    6 ++++++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index d150c57..d297dec 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -640,6 +640,7 @@ struct input_absinfo {
 #define SW_RFKILL_ALL		0x03  /* rfkill master switch, type "any"
 					 set = radio enabled */
 #define SW_RADIO		SW_RFKILL_ALL	/* deprecated */
+#define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 5cb610d..743f559 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -32,7 +32,9 @@ struct input_dev;
  * bitmask.
  */
 enum snd_jack_types {
-	SND_JACK_HEADPHONE = 0x0001,
+	SND_JACK_HEADPHONE	= 0x0001,
+	SND_JACK_MICROPHONE	= 0x0002,
+	SND_JACK_HEADSET	= 0x0003,  /* Both microphone and headphone */
 };
 
 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 36ecc57..9c05ec8 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -102,6 +102,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (type & SND_JACK_HEADPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_HEADPHONE_INSERT);
+	if (type & SND_JACK_MICROPHONE)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_MICROPHONE_INSERT);
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -147,6 +150,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_HEADPHONE)
 		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
 				    status & SND_JACK_HEADPHONE);
+	if (jack->type & SND_JACK_MICROPHONE)
+		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
+				    status & SND_JACK_MICROPHONE);
 
 	input_sync(jack->input_dev);
 }
-- 
1.5.6
