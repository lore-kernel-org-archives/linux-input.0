Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795322576;
	b=ZWuhvG7elOYolzHJnqn+Q+b5Y9cttZYl2WkbxVV2aMKdyB0IO5C6+mHhjOYbWjI3/S66
	 z5fsVIBZg+CG9+l/tr73OnNJ1b3DOXuCIhMalYHUAd0/lWKtQ5ZxwGFSXaKv6sPmNGX5i
	 EaKQ3E1EhDwP8J0/lLwJnaRAZDag9I79RpX8/ahchCka0FYolyld1Qi5NPcgYVJaP/nhP
	 +19dBuHmp41Il80xfCl1h7JB4pE3MpLl5L5c890/J1z4yukt320Y/s563OTnSGgdqfgXT
	 61Q5A61/e/or+mQgiBP1LY4SUu9S6cm+Itpgr/GtZqgZ4zfG3BTrxuyzTicyut80uXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795322576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rt6UXiWxGHTCaDB8jP97D/3s3iTzFooRKYQiFIHUSho=;
	b=LA0x2rkfHg48iSmp2Xx1jTaTumZjaQWotexg1Cvcj+4YphyC+7ppUJ+lvOPp3nM14JVy
	 91BHXKhZ4u5EoT+ZnScTb8liF1sVqwFEVNc12tOgwMFc9kwBQM5kdY+SUDXr4wZOfhsHz
	 wfyFyp1lSGWd9LfrbRljaqKpQ7JI6hN9u2+SSHQkEQeqU0Yt6KyDsBQhOK9MHJ6FhVm0k
	 l3vPftLZayoeD9GAuMAjGZ3fxon8XkUS/QLPCZ7FSem1Vig+o5ZHR/lZz7jrb9lZZ58FW
	 SKJZJtHHX/oF9ttl0dQvgN+zb832oxVh3beJfBjSYrMx00lvjziPzZh9kU6f0wk/s7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJMkoGF3;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE82606A32A
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 04:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE82606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJMkoGF3
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385d8a00598so2870697eec.1
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795322575; x=1795927375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rt6UXiWxGHTCaDB8jP97D/3s3iTzFooRKYQiFIHUSho=;
        b=HJMkoGF3Q0i8d7ggWHHfZc2Et79+mvQpMjWu46VBcRG0MefwiD5piKDyfkpkTjKsis
         Z/LrOFsAtpD5w+4jf/HRbuXNwbyIL8ZDpDaOc5CnwLGp2PMVK+IyWL13S06SbolP4Yfk
         S+p0LjW6Wjjd1aXzrL7PaNI3teCCCiCJ5XHAFzLfdavSBSPX1k6R/FnsU0GAFeC7Kf5l
         M6J2FkMC9kLxmn+j8mm9MC0K1MiAQfENozB9NyuqWRfUPnR80fdAlIkV6SGNsWXGrYZp
         BFAGGgYAW21h0Lu3Ob65NNNuLNUZrHdwFambBCi7IovthPp6cX/NDCJk0V6b3L/J94A1
         Blxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795322575; x=1795927375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rt6UXiWxGHTCaDB8jP97D/3s3iTzFooRKYQiFIHUSho=;
        b=vy7Yd98K6eNZXDDk5OQisONB9QWlz/B/n4IXwT73b0BbjclygKoxf/SGZuePzoXooK
         AkcfAhHtj0/FQtSQ2M9CH9/A6RVU+sTmqx5uGtdHn+BJX1seaOqko4pKamVHil0c83B3
         j3O0CPwZR0YDIYJ0Uvbaeedn9ChG13h436Z3X+tB7oI42O6cwsJm30tSZ6aI8RoDTWHD
         CvJ1awXQVqKjd3cNSiQyNtbCdypcBFLhTeU2Grbg58WHjZKgl/SD6NWZj8YEpgx5bip9
         YbBsfqd/X5AfqFngh5dEFwgGF4kE0iAB6/DzBTvyVykOALwBNf/GYqExdI7wNEY1JOx9
         3FAA==
X-Forwarded-Encrypted: i=1; AL+hErG4llxOyyZpx4BrxMtlSvrkEfxk0Zh3I3eoBT2w83pbiTQwQOd3eQ8gATKLSLbZ5Rw+gvv0/rJsMN/Y3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9CN7+GYNQxzsE+9BpXHRJW1SpQ/jpp0sJYaxtK0mh+5y2tCVC0
	7VyXAi3st8YK1UvsVReS0+RKrHBKnYsR4OwqMoLkPYUUOvAp810yzmlt
X-Gm-Gg: AZFdTZcNdjvyqYqJ2k+O3spffUc9J3yZX2y/QeNA+POdK2rzyqftbcbj5Cu7Nviy2Vg
	4uGF3SrJuhMpKG9JXO0ZkdGG4uQd3VHYesIiOM/AM2Je+QFMelQaMPF6tAkLdvbTlHvtCKO0dj6
	2gwkfBn4NHvo9AFPswqmAcEz46jrnt4qi5cbKijXRR8XL26oyQDVjbCsI7htUTlzhGv6RGQPJQD
	3ivBOJYWNe8wLFy6BbVJP9NN663TokW8AVb6K9YwXYAs1f6lA3BPLmmgvEDXDsIuNvNI5ucrBV6
	oSGcp1mZQQac28xd4siqMht7RM4ccE0nIYNzgh0hS+UIlgGg2hYbGcL39SUJmsw2qIfwS0vRlP6
	D6TbzCc52taJIpAqaO3/Byx4H7BoErMnWUZpS4rAg+PqldNK60XBCj7JsmyhU4I+GX8tUomR/+u
	0a5pV67x5kANrnTcUxSO89DMSSzR/5aLys7wNYyIvYf3MG/6EvKIgNL5wQ49uAk/k1tUrR313g8
	kNBemVbeNflibh/b7iTCk9JkICKEpws9GYRrMJ3MW3fLzVigm9eqLw4hxTc2HO9uPa5Lf45+ihk
	vj7mPyR/GrglwD+fjqrfsAXHmZ3JXjMxszQNHhJ7JCGlgH7hbwXrZ02w5gnDAvUQ8h+FbHO7pbt
	cZAyYCpUmVMHfRPqol78EOu5JhnI05jcVbo5SmnoLwr8we1EEIWjeKkDO/3z0n25jvxE=
X-Received: by 2002:a05:693c:88cc:20b0:384:a0cb:a6b3 with SMTP id 5a478bee46e88-3856f256635mr7638038eec.13.1795322574439;
        Sat, 21 Nov 2026 20:42:54 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([14.137.24.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm19335545eec.20.2026.11.21.20.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 20:42:53 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
	linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: [PATCH v14] Input: xpad - overhaul device data for wireless devices
Date: Sun, 22 Nov 2026 17:42:28 +1300
Message-ID: <20261122044227.3431941-2-sanjay.govind9@gmail.com>
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
input device. Stop routing input immediately on disconnect and remove
the input device synchronously on suspend.

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
code review, and testing preparation. The v13 and v14 fixes and
changelogs were written with the help of Claude Opus 5.5.

Changes in v14:
- Address the Sashiko review of v13: drop the capabilities request and
  return the error when the output URB cannot be submitted, so discovery
  finishes immediately instead of waiting for the timeout.
- Replace the x360w flags field with an ffb_supported bool set only from
  the link report. v13 also merged data[20] of the capabilities report
  into it, but those bits are not the force feedback flag, and with a
  voice device attached a Rock Band drum kit could be named as a Guitar
  Hero drum kit.

Changes in v13:
- Rebase onto input/next (v7.4-rc2).
- Address the Sashiko review of v12:
  - Remove the input and LED devices synchronously in xpad_suspend(),
    before powering the controller off, instead of from work queued on
    resume, which could race with the LED class resuming those devices.
    This race was found by reading drivers/base/power and
    drivers/leds/led-class.c and was not reproduced on hardware.
  - Clean up discovery work and any registered input device on every
    xpad360w_start_input() failure, including on resume, not only in
    probe.
  - Wait for in-flight output URBs (capabilities inquiry, LED updates)
    on the probe error path before freeing them.

Testing:
- v14: built xpad.ko with W=1, no warnings. Tested drum kit naming with
  an Xbox 360 wireless receiver emulated by custom firmware (1209:2883)
  exposing two drum kit pads:
  - With the link report force feedback bit clear on one pad and set on
    the other, they are named "Xbox 360 Wireless Rock Band Drum Kit" and
    "Xbox 360 Wireless Guitar Hero Drum Kit".
  - A drum kit with the force feedback bit clear and bit 0 of data[20]
    set in its capabilities report, as a voice device would set it, was
    named "Xbox 360 Wireless Guitar Hero Drum Kit" by v13 and "Xbox 360
    Wireless Rock Band Drum Kit" by v14.
  - Both pads were registered from their capabilities reports within
    about 60ms of enumeration, without hitting the timeout.
  The capabilities submission failure path was not exercised. The
  remaining results are from v13 and v12.
- v13: built xpad.ko with W=1, no warnings. Retested on the same
  hardware as below: discovery of two gamepads and the guitar gives the
  same names and IDs, and a deep suspend with all three connected runs
  the new suspend teardown without warnings and still powers the
  controllers off. The receiver again failed to resume and was
  re-enumerated, after which all three controllers were rediscovered
  with no stale input or LED devices. The probe error paths were not
  exercised. The remaining results are from v12.
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
v13: Rebase onto input/next; remove input and LED devices synchronously
     on suspend; clean up on every xpad360w_start_input() failure; wait
     for in-flight output URBs on the probe error path.
     https://lore.kernel.org/linux-input/20261115015219.476559-3-sanjay.govind9@gmail.com/
v12: Rebase onto input/next; keep the receiver identity for subtype 0;
     clear discovery state on every suspend; clean up early discovery
     work when wireless start fails during probe.
     https://lore.kernel.org/linux-input/20261108050056.424305-2-sanjay.govind9@gmail.com/
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
 drivers/input/joystick/xpad.c | 404 ++++++++++++++++++++++++++++++----
 1 file changed, 366 insertions(+), 38 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d2eb48d98fea..92a5bf19ff3f 100644
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
@@ -60,6 +63,20 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
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
@@ -749,9 +766,24 @@ struct xpad_output_packet {
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
+	bool ffb_supported;
+	u16 vid;
+	u16 pid;
+	u16 version;
+};
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
@@ -759,8 +791,10 @@ struct usb_xpad {
 	struct usb_device *udev;	/* usb device */
 	struct usb_interface *intf;	/* usb interface */
 
-	bool pad_present;
 	bool input_created;
+	unsigned int input_gen;		/* generation the input device was created for */
+	struct xpad360w_pad_info pad_info;
+	spinlock_t x360w_lock;		/* protects pad_info and x360w_dev publication */
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
@@ -789,17 +823,19 @@ struct usb_xpad {
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
@@ -884,6 +920,8 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 				   u16 cmd, unsigned char *data)
 {
+	bool pad_present = false;
+
 	/* valid pad data */
 	if (data[0] != 0x00)
 		return;
@@ -955,7 +993,11 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
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
@@ -973,19 +1015,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
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
@@ -994,6 +1039,52 @@ static void xpad_presence_work(struct work_struct *work)
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
@@ -1010,18 +1101,117 @@ static void xpad_presence_work(struct work_struct *work)
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
+				info->link_report_received = true;
+				info->ffb_supported = (data[25] & 0x80) != 0;
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
 
@@ -1247,7 +1437,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1488,6 +1678,36 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
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
+	if (error) {
+		/*
+		 * The failed submission may have been for another pending
+		 * packet, but either way no output URB is in flight to send
+		 * the capabilities request later. Drop it so the caller
+		 * finishes discovery now instead of waiting for the timeout.
+		 */
+		packet->pending = false;
+	}
+
+	return error;
+}
+
 static int xpad_start_xbox_one(struct usb_xpad *xpad)
 {
 	int error;
@@ -1857,6 +2077,32 @@ static void xpad360w_poweroff_controller(struct usb_xpad *xpad)
 	xpad_try_sending_next_out_packet(xpad);
 }
 
+static void xpad360w_stop_input(struct usb_xpad *xpad)
+{
+	usb_kill_urb(xpad->irq_in);
+
+	/* Cancel any pending presence work */
+	cancel_delayed_work_sync(&xpad->work);
+}
+
+/*
+ * Forget the current controller and remove its input device, so the next
+ * xpad360w_start_input() rediscovers it from scratch. Input must already be
+ * stopped, so xpad360w_process_packet() cannot be using x360w_dev and no
+ * discovery work can be running.
+ */
+static void xpad360w_reset_pad(struct usb_xpad *xpad)
+{
+	scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+		xpad->pad_info = (struct xpad360w_pad_info) {
+			.gen = xpad->pad_info.gen,
+		};
+	}
+
+	xpad_deinit_input(xpad);
+}
+
 static int xpad360w_start_input(struct usb_xpad *xpad)
 {
 	int error;
@@ -1874,21 +2120,18 @@ static int xpad360w_start_input(struct usb_xpad *xpad)
 	 */
 	error = xpad_inquiry_pad_presence(xpad);
 	if (error) {
-		usb_kill_urb(xpad->irq_in);
+		/*
+		 * Reports received before the inquiry failed may have
+		 * queued discovery work, or even registered an input device.
+		 */
+		xpad360w_stop_input(xpad);
+		xpad360w_reset_pad(xpad);
 		return error;
 	}
 
 	return 0;
 }
 
-static void xpad360w_stop_input(struct usb_xpad *xpad)
-{
-	usb_kill_urb(xpad->irq_in);
-
-	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
-}
-
 static int xpad_open(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
@@ -1943,7 +2186,74 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
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
+		if (info->ffb_supported)
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
@@ -1957,10 +2267,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_dev->phys = xpad->phys;
 	usb_to_input_id(xpad->udev, &input_dev->id);
 
-	if (xpad->xtype == XTYPE_XBOX360W) {
-		/* x360w controllers and the receiver have different ids */
-		input_dev->id.product = 0x02a1;
-	}
+	if (xpad->xtype == XTYPE_XBOX360W)
+		xpad360w_set_input_info(input_dev, info);
 
 	input_dev->dev.parent = &xpad->intf->dev;
 
@@ -2051,6 +2359,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_ff_destroy(input_dev);
 err_free_input:
 	input_free_device(input_dev);
+	xpad->dev = NULL;
 	return error;
 }
 
@@ -2099,7 +2408,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
+	spin_lock_init(&xpad->x360w_lock);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
@@ -2216,13 +2526,16 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 */
 		udev->quirks |= USB_QUIRK_RESET_RESUME;
 	} else {
-		error = xpad_init_input(xpad);
+		/* Only x360w devices use the device info */
+		error = xpad_init_input(xpad, NULL);
 		if (error)
 			goto err_deinit_output;
 	}
 	return 0;
 
 err_deinit_output:
+	/* Wait for capability inquiries or LED updates sent before failing. */
+	xpad_stop_output(xpad);
 	xpad_deinit_output(xpad);
 err_free_in_urb:
 	usb_free_urb(xpad->irq_in);
@@ -2263,6 +2576,7 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usb_xpad *xpad = usb_get_intfdata(intf);
 	struct input_dev *input = xpad->dev;
+	struct xpad360w_pad_info info;
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		/*
@@ -2272,13 +2586,27 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 */
 		xpad360w_stop_input(xpad);
 
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			info = xpad->pad_info;
+		}
+
+		/*
+		 * The controller may change while input is stopped, so force
+		 * resume to rediscover it instead of reusing stale data. Remove
+		 * the input and LED devices now rather than from work queued
+		 * during resume, which could race with resuming those devices.
+		 * Do this before powering off, so the LED-off packet sent when
+		 * the LED is unregistered does not follow the poweroff.
+		 */
+		xpad360w_reset_pad(xpad);
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
 	} else {
 		guard(mutex)(&input->mutex);
-- 
2.56.0

