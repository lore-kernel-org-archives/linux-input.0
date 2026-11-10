Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276062;
	b=BLpimwi6kt1yV2kXl13rfnQEfaEK6TJ9qQl5iXvOaVNXqRXMDqVljOTRQw5U2X3Jc6Dx
	 h/HDNi8I/DEnI5PcO+5z0fjPSkuQjFneDsHO5ok9KJLY0U2w6sw+Ho0PqlGh1TuEuU8rw
	 LhuE2G1tmXbRW68SeqvAcv/e68kq+oDK6oJBsLMYO8E6rPnydx/uiVsF/0GvhLBNqMRc5
	 Bqg8YXZgEoq0i/3n4GJGKhKfOdW/L7H4ivMkRVHzg/xjlhayKjvPwhJL6eLs2mKfY/OE5
	 udkHtYdYettAK8zwDW6UbJ5mbKL/rl0OvktxWOj7GKgCYrD2wRS3ci3BEtasAe2rjoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276062;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dTDNBvz9JBKD2KKOrG5jZ7g9eJePyYolmGcy9dxEaGM=;
	b=g6VAONjsN9ot9DLSA5IbVJNKGlwB282YvDyLqApkLDrojFfjzm51sQZPfgYDNmzsLbkQ
	 bAT+mQ0vCapOTVm84dHfoOIlFfpCVen/KOv5ogedwY0+UzMFU6CCR82gxxIcrjCYr3WXf
	 WKykDqFlCJ/02Vaczwhe+upjhmKGW/KLZsdXbvIusl6j3VIZw53/e6bptmmSLADawyp2B
	 iU/T/xKQmOjRyuWTKB+XZkme/HSs+LIKLkATqHv2ruI4TvA0eAVO5yeI87b6IFjRek+LZ
	 C4Vaoi6FaGGgijjTG2PrZdluu6JGLJQ/oDI8awMCqkDLR3xJVql/IT9jCqm5ZtCgUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dz0E7Kj9;
	arc=none smtp.remote-ip=91.218.175.166
Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BC606A336
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6BC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dz0E7Kj9
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cobyEic3K4rQlDaxnpOiS2Ka0YizmJcjidFdjeRWkig=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794276059; v=1; x=1794880859;
 b=dz0E7Kj9b/NSYTSj4NX6x3J7nXkbvi2iOOs3qMrB74Mql0EIMR8s5f3CRLdRW/5yUBKP4i3g
 q7P7UjpyFVrWqio0fWmaYFjSdF3YjXbpMrq96nvUuHekbf3byfCilMRD/9shtRgt3Oym2FfN/vV
 FN/1NPuejyj9XYamAFNoE7b0=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id edf74e5d944b9c5a;
	Tue, 10 Nov 2026 02:00:59 +0000
X-Mizu-Trace-ID: edf74e5d944b9c5a
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v15 09/18] HID: asus: add support to force feedback
Date: Tue, 10 Nov 2026 02:00:27 +0000
Message-ID: <20261110020036.112884-10-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110020036.112884-1-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
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

Unlike ROG ally the X version and following ones uses DInput protocol
and the force feedback needs to be implemented as its protocol is
vendor-specific, therefore add support for FF_RUMBLE with magnitude
scaling on a work-queue based approach to avoid using possibly
sleeping calls in atomic context.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/Kconfig    |   1 +
 drivers/hid/hid-asus.c | 142 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..dd411f6eff4f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -189,6 +189,7 @@ config HID_ASUS
 	depends on USB_HID
 	depends on LEDS_CLASS
 	depends on ASUS_WMI || ASUS_WMI=n
+	select INPUT_FF_MEMLESS
 	select POWER_SUPPLY
 	help
 	Support for Asus notebook built-in keyboard and touchpad via i2c, and
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ea609ba43e0f..795916068662 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -22,6 +22,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cleanup.h>
+#include <linux/compiler.h>
 #include <linux/compiler_attributes.h>
 #include <linux/container_of.h>
 #include <linux/ctype.h>
@@ -30,6 +31,7 @@
 #include <linux/hid.h>
 #include <linux/jiffies.h>
 #include <linux/kstrtox.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -220,6 +222,23 @@ struct asus_touchpad_info {
 	int report_size;
 };
 
+/* Output report 0x0D on the gamepad interface. */
+struct ally_ff_data {
+	u8 enable;
+	u8 magnitude_left;
+	u8 magnitude_right;
+	u8 magnitude_strong;
+	u8 magnitude_weak;
+	u8 pulse_sustain_10ms;
+	u8 pulse_release_10ms;
+	u8 loop_count;
+} __packed;
+
+struct ally_ff_report {
+	u8 report_id;
+	struct ally_ff_data ff;
+} __packed;
+
 struct ally_intf {
 	struct hid_device *hdev;
 	/* HID-core evdev of this interface. Reports for it land here. */
@@ -236,6 +255,14 @@ struct ally_intf {
 	 */
 	bool sysfs_live;
 	bool cal_sysfs_live;
+	struct {
+		/* Guards live, update, and packet. */
+		spinlock_t lock;
+		bool live;
+		bool update;
+		struct ally_ff_report packet;
+		struct work_struct work;
+	} ff;
 	/* Deferred free through ally_free(): keeps the memory valid for RCU
 	 * readers that loaded drvdata->ally before the teardown unpublished
 	 * it (see hid_asus_ally_terminate()).
@@ -347,10 +374,15 @@ enum ally_command_codes {
 	CMD_SET_ANTI_DEADZONE           = 0x18,
 };
 
+/* Rumble magnitudes use the hardware's 0..100 intensity range. */
+#define ALLY_FF_MAX_INTENSITY 100
+
 static const u8 ally_force_feedback_off[] = {
 	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
 };
 
+static_assert(sizeof(struct ally_ff_report) == sizeof(ally_force_feedback_off));
+
 /*
  * Each Ally interface owns its own ally_intf. A report is delivered on the
  * evdev of the interface that received it. Nothing here points at another
@@ -2231,6 +2263,84 @@ static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev,
 	return input_dev;
 }
 
+static int ally_ff_output(struct hid_device *hdev, const void *buf, size_t len)
+{
+	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);
+
+	if (!dmabuf)
+		return -ENOMEM;
+
+	return hid_hw_output_report(hdev, dmabuf, len);
+}
+
+static int ally_ff_off(struct hid_device *hdev)
+{
+	return ally_ff_output(hdev, ally_force_feedback_off,
+			      sizeof(ally_force_feedback_off));
+}
+
+static void ally_ff_work_fn(struct work_struct *work)
+{
+	struct ally_intf *intf = container_of(work, struct ally_intf, ff.work);
+	struct ally_ff_report report;
+	bool update = false;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &intf->ff.lock) {
+		if (!intf->ff.update)
+			break;
+
+		report = intf->ff.packet;
+		intf->ff.update = false;
+		update = true;
+	}
+
+	if (!update)
+		return;
+
+	ret = ally_ff_output(intf->hdev, &report, sizeof(report));
+	if (ret < 0)
+		hid_err(intf->hdev, "Failed to send force-feedback: %d\n", ret);
+}
+
+static int ally_ff_play(struct input_dev *idev, void *data, struct ff_effect *effect)
+{
+	struct ally_intf *intf = input_get_drvdata(idev);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	guard(spinlock_irqsave)(&intf->ff.lock);
+
+	if (!intf->ff.live)
+		return 0;
+
+	intf->ff.packet.ff.magnitude_strong =
+		effect->u.rumble.strong_magnitude * ALLY_FF_MAX_INTENSITY / U16_MAX;
+	intf->ff.packet.ff.magnitude_weak =
+		effect->u.rumble.weak_magnitude * ALLY_FF_MAX_INTENSITY / U16_MAX;
+	intf->ff.update = true;
+	schedule_work(&intf->ff.work);
+	return 0;
+}
+
+static void ally_ff_quiesce(struct ally_intf *intf)
+{
+	int ret;
+
+	if (!intf || !intf->gamepad)
+		return;
+
+	scoped_guard(spinlock_irqsave, &intf->ff.lock)
+		intf->ff.live = false;
+
+	cancel_work_sync(&intf->ff.work);
+
+	ret = ally_ff_off(intf->hdev);
+	if (ret < 0)
+		hid_warn(intf->hdev, "Failed to stop force-feedback\n");
+}
+
 static int ally_x_setup_input(struct hid_device *hdev, struct ally_intf *intf)
 {
 	struct input_dev *input = ally_x_alloc_input_dev(hdev, intf);
@@ -2259,8 +2369,24 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_intf *intf)
 	input_set_capability(input, EV_KEY, BTN_THUMBL);
 	input_set_capability(input, EV_KEY, BTN_THUMBR);
 
+	spin_lock_init(&intf->ff.lock);
+	INIT_WORK(&intf->ff.work, ally_ff_work_fn);
+	memcpy(&intf->ff.packet, ally_force_feedback_off, sizeof(intf->ff.packet));
+	intf->ff.update = false;
+	intf->ff.live = false;
+
+	input_set_capability(input, EV_FF, FF_RUMBLE);
+	ret = input_ff_create_memless(input, NULL, ally_ff_play);
+	if (ret) {
+		hid_err(hdev, "Failed to create force-feedback: %d\n", ret);
+		input_free_device(input);
+		return ret;
+	}
+
+	intf->ff.live = true;
 	ret = input_register_device(input);
 	if (ret) {
+		intf->ff.live = false;
 		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
 		input_free_device(input);
 		return ret;
@@ -2459,6 +2585,14 @@ static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
 			hid_err(hdev, "Failed to create Ally X gamepad device.\n");
 			return ERR_PTR(ret);
 		}
+
+		/*
+		 * This is the interface that owns the rumble output report.
+		 * Failure to silence it is not fatal.
+		 */
+		ret = ally_ff_off(hdev);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to disable force-feedback: %d\n", ret);
 		break;
 	case HID_ALLY_INTF_KEYBOARD_IN:
 		break;
@@ -2481,6 +2615,13 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf
 		return 0;
 
 	ep = ally_get_endpoint_address(hdev);
+	if (ep == HID_ALLY_X_INTF_IN) {
+		ret = ally_ff_off(hdev);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to disable force-feedback: %d\n", ret);
+		return 0;
+	}
+
 	if (ep != HID_ALLY_INTF_CFG_IN)
 		return 0;
 
@@ -2529,6 +2670,7 @@ static struct ally_intf *hid_asus_ally_terminate(struct asus_drvdata *drvdata)
 	rcu_assign_pointer(drvdata->ally, NULL);
 
 	ally_quiesce(ally);
+	ally_ff_quiesce(ally);
 	ally_unregister_gamepad(ally);
 	ally_sysfs_remove(drvdata->hdev, ally);
 
-- 
2.47.3

