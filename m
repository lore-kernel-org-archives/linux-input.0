Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC13655E9
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133417; cv=none; b=VcP4lLHOJN8pgPm4dTP+5qkS1vpQ6swbJpd3BWbC5/OOENY2pOt8M1reeUWUp2fi48h1h8OEgk4KxkEW1YIw651JCWMr+TWnLZi4593oO4fMKd77pPFfiJkO8Z1rswvjEDS02iofMk7uaREgBNBLd5RKdaNfN5uZwnIkB/B41fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133417; c=relaxed/simple;
	bh=HfLJj2+eaQOsXTaewA6mV9d2yjfRfAfayvXNXSnLFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aThL39WL1dpX540M1Tt4d2SxHPqAWdwfqbAwwwB9SRUXsrM9ygCJ+lbz83Orf1WoqXB0swlEnCwyGvI1u+36faxo/IxqFYjdTz/blm1n84sLj+ufy/aDBNOHdIqFXsxHCrH9iZNUQMu2v9LHnPFp6X3ggSksmu7sNk9ao+K3N9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jiNQ+Rj+; arc=none smtp.client-ip=91.218.175.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jiNQ+Rj+"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HfLJj2+eaQOsXTaewA6mV9d2yjfRfAfayvXNXSnLFpE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788133413; v=1; x=1788738213;
 b=jiNQ+Rj+FohCADFRj6ct2G27U1FCl1t5H3S901QujViNjuUN4pTxOwIHMyfQhpHB/P4q7UGu
 j8AYYMa94zUpmmdCK1p5AoFxDO2HOsZj8weLk8DCkos6B77sAB9dSZ4uqX5whR7T5AOawknQUIw
 riHV6VsV+/NlRTTalKFqXBPk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bb4b5f96da3df124;
	Sun, 30 Aug 2026 23:43:33 +0000
X-Mizu-Trace-ID: bb4b5f96da3df124
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v4 10/13] HID: asus: add support to force feedback
Date: Sun, 30 Aug 2026 23:43:17 +0000
Message-ID: <20260830234320.114356-11-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830234320.114356-1-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike ROG ally the X version and following ones uses DInput protocol
and the force feedback needs to be implemented as its protocol is
vendor-specific, therefore add support for FF_RUMBLE with magnitude
scaling on a work-queue based approach to avoid using possibly
sleeping calls in atomic context.

Assisted-by: opencode:glm-5.2
Assisted-by: VSCode:gpt-5.3-codex
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/Kconfig    |   1 +
 drivers/hid/hid-asus.c | 233 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 225 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index aa7fa11a0197..05cd20139526 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -189,6 +189,7 @@ config HID_ASUS
 	depends on USB_HID
 	depends on LEDS_CLASS
 	depends on ASUS_WMI || ASUS_WMI=n
+        select INPUT_FF_MEMLESS
 	select POWER_SUPPLY
 	help
 	Support for Asus notebook built-in keyboard and touchpad via i2c, and
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bd488acdb5d4..61330ae082b1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -235,6 +235,23 @@ struct ally_config {
 	struct ally_joystick_resp_curve right_curve;
 };
 
+/* XInput force-feedback report (output report 0x0d, gamepad interface) */
+struct ff_data {
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
+struct ff_report {
+	u8 report_id;
+	struct ff_data ff;
+} __packed;
+
 struct ally_handheld {
 	/* All read/write to IN interfaces must lock */
 	struct mutex intf_mutex;
@@ -249,6 +266,13 @@ struct ally_handheld {
 	struct input_dev *ally_x_input;
 	struct hid_device *ally_x_hdev;
 
+	struct ff_report ff_packet;
+	struct work_struct ff_work;
+	/* Serializes ff_packet and update_ff between play_effect and ff_work */
+	spinlock_t ff_lock;
+	bool ff_work_initialized;
+	bool update_ff;
+
 	struct hid_device *keyboard_hdev;
 	struct input_dev *keyboard_input;
 
@@ -363,9 +387,13 @@ enum ally_command_codes {
 	CMD_SET_ANTI_DEADZONE           = 0x18,
 };
 
+/* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
+#define ALLY_FF_MAX_INTENSITY 100
+
 static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
 	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
 };
+static_assert(sizeof(struct ff_report) == sizeof(ALLY_FORCE_FEEDBACK_OFF));
 
 /*
  * The ROG Ally device presents multiple USB interfaces (keyboard, mouse, gamepad,
@@ -374,6 +402,7 @@ static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
  * ally_handheld structure to share state across these separate HID interfaces.
  */
 static void ally_resume_work_fn(struct work_struct *work);
+static void ally_x_ff_work_fn(struct work_struct *work);
 
 /*
  * Changes to ally_drvdata must lock: the raw_event callbacks, which may
@@ -389,6 +418,13 @@ static struct ally_handheld ally_drvdata = {
 	 */
 	.resume_work = __DELAYED_WORK_INITIALIZER(ally_drvdata.resume_work,
 						  ally_resume_work_fn, 0),
+	/*
+	 * Initialised statically for the same reason as resume_work: remove()
+	 * drains the work whichever of the interfaces probed or failed to
+	 * probe, so it must be safe to cancel unconditionally.
+	 */
+	.ff_work = __WORK_INITIALIZER(ally_drvdata.ff_work, ally_x_ff_work_fn),
+	.ff_lock = __SPIN_LOCK_UNLOCKED(ally_drvdata.ff_lock),
 };
 
 /*
@@ -2681,6 +2717,102 @@ static void ally_x_input_close(struct input_dev *dev)
 	hid_hw_close(input_get_drvdata(dev));
 }
 
+/**
+ * ally_x_send_ff_report() - Send a force-feedback report to the gamepad
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @buf: buffer containing the report to send
+ * @len: length of the report
+ *
+ * The gamepad interface consumes force-feedback packets as output reports,
+ * unlike the config interface which expects feature reports: a rumble packet
+ * sent as HID_REQ_SET_REPORT would be rejected by the hardware.
+ *
+ * Return: count of data transferred, negative if error
+ */
+static int ally_x_send_ff_report(struct ally_handheld *ally,
+				 struct hid_device *hdev,
+				 const u8 *buf, size_t len)
+{
+	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	guard(mutex)(&ally->intf_mutex);
+
+	return hid_hw_output_report(hdev, dmabuf, len);
+}
+
+static int ally_x_send_ff_off(struct ally_handheld *ally, struct hid_device *hdev)
+{
+	return ally_x_send_ff_report(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
+				     sizeof(ALLY_FORCE_FEEDBACK_OFF));
+}
+
+static void ally_x_ff_work_fn(struct work_struct *work)
+{
+	struct ally_handheld *ally =
+		container_of(work, struct ally_handheld, ff_work);
+	struct hid_device *hdev = NULL;
+	struct ff_report report;
+	unsigned long flags;
+	bool update = false;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &ally->ff_lock) {
+		if (ally->update_ff) {
+			report = ally->ff_packet;
+			ally->update_ff = false;
+			update = true;
+		}
+	}
+
+	if (!update)
+		return;
+
+	/*
+	 * The hdev pointer is published and cleared under ally_data_lock:
+	 * take a reference on it so the gamepad interface cannot be freed
+	 * under us while the report is being sent.
+	 */
+	spin_lock_irqsave(&ally_data_lock, flags);
+	hdev = ally->ally_x_hdev;
+	if (hdev)
+		get_device(&hdev->dev);
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	if (!hdev)
+		return;
+
+	ret = ally_x_send_ff_report(ally, hdev, (u8 *)&report, sizeof(report));
+	if (ret < 0)
+		hid_err(hdev, "Failed to send force-feedback: %d\n", ret);
+
+	put_device(&hdev->dev);
+}
+
+static int ally_x_play_effect(struct input_dev *idev, void *data,
+			      struct ff_effect *effect)
+{
+	struct ally_handheld *ally = &ally_drvdata;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	scoped_guard(spinlock_irqsave, &ally->ff_lock) {
+		ally->ff_packet.ff.magnitude_strong =
+			effect->u.rumble.strong_magnitude * ALLY_FF_MAX_INTENSITY / 65535;
+		ally->ff_packet.ff.magnitude_weak =
+			effect->u.rumble.weak_magnitude * ALLY_FF_MAX_INTENSITY / 65535;
+		ally->update_ff = true;
+
+		if (ally->ff_work_initialized)
+			schedule_work(&ally->ff_work);
+	}
+
+	return 0;
+}
+
 static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev)
 {
 	struct input_dev *input_dev = devm_input_allocate_device(&hdev->dev);
@@ -2743,6 +2875,30 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
 	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
 	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
 
+	memcpy(&ally->ff_packet, ALLY_FORCE_FEEDBACK_OFF, sizeof(ally->ff_packet));
+	ally->ff_work_initialized = true;
+
+	input_set_capability(input, EV_FF, FF_RUMBLE);
+
+	/*
+	 * A registered device advertising FF_RUMBLE without the memless core
+	 * behind it would crash input_ff_upload(): fail the whole setup instead.
+	 */
+	ret = input_ff_create_memless(input, NULL, ally_x_play_effect);
+	if (ret) {
+		hid_err(hdev, "Failed to create force-feedback: %d\n", ret);
+		goto ally_x_setup_input_err;
+	}
+
+	/*
+	 * Publish the interface before the input device becomes visible to
+	 * userspace: an effect uploaded right after registration would
+	 * otherwise find a NULL hdev and get dropped.
+	 */
+	spin_lock_irqsave(&ally_data_lock, flags);
+	ally->ally_x_hdev = hdev;
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
 	ret = input_register_device(input);
 	if (ret) {
 		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
@@ -2756,19 +2912,43 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
 
 	return 0;
 ally_x_setup_input_err:
+	spin_lock_irqsave(&ally_data_lock, flags);
+	if (ally->ally_x_hdev == hdev)
+		ally->ally_x_hdev = NULL;
+	spin_unlock_irqrestore(&ally_data_lock, flags);
 	return ret;
 }
 
 static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
 {
+	struct hid_device *x_hdev;
 	struct ally_config *cfg;
+	unsigned long flags;
 	int ret;
 
-	/* Failure at this point is non-critical */
-	ret = ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
-				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
-	if (ret < 0)
-		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
+	/*
+	 * The force-feedback "off" packet belongs to the gamepad interface,
+	 * which consumes it as an output report: the config interface probed
+	 * here would reject it. The gamepad probe path sends the packet itself,
+	 * so this only matters when the gamepad interface is already bound,
+	 * e.g. after a reset resume that re-initialized the MCU.
+	 */
+	spin_lock_irqsave(&ally_data_lock, flags);
+	x_hdev = ally->ally_x_hdev;
+	if (x_hdev)
+		get_device(&x_hdev->dev);
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	if (x_hdev) {
+		/* Failure at this point is non-critical */
+		ret = ally_x_send_ff_off(ally, x_hdev);
+
+		if (ret < 0)
+			hid_err(hdev, "Ally failed to init force-feedback off: %d\n",
+				ret);
+
+		put_device(&x_hdev->dev);
+	}
 
 	cfg = ally_get_config(ally);
 	if (!cfg)
@@ -2939,9 +3119,14 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 			return ERR_PTR(ret);
 		}
 
-		spin_lock_irqsave(&ally_data_lock, flags);
-		ally_drvdata.ally_x_hdev = hdev;
-		spin_unlock_irqrestore(&ally_data_lock, flags);
+		/*
+		 * Make sure rumble starts disabled: this is the interface that
+		 * owns the force-feedback output report. Failure is non-critical.
+		 */
+		ret = ally_x_send_ff_off(&ally_drvdata, hdev);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to disable force-feedback: %d\n", ret);
+
 		break;
 	case HID_ALLY_INTF_KEYBOARD_IN:
 		spin_lock_irqsave(&ally_data_lock, flags);
@@ -2964,6 +3149,7 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 {
 	struct ally_config *cfg = NULL;
 	unsigned long flags;
+	bool owns_xpad;
 	bool owns_cfg;
 
 	if (!ally)
@@ -2978,7 +3164,36 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 	cancel_delayed_work_sync(&ally->resume_work);
 
 	spin_lock_irqsave(&ally_data_lock, flags);
-	if (ally->ally_x_hdev == hdev) {
+	owns_xpad = ally->ally_x_hdev == hdev;
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	if (owns_xpad) {
+		/*
+		 * Stop queueing force-feedback work before the gamepad
+		 * pointers are cleared: play_effect() tests the flag under the
+		 * same lock, so no work can be queued past the cancel below.
+		 */
+		scoped_guard(spinlock_irqsave, &ally->ff_lock)
+			ally->ff_work_initialized = false;
+
+		/*
+		 * cancel_work_sync() may sleep: keep it out of ally_data_lock,
+		 * but run it before the pointers are cleared so in-flight work
+		 * cannot outlive the interface it sends through.
+		 */
+		cancel_work_sync(&ally->ff_work);
+
+		/*
+		 * The input core can no longer stop effects through the
+		 * disabled work: quiesce any rumble still playing ourselves,
+		 * or the device would keep vibrating after being unbound.
+		 */
+		if (ally_x_send_ff_off(ally, hdev) < 0)
+			hid_warn(hdev, "Failed to stop force-feedback\n");
+	}
+
+	spin_lock_irqsave(&ally_data_lock, flags);
+	if (owns_xpad) {
 		ally->ally_x_input = NULL;
 		ally->ally_x_hdev = NULL;
 	}
-- 
2.47.3

