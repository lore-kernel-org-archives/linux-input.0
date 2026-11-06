Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975073;
	b=0GYo2QtWCFnEjU66lhZC5DFBuBuIWlGgJOZyXgtDBjPqLHW7oiY0uUGZST5+gfk/aTjB
	 hM1rGEDeoPKDPJZhgHNG1BxzHZ5MNT/8xXvncywS1w4zxe+HyjnjMhI+Zk4K3xTrfLK+Y
	 f5o/COl8Luihg5ZL4/rGoYd8IcGMdV+HAiFKFGYgyb+tg70Ci0JRGv4OEtU8Xb+LinBsO
	 IdM1p59KZ2YgvchveYzDIt7TJ3VVb5Zb/ch4BvF5xKhGLYdzCltyCcxV22YJeybQoZSqI
	 vP4bdNZpMcFXYogii6tBT80R6qVtiCJ8UvnKl238qPcLgCllyowPnU+LyEnQZQzr2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975073;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1uBeIIjWbPXUBn8/XJDw8EAN+odcevX6tnug1cbKb50=;
	b=zlzzc+De/I71Gnivq/wg469MhvL6UTeOrLhe/Na7fudNEbCF99r/Wg/7mrHSw/kmjecS
	 rpWlLKDJCoX7ReMnoy+Xc190ylBYYZu6fHLHEIY1o3F3xM2HQRJziR+P9hBg/HO3Jb332
	 1he3YtQmg1uwWVEuNyWioam0h+Dq3WXnOMLqywZNJ4aZtNKtgtEtfz/8AwkXzVUN3jNSV
	 XyFXz2SoyUVK/nmduLYuj0Nchd5iLB1YvQsPpAC6TPpaZ65EQ9VMIcevtdnpXN9/c28Vi
	 d72m8buh6gFQGGAGedGLERZXPNFUjGmUFxQ5MMjT3RCVIn3qByFCigl18XWWGkePK+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TLMDT5Ik;
	arc=none smtp.remote-ip=91.218.175.205
Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C40606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C40606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TLMDT5Ik
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9iSuG7fAEVMgysYZ4XRnUChZdmhzrRBolFQ/C08XMbg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975070; v=1; x=1794579870;
 b=TLMDT5Ik9sie6s12w5EOk4jnRYtpy6f69FpcIAPf72955dQl8lNswY6DI24FmVzoGtam7K9p
 Cojf1xHfPm6Qqo+x9sfEBsAw00Gn8Tw0nB3TobOlLU2Uk/NGzIPULKFryvzYj5VSIkQWuoPbCE0
 R7Yv+QEtpwGH53uBXnpISPMs=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d0c38a789e8a819f;
	Fri, 06 Nov 2026 14:24:30 +0000
X-Mizu-Trace-ID: d0c38a789e8a819f
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Khamunetri Clark <khamunetriclark@gmail.com>
Subject: [PATCH v14 09/18] HID: asus: add support to force feedback
Date: Fri,  6 Nov 2026 14:23:25 +0000
Message-ID: <20261106142334.1881-10-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106142334.1881-1-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
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
index 3779effe8457..bb3475a038b8 100644
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
@@ -2230,6 +2262,84 @@ static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev,
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
@@ -2258,8 +2368,24 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_intf *intf)
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
@@ -2458,6 +2584,14 @@ static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
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
@@ -2480,6 +2614,13 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf
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
 
@@ -2528,6 +2669,7 @@ static struct ally_intf *hid_asus_ally_terminate(struct asus_drvdata *drvdata)
 	rcu_assign_pointer(drvdata->ally, NULL);
 
 	ally_quiesce(ally);
+	ally_ff_quiesce(ally);
 	ally_unregister_gamepad(ally);
 	ally_sysfs_remove(drvdata->hdev, ally);
 
-- 
2.47.3

