Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8359511E70
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541145; cv=none; b=JGffXZbdSqVKWRfKPdL5rFKqMOmYH4RMjj2twoYTgOif6/YQ8qO5GIvAVtnS/SYVl0h1rebe8x0NHa98gc4tEnJFWgxHfjtNCFqli14lBlFliCHjD8WixJ127yNCFK8devHGFkaHBqiZxSwugWKlxo3pzlUPNju9kgrc8d8y6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541145; c=relaxed/simple;
	bh=C8nI1S4EArsTz50FNz+moACNXSkTk+I4cLRsuAWn980=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2E9z1gjKa4TdCfGxNzCV14LzF9Pu1mUAcltp43HzqEOxgR97Mx56NBrbWgz4/Xx4jcTaCMJ1MI/AL81wfc7rA+Q5U6Xx4VAkemCjQVCzWF14g/LVead4bgslTEHcbsne46Kcjagt8jzhFhFGrE8r4CFqqthr0P9WwM8peDvKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFc7UuQl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFc7UuQl"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b01910b499so1201506e87.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788541140; x=1789145940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4Q6lM2s0+5TOA2O78Hq8ZNB27AK6DfwPSS+JBL2TsA=;
        b=VFc7UuQlYpObbpQ5eduTzgsan3fDwQ1S89dQi24sj5OEC50GZHNDJnikOQK4CQDjre
         iD//wohGFZngVQ7h1enTJSx/1tjvWptkLbNT6SHyshDzcw/5YOEksB67wXZeYvM4l/sd
         zG5TsqrSpARNwDjPFvr6cbTk00SS9bA5gd5pNlZFlp1djhKY2CFh5OdQCtIaueml0gP4
         gnMcmy8tx2aCemE7r9tqSDe5Oi3klQB7yeZHK9viFSiYB3z1lnabf5/8RhKpTC74PdFi
         XrFXFgd7CPKXFqwClujoNR4Aha98rIe9dvFkChkMqIN0mxSAZ6NXwrcLu/go4mI8tgSb
         NgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541140; x=1789145940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k4Q6lM2s0+5TOA2O78Hq8ZNB27AK6DfwPSS+JBL2TsA=;
        b=O/THUbnIDxeE/QTuY2bqyIWyzZruiyJQgZziEGebdpaDQSd3Qp2/TVaoTvPoe/hQYK
         CwA/CjY5CfHkSUAzuZFBeKqhCObIo9ph8nT78le+PopLkn6PnnT9kY41WDmoBSdvqwhu
         6+toltV674Cb9yWZyfsA52RIGHXD2PHFQWiy3zpKuUC5LL3oJUR+qC2LsolkqU76tpt7
         fRMbFP2EzdIT1TTaCMrgYGCXw6u+JtYdzHR8ILls9ivfaEVsb6Jkwl7ByQNHxQMXZDAp
         gY+DuCf8kYw/4LSvuEfnEnVHt3fJ0/M0jJgCDSTXscFMeWkNvVki3j0JtUkgwOZpsxP5
         O5Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxo78s7T5hUtvgEs58GAXl34H8fsyAgNb0m8QTa93cSAcQohI0yVR0PYNDnspADFzPLXbgSBGCaow/YZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lQiQ29epnaZJgFIYW21HV56o31u3h3ybznBp3bIuMBj0wub04s
	WvbwDsm1OTbBj5g5c2H1W8K4w1OFT7LUDmfxITTHfksmfSaGb9W7NAK7
X-Gm-Gg: AYBFou3vND1h9Ott+dfkA5CsCP/LCZvUZA0kUA5HFkuoxWWoCVazFtXRpTMW9V9Yod8
	i5C1dTKVfM6V+N3bSJX/PyyvP2GsL0wnycwp99WMCYcC34Jix/kj8ZYSU5K71rZZnKYxrKkuTL5
	Dt23M681cBOPn6b/cXZdIZ82bal+qO6PBp/2djrW3tt6Ju93gLZBjvrrTBIb9Fc2cG6sahYIFZ6
	qVX6JdXxpfq3UM6N2g9yOX/mZPR7M1sS1G/47u1c/UxDXNS+R3WH2FnwVo8jRPbbZGL2xOMgFrk
	J855qn+sNH/Hru76EkPEKNp64JLw/jdek+WjrQHvoDa/hYRiTbuOim3PycCF26CjI3lYuTk+76B
	jNvvV3rsTBeKI5zk5aDEDIS5OnGFxOcU+43Q1w+d5xQ2MyQYEClFCFxok4aKdpZDvOYpDH8y6mx
	vidszfynrPWg74ZxOf0eiGiH/OGxMz0Ge3M9qeWTT+FknikaTgHro2tPHXwJuxs1iibof6mtkOt
	JBbjgTdqqL3s6gllvEcGNNtZYatEGAvN/orZBsVg1ou+/1Q8CeVBehgy+q0pDEJAEHqNpY=
X-Received: by 2002:a05:6512:6d5:b0:5b6:10bc:dc4b with SMTP id 2adb3069b0e04-5b610bcddbbmr1736130e87.34.1788541140049;
        Fri, 04 Sep 2026 09:59:00 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166f694bsm642070e87.31.2026.09.04.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:58:59 -0700 (PDT)
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
Subject: [RFC PATCH v6 2/2] ALSA: usb-audio: bind the Topping M62's vendor controls
Date: Fri,  4 Sep 2026 21:58:48 +0500
Message-ID: <20260904165848.3940603-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904165848.3940603-1-mikhail.v.gavrilov@gmail.com>
References: <20260904162236.3212370-1-mikhail.v.gavrilov@gmail.com>
 <20260904165848.3940603-1-mikhail.v.gavrilov@gmail.com>
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
 sound/usb/mixer_topping.c | 236 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 ++
 5 files changed, 258 insertions(+)
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
index 000000000000..5557bc41f05f
--- /dev/null
+++ b/sound/usb/mixer_topping.c
@@ -0,0 +1,236 @@
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
+	/*
+	 * Not a bug, and deliberately not a WARN.  devres_release_all()
+	 * moves every node off the device before it calls a single
+	 * release, so between a failed probe beginning to unwind and the
+	 * teardown action running, the context is already gone while the
+	 * aggregate is still registered.  A component that arrives in
+	 * that window has simply come at the wrong moment; EPROBE_DEFER
+	 * says so, and the framework does not log it.
+	 */
+	if (!tm)
+		return -EPROBE_DEFER;
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

