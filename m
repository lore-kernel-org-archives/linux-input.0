Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B24D4874
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357056; cv=none; b=I7Yqa/ls4gyB3kFMKZ8aJIlQTUfQd3RMzMgqy8p9nuz/jOqRsKu6+WxRvTsCK/GudkF0Iz98M0DGy8rNFGXpvq5MhS1A+nKXNI/O74Q9vPIfXr7GknjIHyIkTN3i0BfTEWA8CYj+00ErcWUI/9CJpCDutLb97sE4iW298LR/ghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357056; c=relaxed/simple;
	bh=769Y++44UQnuaDiSoPYgitZkwpZ3TVtexKykchYSDYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrFpmb1yDRXV/9+4bJEFc7f2A7I+04dVZinr7Z65KQFwUeuSW3tDgnVFcPQlvFOSk493vOfS7HgsVAO71VrFsdDHkNCXDo1Hx0N3pnNiDeCU99xKWEZTR4TycvgnsdpRcEj1TWi/aEBdHG+vGHFAqxW4XWpRuFrFTLywAUNFpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEMw9muj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEMw9muj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e011d370dso1212222f8f.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792357052; x=1792961852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NAFGIgjDvrHJkFpiFpT8g86p1zohj0ptKpMYz6gwJGA=;
        b=hEMw9mujXmjAFGXhT/p9w6dLbxLsNPg6DphdjAI/a24q8/efSBmLGX+vt3vy/YHO9A
         W/orFXJZn5VHtV+oMZadC+1cw2Cqo66umMONk0TAd4Qe6Epx8gFefcnUqTDKEr3OXmDn
         LDLOsUx+BdPfSCcJpQ+/n+i54Cws1ZjCv18c+NkP4mGkXwBCkHNtvf3g6T2vOn+xwbJ8
         j4UZSF7Fs3ROB4YAzilQX5QZFCgYXRnbB8Mgl2I+CilhCeUki+FgrSJo/yyYEr7c5gD/
         jMpdrEiECIu/WPZdHh3457RG2oGxQsfT2o0JnvyoAoMd4ihEKyFrcHCMeL9GMEy/lVTU
         JliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357052; x=1792961852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NAFGIgjDvrHJkFpiFpT8g86p1zohj0ptKpMYz6gwJGA=;
        b=pFN/cn4XGyagEzFUNji19TbyhoPhieY5XpeRPUokh8zadSF4SbneKjKfsTQ5RHBGha
         jhmO/WHAkcNvBequA815mBUJ/4rFvmq1KjTAhuPCCBwMOS4qNUdRFQ2ExBEvtyHEXG9c
         /5sVz1KfPw0ty/3EaCQQUgcnuv2Vgn5aIeE7Kt7CCUIXiSdS8DpCt8rgNpZWpYAb1vov
         6d30jQLuv+fDR/kpRhDIb+xTBSXvJdoGkCxCA/cMrwDFUXEvo6+BV6GlcmlM+N6xAguN
         MK91Xu6QuqNp5yxuFE/unGfI3a1ReOnmzyp6JnBFBbpc/7ic+IKaI8krDPGqaDtGIlYc
         +sRw==
X-Forwarded-Encrypted: i=1; AKwUvByN0qgA0qeDIWW4Txgm+7q4lIcoUfEtuMkOK4sndi8+n/mAT5IT43CMqLLyM7xxT4FLBLR3+PaaRozRJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKZwEEQya9yZdeFnQvVcA8MiU/87GO8fJAac5j/YiMdl7l/2Q4V
	yMriB0gMEPhc/RjH6fnWy1ogoE05ylalGJ5AjG5IkYodV5RUtMmIlLkI
X-Gm-Gg: AYBFou07qjP+TigROJN7MubJsg5BZiUzrpZB7Awaw5otE4yg45TMHTHRACZbvnmmzmt
	xRM3BMtvjWwx9UxmJ/KUsKukadebSUXjUnXsgDcHFFFd4+Lmtv+c6GTQrYCCtR9V8GDzVRtWppj
	T2CNp7aqKjCrBhNfAfAz9HcK61qL/gO8EjMWXM9HLpkZjDU2TCck2lIMpajzdTgSJA2nFf6Wv/H
	V4EV3OnEdlrCU0yks2I9UDNRbjuEX0qCNcXJT8w5o5bPzTI7mo0At9/zcgAgEjksqWR3Ep80myr
	ROC5WsPxEHjSd8kTmYLH8LYSIEax2BFseAljTvu6vbcVieo37IEi9rckrCty/JjNASiUqTpJJvJ
	2CyJu4KViYVLkMOeuLkkRpB8/Z62U1de4jReLP0Jmu7D0TeVhfx1tmJoFf1+8v89QViqjTXbXnQ
	33U1WIVw5upywLXma7I3kw4Q2jIoUPgUfCZthKADHxKWXmjVGvzwOlBFUfHjXh/qrqkFVfdrAQR
	djkex3wqefEOmoshznHwUhQ5zZ2suYM+EAVe6XMV00+c0jLvBc5c+UiysROYZW2ArTsiXMqHM9S
	XEmn
X-Received: by 2002:a05:6000:4a0c:b0:48d:db77:d119 with SMTP id ffacd0b85a97d-48e07975a78mr11289991f8f.2.1792357051525;
        Sun, 18 Oct 2026 13:57:31 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm18496263f8f.30.2026.10.18.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:57:31 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v10 5/8] HID: topping: report the M62's battery level
Date: Mon, 19 Oct 2026 01:57:07 +0500
Message-ID: <20261018205711.168291-6-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018205711.168291-1-mikhail.v.gavrilov@gmail.com>
References: <20261018205711.168291-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M62 runs on its own battery, and a card connected to a computer can
still run down: whether the host charges it depends on a setting of the
card's USB-C port, and nothing on a Linux desktop shows its level.

The card reports the level itself, at 0x11/0x18 in percent: within
seconds of the subscription and again at every change. Offer it as a
power supply of device scope, so that it is never taken for the
system's own battery. The supply is registered only once the first
level has arrived: UPower decides when a device supply appears whether
it is a battery, by reading its capacity, and ignores for good one that
cannot answer yet. Whether it is charging the card does not report, so
the status is unknown.

In Mobile Mode the card announces nothing to a plain subscription, and
its first level came 20 to 30 seconds after it appeared. Inside a
session it announces at once, so the driver now opens one at bind and
at resume as the vendor application does, with the handshake 0x11/0x01
before the subscription and the request to announce: the supply then
appears about 2 seconds after a card is plugged in, in either mode. The
dump of DSP blocks the card adds inside a session carries nothing this
driver exposes, and is ignored.

The card answers the handshake with its mode, 8 to 851 ms after it
here, the latest while it was still sending an announce asked for just
before, and the vendor application sends nothing until that answer has
come; its next frame follows the answer by 4 to 6 ms. In a first bind
that wrote straight after the handshake, the one write that reached the
card 2 ms before the answer was not applied, while the rest were. So
the subscription, the request to announce and everything the audio side
writes after a bind or a resume wait for the answer, or for 3.5 s, a
little longer than an announce lasts, from a card that gives none.

The E2x2 OTG has no battery and gets no supply.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/hid/Kconfig       |   3 +-
 drivers/hid/hid-topping.c | 235 +++++++++++++++++++++++++++++++++++---
 2 files changed, 219 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 9367a71..fad88f4 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1289,13 +1289,14 @@ config HID_TOPPING
 	depends on USB_HID
 	depends on SND_USB_AUDIO
 	select CRC16
+	select POWER_SUPPLY
 	help
 	  The vendor protocol behind the input gains, output volumes and
 	  source selectors of the Topping M62 and E2x2 OTG USB audio
 	  interfaces, and the output switches of the E2x2 OTG. These are
 	  not described by the USB Audio Class and are reached over the
 	  card's HID interface, so a driver is needed for them to work
-	  at all.
+	  at all. The M62's battery level is reported as a power supply.
 
 	  The controls themselves belong to snd-usb-audio, on the sound
 	  card it makes for the same device; this driver carries them
diff --git a/drivers/hid/hid-topping.c b/drivers/hid/hid-topping.c
index 9d23c0c..a9054a7 100644
--- a/drivers/hid/hid-topping.c
+++ b/drivers/hid/hid-topping.c
@@ -28,9 +28,15 @@
  * The M62 says nothing until it is subscribed: one write of 0x11/0x24
  * starts the notification stream, after which every change, including
  * a front panel button, arrives unsolicited.  A second write, 0x11/0x26,
- * makes the device announce what it reports at all.  The E2x2 OTG
- * reports without being asked, and its own vendor application never
- * sends it either of the two, so neither does this driver.
+ * makes the device announce what it reports at all -- in Mobile Mode
+ * only inside a session, so a third goes first: 0x11/0x01, the
+ * handshake the vendor application opens with.  The device answers it
+ * with its mode, and inside the session adds a dump of its DSP blocks
+ * that nothing here uses; until it has answered, the application sends
+ * it nothing more, and neither does this driver.  The E2x2 OTG reports
+ * without being asked, and its own vendor application never subscribes
+ * to it or asks it to announce, so this driver sends it none of the
+ * three.
  *
  * The control pipe is not an option: GET_REPORT and SET_REPORT both
  * stall with EPIPE for every report type, so the interrupt endpoints
@@ -46,14 +52,23 @@
  * struct topping_component it is handed with the one operation the
  * controls need -- send a frame -- and from then on passes on every
  * frame the card reports.
+ *
+ * THE M62'S BATTERY IS.  The card reports its charge in percent at
+ * 0x11/0x18, and this driver offers it as a power supply of device
+ * scope, registered once the first level has arrived.  Whether the card
+ * is charging it does not say.  Like every report the level comes only
+ * to a subscriber, so the supply appears after the card's audio side
+ * has bound.
  */
 
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/completion.h>
 #include <linux/component.h>
 #include <linux/crc16.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -77,9 +92,12 @@
  */
 #define TOPPING_IFNUM		GENMASK(7, 0)
 #define TOPPING_SUBSCRIBE	BIT(8)	/* wants 0x11/0x24 and its renewal */
+#define TOPPING_BATTERY		BIT(9)	/* reports its charge at 0x11/0x18 */
 
 /* device-scope properties */
 #define TOPPING_TT_DEVICE	0x11
+#define TOPPING_PP_HANDSHAKE	0x01
+#define TOPPING_PP_BATTERY	0x18
 #define TOPPING_PP_SUBSCRIBE	0x24
 #define TOPPING_PP_ANNOUNCE	0x26
 
@@ -92,6 +110,18 @@
  */
 #define TOPPING_KEEPALIVE_MS	2000
 
+/*
+ * NOTHING FOLLOWS THE HANDSHAKE UNTIL IT IS ANSWERED.  The card answers
+ * 0x11/0x01 8 to 851 ms after it here, the latest while it was still
+ * sending an announce asked for just before, and the vendor application
+ * sends nothing in between: its next frame follows the answer by 4 to
+ * 6 ms.  A write that reached the card 2 ms before the answer was once
+ * not applied, while the rest of the same bind's writes were.  An
+ * announce lasts 3.1 to 3.3 s from its request, so a card that has not
+ * answered by this is not waited for any longer.
+ */
+#define TOPPING_ANSWER_MS	3500
+
 struct topping_hid {
 	struct hid_device *hdev;
 	struct usb_interface *intf;	/* for runtime PM */
@@ -106,6 +136,18 @@ struct topping_hid {
 
 	bool subscribe;			/* TOPPING_SUBSCRIBE */
 	struct delayed_work keepalive;
+	struct completion answered;	/* the card's answer to 0x11/0x01 */
+
+	/*
+	 * The charge in percent, or -1 until the card has said; written
+	 * by .raw_event() alone.  psy stays NULL until battery_work has
+	 * registered the supply, and on a card without a battery.
+	 */
+	bool has_battery;		/* TOPPING_BATTERY */
+	int battery;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	struct work_struct battery_work;
 };
 
 /* ------------------------------------------------------------------ */
@@ -132,11 +174,11 @@ static void topping_build(u8 *f, u8 target, u8 prop, s32 value)
 
 /*
  * The frame goes out as it is; waking the device is the CALLER's
- * business.  A write asked for by the audio side takes a runtime PM
- * reference first, which wakes what is asleep.  The keepalive and the
- * resume path deliberately do not: the first because a sleeping device
- * has no subscription worth renewing -- resume renews it -- and the
- * second because it IS the resume.
+ * business.  A write asked for by the audio side, and the session a
+ * bind opens, take a runtime PM reference first, which wakes what is
+ * asleep.  The keepalive and the resume path deliberately do not: the
+ * first because a sleeping device has no subscription worth renewing
+ * -- resume renews it -- and the second because it IS the resume.
  *
  * That division is also what keeps the keepalive out of a deadlock.
  * If it woke the device itself, a runtime suspend arriving at the same
@@ -237,6 +279,25 @@ static int topping_raw_event(struct hid_device *hdev,
 	if (get_unaligned_be16(data + 11) != crc16(0xffff, data + 2, 9))
 		return 0;
 
+	if (data[5] == TOPPING_TT_DEVICE && data[6] == TOPPING_PP_HANDSHAKE)
+		complete(&th->answered);
+
+	if (th->has_battery && data[5] == TOPPING_TT_DEVICE &&
+	    data[6] == TOPPING_PP_BATTERY) {
+		int charge = clamp_t(s32, get_unaligned_be32(data + 7), 0, 100);
+		/* pairs with the release in topping_battery_work() */
+		struct power_supply *psy = smp_load_acquire(&th->psy);
+
+		/* the card repeats an unchanged level now and then */
+		if (charge != th->battery) {
+			WRITE_ONCE(th->battery, charge);
+			if (psy)
+				power_supply_changed(psy);
+			else
+				schedule_work(&th->battery_work);
+		}
+	}
+
 	/*
 	 * Under the lock that topping_unbind() takes to clear th->comp,
 	 * so a frame cannot reach an audio side that has already been
@@ -249,6 +310,23 @@ static int topping_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
+/*
+ * Open a session as the vendor application does on connecting, less
+ * its push of the whole workspace: the handshake, and once the card has
+ * answered it, the subscription and the request to announce.  What the
+ * audio side writes comes after this returns, at a bind and at a resume
+ * alike, so that waits for the answer too.
+ */
+static void topping_open_session(struct topping_hid *th)
+{
+	reinit_completion(&th->answered);
+	if (!topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_HANDSHAKE, 1))
+		wait_for_completion_timeout(&th->answered,
+					    msecs_to_jiffies(TOPPING_ANSWER_MS));
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+}
+
 static void topping_keepalive(struct work_struct *work)
 {
 	struct topping_hid *th = container_of(work, struct topping_hid,
@@ -263,6 +341,85 @@ static void topping_keepalive(struct work_struct *work)
 			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 }
 
+/* ------------------------------------------------------------------ */
+/* battery								*/
+/* ------------------------------------------------------------------ */
+
+static const enum power_supply_property topping_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+static int topping_battery_get(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       union power_supply_propval *val)
+{
+	struct topping_hid *th = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		/* the card does not report whether it is charging */
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = READ_ONCE(th->battery);
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		/* the card's own battery, never the system's */
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = th->hdev->name;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Registered only once the card has reported a level.  A supply that
+ * cannot yet answer for its capacity is not a battery to UPower, which
+ * decides that once, when the supply appears, and ignores it from then
+ * on.
+ *
+ * NOT with devm.  component_bind() opens a devres group on this very
+ * device for as long as topping_bind() runs, and a group takes every
+ * devm resource added to the device while it is open, whichever thread
+ * adds it.  A level that arrives while a bind waits for the answer to
+ * the handshake -- the end of an earlier session's announce, when binds
+ * follow each other closely -- would put the supply in that group, and
+ * the audio side's next unbind would free it under th->psy.  So the
+ * name is made at probe, before the component exists, and the supply
+ * goes in topping_remove(), once the reports have stopped.
+ */
+static void topping_battery_work(struct work_struct *work)
+{
+	struct topping_hid *th = container_of(work, struct topping_hid,
+					      battery_work);
+	struct hid_device *hdev = th->hdev;
+	struct power_supply_config cfg = { .drv_data = th };
+	struct power_supply *psy;
+	int err;
+
+	if (th->psy)
+		return;
+
+	psy = power_supply_register(&hdev->dev, &th->psy_desc, &cfg);
+	if (IS_ERR(psy)) {
+		hid_err(hdev, "battery: %ld\n", PTR_ERR(psy));
+		return;
+	}
+	err = power_supply_powers(psy, &hdev->dev);
+	if (err)
+		hid_warn(hdev, "battery: powers link: %d\n", err);
+
+	/* a supply seen by .raw_event() is a registered one */
+	smp_store_release(&th->psy, psy);
+}
+
 /* ------------------------------------------------------------------ */
 /* component								*/
 /* ------------------------------------------------------------------ */
@@ -273,10 +430,21 @@ static int topping_bind(struct device *dev, struct device *master,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct topping_hid *th = hid_get_drvdata(hdev);
 	struct topping_component *comp = master_data;
+	bool held;
 
 	comp->dev = &hdev->dev;
 	comp->ops = &topping_hid_ops;
 
+	/*
+	 * Awake for the session, as every caller of topping_send() has to
+	 * see to.  A bind can come from this driver being loaded onto an
+	 * interface usbhid already holds, outside any USB probe, and the
+	 * wait for the answer can outlast the autosuspend delay.  Taken
+	 * before comp is published, so that a resume it causes has nobody
+	 * to tell and opens no session of its own.
+	 */
+	held = th->subscribe && !usb_autopm_get_interface(th->intf);
+
 	/*
 	 * Published only now: until this store every frame stops here,
 	 * and from it on every frame reaches the audio side, which keeps
@@ -286,18 +454,22 @@ static int topping_bind(struct device *dev, struct device *master,
 		th->comp = comp;
 
 	/*
-	 * Subscribe and ask for the state HERE rather than at probe:
-	 * before this point there is nobody to pass the answer to.  The
-	 * card answers in two waves -- the jacks at once, the gain of a
-	 * connected input about 5 s later -- so nothing here waits for
-	 * them: each value arrives through .raw_event() on its own.
+	 * Open the session and ask for the state HERE rather than at
+	 * probe: before this point there is nobody to pass the answer to.
+	 * The card answers in two waves -- the jacks at once, the gain of
+	 * a connected input about 5 s later -- so nothing here waits for
+	 * them: each value arrives through .raw_event() on its own.  Only
+	 * the answer to the handshake is waited for, inside
+	 * topping_open_session(), before the audio side writes anything.
 	 */
 	if (th->subscribe) {
-		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
-		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+		topping_open_session(th);
 		schedule_delayed_work(&th->keepalive,
 				      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 	}
+
+	if (held)
+		usb_autopm_put_interface(th->intf);
 	return 0;
 }
 
@@ -367,11 +539,28 @@ static int topping_probe(struct hid_device *hdev,
 	    (id->driver_data & TOPPING_IFNUM))
 		return -ENODEV;
 	th->subscribe = id->driver_data & TOPPING_SUBSCRIBE;
+	th->has_battery = id->driver_data & TOPPING_BATTERY;
+	th->battery = -1;
 
 	spin_lock_init(&th->lock);
 	INIT_DELAYED_WORK(&th->keepalive, topping_keepalive);
+	init_completion(&th->answered);
+	INIT_WORK(&th->battery_work, topping_battery_work);
 	hid_set_drvdata(hdev, th);
 
+	/* here, before component_add(): see topping_battery_work() */
+	if (th->has_battery) {
+		th->psy_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						   "hid-%s-battery",
+						   dev_name(&hdev->dev));
+		if (!th->psy_desc.name)
+			return -ENOMEM;
+		th->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+		th->psy_desc.properties = topping_battery_props;
+		th->psy_desc.num_properties = ARRAY_SIZE(topping_battery_props);
+		th->psy_desc.get_property = topping_battery_get;
+	}
+
 	err = hid_parse(hdev);
 	if (err)
 		return err;
@@ -409,6 +598,9 @@ err_close:
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
+	cancel_work_sync(&th->battery_work);
+	if (th->psy)
+		power_supply_unregister(th->psy);
 	return err;
 }
 
@@ -430,6 +622,14 @@ static void topping_remove(struct hid_device *hdev)
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
+	/*
+	 * After the reports have stopped, so that nothing queues the work
+	 * again, and nothing reaches the supply once it is gone.
+	 */
+	cancel_work_sync(&th->battery_work);
+	if (th->psy)
+		power_supply_unregister(th->psy);
 }
 
 static int topping_suspend(struct hid_device *hdev, pm_message_t message)
@@ -466,8 +666,7 @@ static int topping_resume(struct hid_device *hdev)
 	 */
 	if (th->subscribe) {
 		noio = memalloc_noio_save();
-		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
-		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+		topping_open_session(th);
 		memalloc_noio_restore(noio);
 	}
 
@@ -495,7 +694,7 @@ static const struct hid_device_id topping_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_E2X2_OTG),
 	  .driver_data = 4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62),
-	  .driver_data = 4 | TOPPING_SUBSCRIBE },
+	  .driver_data = 4 | TOPPING_SUBSCRIBE | TOPPING_BATTERY },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, topping_devices);
-- 
2.43.0

