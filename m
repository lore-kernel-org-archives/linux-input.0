Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4C484258
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632473; cv=none; b=taiCMdwPQywpMTEaFmLsbDfdZwE5tP3NTgq4ExE+vXHBD2uF6vVBpryqr9uYkPBcrhc6foMXYRUswK0VzJF2pp4RH09G89y0OItSGLST4WQgUKo6X+puSLbkXfoYtPKcGkwSlUwJ/HasJZsJwUnsp0Pp93PCEk4unJtdyJSDd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632473; c=relaxed/simple;
	bh=yiihpTdAnIjOGeTjRFcMu3Ke4GMLh8r3w5k5KjT2cvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUgo8zxS+EudMUo2p5UUkPrU5gGoOTZ4CS2EEQQzpe4PWmn7JjFcEfKP0rlK1osiLdAeGJ2iKWKoY9Q6jTPWxAECnaNciTaWkVK2ZpMiMxOXJHLsYQAxDe5wwgbb4+veEwFTx2IPQB34PVN/NMf/GwOXUzLMvLoQuf2j0IjJ7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKsQXgpJ; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKsQXgpJ"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yiihpTdAnIjOGeTjRFcMu3Ke4GMLh8r3w5k5KjT2cvo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632466; v=1; x=1787237266;
 b=xKsQXgpJ/SMLn/Ie/JjChnsBnMTXmWqBESLQ6g8Ghyvdl+u8ta566mUBWIKAvGN7NB/PkWlP
 hR604iPjKhhGIvasTMYJq1FE30TyyOHi0Utfp+EAF413l/ZxJqMxSj4wjgJIN9UGzTE1+s0yr+R
 vo/lgKx3F9lQ0Fua0RwPpw10=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 8f565c6c9cfcf026;
	Thu, 13 Aug 2026 14:47:46 +0000
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
Subject: [PATCH 09/12] HID: asus: add support to force feedback
Date: Thu, 13 Aug 2026 14:47:33 +0000
Message-ID: <20260813144736.2477941-10-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144736.2477941-1-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
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

Assisted-by: VSCode:gpt-5.3-codex
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 8018e61cf026..301fe33f66b1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -248,6 +248,23 @@ struct ally_config {
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
@@ -256,6 +273,13 @@ struct ally_handheld {
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
 
@@ -370,9 +394,13 @@ enum ally_command_codes {
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
@@ -2254,6 +2282,59 @@ static bool ally_x_raw_event(struct input_dev *input, struct hid_device *hdev,
 	return true;
 }
 
+static void ally_x_ff_work_fn(struct work_struct *work)
+{
+	struct ally_handheld *ally =
+		container_of(work, struct ally_handheld, ff_work);
+	struct hid_device *hdev = NULL;
+	struct ff_report report;
+	bool update = false;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &ally->ff_lock) {
+		if (ally->update_ff) {
+			report = ally->ff_packet;
+			ally->update_ff = false;
+			update = true;
+			hdev = ally->ally_x_hdev;
+		}
+	}
+
+	if (!update || !hdev)
+		return;
+
+	ret = ally_gamepad_send_packet(ally, hdev, (u8 *)&report, sizeof(report));
+	if (ret < 0)
+		hid_err(hdev, "Failed to send force-feedback: %d\n", ret);
+}
+
+static int ally_x_play_effect(struct input_dev *idev, void *data,
+			     struct ff_effect *effect)
+{
+	struct ally_handheld *ally = &ally_drvdata;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	/*
+	 * Both the flag and the queueing must happen under ff_lock: removal
+	 * clears the flag under the same lock before cancel_work_sync(), so an
+	 * unlocked test here could queue work again after the cancel.
+	 */
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
@@ -2308,6 +2389,16 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
 	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
 	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
 
+	memcpy(&ally->ff_packet, ALLY_FORCE_FEEDBACK_OFF, sizeof(ally->ff_packet));
+	spin_lock_init(&ally->ff_lock);
+	INIT_WORK(&ally->ff_work, ally_x_ff_work_fn);
+	ally->ff_work_initialized = true;
+
+	input_set_capability(input, EV_FF, FF_RUMBLE);
+	ret = input_ff_create_memless(input, NULL, ally_x_play_effect);
+	if (ret)
+		hid_warn(hdev, "Failed to create force-feedback: %d\n", ret);
+
 	ret = input_register_device(input);
 	if (ret) {
 		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
@@ -2460,6 +2551,9 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 
 	scoped_guard(mutex, &ally_data_mutex) {
 		if (ally->ally_x_hdev == hdev) {
+			scoped_guard(spinlock_irqsave, &ally->ff_lock)
+				ally->ff_work_initialized = false;
+			cancel_work_sync(&ally->ff_work);
 			ally->ally_x_input = NULL;
 			ally->ally_x_hdev = NULL;
 		}
-- 
2.47.3

