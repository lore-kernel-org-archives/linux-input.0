From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 26/26] HID/ALSA: wiimote: add speaker support
Date: Sun,  5 May 2013 23:13:10 +0200
Message-ID: <1367788390-29835-27-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:62043 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3EEVO1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:27 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik5so1347986bkc.37
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:25 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>

Classic Wii Remotes provide a speaker on the device. We can stream PCM
data, mute and change volume via special protocol requests and remote
audio registers.
The device supports several different formats, but fully understood are
only signed 8-bit PCM and something that looks like 4-bit Yamaha ADPCM.
Theoretically, we can set data-rates from 183Hz up to 12MHz, but a
realistic range for Bluetooth l2cap is 1000-4000 Hz.

Data is streamed as 20bytes blocks and must be sent in a constant rate.
There is no way to read the current position. It would be way too slow,
anyway. However, if we stream data too fast, older devices will report
overrun errors. It is nearly impossible to avoid them as we have no
fine-grained control over bluetooth radio. But that's probably also the
reason why newer devices no longer send these errors.

Note that 8bit PCM at such low rates has quite bad sound quality. You
also need to use user-space programs like "sox/play" as other
applications require rates >4000/8000Hz.

The 4bit Yamaha ADPCM should improve sound-quality a lot, however, the
kernel currently doesn't support this. So we either need to add ALSA
support or add an internal encoder. But this will be implemented in
follow-up patches so we first get the infrastructure ready.

Thanks to David Henningsson for very helpful advice on the driver layout.
The driver is also very loosely based on the sgio2audio driver by
Vivien Chappelier <vivien.chappelier@linux-mips.org> and the dummy
alsa sound driver.

Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi

This is my second revision of the Wii Remote sound-driver. It is based on the
hotplugging rework in this series. It's the only patch that is marked as RFC
but I thought I'd just include it in this series for completenes.

If someone wants to give it a try, I used the "sox" tools for testing as most
other tools require rates >4000/8000Hz.
  Sample created via:
    sox input.wav -b 8 -e signed -c 1 -r 2000 output.raw
  Play via: (prefix with: SOX_OPTS="--buffer 128" for better responsiveness)
    AUDIODEV=hw:1 play -e signed -b 8 -c 1 -r 2000 output.raw

Comments welcome! I tested this with 4 different devices and all worked well.
I also tested hotplugging while playing audio and I never got any deadlocks or
oopses. It's the first time I worked with the sound-layer, but I'm now pretty
sure I got everything right. Maybe I could even relax the heavy-locking but
better be safe.

Cheers
David

 drivers/hid/Kconfig               |   4 +
 drivers/hid/Makefile              |   3 +
 drivers/hid/hid-wiimote-core.c    |  66 +++-
 drivers/hid/hid-wiimote-modules.c |   5 +
 drivers/hid/hid-wiimote-speaker.c | 662 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |  17 +
 6 files changed, 755 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote-speaker.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e8ef86c..3bc81c8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -699,6 +699,7 @@ config HID_WIIMOTE
 	tristate "Nintendo Wii / Wii U peripherals"
 	depends on HID
 	depends on LEDS_CLASS
+	depends on !SND || HIGH_RES_TIMERS
 	select POWER_SUPPLY
 	select INPUT_FF_MEMLESS
 	---help---
@@ -715,6 +716,9 @@ config HID_WIIMOTE
 	the Wii U Gamepad) might be supported in the future. But currently
 	support is limited to Bluetooth based devices.
 
+	If Alsa sound support (CONFIG_SND) is enabled, this driver also provides
+	a sound card interface for Wii Remote speakers.
+
 	If unsure, say N.
 
 	To compile this driver as a module, choose M here: the
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8b7106b..d149e10 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -32,6 +32,9 @@ hid-wiimote-y		:= hid-wiimote-core.o hid-wiimote-modules.o
 ifdef CONFIG_DEBUG_FS
 	hid-wiimote-y	+= hid-wiimote-debug.o
 endif
+ifdef CONFIG_SND
+	hid-wiimote-y	+= hid-wiimote-speaker.o
+endif
 
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 279a07d..ea07fc3 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -309,8 +309,8 @@ void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags)
 #define wiiproto_req_weeprom(wdata, os, buf, sz) \
 			wiiproto_req_wmem((wdata), true, (os), (buf), (sz))
 
-static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
-				__u32 offset, const __u8 *buf, __u8 size)
+void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
+		       __u32 offset, const __u8 *buf, __u8 size)
 {
 	__u8 cmd[22];
 
@@ -359,6 +359,58 @@ void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom, __u32 offset,
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+void wiiproto_req_speaker(struct wiimote_data *wdata, bool on)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_SPEAKER;
+	cmd[1] = on ? 0x04 : 0x00;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
+void wiiproto_req_mute(struct wiimote_data *wdata, bool on)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_MUTE;
+	cmd[1] = on ? 0x04 : 0x00;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
+/* send audio data, possibly fragmented into two blocks */
+size_t wiiproto_req_audio(struct wiimote_data *wdata, const __u8 *b1,
+			  size_t len1, const __u8 *b2, size_t len2)
+{
+	__u8 cmd[22];
+	size_t pos, len;
+
+	pos = 0;
+	len = min_t(size_t, len1, 20ULL);
+	memcpy(&cmd[2 + pos], b1, len);
+	pos += len;
+
+	if (pos < 20 && len2) {
+		len = min_t(size_t, len2, 20ULL - pos);
+		memcpy(&cmd[2 + pos], b2, len);
+		pos += len;
+	}
+
+	cmd[0] = WIIPROTO_REQ_AUDIO;
+	cmd[1] = (pos & 0xff) << 3;
+
+	for ( ; pos < 20; ++pos)
+		cmd[pos] = 0;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+
+	return pos;
+}
+
 /* requries the cmd-mutex to be held */
 int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size)
@@ -570,6 +622,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED4,
 		WIIMOD_ACCEL,
 		WIIMOD_IR,
+		WIIMOD_SPEAKER,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN10] = (const __u8[]){
@@ -582,6 +635,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED4,
 		WIIMOD_ACCEL,
 		WIIMOD_IR,
+		WIIMOD_SPEAKER,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN20] = (const __u8[]){
@@ -595,6 +649,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_ACCEL,
 		WIIMOD_IR,
 		WIIMOD_BUILTIN_MP,
+		WIIMOD_SPEAKER,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_BALANCE_BOARD] = (const __u8[]) {
@@ -1469,6 +1524,13 @@ static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 	if (wiimote_cmd_pending(wdata, cmd, 0)) {
 		wdata->state.cmd_err = err;
 		wiimote_cmd_complete(wdata);
+	} else if (cmd == WIIPROTO_REQ_AUDIO && err == 4) {
+		/* If we stream audio data too fast, we get overrun errors
+		 * from the device. However, on audio-period bounds,
+		 * we have a very hard time sending audio at the exact rate
+		 * as we have no control over the bluetooth l2cap IRQs.
+		 * Hence, drop any overrun errors. */
+		hid_dbg(wdata->hdev, "audio overrun error\n");
 	} else if (err) {
 		hid_warn(wdata->hdev, "Remote error %hhu on req %hhu\n", err,
 									cmd);
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index ab25a64..25483aa 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -2074,6 +2074,11 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_IR] = &wiimod_ir,
 	[WIIMOD_BUILTIN_MP] = &wiimod_builtin_mp,
 	[WIIMOD_NO_MP] = &wiimod_no_mp,
+#ifdef CONFIG_SND
+	[WIIMOD_SPEAKER] = &wiimod_speaker,
+#else
+	[WIIMOD_SPEAKER] = &wiimod_dummy,
+#endif
 };
 
 const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
diff --git a/drivers/hid/hid-wiimote-speaker.c b/drivers/hid/hid-wiimote-speaker.c
new file mode 100644
index 0000000..89b7f9f
--- /dev/null
+++ b/drivers/hid/hid-wiimote-speaker.c
@@ -0,0 +1,662 @@
+/*
+ * Driver for audio speakers of Nintendo Wii / Wii U peripherals
+ * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+/*
+ * Audio Speakers
+ * Some Wii peripherals provide an audio speaker that supports 8bit PCM, 4bit
+ * Yamaha ADPCM and some other mostly unknown formats. Not all setup options
+ * are known, but we know how to setup an 8bit PCM or 4bit ADPCM stream and
+ * adjust volume. Data is sent as 20bytes chunks and needs to be streamed at
+ * a constant rate.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include "hid-wiimote.h"
+
+struct wiimote_speaker {
+	spinlock_t lock;
+	struct snd_card *card;
+	struct wiimote_data *wdata;
+	unsigned int online : 1;
+	unsigned int mute : 1;
+	__u8 volume;
+
+	unsigned long pos;
+	struct snd_pcm_substream *subs;
+	struct mutex runlock;
+
+	struct hrtimer timer;
+	struct tasklet_struct tasklet;
+};
+
+enum wiimod_speaker_mode {
+	WIIMOD_SPEAKER_MODE_PCM8,
+	/* TODO: 4bit Yamaha ADPCM is currently not implemented */
+	WIIMOD_SPEAKER_MODE_ADPCM4,
+};
+
+static int wiimod_speaker_enable(struct wiimote_speaker *speaker)
+{
+	struct wiimote_data *wdata = speaker->wdata;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	if (!speaker->online) {
+		speaker->online = 1;
+		wiiproto_req_speaker(wdata, true);
+		wiiproto_req_mute(wdata, speaker->mute);
+	}
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_speaker_disable(struct wiimote_speaker *speaker)
+{
+	struct wiimote_data *wdata = speaker->wdata;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	if (speaker->online) {
+		speaker->online = 0;
+		wiiproto_req_speaker(wdata, false);
+	}
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static void wiimod_speaker_set_mute(struct wiimote_speaker *speaker, bool mute)
+{
+	struct wiimote_data *wdata = speaker->wdata;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	if (speaker->mute != mute) {
+		speaker->mute = mute;
+		if (speaker->online)
+			wiiproto_req_mute(wdata, mute);
+	}
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static void wiimod_speaker_set_volume(struct wiimote_speaker *speaker,
+				      __u8 volume)
+{
+	struct wiimote_data *wdata = speaker->wdata;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	if (speaker->volume != volume) {
+		speaker->volume = volume;
+		if (speaker->online)
+			wiiproto_req_wmem(wdata, false, 0xa20005, &volume,
+					  sizeof(volume));
+	}
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+/* Change speaker configuration. \mode can be one of WIIMOD_SPEAKER_MODE_*,
+ * \rate is the PCM sample rate and \volume is the requested volume. */
+static int wiimod_speaker_setup(struct wiimote_speaker *speaker,
+				__u8 mode, __u16 rate, __s16 volume)
+{
+	struct wiimote_data *wdata = speaker->wdata;
+	unsigned long flags;
+	__u8 config[7], m, wmem;
+	__u16 r;
+	int ret;
+
+	if (!rate)
+		return -EINVAL;
+
+	switch (mode) {
+	case WIIMOD_SPEAKER_MODE_PCM8:
+		r = 12000000ULL / rate;
+		m = 0x40;
+		break;
+	case WIIMOD_SPEAKER_MODE_ADPCM4:
+		r = 6000000ULL / rate;
+		m = 0x00;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config[0] = 0x00;
+	config[1] = m;
+	config[2] = r & 0x00ff;
+	config[3] = (r & 0xff00) >> 8;
+	config[4] = volume & 0xff;
+	config[5] = 0x00;
+	config[6] = 0x00;
+
+	wiimote_cmd_acquire_noint(wdata);
+
+	/* mute speaker during setup and read/write volume field */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	wiiproto_req_mute(wdata, true);
+	if (volume < 0)
+		config[4] = speaker->volume;
+	else
+		speaker->volume = volume;
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	/* power speaker */
+	wmem = 0x01;
+	ret = wiimote_cmd_write(wdata, 0xa20009, &wmem, sizeof(wmem));
+	if (ret)
+		goto out_unlock;
+
+	/* prepare setup */
+	wmem = 0x08;
+	ret = wiimote_cmd_write(wdata, 0xa20001, &wmem, sizeof(wmem));
+	if (ret)
+		goto out_unlock;
+
+	/* write configuration */
+	ret = wiimote_cmd_write(wdata, 0xa20001, config, sizeof(config));
+	if (ret)
+		goto out_unlock;
+
+	/* enable speaker */
+	wmem = 0x01;
+	ret = wiimote_cmd_write(wdata, 0xa20008, &wmem, sizeof(wmem));
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	wiimote_cmd_release(wdata);
+	return ret;
+}
+
+/* returns true if a period has elapsed */
+static bool wiimod_speaker_push(struct wiimote_speaker *speaker)
+{
+	struct wiimote_data *wdata = speaker->wdata;
+	struct snd_pcm_runtime *runtime = speaker->subs->runtime;
+	unsigned long flags;
+	bool elapsed;
+	unsigned long buflen, plen, len;
+	__u8 *src;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	buflen = frames_to_bytes(runtime, runtime->buffer_size);
+	plen = frames_to_bytes(runtime, runtime->period_size);
+	src = runtime->dma_area;
+
+	len = buflen - speaker->pos;
+
+	/* no need to send data while muted or offline */
+	if (speaker->online && !speaker->mute) {
+		if (len < 20)
+			wiiproto_req_audio(wdata, &src[speaker->pos],
+					   len, src, 20 - len);
+		else
+			wiiproto_req_audio(wdata, &src[speaker->pos],
+					   20, NULL, 0);
+	}
+
+	speaker->pos += 20;
+	speaker->pos %= buflen;
+	elapsed = (speaker->pos % plen) < 20;
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return elapsed;
+}
+
+/* timer handling */
+
+static void wiimod_speaker_task(unsigned long data)
+{
+	struct wiimote_speaker *speaker = (void*)data;
+	unsigned long flags;
+	bool elapsed = false;
+
+	spin_lock_irqsave(&speaker->lock, flags);
+	if (speaker->wdata)
+		elapsed = wiimod_speaker_push(speaker);
+	spin_unlock_irqrestore(&speaker->lock, flags);
+
+	if (elapsed)
+		snd_pcm_period_elapsed(speaker->subs);
+}
+
+static enum hrtimer_restart wiimod_speaker_tick(struct hrtimer *timer)
+{
+	struct wiimote_speaker *speaker = container_of(timer,
+						       struct wiimote_speaker,
+						       timer);
+	unsigned long missed;
+	__u64 ival;
+
+	tasklet_schedule(&speaker->tasklet);
+
+	ival = 1000000000ULL * 20U;
+	ival /= speaker->subs->runtime->rate;
+
+	missed = hrtimer_forward_now(timer, ns_to_ktime(ival));
+	if (missed > 1)
+		snd_printdd("wiimote: speaker: missed %lu timer interrupts\n",
+			    missed - 1);
+
+	return HRTIMER_RESTART;
+}
+
+/* PCM layer */
+
+static const struct snd_pcm_hardware wiimod_speaker_playback_hw = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_INTERLEAVED,
+	.formats = SNDRV_PCM_FMTBIT_S8,
+	.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min = 500,
+	.rate_max = 2000, /* TODO: >2000 only supported by 2nd gen */
+	.channels_min = 1,
+	.channels_max = 1,
+	.buffer_bytes_max = 32768,
+	.period_bytes_min = 128,
+	.period_bytes_max = 32768,
+	.periods_min = 1,
+	.periods_max = 1024,
+};
+
+static int wiimod_speaker_playback_open(struct snd_pcm_substream *substream)
+{
+	struct wiimote_speaker *speaker = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long flags;
+	int ret;
+
+	runtime->hw = wiimod_speaker_playback_hw;
+
+	spin_lock_irqsave(&speaker->lock, flags);
+	ret = -ENODEV;
+	if (speaker->wdata) {
+		runtime->private_data = speaker->wdata;
+		ret = wiimod_speaker_enable(speaker);
+	}
+	spin_unlock_irqrestore(&speaker->lock, flags);
+
+	return ret;
+}
+
+static int wiimod_speaker_playback_close(struct snd_pcm_substream *substream)
+{
+	struct wiimote_speaker *speaker = snd_pcm_substream_chip(substream);
+	unsigned long flags;
+
+	spin_lock_irqsave(&speaker->lock, flags);
+	if (speaker->wdata)
+		wiimod_speaker_disable(speaker);
+	spin_unlock_irqrestore(&speaker->lock, flags);
+
+	hrtimer_cancel(&speaker->timer);
+	tasklet_kill(&speaker->tasklet);
+
+	return 0;
+}
+
+static int wiimod_speaker_playback_hw_params(struct snd_pcm_substream *subs,
+					     struct snd_pcm_hw_params *hw)
+{
+	return snd_pcm_lib_alloc_vmalloc_buffer(subs, params_buffer_bytes(hw));
+}
+
+static int wiimod_speaker_playback_hw_free(struct snd_pcm_substream *subs)
+{
+	return snd_pcm_lib_free_vmalloc_buffer(subs);
+}
+
+static int wiimod_speaker_playback_prepare(struct snd_pcm_substream *subs)
+{
+	struct wiimote_speaker *speaker = snd_pcm_substream_chip(subs);
+	struct wiimote_data *wdata;
+	struct snd_pcm_runtime *runtime = subs->runtime;
+	int ret, online;
+	unsigned long flags;
+
+	/* runlock synchronizes with device hotplugging */
+	mutex_lock(&speaker->runlock);
+
+	spin_lock_irqsave(&speaker->lock, flags);
+	wdata = speaker->wdata;
+	online = speaker->online;
+	spin_unlock_irqrestore(&speaker->lock, flags);
+
+	if (!wdata || !online) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	speaker->pos = 0;
+	speaker->subs = subs;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	/* Perform speaker setup. This may take a few milliseconds and the
+	 * handlers perform synchronous network operations so this
+	 * may sleep. */
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S8:
+		ret = wiimod_speaker_setup(speaker, WIIMOD_SPEAKER_MODE_PCM8,
+					   runtime->rate, -1);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+unlock:
+	mutex_unlock(&speaker->runlock);
+	return ret;
+}
+
+static int wiimod_speaker_playback_trigger(struct snd_pcm_substream *subs,
+					   int cmd)
+{
+	struct wiimote_speaker *speaker = snd_pcm_substream_chip(subs);
+	struct snd_pcm_runtime *runtime = subs->runtime;
+	struct wiimote_data *wdata;
+	unsigned long flags;
+	__u64 ival;
+
+	spin_lock_irqsave(&speaker->lock, flags);
+
+	wdata = speaker->wdata;
+	if (!wdata || !speaker->online)
+		goto unlock;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* unmute device on start if not muted by user-space */
+		spin_lock(&wdata->state.lock);
+		if (!speaker->mute)
+			wiiproto_req_mute(wdata, false);
+		spin_unlock(&wdata->state.lock);
+
+		ival = 20U * 1000000000ULL / runtime->rate;
+		hrtimer_start(&speaker->timer, ktime_set(0, ival),
+			      HRTIMER_MODE_REL);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* mute device when stopping transmission */
+		spin_lock(&wdata->state.lock);
+		wiiproto_req_mute(wdata, true);
+		spin_unlock(&wdata->state.lock);
+
+		hrtimer_cancel(&speaker->timer);
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* unmute device on start if not muted by user-space */
+		spin_lock(&wdata->state.lock);
+		if (!speaker->mute)
+			wiiproto_req_mute(wdata, false);
+		spin_unlock(&wdata->state.lock);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		/* mute device when stopping transmission */
+		spin_lock(&wdata->state.lock);
+		wiiproto_req_mute(wdata, true);
+		spin_unlock(&wdata->state.lock);
+		break;
+	}
+
+unlock:
+	spin_unlock_irqrestore(&speaker->lock, flags);
+	return 0;
+}
+
+static snd_pcm_uframes_t wiimod_speaker_playback_pointer(struct snd_pcm_substream *subs)
+{
+	struct wiimote_speaker *speaker = snd_pcm_substream_chip(subs);
+
+	return bytes_to_frames(subs->runtime, speaker->pos);
+}
+
+static struct snd_pcm_ops wiimod_speaker_playback_ops = {
+	.open		= wiimod_speaker_playback_open,
+	.close		= wiimod_speaker_playback_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= wiimod_speaker_playback_hw_params,
+	.hw_free	= wiimod_speaker_playback_hw_free,
+	.prepare	= wiimod_speaker_playback_prepare,
+	.trigger	= wiimod_speaker_playback_trigger,
+	.pointer	= wiimod_speaker_playback_pointer,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+	.mmap		= snd_pcm_lib_mmap_vmalloc,
+};
+
+/* volume control */
+
+static int wiimod_speaker_volume_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *info)
+{
+	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	info->count = 1;
+	info->value.integer.min = 0;
+	info->value.integer.max = 0xff;
+
+	return 0;
+}
+
+static int wiimod_speaker_volume_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *val)
+{
+	struct wiimote_speaker *speaker = snd_kcontrol_chip(kcontrol);
+
+	val->value.integer.value[0] = speaker->volume;
+
+	return 0;
+}
+
+static int wiimod_speaker_volume_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *val)
+{
+	struct wiimote_speaker *speaker = snd_kcontrol_chip(kcontrol);
+	unsigned long value, flags;
+
+	value = val->value.integer.value[0];
+	if (value > 0xff)
+		value = 0xff;
+
+	spin_lock_irqsave(&speaker->lock, flags);
+	if (speaker->wdata)
+		wiimod_speaker_set_volume(speaker, value);
+	spin_unlock_irqrestore(&speaker->lock, flags);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new wiimod_speaker_volume = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Playback Volume",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = wiimod_speaker_volume_info,
+	.get = wiimod_speaker_volume_get,
+	.put = wiimod_speaker_volume_put,
+};
+
+/* mute control */
+
+static int wiimod_speaker_mute_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *val)
+{
+	struct wiimote_speaker *speaker = snd_kcontrol_chip(kcontrol);
+
+	val->value.integer.value[0] = !speaker->mute;
+
+	return 0;
+}
+
+static int wiimod_speaker_mute_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *val)
+{
+	struct wiimote_speaker *speaker = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&speaker->lock, flags);
+	if (speaker->wdata)
+		wiimod_speaker_set_mute(speaker,
+					!val->value.integer.value[0]);
+	spin_unlock_irqrestore(&speaker->lock, flags);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new wiimod_speaker_mute = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Playback Switch",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = snd_ctl_boolean_mono_info,
+	.get = wiimod_speaker_mute_get,
+	.put = wiimod_speaker_mute_put,
+};
+
+/* initialization and setup */
+
+static int wiimod_speaker_probe(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	int ret;
+	struct wiimote_speaker *speaker;
+	struct snd_card *card;
+	struct snd_kcontrol *kcontrol;
+	struct snd_pcm *pcm;
+
+	/* create sound card device */
+	ret = snd_card_create(-1, NULL, THIS_MODULE,
+			      sizeof(struct wiimote_speaker), &card);
+	if (ret)
+		return ret;
+	speaker = card->private_data;
+
+	wdata->speaker = speaker;
+	speaker->wdata = wdata;
+	speaker->card = card;
+	speaker->mute = 1;
+	speaker->volume = 0xff;
+	strcpy(card->driver, "hid-wiimote");
+	strcpy(card->shortname, "wiimote");
+	strcpy(card->longname, "Nintendo Wii Remote speaker");
+
+	spin_lock_init(&speaker->lock);
+	mutex_init(&speaker->runlock);
+	hrtimer_init(&speaker->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	speaker->timer.function = wiimod_speaker_tick;
+	tasklet_init(&speaker->tasklet, wiimod_speaker_task,
+		     (unsigned long)speaker);
+
+	/* create volume control */
+	kcontrol = snd_ctl_new1(&wiimod_speaker_volume, speaker);
+	if (!kcontrol) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	ret = snd_ctl_add(card, kcontrol);
+	if (ret) {
+		snd_ctl_free_one(kcontrol);
+		goto err_free;
+	}
+
+	/* create mute control */
+	kcontrol = snd_ctl_new1(&wiimod_speaker_mute, speaker);
+	if (!kcontrol) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	ret = snd_ctl_add(card, kcontrol);
+	if (ret) {
+		snd_ctl_free_one(kcontrol);
+		goto err_free;
+	}
+
+	/* create PCM sub-device for playback */
+	ret = snd_pcm_new(card, "Speaker", 0, 1, 0, &pcm);
+	if (ret)
+		goto err_free;
+
+	pcm->private_data = speaker;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&wiimod_speaker_playback_ops);
+
+	/* register sound card */
+	snd_card_set_dev(card, &wdata->hdev->dev);
+	ret = snd_card_register(card);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	snd_card_free(card);
+	wdata->speaker = NULL;
+	return ret;
+}
+
+static void wiimod_speaker_remove(const struct wiimod_ops *ops,
+				  struct wiimote_data *wdata)
+{
+	struct wiimote_speaker *speaker = wdata->speaker;
+	unsigned long flags;
+
+	if (!speaker)
+		return;
+
+	mutex_lock(&speaker->runlock);
+	spin_lock_irqsave(&speaker->lock, flags);
+
+	wdata->speaker = NULL;
+	speaker->online = 0;
+	speaker->wdata = NULL;
+
+	spin_lock(&wdata->state.lock);
+	wiiproto_req_mute(wdata, true);
+	wiiproto_req_speaker(wdata, false);
+	spin_unlock(&wdata->state.lock);
+
+	spin_unlock_irqrestore(&speaker->lock, flags);
+	mutex_unlock(&speaker->runlock);
+
+	hrtimer_cancel(&speaker->timer);
+	tasklet_kill(&speaker->tasklet);
+	snd_card_free_when_closed(speaker->card);
+}
+
+const struct wiimod_ops wiimod_speaker = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_speaker_probe,
+	.remove = wiimod_speaker_remove,
+};
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index f1474f3..63a9244 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -147,6 +147,7 @@ struct wiimote_data {
 	struct input_dev *mp;
 	struct timer_list timer;
 	struct wiimote_debug *debug;
+	struct wiimote_speaker *speaker;
 
 	union {
 		struct input_dev *input;
@@ -171,6 +172,7 @@ enum wiimod_module {
 	WIIMOD_IR,
 	WIIMOD_BUILTIN_MP,
 	WIIMOD_NO_MP,
+	WIIMOD_SPEAKER,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
@@ -207,9 +209,12 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
 	WIIPROTO_REQ_IR1 = 0x13,
+	WIIPROTO_REQ_SPEAKER = 0x14,
 	WIIPROTO_REQ_SREQ = 0x15,
 	WIIPROTO_REQ_WMEM = 0x16,
 	WIIPROTO_REQ_RMEM = 0x17,
+	WIIPROTO_REQ_AUDIO = 0x18,
+	WIIPROTO_REQ_MUTE = 0x19,
 	WIIPROTO_REQ_IR2 = 0x1a,
 	WIIPROTO_REQ_STATUS = 0x20,
 	WIIPROTO_REQ_DATA = 0x21,
@@ -263,6 +268,12 @@ extern void wiiproto_req_status(struct wiimote_data *wdata);
 extern void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel);
 extern void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags);
 extern void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags);
+extern void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
+			      __u32 offset, const __u8 *buf, __u8 size);
+extern void wiiproto_req_speaker(struct wiimote_data *wdata, bool on);
+extern void wiiproto_req_mute(struct wiimote_data *wdata, bool on);
+extern size_t wiiproto_req_audio(struct wiimote_data *wdata, const __u8 *b1,
+				 size_t len1, const __u8 *b2, size_t len2);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
@@ -287,6 +298,12 @@ static inline void wiidebug_deinit(void *u) { }
 
 #endif
 
+#ifdef CONFIG_SND
+
+extern const struct wiimod_ops wiimod_speaker;
+
+#endif
+
 /* requires the state.lock spinlock to be held */
 static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
 								__u32 opt)
-- 
1.8.2.2

