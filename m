From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH/RFC 2/2] Add microphone and headset reporting
Date: Thu, 29 May 2008 22:09:05 +0100
Message-ID: <12120953452074-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42978 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754565AbYE2VJI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2008 17:09:08 -0400
In-Reply-To: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@insightbb.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-input@vger.kernel.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

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
index d8521c7..07593f2 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -612,6 +612,7 @@ struct input_absinfo {
 #define SW_TABLET_MODE		0x01  /* set = tablet mode */
 #define SW_HEADPHONE_INSERT	0x02  /* set = inserted */
 #define SW_RADIO		0x03  /* set = radio enabled */
+#define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_MAX			0x0f
 
 /*
diff --git a/include/sound/jack.h b/include/sound/jack.h
index e5ac26c..1e080c2 100644
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
index 1a52997..f030be9 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -99,6 +99,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (type & SND_JACK_HEADPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_HEADPHONE_INSERT);
+	if (type & SND_JACK_MICROPHONE)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_MICROPHONE_INSERT);
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -126,6 +129,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_HEADPHONE)
 		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
 				    status & SND_JACK_HEADPHONE);
+	if (jack->type & SND_JACK_MICROPHONE)
+		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
+				    status & SND_JACK_MICROPHONE);
 
 	input_sync(jack->input_dev);
 }
-- 
1.5.5.1

