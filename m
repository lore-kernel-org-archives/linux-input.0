Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389F49BD64
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327796; cv=none; b=lDb56kPQgu4JrCSy6ZJuOBO62gg8/Tql6P7MQdjL69IZmwYH+ANpb9gNms1LA3kAx+mIaSeDjMB6+I8JxoJyu16NQyAFMzMtiphUaDZP/ltdJHDF9BrgsEIp/F5dV/xrMQYs9M1AdP6LzyeKefhHvo47rwP3o2gxOnLQG1wiiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327796; c=relaxed/simple;
	bh=ZybwQuyiX3gXI+mzrbA/1G2Vz3Vmb3YTfYhqISQGDuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmDiFBwQZYd/tgQrMrPxamXP+0/8480ZRLiAJt8gnzIU2kaLIlzscdLB+sjC0JGZda4Xltj427buBl9VU4R0W1/ZztbwELOWhqo81DU1Ltn1iDniH/+M36cJBsRdGpuZ2wX41mnv26950pFanoa2EIP6qOqyHC0T5fav/mFE7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0XP4VA2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0XP4VA2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so9482785e9.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327791; x=1792932591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R28zVLjzzIWNytJABkl7jLklHY8Z5yrz+uQ9TaZ758Y=;
        b=l0XP4VA2we8UZpiHWkTDEPLBIdkTMNtPwCd0fna/1lXEnqXuSvlPq0G18W2ZSktjVY
         4QFzVnFuG7Us8mOHcILG2kzk2Pa0VADTA2LnzVD7DaC1ChDx0Vf586sWeWcYalour91k
         FrS+e0eFcaKZYIYZzBaILHQeULdKTUv3Iq89zI2Gs2me6OPcG+F9I8B1LnMiYAV5YLRI
         dzfwZLaAwyOw5iTO/WqFXmWsBfM/xobJweW3iUZ1HsdIInCo3asza5PsF0wAEJl5VZkW
         0KhHEbgKhdpfxiTsELMUhUucp/sLF14k3Mee+QdACjSMXs9rwidVh3IkVcsuwRPtXLX3
         tn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327791; x=1792932591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R28zVLjzzIWNytJABkl7jLklHY8Z5yrz+uQ9TaZ758Y=;
        b=1cvTSAnDKWlFQw/pd9BUsZ/GhpJLM9YpsPB0v4jBFQulItAb9ld/OqZCPa955XtTi8
         5ilPWwxItvM2dIMf2UKXDG4X0gXpYfBFTESBAUT4o9J+SN22+UAjbo28tCEXmDd9KGIj
         P4E0KF26DKK5dBcNY617JqyO1CBkSl2MBkH9nRLTQtQD0E5ij7vZpbHmBkq07RwomnCN
         tcjAVEGew120J9cNaFZOpLuXEoANCGOsFManD9KzFt1PqS+pyOxlME8gK2G+BjhqhRuU
         zWjSiqeiIp8K220Z1oGBTidCBFVNRW2Plb4ttaotNa2Ov/0wIZTwiU+z8v9XyWkygb2q
         s9Eg==
X-Forwarded-Encrypted: i=1; AKwUvBwCvYMwtW7fetfnFMyTQoDQeYNhcQCo7GEq4fCgqDcuh8uUiwZk3p7BUGfVnj9RC532vBSF8zYN6JpnVw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLWdjK2dfysLxWEu7Lfr6ef9vCT67NUGa7GZlDXUlL5rEpqq3gF
	3dxxCa0v2YAii4LdgJ+b9ISJ4/oeeKsP9q9XQDgTNFyOF1nGdZa6Jn39
X-Gm-Gg: AYBFou2lmxvPqdcPb7l2ta6yacOCfedP8AHVG7/W01NpA+8spSYbpJevet2g4YLxxU0
	m/SLwf5/eZGPvwjINea/qTQ8oyPdq1e2zf0rvkl7RoM+CWtCsC3oiKbjiGn1nFMU1u58t7fdoa6
	g1y0QqCjvOCVdoBPBxckjR1OO8CN/TZxLG5Z33lwoNP8vQQcGh6/jsWsS44UblWAhjxsSMnPDTP
	AQ3almcVtwTaPvAjYb7hCpviUZukh+xiLdoY8vP/gc0sFmSkp86lpCyYDW0acoB4hleDhHBYg4L
	6WgbFFW6vfebchg7P6dAwWF4JRNnaokr9US8iYdinmyY3yOdkhJ+ijZbjdP2DfRKtIsGD895UWk
	XYMZa7qfwiM+47zZ61ZjHph21AQbUlEYaBVLcjhOWWIEynMtPcFQkS3DeQCQuTZDVGJbsSmmuw5
	d/PT2fX75u7j2XiOgvp7wBER5wvviFeBtd8I9fzet3vFr174DiA52MPKrUd3Bd+MwH5HnDjbVLv
	RIV3FvVd500EArVkXAdw2c2nqaofBDh00PRcvhwwRThBEn+1tR84R0d7XGXbfz4uBXkCQ==
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4a1d75e6f32mr98908035e9.5.1792327790979;
        Sun, 18 Oct 2026 05:49:50 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:50 -0700 (PDT)
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
Subject: [PATCH v9 5/8] HID: topping: report the M62's battery level
Date: Sun, 18 Oct 2026 17:48:35 +0500
Message-ID: <20261018124838.129349-6-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
References: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
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
 drivers/hid/hid-topping.c | 195 +++++++++++++++++++++++++++++++++++---
 2 files changed, 184 insertions(+), 14 deletions(-)

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
index 7b46c4c..f9e05ce 100644
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
@@ -263,6 +341,89 @@ static void topping_keepalive(struct work_struct *work)
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
+	th->psy_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+					   "hid-%s-battery",
+					   dev_name(&hdev->dev));
+	if (!th->psy_desc.name)
+		return;
+	th->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	th->psy_desc.properties = topping_battery_props;
+	th->psy_desc.num_properties = ARRAY_SIZE(topping_battery_props);
+	th->psy_desc.get_property = topping_battery_get;
+
+	/*
+	 * devm on the HID device: released after .remove(), which has
+	 * stopped .raw_event() and this work by then.
+	 */
+	psy = devm_power_supply_register(&hdev->dev, &th->psy_desc, &cfg);
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
@@ -286,15 +447,16 @@ static int topping_bind(struct device *dev, struct device *master,
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
@@ -367,9 +529,13 @@ static int topping_probe(struct hid_device *hdev,
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
 
 	err = hid_parse(hdev);
@@ -409,6 +575,7 @@ err_close:
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
+	cancel_work_sync(&th->battery_work);
 	return err;
 }
 
@@ -430,6 +597,9 @@ static void topping_remove(struct hid_device *hdev)
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
+	/* After the reports have stopped, so that nothing queues it again. */
+	cancel_work_sync(&th->battery_work);
 }
 
 static int topping_suspend(struct hid_device *hdev, pm_message_t message)
@@ -466,8 +636,7 @@ static int topping_resume(struct hid_device *hdev)
 	 */
 	if (th->subscribe) {
 		noio = memalloc_noio_save();
-		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
-		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+		topping_open_session(th);
 		memalloc_noio_restore(noio);
 	}
 
@@ -495,7 +664,7 @@ static const struct hid_device_id topping_devices[] = {
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

