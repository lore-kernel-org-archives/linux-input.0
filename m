Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620717;
	b=L8j2fgGopYKP655Vq3Uk/5dMSfkDo7eIcYh5Us1Gdp4k7wwdoQzKVA1uBxwkwMTqBLrL
	 GW8uFy+dA8NImVaEh14T5Yd16xD0tdlrX21lBydzMMv+MJ/YbsKqXQCqTrO6GuM2BDsA4
	 4Nmp5+POB957TWPc3sIOVFNZnRV65bUGEDD0m43PAZ4VUvOWIjbRouEE9/09H3Mif+P9u
	 lrjjZMyRhs7t4HNKZKA+eyv90KKah1rxp9iN44j4+FRV+xf6IaPaZO6NWs9zdA31dwm4Q
	 PWVEE9ak8Oi5XsmLSOyNdnWrGCK5fV+s+6AtfZLqsV3cpd+qAqMB7dHT0YKeDt4jozA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OVQXlRc9jEk4D2ldp46dqYfj2vUZ7gRk6ECjKwoF6ew=;
	b=HJUShaOi6a3DUYDh4QmzYftiFgNHtvCEIJwhHRhAdnZgUAjJJndzApCR1GLNPWP76wZH
	 0XV7qYGy0fhXUSe/GE6+QLc6VcHer9OFp4Y77agU4ftrzcNXBkqVaxQpeXeV3FGOjVYQX
	 oAZZwkb9bCrEZNqrUlL1O37qJ+HkxN+dCMbDE6kri/mNqan2nVK8atQ9T5kfzrZnz79Ok
	 pGZr6XnUKVBQbnm0ngkuthA8WHq6w6I6uihv/+i/VGzp6igfs/eGT4RcGUAnlYkB15YLo
	 IkbD7ikt9mUvCZEea1aYCVxEcSHDToBl0ACyOJcFhwVTgcxiAqngSk0HSHhodVTg8YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a5lcCI5c;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B123606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 22:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B123606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a5lcCI5c
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35c76e9614aso2196786eec.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620716; x=1793225516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVQXlRc9jEk4D2ldp46dqYfj2vUZ7gRk6ECjKwoF6ew=;
        b=a5lcCI5cgnST3DY9D6D4jywWA4QDNPLFgBJReUndFzpff+ENKtM/GsHx7LNkNs1kXj
         mfSYQcfLakvRBLHhHaWgunLLRmUJc4/ZOUFKzxIM2tIa+zDxNcf74MR9NOktqjbXcezK
         95P1irtwAYjlGMjPEjUV3POlnDomAxisUsrZOJmPrn2eLNVIJsbVcPuz+KEdxkA8mqtz
         FYhY7WYKo6v46sulXAuyiLa2CFJV2/NmGbXwSTCJcq0KV9DF8zJhjvVbjmLnPr0JDk7a
         x5oRp+uWNgQ8PImehmY59qvTaIife7CbqKc1uyRjSzlwrYT2AmdCWMONDPCAFIeX+WTx
         aWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620716; x=1793225516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVQXlRc9jEk4D2ldp46dqYfj2vUZ7gRk6ECjKwoF6ew=;
        b=2eN3rHReFUjIhNsF5nb/m/Nrekw2wVaVRyxmpdSltf+IdBx8oMYNLwF6C/donC2oGt
         gLrUbsAE4JZFzZMb/WuGW5GvexaV/BRvYax148OC+10PdHsVWFoWO/CMNgbKLNQniLE4
         8uzDqnccASZM4r/k6wL7QqBSBRnafSZRwSJzErsovyGiVMZba0oTiBn6gLQpW4l72ZrH
         dS3YSE20SuBYzfzWH0td1/WQumiZIffDEy5hxyXqsCNbu6xJfBjKRf+13ltASWpIT9Mu
         qkwPmEpdsKCkGSxt57+WhAHJE6TmnYwY2e25o4d8b6H2hezET+aKIVTTYiAXXx/XjhOc
         GTbQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+zOS8UPsGMQWpO8YOrHvJcKtD9/d5irIGOKPif9NIVi1N52eU29Ahyrds5CoJtAo9tuNNIb1Kas25Cg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3JBwDWduUKAJYhQ6Lkgy7vUR21lgst79dYop6TvnJfbHOLd0r
	ahwb517qkTMkJE+pgt2Rss7r6b093xo0PGIPTbFjZ3d/kHYD1GGlzDG/
X-Gm-Gg: AYBFou1QWZiNzhWNMKGprrmn9SL78BpHtwSVIZWpMp2aXsOCJgLRVb14w9emMTsBNrG
	xxSG3HC98KjbvYRX6d+6k67seQQfh3olCpSICLvczN5ULyrNHPzxY5wFKUz1wWScXVCLpzAP48Y
	AQBozfBaKlESGDWfnh8QhYzHroefrsKDNghWLA907vkj4zOZntQc4N2W10BACTTo5GmivnXn3So
	7GZt6/uB7d9kch+dFEbvvTOfy0T9oY2zjVlsbjnJ2/RPY/9bOJi0HgSLpxARGoyrKwaMz173p3u
	yl0A4esNWMlBqS4Yhph8SveNpoUoy1A7DvuQOeAwBsP3X8VSd6J/lEWREMSkw91GVB9A09na4Nn
	vBW9R6spGM8rK3A/gjPH6IaCa90UCnLF+vs+gRzPUzo9rOsofmFgDUk9JAXdgqsH0fgVRB2SQ9z
	xlEuP7ninaNAVUmugdPn7w59/zu9XYAdKuA7Fw1By3J70SenFh7urpTWFG++UgUGDt9/05mZmNR
	3ZrYvUnUVb1VkNDGw2iQwFylrAFQwjpHAeCMvd082lwh00APf//3TcFEhIWA7z91bQOg7XN80LV
	ioavCPm1ILzmmVqM9kusyE9svditjYgvhkM6f/wTtbreHwUzPa9ZiedFuqT6Zznojb4tFfTlWMP
	m+ZXWACt9na+4/vGoIQ==
X-Received: by 2002:a05:7301:e118:b0:359:1b05:ed30 with SMTP id 5a478bee46e88-3674b53008fmr4419050eec.4.1792620715887;
        Wed, 21 Oct 2026 15:11:55 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([139.180.93.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367412b24e3sm9107489eec.19.2026.10.21.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:11:55 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Zoltan Illes <zoliviragh@gmail.com>,
	Dmitriy Zharov <contact@zharov.dev>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Shengyu Qu <wiagn233@outlook.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	Kees Cook <kees@kernel.org>,
	Kyohei Kadota <lufia@lufia.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10] Input: xpad - overhaul device data for wireless devices
Date: Thu, 22 Oct 2026 11:10:09 +1300
Message-ID: <20261021221009.361992-3-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015220126.102766-3-sanjay.govind9@gmail.com>
References: <20261015220126.102766-3-sanjay.govind9@gmail.com>
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
with a 500ms fallback for controllers that do not respond. If discovery
does not provide identification data, retain the receiver-derived
identity and the existing default product ID of 0x02a1.

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

Assisted-by: LLM
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
Tool assistance:
Copilot SDK in VS Code assisted with implementing review feedback, code
review, testing preparation, and drafting the commit message. Hardware
testing was performed by the submitter.

Changes in v10:
- Address Sashiko's metadata race report by snapshotting the wireless
  discovery state under a spinlock.
- Following Dmitry's review, group presence, generation and identification
  fields in struct xpad360w_pad_info and increment the generation on connect.
- Revalidate presence and generation under the lock before publishing a
  newly registered input device; tear it down if the controller changed.
- Clear the RCU input pointer immediately when a disconnect is reported.
- Schedule discovery only on presence transitions, so repeated status
  reports do not extend the 500ms timeout.
- Reconcile presence with input device state on suspend, including
  completing teardown if work for an old controller was cancelled.
- Expedite pending registration when a capabilities report arrives.
- Make the capabilities inquiry helper return void and extract wireless
  ID/name setup into a separate helper.

Testing:
- Built with W=1, with force feedback and LED code enabled and disabled.
- Loaded an external module built against the running 7.2.3-arch1-3
  kernel, using an unofficial Xbox 360 wireless receiver, two wireless
  gamepads and a wireless guitar.
- SDL2 enumeration showed both gamepads as 045e:02a1 and the guitar as
  1430:02a7, named "Xbox 360 Wireless Alternate Guitar". Inputs worked.
- Repeated battery-removal/reconnect testing produced fresh input devices.
  One registration used the receiver-name fallback; this did not recur
  in subsequent attempts.
- Powered off multiple controllers and powered them back on together;
  reconnection worked.
- Suspend/resume testing succeeded: both gamepads and the guitar
  registered with the expected names, and inputs worked afterward.
- In a separate test-only build, discarding wireless link reports forced
  all three devices to register with the receiver-name fallback. Inputs
  still worked. This fallback identity matches the pre-patch behaviour.
  This verifies the missing-identification fallback, not
  the packet ordering responsible for the earlier transient event.
  The fault-injection changes are not included in this patch.

Previous revisions:
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
 drivers/input/joystick/xpad.c | 282 ++++++++++++++++++++++++++++++----
 1 file changed, 251 insertions(+), 31 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..41348e62fe19 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/usb/input.h>
 #include <linux/usb/quirks.h>
 
@@ -60,6 +61,26 @@
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
@@ -734,9 +755,21 @@ struct xpad_output_packet {
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
+	unsigned int gen;
+	u8 sub_type;
+	u8 flags;
+	u16 vid;
+	u16 pid;
+	u16 version;
+};
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
@@ -744,8 +777,10 @@ struct usb_xpad {
 	struct usb_device *udev;	/* usb device */
 	struct usb_interface *intf;	/* usb interface */
 
-	bool pad_present;
 	bool input_created;
+	unsigned int input_gen;		/* generation the input device was created for */
+	struct xpad360w_pad_info pad_info;
+	spinlock_t x360w_lock;		/* protects pad_info and x360w_dev publication */
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
@@ -774,17 +809,19 @@ struct usb_xpad {
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
+static void xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
 
 /*
  *	xpad_process_packet
@@ -940,7 +977,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 	/* XBOX360W controllers can't be turned off without driver assistance */
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		if (xpad->mode_btn_down_ts > 0 && xpad->pad_present &&
+		if (xpad->mode_btn_down_ts > 0 && xpad->pad_info.present &&
 		    ((ktime_get_seconds() - xpad->mode_btn_down_ts) >=
 		     XPAD360W_POWEROFF_TIMEOUT)) {
 			xpad360w_poweroff_controller(xpad);
@@ -958,19 +995,20 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 static void xpad_presence_work(struct work_struct *work)
 {
-	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work.work);
+	struct xpad360w_pad_info info;
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
@@ -979,6 +1017,26 @@ static void xpad_presence_work(struct work_struct *work)
 		 */
 		xpad_deinit_input(xpad);
 	}
+
+	if (info.present && !xpad->input_created) {
+		error = xpad_init_input(xpad, &info);
+		if (error) {
+			/* complain only, not much else we can do here */
+			dev_err(&xpad->intf->dev,
+				"unable to init device: %d\n", error);
+		} else {
+			scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+				if (xpad->pad_info.present &&
+				    xpad->pad_info.gen == info.gen) {
+					xpad->input_gen = info.gen;
+					rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
+					return;
+				}
+			}
+
+			xpad_deinit_input(xpad);
+		}
+	}
 }
 
 /*
@@ -995,19 +1053,83 @@ static void xpad_presence_work(struct work_struct *work)
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
+	struct xpad360w_pad_info *info = &xpad->pad_info;
 	struct input_dev *dev;
 	bool present;
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
+			if (!present) {
+				RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+				/* Forget everything we learned about the old pad */
+				*info = (struct xpad360w_pad_info) { .gen = info->gen };
+			}
+			info->present = present;
+			if (present) {
+				info->gen++;
+				/*
+				 * Allow discovery to complete; some pads never
+				 * send capabilities.
+				 */
+				mod_delayed_work(system_percpu_wq,
+						 &xpad->work, msecs_to_jiffies(500));
+			} else {
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
+		/* Use a subtype-derived PID unless capabilities supply one. */
+		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
+			info->sub_type = data[25] & 0x7f;
+			info->vid = parsed_vid;
+			info->pid = 0x02a0 + info->sub_type;
+			info->version = 0;
+			info->flags = 0;
+
+			if ((data[25] & 0x80) != 0)
+				info->flags |= FLAG_FORCE_FEEDBACK;
 		}
+
+		xpad_inquiry_pad_capabilities(xpad);
+	}
+
+	/* Capabilities report */
+	if (len >= 21 && data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12) {
+		guard(spinlock_irqsave)(&xpad->x360w_lock);
+
+		info->flags |= data[20];
+		/*
+		 * Some vendors encode identification in the stick capabilities.
+		 * Only trust it when the VID matches the link report.
+		 */
+		if (info->vid &&
+		    get_unaligned_le16(data + 10) == info->vid &&
+		    get_unaligned_le16(data + 12)) {
+			info->pid = get_unaligned_le16(data + 12);
+			info->version = get_unaligned_le16(data + 14);
+		}
+
+		if (info->present && delayed_work_pending(&xpad->work))
+			mod_delayed_work(system_percpu_wq, &xpad->work, 0);
 	}
 
 	/* Valid pad data */
@@ -1232,7 +1354,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1473,6 +1595,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 	return xpad_try_sending_next_out_packet(xpad);
 }
 
+static void xpad_inquiry_pad_capabilities(struct usb_xpad *xpad)
+{
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CAPS_IDX];
+
+	guard(spinlock_irqsave)(&xpad->odata_lock);
+
+	packet->data[0] = 0x00;
+	packet->data[1] = 0x00;
+	packet->data[2] = 0x02;
+	packet->data[3] = 0x80;
+	packet->data[4] = 0x00;
+	packet->data[5] = 0x00;
+	packet->data[6] = 0x00;
+	packet->data[7] = 0x00;
+	packet->data[8] = 0x00;
+	packet->data[9] = 0x00;
+	packet->data[10] = 0x00;
+	packet->data[11] = 0x00;
+	packet->len = 12;
+	packet->pending = true;
+
+	xpad_try_sending_next_out_packet(xpad);
+}
+
 static int xpad_start_xbox_one(struct usb_xpad *xpad)
 {
 	int error;
@@ -1870,8 +2017,8 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
 {
 	usb_kill_urb(xpad->irq_in);
 
-	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
+	/* Cancel any pending presence work */
+	cancel_delayed_work_sync(&xpad->work);
 }
 
 static int xpad_open(struct input_dev *dev)
@@ -1928,7 +2075,68 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 	}
 }
 
-static int xpad_init_input(struct usb_xpad *xpad)
+static void xpad360w_set_input_info(struct input_dev *input_dev,
+				   const struct xpad360w_pad_info *info)
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
+	}
+}
+
+static int xpad_init_input(struct usb_xpad *xpad,
+			   const struct xpad360w_pad_info *info)
 {
 	struct input_dev *input_dev;
 	int i, error;
@@ -1942,10 +2150,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_dev->phys = xpad->phys;
 	usb_to_input_id(xpad->udev, &input_dev->id);
 
-	if (xpad->xtype == XTYPE_XBOX360W) {
-		/* x360w controllers and the receiver have different ids */
-		input_dev->id.product = 0x02a1;
-	}
+	if (xpad->xtype == XTYPE_XBOX360W)
+		xpad360w_set_input_info(input_dev, info);
 
 	input_dev->dev.parent = &xpad->intf->dev;
 
@@ -2084,7 +2290,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
+	spin_lock_init(&xpad->x360w_lock);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
@@ -2201,7 +2408,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 */
 		udev->quirks |= USB_QUIRK_RESET_RESUME;
 	} else {
-		error = xpad_init_input(xpad);
+		/* Only x360w devices use the device info */
+		error = xpad_init_input(xpad, NULL);
 		if (error)
 			goto err_deinit_output;
 	}
@@ -2263,8 +2471,20 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 * Unless explicitly disabled, power them down
 		 * so they don't just sit there flashing.
 		 */
-		if (auto_poweroff && xpad->pad_present)
+		if (auto_poweroff && xpad->pad_info.present)
 			xpad360w_poweroff_controller(xpad);
+
+		/* Finish teardown if suspend cancelled work for an old pad. */
+		if (xpad->input_created &&
+		    (!xpad->pad_info.present ||
+		     xpad->input_gen != xpad->pad_info.gen)) {
+			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+			synchronize_rcu();
+			xpad_deinit_input(xpad);
+		}
+
+		/* A cancelled discovery must be restarted by the resume inquiry. */
+		xpad->pad_info.present = xpad->input_created;
 	} else {
 		guard(mutex)(&input->mutex);
 

base-commit: 29ee387509a184c3bfff9e26831aacc7b2edc02a
-- 
2.55.0

