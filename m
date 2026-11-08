Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794114224;
	b=KCSWkbnAHyu9gcBtCAwJ1i4RR8n645Y03fNB0PXsEMiZSumbi0AKEM8NrVIgUxPeOC+0
	 1cbyUcAzAi/1Pmvp4b2CJph3L49cD7wFlEoHD95ZvarUUbyjsUxQYwaeWMZGNVTq04NKq
	 e9pFuDFVdcji4yhc1v1Dmi3JzGqdZRC0F3dfewqz1L/iDd8CswwW8z5TqH7s75G+9qyFt
	 tjgXXQRfdBHtrBccLOZI4T5Hi9yE1ZaWE+kOO/pGYTk9htUSrRtDbd5iK/ev5ory0M2jn
	 pZ0lztlnD08mDBujbvZ2pJfOcnUJ7NsMsXfjwTAySEx65Vx57LBCZTYJcKdgEylBXbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794114224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eLx7ZFBpHeg0V+5Mid2XENGd+CE2q1yEb7LrvhyaKaM=;
	b=uwsZwSRJzvbUvgV47wTQ5bpTm7a0/Ug0eC9VWILd27xpURiVEJgmzoQRKdO2RK6UMVMk
	 aJH/O2DU09Wu56+hT1ar4826bWyU+QIvO7apg8azANuKdtr5irphfeBylNEt3mvpi+LRu
	 uxfhWasnlA4M1rVRUR+eY+0PKX7+S+Eks8lAgc4iUYFBq8BbIfhD+pz5ong7RpRdnLPt+
	 3BaDupYRqtZooQBflEgl3StBZoK+lqoXXTCAjVkT2Trqn1A9HMbX/WJKUQYYQ3sC31zj5
	 KxIERSunwSQCqqKdtowoWLPMiw3pBUfCnhcrfgPqB57UzM+8vm95yuSdD7sgE4fw+aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Lkwt/5KO";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0C606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 05:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA0C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lkwt/5KO
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a9f9473029so115112b3a.2
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794114223; x=1794719023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eLx7ZFBpHeg0V+5Mid2XENGd+CE2q1yEb7LrvhyaKaM=;
        b=Lkwt/5KOESVHGaor2tkV/L8y19vAoEcLDavWWF/+42eAVPQSQEhnaTB7XQVzfwZkt1
         EcqTe9ExhTjA5SadnvJzvcNO0JwN28ho4YlBDL4eXQ8lwzHq3FPLCJ3xKMh+PJh56dr0
         4P2fXapSFknGQJutVp79sXdrFhl3RvsS0CcQhdVRJYn7fN1TR1H1vkgjHUBJ9xEG1Wlt
         hvwBNYsX2l37DdRCkkVxVonSlCfNswF63ExtuzsJy5FBXfy8RtL2MFc7xyC9ffr2F+lK
         kr5GjFcA+hjgzxUay8g8FJ/lb+0tMIIPY30i9LXKabUjz0BKB0y6jRen5QfcwZjrlO/f
         MFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794114223; x=1794719023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLx7ZFBpHeg0V+5Mid2XENGd+CE2q1yEb7LrvhyaKaM=;
        b=FwOZTbCa7dwfw7BhOnFOwqNCrtMORN+gzOt0ivDMx/laraFwrLFB/tFMDlPAeNNhSR
         XIJGy0PZ6z68OCMpTXq2m6fykzNre4OUC0Dk33Knadc1zgNWFsHwHC8CJpq8qT1yTKFs
         XrFyAwhUMzA3+soZlBYC+Af4o27VqulIaOpXO+DtFDR+J7dCJi3WluDbJKRmkMa3miK4
         jMa6L9Hoaq+InhQho4N5lMJtJXgtyGwON+ZdRxb0/ZNd/1DDIS2vNdYEnw/28tVxgUmI
         /VRwEtmK663HkOo3UoUrLpC1nlQCEC6uNv8yo5cpG2upBTSyuIpK000Im7dCkpZo9OOh
         tDmQ==
X-Forwarded-Encrypted: i=1; AL+hErHgFRbxIA9Nvz4uG8GBlFqYSu3hqhwQ7FLst0BhAlgcDEjaOyOIW1sl6o2IRpyIGuMZNZzkOwIYOltxfQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8slcjfMimsyAXgra6GJJ5bdeBFf83sQ8LWe6oFs1TWHfHGYNEs
	RpjbkYhKtX+PR6rpyddKe2XPvPQKH/sAyWwCRpg3fXICCwSgY1BFnJNY
X-Gm-Gg: AYBFou1eNP+bZov3yyD+J9fqOk+ivEOuCCbLVunJP43Fin+NwfNeYNexXuexRZqHYov
	2dur6wksEyJT7LjvgXUH3PxAt8zf6uyck/B2zjA8CqMSd4/X9atu7KI9S+4PuzK+/uTSY+MbXoF
	Enh7I5vx1X7GmKT2zwTPB/GPtKI6G2J6MOM5jzGYyOaAaMCdKNtmzdUBl9szsu1yHhDIDF9Sp5E
	aAzfVdZScLIThlTgZO4w/ZJ5FkO6s5ce852iG4N1IUWZRKLfEF+YMmb4+pkfGbncy2ws5W9HEm/
	+x98sH/FsgCPrXtvxf57zyVatDQit2jHoh1iAdXcrCtm1NEP6qAXjaFm/W6/i5EsHAtXCC6znLT
	fe0frI4PqbtMQYzBBpWOz8mg7yNXacncriRTfBmvcrEa+QGH5bxrqgTAq5zq3fpDqs8lUHn24Az
	oIEgvH0cUtSLE+0+Og15zFS+NmEc89/GNWWGea+Yywd9R7AR39u0Zv3ZcChYIwB+dkpCUJk0pte
	mNycoaJA4NLV4e7NkbSVP6A4y2+X3TJ9JnyheJCjRTycS7DZ1bwIKz/FkKnxJd6BcVtku3OJfBc
	Rgi0Nya2dCD4PaW/o1BHuun7rGxVFxXXn+zHNBbuefErym+1COa83i3YuUdr3oO6dFALt55Zqx8
	m4o+rZmgbDkZ2I3E9ZDHrieRmnxdhlXV/0Icu3eI3NSt3DkH5M1ugvVbpXNkSIL80gK1Yt5BoPh
	yD+9c10Ez6AA==
X-Received: by 2002:a05:6a00:b8d:b0:8a0:5da1:2264 with SMTP id d2e1a72fcca58-8b6706407cemr466888b3a.47.1794114222996;
        Sat, 07 Nov 2026 21:03:42 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([203.94.55.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b648e54738sm267977b3a.20.2026.11.07.21.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 21:03:41 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Roberts Kursitis <roberts.kursitis@azeron.eu>,
	Krzysztof Furman <krisfur@proton.me>,
	Dmitriy Zharov <contact@zharov.dev>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Shengyu Qu <wiagn233@outlook.com>,
	Erich Sartison <byt.es@mailbox.org>,
	Kees Cook <kees@kernel.org>,
	Elliot Tester <elliotctester@gmail.com>
Cc: Zoltan Illes <zoliviragh@gmail.com>,
	Bihaan Sen <stevewholikesthings@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12] Input: xpad - overhaul device data for wireless devices
Date: Sun,  8 Nov 2026 18:00:54 +1300
Message-ID: <20261108050056.424305-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xbox 360 wireless controllers expose identification information in their
link and capabilities reports. Use the vendor ID and subtype from the
link report to give each controller a more descriptive name and product
ID. Some controllers also encode their vendor ID, product ID and revision
in the stick capability data; use those IDs when the vendor matches the
link report.

Defer input device registration until the capabilities report arrives,
with a 500ms fallback for controllers that do not respond. If a link report
is not received, retain the receiver-derived identity and the existing
default product ID of 0x02a1.

Protect the wireless discovery state with a spinlock and initialize the
input device from a consistent snapshot. Track controller generations
and revalidate presence and generation after registration, so a
disconnect or replacement during registration cannot publish a stale
input device. Stop routing input immediately on disconnect and reconcile
cancelled discovery or teardown work across suspend.

This changes the IDs reported to userspace when discovery succeeds.
Wireless controllers previously used the receiver's vendor ID and a
product ID of 0x02a1. They now use the controller's vendor ID and a product
ID of 0x02a0 + subtype, unless the capabilities report supplies a product
ID. This matches Windows for gamepads (0x02a1) and wheels (0x02a2).
Windows reports all other subtypes as 0x02a9, but Linux has no other way
to expose the XInput subtype to userspace, so retain the subtype in the
product ID for those devices as well. SDL already handles these IDs:
https://github.com/libsdl-org/SDL/commit/fdc5efe1cbbcbffda016fbab9d5d9083ba040470

If the link report carries a subtype but no usable vendor ID, keep the
receiver's vendor ID together with the subtype-derived product ID. A link
report with subtype 0 keeps the receiver-derived identity. The version
is only replaced when the capabilities report supplies one; otherwise it
remains the receiver's.

Discovery state is cleared on every suspend, so a controller that stays
connected across suspend is rediscovered on resume and its input device
is removed and created again.

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
Tool assistance:
Copilot SDK in VS Code assisted with review feedback, implementation,
code review, and testing preparation.

Changes in v12:
- Rebase onto input/next.
- Keep the default product ID and the receiver name when the link report
  carries subtype 0, and name unrecognised subtypes "Xbox 360 Wireless
  Controller" so the name and product ID stay consistent.
- Return the error from the capabilities inquiry. If it cannot be sent,
  finish discovery with the link report data instead of waiting for the
  timeout.
- Drop an always-true check in the presence work, drop an unneeded lock
  around queueing work on resume, and move a misplaced comment.
- If the wireless start fails during probe, cancel discovery work queued
  by early reports and tear down any input device it already registered,
  so neither outlives xpad.
- Only finish discovery early when it was the capabilities request itself
  that could not be submitted, not another pending output packet.
- Ignore the link report VID for subtype 0 as well, so it keeps the
  receiver-derived identity as documented.
- Run the presence work immediately when a controller connects, so a stale
  input device is removed at once instead of at the discovery deadline.
- Clear xpad->dev when input initialization fails.
- Rename the link report generation snapshot so it no longer shadows the
  new generation in the presence handler.
- Snapshot jiffies once when checking the discovery deadline. Schedule
  timeout retries while holding the discovery lock so a concurrent
  capabilities report or disconnect cannot have its immediate work
  overwritten by a stale timeout.
- Clear discovery state and the published input pointer on every suspend.
  Queue teardown on resume so an old input device is removed even if the
  presence inquiry reports no controller; a newly detected controller
  starts a fresh discovery generation.
- Read the wireless presence state under the discovery lock, matching the
  lock discipline used for all other accesses to pad_info.
- Continue deriving the subtype-based product ID when a link report has a
  valid subtype but no usable VID, preserving receiver VID fallback while
  using the controller subtype for SDL and Windows-compatible IDs.

Testing:
- Built xpad.ko with W=1 against the running 7.2.11-arch1-1 kernel
  headers, with force feedback and LED support enabled. No new warnings
  with W=2 either.
- Hardware tested with an unofficial Xbox 360 wireless receiver
  (045e:02a9), two official gamepads and a RedOctane guitar connected at
  the same time:
  - Gamepads report 045e:02a1 as "Xbox 360 Wireless Controller" and the
    guitar reports 1430:02a7 as "Xbox 360 Wireless Alternate Guitar".
  - Repeated reconnects, including powering a gamepad off again while
    discovery was still running, leave exactly one input device per slot.
  - Moving controllers between slots, including a gamepad slot that is
    reused by the guitar, updates the name and IDs with no stale device.
  - On one USB port the receiver sent no link report at all (confirmed
    with usbmon). Those controllers fell back to the receiver name and
    product ID 0x02a1 after the 500ms timeout, as intended.
  - Suspend powers controllers off and they are rediscovered after
    resume. This receiver fails the reset-resume on every resume, in both
    s2idle and deep sleep and on two different host controllers, and is
    re-enumerated instead. The stock driver behaves the same way, so the
    xpad_resume() path itself could not be exercised.
- Not tested: a controller staying connected across suspend, or being
  replaced while input is stopped during suspend.

Previous revisions:
v11: Track discovery readiness and a per-generation deadline; reject stale
     reports and restart discovery after suspend.
     https://lore.kernel.org/linux-input/20261103021550.1054584-3-sanjay.govind9@gmail.com/
v10: Protect discovery snapshots and input publication with a spinlock;
     track controller generations, clear the RCU input pointer on
     disconnect, and reconcile canceled work over suspend.
     https://lore.kernel.org/linux-input/20261021221009.361992-3-sanjay.govind9@gmail.com/
v9: Track controller generations, clear discovery state on disconnect,
    use a separate capabilities output slot, and validate vendor IDs.
    https://lore.kernel.org/linux-input/20261015220126.102766-3-sanjay.govind9@gmail.com/
v8: Clear presence state on suspend and wireless flags on input teardown.
    https://lore.kernel.org/linux-input/20260818073159.909188-4-sanjay.govind9@gmail.com/
v7: Check whether the input device has already been initialized.
v6: Address presence-work time-of-check/time-of-use issues.
v5: Fix work scheduling races and a typo.
v4: Clear wireless state on presence changes.
v3: Handle incorrect or missing link and capabilities reports.
v2: Defer registration until capabilities discovery or timeout.
---
 drivers/input/joystick/xpad.c | 400 +++++++++++++++++++++++++++++++---
 1 file changed, 367 insertions(+), 33 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782ae8..a273d820910e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -30,14 +30,17 @@
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/usb/input.h>
 #include <linux/usb/quirks.h>
 
 #define XPAD_PKT_LEN 64
+#define XPAD360W_DISCOVERY_TIMEOUT	msecs_to_jiffies(500)
 
 /*
  * xbox d-pads should map to buttons, as is required for DDR pads
@@ -60,6 +63,26 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+/*
+ * Capability flags reported by x360w pads. Bit 0 matches
+ * XINPUT_CAPS_FFB_SUPPORTED, which is also set from the link report.
+ */
+#define FLAG_FORCE_FEEDBACK	0x01
+
+#define SUBTYPE_GAMEPAD			0x01
+#define SUBTYPE_WHEEL			0x02
+#define SUBTYPE_ARCADE_STICK		0x03
+#define SUBTYPE_FLIGHT_STICK		0x04
+#define SUBTYPE_DANCE_PAD		0x05
+#define SUBTYPE_GUITAR			0x06
+#define SUBTYPE_GUITAR_ALTERNATE	0x07
+#define SUBTYPE_DRUM_KIT		0x08
+#define SUBTYPE_GUITAR_BASS		0x0B
+#define SUBTYPE_RB_KEYBOARD		0x0F
+#define SUBTYPE_ARCADE_PAD		0x13
+#define SUBTYPE_TURNTABLE		0x17
+#define SUBTYPE_PRO_GUITAR		0x19
+
 /* Send power-off packet to xpad360w after holding the mode button for this many
  * seconds
  */
@@ -748,9 +771,24 @@ struct xpad_output_packet {
 #define XPAD_OUT_CMD_IDX	0
 #define XPAD_OUT_FF_IDX		1
 #define XPAD_OUT_LED_IDX	(1 + IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF))
-#define XPAD_NUM_OUT_PACKETS	(1 + \
+#define XPAD_OUT_CAPS_IDX	(1 + \
 				 IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF) + \
 				 IS_ENABLED(CONFIG_JOYSTICK_XPAD_LEDS))
+#define XPAD_NUM_OUT_PACKETS	(XPAD_OUT_CAPS_IDX + 1)
+
+/* Discovery state learned from x360w presence, link and capabilities reports */
+struct xpad360w_pad_info {
+	bool present;
+	bool link_report_received;
+	bool discovery_ready;
+	unsigned int gen;
+	unsigned long discovery_deadline;
+	u8 sub_type;
+	u8 flags;
+	u16 vid;
+	u16 pid;
+	u16 version;
+};
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
@@ -758,8 +796,10 @@ struct usb_xpad {
 	struct usb_device *udev;	/* usb device */
 	struct usb_interface *intf;	/* usb interface */
 
-	bool pad_present;
 	bool input_created;
+	unsigned int input_gen;		/* generation the input device was created for */
+	struct xpad360w_pad_info pad_info;
+	spinlock_t x360w_lock;		/* protects pad_info and x360w_dev publication */
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
@@ -788,17 +828,19 @@ struct usb_xpad {
 	int packet_type;		/* type of the extended packet */
 	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
-	struct work_struct work;	/* init/remove device from callback */
+	struct delayed_work work;	/* init/remove device from callback */
 	time64_t mode_btn_down_ts;
 	bool delay_init;		/* init packets should be delayed */
 	bool delayed_init_done;
 };
 
-static int xpad_init_input(struct usb_xpad *xpad);
+static int xpad_init_input(struct usb_xpad *xpad,
+			   const struct xpad360w_pad_info *info);
 static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
 
 /*
  *	xpad_process_packet
@@ -883,6 +925,8 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 				   u16 cmd, unsigned char *data)
 {
+	bool pad_present = false;
+
 	/* valid pad data */
 	if (data[0] != 0x00)
 		return;
@@ -954,7 +998,11 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 	/* XBOX360W controllers can't be turned off without driver assistance */
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		if (xpad->mode_btn_down_ts > 0 && xpad->pad_present &&
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			pad_present = xpad->pad_info.present;
+		}
+
+		if (xpad->mode_btn_down_ts > 0 && pad_present &&
 		    ((ktime_get_seconds() - xpad->mode_btn_down_ts) >=
 		     XPAD360W_POWEROFF_TIMEOUT)) {
 			xpad360w_poweroff_controller(xpad);
@@ -972,19 +1020,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 static void xpad_presence_work(struct work_struct *work)
 {
-	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work.work);
+	struct xpad360w_pad_info info;
+	unsigned long delay = 0;
+	unsigned long now;
 	int error;
 
-	if (xpad->pad_present) {
-		error = xpad_init_input(xpad);
-		if (error) {
-			/* complain only, not much else we can do here */
-			dev_err(&xpad->dev->dev,
-				"unable to init device: %d\n", error);
-		} else {
-			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
-		}
-	} else {
+	/*
+	 * Take a consistent snapshot, as the reports are processed
+	 * concurrently from the irq handler.
+	 */
+	scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+		info = xpad->pad_info;
+	}
+
+	/* Remove the input device if its controller disconnected or changed. */
+	if (xpad->input_created && (!info.present || xpad->input_gen != info.gen)) {
 		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
 		synchronize_rcu();
 		/*
@@ -993,6 +1044,52 @@ static void xpad_presence_work(struct work_struct *work)
 		 */
 		xpad_deinit_input(xpad);
 	}
+
+	if (!info.present || xpad->input_created)
+		return;
+
+	/*
+	 * The work may already be running when a new pad connects, so its
+	 * original delayed execution cannot be relied on to finish discovery.
+	 */
+	scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+		if (!xpad->pad_info.present || xpad->pad_info.gen != info.gen)
+			return;
+
+		now = jiffies;
+		if (!xpad->pad_info.discovery_ready &&
+		    time_before(now, xpad->pad_info.discovery_deadline)) {
+			delay = xpad->pad_info.discovery_deadline - now;
+			mod_delayed_work(system_percpu_wq, &xpad->work, delay);
+		} else {
+			xpad->pad_info.discovery_ready = true;
+			info = xpad->pad_info;
+		}
+	}
+
+	if (delay)
+		return;
+
+	error = xpad_init_input(xpad, &info);
+	if (error) {
+		/* complain only, not much else we can do here */
+		dev_err(&xpad->intf->dev, "unable to init device: %d\n", error);
+		return;
+	}
+
+	scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+		if (xpad->pad_info.present &&
+		    xpad->pad_info.gen == info.gen &&
+		    xpad->pad_info.discovery_ready) {
+			xpad->input_gen = info.gen;
+			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
+			return;
+		}
+	}
+
+	RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+	synchronize_rcu();
+	xpad_deinit_input(xpad);
 }
 
 /*
@@ -1009,18 +1106,121 @@ static void xpad_presence_work(struct work_struct *work)
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
+	struct xpad360w_pad_info *info = &xpad->pad_info;
 	struct input_dev *dev;
 	bool present;
+	bool request_capabilities;
+	unsigned int link_gen = 0;
+	u16 parsed_vid;
 
 	/* Presence change */
 	if (data[0] & 0x08) {
 		present = (data[1] & 0x80) != 0;
 
-		if (xpad->pad_present != present) {
-			xpad->pad_present = present;
-			schedule_work(&xpad->work);
+		guard(spinlock_irqsave)(&xpad->x360w_lock);
+
+		if (info->present != present) {
+			if (present) {
+				unsigned int gen = info->gen + 1;
+
+				*info = (struct xpad360w_pad_info) {
+					.present = true,
+					.gen = gen,
+					.discovery_deadline = jiffies +
+						XPAD360W_DISCOVERY_TIMEOUT,
+				};
+				/*
+				 * Run the work now so it removes any stale input
+				 * device; it re-arms itself for the deadline.
+				 */
+				mod_delayed_work(system_percpu_wq, &xpad->work, 0);
+			} else {
+				RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+				/* Forget everything we learned about the old pad */
+				*info = (struct xpad360w_pad_info) { .gen = info->gen };
+				mod_delayed_work(system_percpu_wq, &xpad->work, 0);
+			}
+		}
+	}
+
+	/* Link report */
+	if (len >= 26 && data[0] == 0x00 && data[1] == 0x0F) {
+		/* Decode vendor id from link report */
+		parsed_vid = ((data[0x16] & 0xf) | (data[0x18] & 0xf) << 4) << 8 |
+			     data[0x17];
+
+		/* VID 1 means unavailable; fall back to the receiver's VID. */
+		if (parsed_vid == 1)
+			parsed_vid = 0;
+
+		request_capabilities = false;
+
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			if (info->present && !info->discovery_ready) {
+				info->sub_type = data[25] & 0x7f;
+				/*
+				 * Use the subtype to derive a PID even if the VID
+				 * is unavailable. Subtype 0 carries no information,
+				 * so keep the receiver-derived identity for it.
+				 */
+				if (info->sub_type) {
+					info->vid = parsed_vid;
+					info->pid = 0x02a0 + info->sub_type;
+				} else {
+					info->vid = 0;
+					info->pid = 0;
+				}
+				info->version = 0;
+				info->flags = 0;
+				info->link_report_received = true;
+
+				if ((data[25] & 0x80) != 0)
+					info->flags |= FLAG_FORCE_FEEDBACK;
+
+				request_capabilities = true;
+				link_gen = info->gen;
+			}
+		}
+
+		/*
+		 * If the capabilities request cannot be sent, finish discovery
+		 * now with the link report data rather than waiting for the
+		 * timeout.
+		 */
+		if (request_capabilities && xpad_inquiry_pad_capabilities(xpad)) {
+			guard(spinlock_irqsave)(&xpad->x360w_lock);
+
+			if (info->present && info->gen == link_gen &&
+			    !info->discovery_ready) {
+				info->discovery_ready = true;
+				mod_delayed_work(system_percpu_wq, &xpad->work, 0);
+			}
+		}
+	}
+
+	/* Capabilities report */
+	if (len >= 21 && data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12) {
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			if (info->present && info->link_report_received &&
+			    !info->discovery_ready) {
+				info->flags |= data[20];
+				/*
+				 * Some vendors encode identification in the stick
+				 * capabilities. Only trust it when the VID matches
+				 * the link report.
+				 */
+				if (info->vid &&
+				    get_unaligned_le16(data + 10) == info->vid &&
+				    get_unaligned_le16(data + 12)) {
+					info->pid = get_unaligned_le16(data + 12);
+					info->version = get_unaligned_le16(data + 14);
+				}
+
+				info->discovery_ready = true;
+				mod_delayed_work(system_percpu_wq, &xpad->work, 0);
+			}
 		}
 	}
 
@@ -1246,7 +1446,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1487,6 +1687,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 	return xpad_try_sending_next_out_packet(xpad);
 }
 
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad)
+{
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CAPS_IDX];
+	static const u8 caps_inquiry[] = {
+		0x00, 0x00, 0x02, 0x80, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+	int error;
+
+	guard(spinlock_irqsave)(&xpad->odata_lock);
+
+	packet->len = sizeof(caps_inquiry);
+	memcpy(packet->data, caps_inquiry, packet->len);
+	packet->pending = true;
+
+	error = xpad_try_sending_next_out_packet(xpad);
+
+	/*
+	 * The failed submission may have been for another pending packet.
+	 * Only report an error if the capabilities request was dropped.
+	 */
+	return packet->pending ? 0 : error;
+}
+
 static int xpad_start_xbox_one(struct usb_xpad *xpad)
 {
 	int error;
@@ -1884,8 +2109,8 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
 {
 	usb_kill_urb(xpad->irq_in);
 
-	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
+	/* Cancel any pending presence work */
+	cancel_delayed_work_sync(&xpad->work);
 }
 
 static int xpad_open(struct input_dev *dev)
@@ -1942,7 +2167,74 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 	}
 }
 
-static int xpad_init_input(struct usb_xpad *xpad)
+static void xpad360w_set_input_info(struct input_dev *input_dev,
+				    const struct xpad360w_pad_info *info)
+{
+	if (info->vid)
+		input_dev->id.vendor = info->vid;
+	if (info->pid)
+		input_dev->id.product = info->pid;
+	else
+		/* Default product id for x360w controllers */
+		input_dev->id.product = 0x02a1;
+	if (info->version)
+		input_dev->id.version = info->version;
+
+	switch (info->sub_type) {
+	case SUBTYPE_GAMEPAD:
+		input_dev->name = "Xbox 360 Wireless Controller";
+		break;
+	case SUBTYPE_WHEEL:
+		input_dev->name = "Xbox 360 Wireless Wheel";
+		break;
+	case SUBTYPE_ARCADE_STICK:
+		input_dev->name = "Xbox 360 Wireless Arcade Stick";
+		break;
+	case SUBTYPE_FLIGHT_STICK:
+		input_dev->name = "Xbox 360 Wireless Flight Stick";
+		break;
+	case SUBTYPE_DANCE_PAD:
+		input_dev->name = "Xbox 360 Wireless Dance Pad";
+		break;
+	case SUBTYPE_GUITAR:
+		input_dev->name = "Xbox 360 Wireless Guitar";
+		break;
+	case SUBTYPE_GUITAR_ALTERNATE:
+		input_dev->name = "Xbox 360 Wireless Alternate Guitar";
+		break;
+	case SUBTYPE_GUITAR_BASS:
+		input_dev->name = "Xbox 360 Wireless Bass Guitar";
+		break;
+	case SUBTYPE_DRUM_KIT:
+		/* Vendors used force feedback flag to differentiate these */
+		if (info->flags & FLAG_FORCE_FEEDBACK)
+			input_dev->name = "Xbox 360 Wireless Guitar Hero Drum Kit";
+		else
+			input_dev->name = "Xbox 360 Wireless Rock Band Drum Kit";
+		break;
+	case SUBTYPE_RB_KEYBOARD:
+		input_dev->name = "Xbox 360 Wireless Rock Band Keyboard";
+		break;
+	case SUBTYPE_ARCADE_PAD:
+		input_dev->name = "Xbox 360 Wireless Arcade Pad";
+		break;
+	case SUBTYPE_TURNTABLE:
+		input_dev->name = "Xbox 360 Wireless DJ Hero Turntable";
+		break;
+	case SUBTYPE_PRO_GUITAR:
+		input_dev->name = "Xbox 360 Wireless Rock Band Pro Guitar";
+		break;
+	case 0:
+		/* No subtype reported, keep the receiver's name */
+		break;
+	default:
+		input_dev->name = "Xbox 360 Wireless Controller";
+		break;
+	}
+}
+
+static int xpad_init_input(struct usb_xpad *xpad,
+			   const struct xpad360w_pad_info *info)
 {
 	struct input_dev *input_dev;
 	int i, error;
@@ -1956,10 +2248,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_dev->phys = xpad->phys;
 	usb_to_input_id(xpad->udev, &input_dev->id);
 
-	if (xpad->xtype == XTYPE_XBOX360W) {
-		/* x360w controllers and the receiver have different ids */
-		input_dev->id.product = 0x02a1;
-	}
+	if (xpad->xtype == XTYPE_XBOX360W)
+		xpad360w_set_input_info(input_dev, info);
 
 	input_dev->dev.parent = &xpad->intf->dev;
 
@@ -2050,6 +2340,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_ff_destroy(input_dev);
 err_free_input:
 	input_free_device(input_dev);
+	xpad->dev = NULL;
 	return error;
 }
 
@@ -2098,7 +2389,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
+	spin_lock_init(&xpad->x360w_lock);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
@@ -2204,8 +2496,18 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 * we're waiting for.
 		 */
 		error = xpad360w_start_input(xpad);
-		if (error)
+		if (error) {
+			/*
+			 * Reports received before the inquiry failed may have
+			 * queued discovery work, or even registered an input
+			 * device. The irq is already stopped, so nothing can
+			 * queue more work or use x360w_dev.
+			 */
+			cancel_delayed_work_sync(&xpad->work);
+			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+			xpad_deinit_input(xpad);
 			goto err_deinit_output;
+		}
 		/*
 		 * Wireless controllers require RESET_RESUME to work properly
 		 * after suspend. Ideally this quirk should be in usb core
@@ -2215,7 +2517,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 */
 		udev->quirks |= USB_QUIRK_RESET_RESUME;
 	} else {
-		error = xpad_init_input(xpad);
+		/* Only x360w devices use the device info */
+		error = xpad_init_input(xpad, NULL);
 		if (error)
 			goto err_deinit_output;
 	}
@@ -2262,6 +2565,7 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usb_xpad *xpad = usb_get_intfdata(intf);
 	struct input_dev *input = xpad->dev;
+	struct xpad360w_pad_info info;
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		/*
@@ -2271,14 +2575,37 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 */
 		xpad360w_stop_input(xpad);
 
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			info = xpad->pad_info;
+		}
+
 		/*
 		 * The wireless adapter is going off now, so the
 		 * gamepads are going to become disconnected.
 		 * Unless explicitly disabled, power them down
 		 * so they don't just sit there flashing.
 		 */
-		if (auto_poweroff && xpad->pad_present)
+		if (auto_poweroff && info.present)
 			xpad360w_poweroff_controller(xpad);
+
+		/* Finish teardown if suspend cancelled work for an old pad. */
+		if (xpad->input_created &&
+		    (!info.present || xpad->input_gen != info.gen)) {
+			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+			synchronize_rcu();
+			xpad_deinit_input(xpad);
+		}
+
+		/*
+		 * The controller may have changed while input was stopped.
+		 * Force resume to rediscover it instead of reusing stale data.
+		 */
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+			xpad->pad_info = (struct xpad360w_pad_info) {
+				.gen = xpad->pad_info.gen,
+			};
+		}
 	} else {
 		guard(mutex)(&input->mutex);
 
@@ -2297,8 +2624,15 @@ static int xpad_resume(struct usb_interface *intf)
 	struct input_dev *input = xpad->dev;
 
 	xpad->delayed_init_done = false;
-	if (xpad->xtype == XTYPE_XBOX360W)
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		/*
+		 * Tear down the old input device even if the resume inquiry
+		 * reports that no controller is currently present.
+		 */
+		mod_delayed_work(system_percpu_wq, &xpad->work, 0);
+
 		return xpad360w_start_input(xpad);
+	}
 
 	guard(mutex)(&input->mutex);
 
-- 
2.56.0

