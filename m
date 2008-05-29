From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH/RFC 1/2] Add jack reporting API for ALSA
Date: Thu, 29 May 2008 22:09:04 +0100
Message-ID: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Currently very few systems provide information about jack status to user
space, even though many have hardware facilities to do detection. Those
systems that do use an input device with the existing SW_HEADPHONE_INSERT
switch type to do so, often independently of ALSA.

This patch introduces a standard method for representing jacks to user
space into ALSA. It allows drivers to register jacks for a sound card with
the input subsystem, binding the input device to the card to help user
space associate the input devices with their sound cards. The created
input devices are named in the form "card longname jack" where jack is
provided by the driver when allocating a jack.

The existing user space API with SW_HEADPHONE_INSERT is preserved.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/core.h |    1 +
 include/sound/jack.h |   51 +++++++++++++++++++
 sound/core/Kconfig   |    5 ++
 sound/core/Makefile  |    2 +
 sound/core/jack.c    |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/jack.h
 create mode 100644 sound/core/jack.c

diff --git a/include/sound/core.h b/include/sound/core.h
index ee2d7e1..8c87713 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -53,6 +53,7 @@ typedef int __bitwise snd_device_type_t;
 #define	SNDRV_DEV_INFO		((__force snd_device_type_t) 0x1006)
 #define	SNDRV_DEV_BUS		((__force snd_device_type_t) 0x1007)
 #define	SNDRV_DEV_CODEC		((__force snd_device_type_t) 0x1008)
+#define	SNDRV_DEV_JACK          ((__force snd_device_type_t) 0x1009)
 #define	SNDRV_DEV_LOWLEVEL	((__force snd_device_type_t) 0x2000)
 
 typedef int __bitwise snd_device_state_t;
diff --git a/include/sound/jack.h b/include/sound/jack.h
new file mode 100644
index 0000000..e5ac26c
--- /dev/null
+++ b/include/sound/jack.h
@@ -0,0 +1,51 @@
+#ifndef __SOUND_JACK_H
+#define __SOUND_JACK_H
+
+/*
+ *  Jack abstraction layer
+ *
+ *  Copyright 2008 Wolfson Microelectronics plc
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <sound/core.h>
+
+struct input_dev;
+
+/**
+ * Jack types which can be reported.  These values are used as a
+ * bitmask.
+ */
+enum snd_jack_types {
+	SND_JACK_HEADPHONE = 0x0001,
+};
+
+struct snd_jack {
+	struct input_dev *input_dev;
+	int registered;
+	int type;
+	const char *id;
+	char name[100];
+};
+
+int snd_jack_new(struct snd_card *card, const char *id, int type,
+		 struct snd_jack **jack);
+
+void snd_jack_report(struct snd_jack *jack, int status);
+
+#endif
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 829ca38..4e8e52d 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -16,6 +16,11 @@ config SND_RAWMIDI
 	tristate
 	depends on SND
 
+config SND_JACK
+	tristate
+	depends on SND
+	depends on INPUT
+
 config SND_SEQUENCER
 	tristate "Sequencer support"
 	depends on SND
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 5a01c76..e1cb6d6 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -20,9 +20,11 @@ snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
 snd-rtctimer-objs := rtctimer.o
 snd-hwdep-objs    := hwdep.o
+snd-jack-objs     := jack.o
 
 obj-$(CONFIG_SND) 		+= snd.o
 obj-$(CONFIG_SND_HWDEP)		+= snd-hwdep.o
+obj-$(CONFIG_SND_JACK)		+= snd-jack.o
 obj-$(CONFIG_SND_TIMER)		+= snd-timer.o
 obj-$(CONFIG_SND_RTCTIMER)	+= snd-rtctimer.o
 obj-$(CONFIG_SND_PCM)		+= snd-pcm.o snd-page-alloc.o
diff --git a/sound/core/jack.c b/sound/core/jack.c
new file mode 100644
index 0000000..1a52997
--- /dev/null
+++ b/sound/core/jack.c
@@ -0,0 +1,136 @@
+/*
+ *  Jack abstraction layer
+ *
+ *  Copyright 2008 Wolfson Microelectronics
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/input.h>
+#include <sound/jack.h>
+#include <sound/core.h>
+
+static int snd_jack_dev_free(struct snd_device *device)
+{
+	struct snd_jack *jack = device->device_data;
+
+	/* If the input device is registered with the input subsystem
+	 * then we need to use a different deallocator. */
+	if (jack->registered)
+		input_unregister_device(jack->input_dev);
+	else
+		input_free_device(jack->input_dev);
+
+	kfree(jack);
+
+	return 0;
+}
+
+static int snd_jack_dev_register(struct snd_device *device)
+{
+	struct snd_jack *jack = device->device_data;
+	struct snd_card *card = device->card;
+	int err;
+
+	snprintf(jack->name, sizeof(jack->name), "%s %s",
+		 card->longname, jack->id);
+	jack->input_dev->name = jack->name;
+
+	err = input_register_device(jack->input_dev);
+	if (err == 0)
+		jack->registered = 1;
+
+	return err;
+}
+
+/**
+ * snd_jack_new - Create a new jack
+ * @card:  the card instance
+ * @id:    an identifying string for this jack
+ * @type:  a bitmask of enum snd_jack_type values that can be detected by
+ *         this jack
+ * @jjack: Used to provide the allocated jack object to the caller.
+ *
+ * Creates a new jack object.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ * On success jjack will be initialised.
+ */
+int snd_jack_new(struct snd_card *card, const char *id, int type,
+		 struct snd_jack **jjack)
+{
+	struct snd_jack *jack;
+	int err;
+	static struct snd_device_ops ops = {
+		.dev_free = snd_jack_dev_free,
+		.dev_register = snd_jack_dev_register,
+	};
+
+	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
+	if (jack == NULL)
+		return -ENOMEM;
+
+	jack->id = id;
+
+	jack->input_dev = input_allocate_device();
+	if (jack->input_dev == NULL) {
+		err = -ENOMEM;
+		goto fail_input;
+	}
+
+	jack->input_dev->phys = "ALSA";
+	jack->input_dev->dev.parent = card->dev;
+
+	jack->type = type;
+
+	if (type & SND_JACK_HEADPHONE)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_HEADPHONE_INSERT);
+
+	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
+	if (err < 0)
+		goto fail_input;
+
+	*jjack = jack;
+
+	return 0;
+
+fail_input:
+	input_free_device(jack->input_dev);
+	kfree(jack);
+	return err;
+}
+EXPORT_SYMBOL(snd_jack_new);
+
+/**
+ * snd_jack_report - Report the current status of a jack
+ *
+ * @jack:   The jack to report status for
+ * @status: The current status of the jack
+ */
+void snd_jack_report(struct snd_jack *jack, int status)
+{
+	if (jack->type & SND_JACK_HEADPHONE)
+		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
+				    status & SND_JACK_HEADPHONE);
+
+	input_sync(jack->input_dev);
+}
+EXPORT_SYMBOL(snd_jack_report);
+
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_DESCRIPTION("Jack detection support for ALSA");
+MODULE_LICENSE("GPL");
-- 
1.5.5.1
