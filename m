Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985454EE84B
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538971; cv=none; b=Pp1jQQ3fM37DDJM9AO88V0P0Jv7GTYrGl7Qbw0nhnkMMk0bK+Q0MkKrDA0TnXqNUfYr7jwvjTVfspRGOIzJhC1+VgOOAHY7SWltLanY68SOdD02ZEB0LMD/1+DG0HdGNvVFc4Mw9te55/sTom4DADLOESUQV4xkYqGRWgt+09MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538971; c=relaxed/simple;
	bh=2t9+xjrvFNR1G1fZUT4v3+AeFA4hoqEgo9ZBHKJKfLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YShHVj+C15gvyZSH6pm6kYichFydvy6ekjXnXL1ItquyQc23nBUCr3gZGYen/eNVeRqsyQEwSqaS+dK8k5k64KGWtvnzfnddWSr0BWDPbmJXZhnGbCsIQ5oYPE6duaB9k+EDxPly3nXKQrL40w0juBGmi0wt+tP9zG++zvkogO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CazJ4t4F; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CazJ4t4F"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b6188a2c0eso797560e87.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788538963; x=1789143763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBGRb5fe7kyS/Xr9xrztI/Qk2Ee18TsW6P+3sw25/iU=;
        b=CazJ4t4FAA0nAi00sAdN16gVhBy7bbnj1SOzDmlDgk646bW6rCvttHMQ64NSs5sbXu
         LdwkFk1969Ct26E3Fro+lT2a/7NGn7iTlleeHOvi35hHMMca58eKyJFc4qV/LJ4+sZ7m
         /sFIwiZ5sQTujtjrWfGVnoMi2IWZzlqMxBJpaxyu1bk8HNFhNzWlaXeKqXvzx0HfVCe/
         EapOIx8Kx4RRk8TUwjnmpYlRRvP0T7RuljzMXDK32RH1Jen1J0I0la8iELcSDLtdNXk5
         GaqYc05cmZFm4r41R4ITWDoFK2GkUDLY/sHI08/yAxzz3Ma70juf9Aqp1lhweRiABQ2F
         G9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538963; x=1789143763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBGRb5fe7kyS/Xr9xrztI/Qk2Ee18TsW6P+3sw25/iU=;
        b=hJNrTQj91/8rp9j4zduVUDM3/CEX+BdDMYMmIOTCmdfhWWMnamB8IVUKRF30Lv1UcU
         hEf5EP19W9i394e1mSmQQLvVqvoqImwMgUIp4CSXIsntsDxXBNcoJj/AsegJj2dOa8n8
         DI+9ykUUJNtmZr6IktJLbNQkfVTGyucVSrBCt55QaayY4Po+74Phzb1ciD/k3LGeyRCp
         o9qIb7cqXQjtdlkQoVESEqoUjBkB/AoJJCe+YSfwNH1beexUeZtCayxR9MU9B1ttz41O
         OWSQm6x8XvHXROJrMeZc1nY1iG/cQcaM7yYkfm77iYyqpFqgkcB/6GpC3G1mX8wXKcgU
         Xz9A==
X-Forwarded-Encrypted: i=1; AKwUvBw2n/8fK+S//HRiKPhpws6yWHeAnR98G1U8d0dgQd/oGZKV0JBKomHrl3jmlOJHlLZE9SA/YPoGWvY7oA==@vger.kernel.org
X-Gm-Message-State: AFuF++k6+pHOHQfeVYdgmco40m0jGxfh9Zn/sfT/qDVC/dOkN7LkEOsf
	mKWqKNRWQfkCWfvvLfzwiw3AVaZnVrsvOnjpwqjvnxiaL4KcsN//1B0C
X-Gm-Gg: AYBFou2H4pLaOLnIMbwDmp34qLy4Th+1JaFHkTx7S9ePfsL69iS8Ezz2067fHut8Dqy
	3F4Lg8IUOFg5xO0zt2Hf8syTFM7KJBsvGI0gioD9yehKunmDJcwzIiIie+WICzhyG+xkie2nmQa
	pmYap03Z6UyYjxq1sACeFS6H6EqhemmEbp98A7Myhu9NtujjRSghqnFIWhsZtxFiG6QoqL+B99T
	VI/EFk73Bvxy1FPUHWWPF9aHDrqacP2Rtxt+U+n8kqia6/oUxA6fpMYU02Z8zkx7SR1yyZyQb+l
	pNROZS9LUmIKt1BizlPJuZCqOTCWD6I0NXQ7z/kMMTh3hPHoDdJ5l/9Q5/RdQo2hSeK7PgXdaGa
	1zxqBxsWaG6eduRZg/uiEkBVvYKQHd+GtY53AIOrJl4170jjgIRtdGSGXHr88aQGeXL3H/25P0f
	xc5sugGRT9xoW3hxTAYB4rai8qQ3EJg0wN6EPnObtGSAt85MDucZmvoSNnaknUI1aWeM+aSqT5/
	1RlwO9fK0XkRx7q9XXv5cFAJIp5B7SkZfPo4mPemML1k58CjLFNAwRzZLjT
X-Received: by 2002:a05:6512:3b87:b0:5b6:1a7c:fd90 with SMTP id 2adb3069b0e04-5b61a7cfdc4mr873494e87.54.1788538962878;
        Fri, 04 Sep 2026 09:22:42 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b667b6c30fsm281370e87.9.2026.09.04.09.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:22:42 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [RFC PATCH v5 2/2] ALSA: usb-audio: bind the Topping M62's vendor controls
Date: Fri,  4 Sep 2026 21:22:36 +0500
Message-ID: <20260904162236.3212370-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904162236.3212370-1-mikhail.v.gavrilov@gmail.com>
References: <20260904153051.1785280-1-mikhail.v.gavrilov@gmail.com>
 <20260904162236.3212370-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M62's vendor controls are driven by hid-topping-m62, added in the
previous patch, which speaks a vendor protocol on the card's HID
interface. Those controls belong on the sound card that plays the
audio, not on a card of the HID driver's own.

This adds the other half of that: a component master, registered from
the M62's mixer quirk, which hands its struct snd_card to the HID
driver at bind time and takes the controls away again at unbind. The
lifetime rules are the component framework's, which is the point --
neither driver has to be told about the other's disconnect, and neither
has to guess at the other's state. The same shape binds HD-audio to the
graphics drivers in sound/hda/core/component.c, with sound as the
master there too.

The master's context lives in devres on the audio control interface
rather than in drvdata, which on a usb_interface belongs to
snd-usb-audio itself; devres_find(), keyed on the release function,
gives it back inside the callbacks, which are handed nothing but a
struct device *. It hangs off the control interface rather than off the
USB device because component_match_add() allocates the match list with
devm: on the interface that is released at unbind, while on the
usb_device it would live until the device itself was released and a
rebind would stack a second list on top.

Neither component_compare_dev() nor component_compare_dev_name() fits:
the audio side has no pointer to the HID device, and the HID device's
name carries an instance counter that is not predictable. The match is
therefore one of descent -- the HID device sits two levels below the
USB device -- and which interface it is stays the HID driver's
business, since it registers a component for the vendor interface and
for no other. That keeps sound/usb free of HID symbols and of any
opinion about this card's interface numbering.

component_master_add_with_match() returns 0 with the aggregate merely
pending when the HID driver is absent, so the card comes up either way
and grows the vendor controls if and when the other half appears.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 MAINTAINERS               |   9 ++
 sound/usb/Makefile        |   1 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 227 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 ++
 5 files changed, 249 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 627595e245f3..b49560efa1c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27593,6 +27593,15 @@ S:	Maintained
 W:	https://tomoyo.sourceforge.net/
 F:	security/tomoyo/
 
+TOPPING M62 VENDOR CONTROLS
+M:	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+L:	linux-sound@vger.kernel.org
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-topping-m62.c
+F:	sound/usb/mixer_topping.c
+F:	sound/usb/mixer_topping.h
+
 TOPSTAR LAPTOP EXTRAS DRIVER
 M:	Herton Ronaldo Krzesinski <herton@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index e62794a87e73..151b481df795 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -14,6 +14,7 @@ snd-usb-audio-y := 	card.o \
 			mixer_quirks.o \
 			mixer_scarlett.o \
 			mixer_scarlett2.o \
+			mixer_topping.o \
 			mixer_us16x08.o \
 			mixer_s1810c.o \
 			pcm.o \
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a1f5592cc5d5..10f33026cdff 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -36,6 +36,7 @@
 #include "mixer_quirks.h"
 #include "mixer_scarlett.h"
 #include "mixer_scarlett2.h"
+#include "mixer_topping.h"
 #include "mixer_us16x08.h"
 #include "mixer_s1810c.h"
 #include "helper.h"
@@ -4531,6 +4532,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_fcp_init(mixer);
 		break;
 
+	case USB_ID(0x152a, 0x875c): /* Topping M62 */
+		err = snd_topping_init(mixer);
+		break;
+
 	case USB_ID(0x041e, 0x323b): /* Creative Sound Blaster E1 */
 		err = snd_soundblaster_e1_switch_create(mixer);
 		break;
diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
new file mode 100644
index 000000000000..722f98f97d0b
--- /dev/null
+++ b/sound/usb/mixer_topping.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Topping M62 -- component master for the card's vendor controls.
+ *
+ * The M62's analogue gains, output volumes and source selectors are not
+ * described by the USB Audio Class.  They are reached over a vendor
+ * protocol on the card's HID interface, which hid-topping-m62 speaks.
+ *
+ * This file speaks none of that protocol.  It publishes the sound card to
+ * whoever drives the vendor interface, so that the controls are created on
+ * the card that plays the audio rather than on a card of their own, and are
+ * torn down when either side goes away.  The lifetime rules are the
+ * component framework's, which is the point: neither driver has to guess at
+ * the other's state, and neither has to be told about the other's
+ * disconnect.
+ *
+ * The same shape binds HD-audio to the graphics drivers in
+ * sound/hda/core/component.c, with sound as the master there too.
+ */
+
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/usb.h>
+
+#include <sound/core.h>
+
+#include "usbaudio.h"
+#include "mixer.h"
+#include "helper.h"
+#include "mixer_topping.h"
+
+/*
+ * What the master hands the component at bind time.  It lives in devres on
+ * the audio control interface rather than in drvdata, because drvdata on a
+ * usb_interface belongs to snd-usb-audio itself.  devres_find(), keyed on
+ * the release function, gives it back inside the callbacks, which are
+ * handed nothing but a struct device *.
+ */
+struct topping_master {
+	struct device *dev;		/* the audio control interface */
+	struct snd_card *card;
+	struct usb_mixer_interface *mixer;
+};
+
+static void topping_master_release(struct device *dev, void *res)
+{
+	/*
+	 * Storage only.  Taking the master down is a separate devres
+	 * action registered after the match array, so that it runs
+	 * before it -- see topping_master_teardown() below.
+	 */
+}
+
+static struct topping_master *topping_get_master(struct device *dev)
+{
+	return devres_find(dev, topping_master_release, NULL, NULL);
+}
+
+/*
+ * Which of the registered components is ours.
+ *
+ * This is only ever called against devices that have registered with
+ * component_add(), so it does not have to defend itself against the whole
+ * device tree.  What it does have to do is tell this card's vendor
+ * function apart from a second M62 on another port.
+ *
+ * The HID device sits two levels below the USB device:
+ *
+ *	hid_device  ->  usb_interface  ->  usb_device
+ *
+ * WHICH interface it is, is the HID driver's business: it registers a
+ * component for the vendor interface and for nothing else.  So the test
+ * here is one of descent alone and needs no HID symbols in sound/usb --
+ * which also keeps this file free of any opinion about the M62's
+ * interface numbering.
+ */
+static int topping_match_component(struct device *dev, void *data)
+{
+	return dev->parent && dev->parent->parent == data;
+}
+
+static int topping_master_bind(struct device *dev)
+{
+	struct topping_master *tm = topping_get_master(dev);
+
+	if (WARN_ON(!tm))
+		return -EINVAL;
+
+	return component_bind_all(dev, tm->card);
+}
+
+/*
+ * No topping_get_master() here, deliberately.  This can run while the
+ * interface's devres is unwinding, and devres_release_all() moves every
+ * node off the device before it calls a single release, so the lookup
+ * would come back empty and the unbind would be skipped altogether.
+ *
+ * The component does not need the card from us in any case: it kept the
+ * one it was handed at bind, and takes its controls off that.
+ */
+static void topping_master_unbind(struct device *dev)
+{
+	component_unbind_all(dev, NULL);
+}
+
+static const struct component_master_ops topping_master_ops = {
+	.bind	= topping_master_bind,
+	.unbind	= topping_master_unbind,
+};
+
+/*
+ * Registered as a devres action AFTER component_match_add(), because
+ * devres unwinds in reverse: this then runs before the match array is
+ * freed, and component_unbind_all() walks that array.
+ *
+ * Two roads reach it.  Normally topping_private_free() calls it through
+ * devm_release_action().  The other is a probe that got as far as
+ * creating this mixer and then failed: usb_audio_probe() leaves the
+ * card and its mixer list alone in that case, as long as an earlier
+ * interface had succeeded, so the mixer would outlive the interface
+ * whose devres this is.  Unhooking it here is what keeps a later
+ * disconnect from reaching freed storage.
+ */
+static void topping_master_teardown(void *data)
+{
+	struct topping_master *tm = data;
+
+	component_master_del(tm->dev, &topping_master_ops);
+
+	if (tm->mixer) {
+		tm->mixer->private_data = NULL;
+		tm->mixer->private_free = NULL;
+	}
+}
+
+static void topping_private_free(struct usb_mixer_interface *mixer)
+{
+	struct topping_master *tm = mixer->private_data;
+
+	if (!tm)
+		return;
+
+	/*
+	 * Reached from snd_usb_mixer_disconnect(), on an unplug and on an
+	 * unbind of the audio interface alike.  The action clears
+	 * mixer->private_data on its way through, so nothing is left
+	 * pointing at the storage dropped below.
+	 */
+	devm_release_action(tm->dev, topping_master_teardown, tm);
+	devres_destroy(tm->dev, topping_master_release, NULL, NULL);
+}
+
+int snd_topping_init(struct usb_mixer_interface *mixer)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	struct component_match *match = NULL;
+	struct usb_interface *intf;
+	struct topping_master *tm;
+	struct device *dev;
+	int err;
+
+	/*
+	 * The master hangs off the audio control interface rather than off
+	 * the USB device: component_match_add() allocates the match list
+	 * with devm, and on an interface that is released when the interface
+	 * is unbound.  On the usb_device it would live until the device
+	 * itself was released, and a rebind would stack a second list on top
+	 * of the first.
+	 */
+	intf = usb_ifnum_to_if(chip->dev,
+			       get_iface_desc(mixer->hostif)->bInterfaceNumber);
+	if (!intf)
+		return -ENODEV;
+	dev = &intf->dev;
+
+	tm = devres_alloc(topping_master_release, sizeof(*tm), GFP_KERNEL);
+	if (!tm)
+		return -ENOMEM;
+	tm->dev = dev;
+	tm->card = chip->card;
+	tm->mixer = mixer;
+	devres_add(dev, tm);
+
+	mixer->private_data = tm;
+	mixer->private_free = topping_private_free;
+
+	component_match_add(dev, &match, topping_match_component,
+			    &chip->dev->dev);
+
+	/*
+	 * component_match_add() reports a failed allocation by storing
+	 * an error pointer rather than by returning, and
+	 * component_master_add_with_match() dereferences what it is
+	 * given without looking.
+	 */
+	if (IS_ERR(match)) {
+		err = PTR_ERR(match);
+		goto err_free;
+	}
+
+	/*
+	 * This returns 0 with the aggregate merely pending when
+	 * hid-topping-m62 has not registered its component yet:
+	 * try_to_bring_up_aggregate_device() reports an incomplete set as
+	 * "not ready", not as an error.  So the card comes up either way and
+	 * grows the vendor controls if and when the other half appears.
+	 */
+	err = component_master_add_with_match(dev, &topping_master_ops, match);
+	if (err < 0)
+		goto err_free;
+
+	/* Last, so that devres releases it first -- see the teardown. */
+	err = devm_add_action(dev, topping_master_teardown, tm);
+	if (err < 0) {
+		component_master_del(dev, &topping_master_ops);
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	mixer->private_data = NULL;
+	mixer->private_free = NULL;
+	devres_destroy(dev, topping_master_release, NULL, NULL);
+	usb_audio_err(chip, "Topping: no component master: %d\n", err);
+	return err;
+}
diff --git a/sound/usb/mixer_topping.h b/sound/usb/mixer_topping.h
new file mode 100644
index 000000000000..15e16b509eb9
--- /dev/null
+++ b/sound/usb/mixer_topping.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __USB_MIXER_TOPPING_H
+#define __USB_MIXER_TOPPING_H
+
+int snd_topping_init(struct usb_mixer_interface *mixer);
+
+#endif /* __USB_MIXER_TOPPING_H */
-- 
2.55.0

