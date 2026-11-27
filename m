Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795765133;
	b=XIrbhynUiElyl7G9rvuaaco3p8GGTEi8gwIRPg83LThqdVK3RaZfwU5aB4ElRbHq3CdA
	 VXnrTdl2dw05WwaTtRhWa8AWeHk+ykR6GhNpKcmHGHI//BhGsOcZi6StvKa/egf3S4R/z
	 /T9rqSZ0m4mXbmUXF8ZK5w0Aq2LwOWYcb5o8XnLUMLMsGjCJSKQxr98sza8nEQRsbJ4QS
	 F5oUR9LAVH4PJXTQGYu3Opw490ItEXvYNvPNo6t3XJqe1sBQLrrx7bzEb/NRL9CHbEgu+
	 UUWHDIGr3M90bkzqAmEBBIP063tolYj6g+14T2l2RiRjgloMyIyV6Ze4pmHHxzrfEuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765133;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l0A2sV0i7kZaoWttRyVsM/rsQvcwdxxyioepyO/7+xc=;
	b=dk1Vn1o+pkVox5Xk6MhvLSFeHXcUHUCWU1b2KkIYe7fvJjWkg0EkV9IW+8OQVAugqPJk
	 WkGdJDw3Ys1oEh7dd9jE2hfiHQLA+a7rez+Jr4N3x1P3UlBZbWYaQxVLhYJMUQCRNe/t5
	 ODQjmK9THX2KaaOBLl8W7x7+V8C6BssdDN+Vd+jUvoO/7/bHnXmMvFz82pWM7HJE6Af9L
	 wbszBkeyPH7kMPuzU0ScNMWyd4Ig1xbd8Of/D042ahXqa7p0ZZmgSdNOKvpXd3sGW5rcH
	 iWzdkDdStXKZW9nXB3V2zlbq++vbpCO5vov0y7adoHiI323+wOSKsNFv0W2m1HdVgXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaJtajvc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F4606A333;
	Fri, 27 Nov 2026 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaJtajvc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795765133;
	b=cW0W7EeLKN29pHGgHCf9FZqLjNbFu02q3pwPYyswK86cvr7o8J6L3vjXeSJY4Sz1Y1vs
	 Fp1IeySkxcttMc+cKkq8GD9y0ibA8IVQHxFnfN6RrwT7mX2kpp+EIxYSsBTBJVWP6emgp
	 JWgNDjgJqZvyG+5GRd8uSzlKLvaT8mOZ/70ZbKzODMKwerfz91G3hU8YJ26TK65ytzNgS
	 4vx3D+6PVEAQc9N9MUgbuT3ZD9nSoX8sMMEV20hrAruqcud0kOYLyGiUoAskkmjBwISyS
	 kIYfgAvOVYV/RbkmXzZ648cDIBuoU/DbQz91DLTN7R2EGFAqlA1ZdHp8IOSHs/wuhJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795765133;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l0A2sV0i7kZaoWttRyVsM/rsQvcwdxxyioepyO/7+xc=;
	b=zAVJPKHsI3nHyPSRWKfyqql2RdxE0U5urD+N/HSKWGvrVQa4rgO8dvs85U5HTjR5Bhvx
	 Ek9xHx9PlIuOiEJ38dxumq1jO6mXuWOxt/3g8tFQXXcZYP/ZthPk9hRgqeN6QZpC5j3Ch
	 58BIo0luk8oJcNYigN1IEGozpSzldZvXQv6xoDTg0P7MKn7e6FnwN2Fjajn2FDFirz5nD
	 Fd8/RX4tI4MaBtHA75EMWX2yo+6Sej4DVNbSyC+AEjrREwHeBU5SdSSJakUZyJe6HRj4j
	 tbGQs3s2DBprjDAOOrejVumiIq4YRYKVLk20aOWDKkN0LfJR3XcP8Qs5216I8vNjgbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B98FA1F0089B;
	Fri, 27 Nov 2026 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795765133;
	bh=l0A2sV0i7kZaoWttRyVsM/rsQvcwdxxyioepyO/7+xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IaJtajvcvu45WlbcbiXxIqbyMCCca+OtLpHgzDdtH6DssQLxWm3CprwwVH8Vb9w8Q
	 YtVSUNgkuWVQnj7J8IHJI/4ou3JZ2BP5T0/SJXjsK78DkfYFFPgXhfNx/5gKpifl7/
	 pI7nB9YuKreNj47/HgPGs15kST6UcTk5WFRl7gX0qVrHvKQ5prt6O2EI6Cz3J36wQr
	 1gcKXN2xrumRUWOsYF/Mpx+sqzehb8T6rY5KFkc5s0FFJw8yF2PVZMoMPuYPn/7yA7
	 +juojVl0S6e8OPWha9REPVs9ez9o6FrWI/VkN8YV/ntFnwe8HGTEtl2OwiW9tih1yy
	 NnEglwOjAxvaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 444164B619;
	Fri, 27 Nov 2026 07:38:42 +0000 (UTC)
From: Andrei Aleksandrov via B4 Relay <devnull+aladex.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 08:38:43 +0100
Subject: [PATCH RFC v2 2/2] ALSA: usb-audio: Handle the EPOS GSX 1000 v2
 volume ring in the driver
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-gsx1000-v2-2-0a0f20f1a2da@gmail.com>
References: <20261127-gsx1000-v2-0-0a0f20f1a2da@gmail.com>
In-Reply-To: <20261127-gsx1000-v2-0-0a0f20f1a2da@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrei Aleksandrov <aladex@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795765121; l=7745;
 i=aladex@gmail.com; s=20261127; h=from:subject:message-id;
 bh=LKmyIFGQs/e6UdYS47l4eBiS1d+lPwIJQts+XxND7RI=;
 b=+0zwVrakw4os5Q25GpHDb8/qkLT3EXhcm5EyoYBXEjrh9B1h3y9Otq7qEjK/+2C/WLMhfREmb
 5nPSPF8bRlxCyn9ol7XkJ46f/wGhpwjZ1IT4+7q4MPjV8geLs6AW5w+
X-Developer-Key: i=aladex@gmail.com; a=ed25519;
 pk=BRFQEVGQ1X027TItMW+SIsAtbYscopzlk1EJT8Girkg=
X-Endpoint-Received: by B4 Relay for aladex@gmail.com/20261127 with
 auth_id=1663
X-Original-From: Andrei Aleksandrov <aladex@gmail.com>
Reply-To: aladex@gmail.com
Content-Transfer-Encoding: 7bit

From: Andrei Aleksandrov <aladex@gmail.com>

The volume ring of the GSX 1000 v2 is an encoder that does not report
its direction. The device sends HID Vol+/Vol- (consumer usages 0xe9 and
0xea, report 2 on interface 5) until the volume the host writes to FU 12
matches the ring position, one event per detent. Windows answers every
event with a 2 % step on its volume scale; the device compares the
written value with 1/256 dB precision and stops asking once it matches.

On Linux these events reach the desktop as global KEY_VOLUMEUP and
KEY_VOLUMEDOWN, the desktop applies its own step size (5 % by default in
KDE), the result does not match the ring, and the device keeps
correcting: the volume oscillates or runs away. Existing workarounds
remap the keys to "reserved" in hwdb, which disables the ring.

Register an input handler that filters KEY_VOLUMEUP/KEY_VOLUMEDOWN only
from input devices whose parent is this USB device, so another keyboard
or another GSX is not affected. Each press steps the control added in the
previous patch by 2, as Windows does, and notifies user space; the
device then sees the expected value and the ring, the desktop volume and
the display stay in sync. The step runs in a work item because the
filter is called in atomic context and the USB write sleeps.

Tested with a GSX 1000 v2 (firmware 2.13) on PipeWire/KDE: slow and fast
turns in both directions, 0 -> 100 % by the ring, slider changes,
unplug/replug and suspend/resume (the desktop volume is restored on the
device).
usbmon shows one SET_CUR pair per detent and no reversals, as in the
Windows captures.

Link: https://github.com/Aladex/epos-gsx
Signed-off-by: Andrei Aleksandrov <aladex@gmail.com>
---
 sound/usb/mixer_quirks.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 50d640844003..94ebd34ed128 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4689,10 +4689,17 @@ static const s16 snd_gsx1000_vol_table[SND_GSX1000_VOL_STEPS + 1] = {
 	0,
 };
 
+#define SND_GSX1000_RING_STEP	2	/* one ring detent, as on Windows */
+
 struct snd_gsx1000_vol {
 	struct usb_mixer_elem_list list;	/* kctl private data */
 	struct mutex lock;			/* serializes value and USB writes */
 	unsigned int value;			/* 0..SND_GSX1000_VOL_STEPS */
+	struct work_struct ring_work;
+	atomic_t ring_delta;
+	struct input_handler ih;
+	struct input_device_id id_table[2];
+	bool ih_registered;
 };
 
 #define to_gsx1000_vol(l)	container_of(l, struct snd_gsx1000_vol, list)
@@ -4807,10 +4814,151 @@ static const struct snd_kcontrol_new snd_gsx1000_vol_control = {
 	.put = snd_gsx1000_vol_put,
 };
 
+/*
+ * The ring keeps sending Vol+/Vol- until the host volume matches the ring
+ * position, one detent per event.  Answer these requests here instead of
+ * passing them on as global volume keys, so the desktop does not apply its
+ * own step size to them and only this card is affected.
+ */
+static void snd_gsx1000_ring_work(struct work_struct *work)
+{
+	struct snd_gsx1000_vol *vol =
+		container_of(work, struct snd_gsx1000_vol, ring_work);
+	int delta = atomic_xchg(&vol->ring_delta, 0);
+	int value, changed;
+
+	if (!delta)
+		return;
+
+	CLASS(snd_usb_lock, pm)(vol->list.mixer->chip);
+	if (pm.err < 0)
+		return;
+
+	scoped_guard(mutex, &vol->lock) {
+		value = clamp_t(int, vol->value + delta * SND_GSX1000_RING_STEP,
+				0, SND_GSX1000_VOL_STEPS);
+		changed = __snd_gsx1000_vol_set(vol, value);
+	}
+	if (changed > 0)
+		snd_ctl_notify(vol->list.mixer->chip->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE, &vol->list.kctl->id);
+}
+
+#if IS_REACHABLE(CONFIG_INPUT)
+static bool snd_gsx1000_ih_filter(struct input_handle *handle,
+				  unsigned int type, unsigned int code,
+				  int value)
+{
+	struct snd_gsx1000_vol *vol =
+		container_of(handle->handler, struct snd_gsx1000_vol, ih);
+
+	if (type != EV_KEY ||
+	    (code != KEY_VOLUMEUP && code != KEY_VOLUMEDOWN))
+		return false;
+
+	/* Act on presses only; swallow releases and repeats as well */
+	if (value == 1) {
+		atomic_add(code == KEY_VOLUMEUP ? 1 : -1, &vol->ring_delta);
+		schedule_work(&vol->ring_work);
+	}
+	return true;
+}
+
+static bool snd_gsx1000_ih_match(struct input_handler *handler,
+				 struct input_dev *dev)
+{
+	struct snd_gsx1000_vol *vol =
+		container_of(handler, struct snd_gsx1000_vol, ih);
+	struct usb_device *snd_dev = vol->list.mixer->chip->dev;
+	struct device *parent;
+
+	/* Only the HID interface of this very card, not an identical one */
+	for (parent = dev->dev.parent; parent; parent = parent->parent) {
+		if (parent == &snd_dev->dev)
+			return true;
+	}
+	return false;
+}
+
+static int snd_gsx1000_ih_connect(struct input_handler *handler,
+				  struct input_dev *dev,
+				  const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int err;
+
+	handle = kzalloc_obj(*handle);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = handler->name;
+
+	err = input_register_handle(handle);
+	if (err)
+		goto err_free;
+
+	err = input_open_device(handle);
+	if (err)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	input_unregister_handle(handle);
+err_free:
+	kfree(handle);
+	return err;
+}
+
+static void snd_gsx1000_ih_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static void snd_gsx1000_ih_register(struct snd_gsx1000_vol *vol)
+{
+	struct usb_mixer_interface *mixer = vol->list.mixer;
+	struct input_device_id *id = &vol->id_table[0];
+	int err;
+
+	id->flags = INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT |
+		    INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT;
+	id->vendor = USB_ID_VENDOR(mixer->chip->usb_id);
+	id->product = USB_ID_PRODUCT(mixer->chip->usb_id);
+	id->evbit[BIT_WORD(EV_KEY)] = BIT_MASK(EV_KEY);
+	id->keybit[BIT_WORD(KEY_VOLUMEUP)] = BIT_MASK(KEY_VOLUMEUP);
+
+	vol->ih.filter = snd_gsx1000_ih_filter;
+	vol->ih.match = snd_gsx1000_ih_match;
+	vol->ih.connect = snd_gsx1000_ih_connect;
+	vol->ih.disconnect = snd_gsx1000_ih_disconnect;
+	vol->ih.name = "snd-usb-gsx1000-ring";
+	vol->ih.id_table = vol->id_table;
+
+	err = input_register_handler(&vol->ih);
+	if (err)
+		usb_audio_warn(mixer->chip,
+			       "GSX 1000: cannot register ring handler: %d\n", err);
+	else
+		vol->ih_registered = true;
+}
+#else
+static void snd_gsx1000_ih_register(struct snd_gsx1000_vol *vol) {}
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 static void snd_gsx1000_vol_free(struct snd_kcontrol *kctl)
 {
 	struct snd_gsx1000_vol *vol = to_gsx1000_vol(snd_kcontrol_chip(kctl));
 
+#if IS_REACHABLE(CONFIG_INPUT)
+	if (vol->ih_registered)
+		input_unregister_handler(&vol->ih);
+#endif
+	cancel_work_sync(&vol->ring_work);
 	mutex_destroy(&vol->lock);
 	kfree(vol);
 	kctl->private_data = NULL;
@@ -4834,6 +4982,8 @@ static int snd_gsx1000_controls_create(struct usb_mixer_interface *mixer)
 	vol->list.resume = snd_gsx1000_vol_resume;
 	vol->value = SND_GSX1000_VOL_DEFAULT;
 	mutex_init(&vol->lock);
+	INIT_WORK(&vol->ring_work, snd_gsx1000_ring_work);
+	atomic_set(&vol->ring_delta, 0);
 
 	kctl = snd_ctl_new1(&snd_gsx1000_vol_control, &vol->list);
 	if (!kctl) {
@@ -4853,6 +5003,8 @@ static int snd_gsx1000_controls_create(struct usb_mixer_interface *mixer)
 	if (err < 0)
 		usb_audio_warn(mixer->chip,
 			       "GSX 1000: cannot set initial volume: %d\n", err);
+
+	snd_gsx1000_ih_register(vol);
 	return 0;
 }
 

-- 
2.56.1


