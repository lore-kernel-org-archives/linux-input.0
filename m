Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF63AFAF8;
	Mon,  1 Jun 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322944; cv=none; b=sAnaadsjUTvmxU2fxfEmwicg0RCzcI742+/en7EfTU+OFO4yo9fGsmK802RmvMuM1Pt9WOeDV0+4vSerXbz3CGnH6nF+TAWI1muQD8H6I25qXewbDHOVBo7heVoPbSIFdDHPVdZLlpwjApM1djNmCuFPznl7lslqjphEfuIhALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322944; c=relaxed/simple;
	bh=yVrQRzp7tcSaZ67AdEJQJD87DcgHGLd1xZ8ihNuPQzA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YQUa8dZeQUqWaJNspRfkUoHVwg6YEA2KIHh/7TYhLXhRqd+3WG8TIk0NHZu0oadsfzU7xKhMrLPF2Sy2gXPfBHqOd7GpD+93QcTwutqZK59OeLt3fiTkmSNbmL9hNuU4R26bqGnPPIpGf83aZFCVwtdzsE0EM3FCk3uUS1noPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m38xjdIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m38xjdIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEA91F00893;
	Mon,  1 Jun 2026 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322943;
	bh=P90fAscHLPm5b6+DqeAdj/b6SWbjnNY0YBSrUnKQZPE=;
	h=From:To:Subject:Date;
	b=m38xjdIkHgujhxSoaFNoBGXyGbdiPfl5f3effaAFrP3bJCMcHYju6Geq2ZRy4iggo
	 yUYptsHSNRCHZR+XfnLBQEzEm7UnF/8wrqClQ9yfTPptDXbO6Ji9S+40ZdAlDEynlF
	 O7kCtoQc3+baXO5JgK5w78/i426kEJlhcINe5mh3wdPKDv345nZn14aPvrOLysN9ac
	 Ccz3SO/5rtDDTXxGEsotW8RVLTrprm8XZx7eidIwp2NKx6TnsIsFRqGFeTLhKCz5jI
	 7qu1JPNGrr+O9zB9hwttQmJpz47lOyFt3n/WZjycLwfxbBHREqlG8NGg1nneTjgAHB
	 FxhS1KEUPo4aQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Date: Mon,  1 Jun 2026 15:08:37 +0100
Message-ID: <20260601140845.1237227-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() accesses wacom->shared->touch_input locklessly inside the
interrupt handler context.  If the Touch sibling device is disconnected,
wacom_remove_shared_data() clears 'touch_input' outside any lock, creating a
Time-of-Check to Time-of-Use (TOCTOU) race condition where a preempted reader in
interrupt context dereferences the freed pointer, leading to a Use-After-Free.

Resolve this by introducing RCU protection for the touch_input pointer:

 - Annotate 'touch_input' in wacom_shared struct with __rcu
 - Wrap lockless readers in wacom_wac.c with rcu_read_lock() and rcu_dereference()
 - Update writers in wacom_sys.c using rcu_assign_pointer()
 - Call synchronize_rcu() in wacom_remove_shared_data() to ensure all active RCU
   readers have finished before the input device is freed

To ensure the devres release order is correct and wacom_remove_shared_data()
completes its RCU synchronization BEFORE the input device is freed, move the
wacom_add_shared_data() call to the very end of wacom_parse_and_register().
Since devres actions are executed in LIFO order, this guarantees the shared
reference is cleared and synchronized before the input device resource is destroyed.

Also wrap wacom_set_shared_values() and touch/pen assignments in
wacom_add_shared_data() inside the wacom_udev_list_lock to serialize concurrent
probe assignments, and verify that 'shared->touch == hdev' before setting
touch_input to prevent concurrent sibling probe state desynchronization.

Fixes: 961794a00eab ("Input: wacom - add reporting of SW_MUTE_DEVICE events")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2: Split and use RCU as per Dmitry's review

 drivers/hid/wacom_sys.c | 49 +++++++++++++++++++++++++++--------------
 drivers/hid/wacom_wac.c | 17 +++++++++-----
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2220168bf116..26fce6d3198a 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
-		if (wacom_wac->shared->touch == wacom->hdev)
+		mutex_lock(&wacom_udev_list_lock);
+		if (wacom_wac->shared->touch == wacom->hdev) {
 			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == wacom->hdev)
+			rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
+		} else if (wacom_wac->shared->pen == wacom->hdev) {
 			wacom_wac->shared->pen = NULL;
+		}
+		mutex_unlock(&wacom_udev_list_lock);
+
+		synchronize_rcu();
 
 		kref_put(&data->kref, wacom_release_shared_data);
 		wacom_wac->shared = NULL;
@@ -909,6 +915,11 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		list_add_tail(&data->list, &wacom_udev_list);
 	}
 
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
+		data->shared.touch = hdev;
+	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
+		data->shared.pen = hdev;
+
 	mutex_unlock(&wacom_udev_list_lock);
 
 	wacom_wac->shared = &data->shared;
@@ -917,11 +928,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 	if (retval)
 		return retval;
 
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		wacom_wac->shared->pen = hdev;
-
 	return retval;
 }
 
@@ -2345,9 +2351,15 @@ static void wacom_release_resources(struct wacom *wacom)
 
 static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+
+	mutex_lock(&wacom_udev_list_lock);
+
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		wacom_wac->shared->type = wacom_wac->features.type;
-		wacom_wac->shared->touch_input = wacom_wac->touch_input;
+		if (wacom_wac->shared->touch == wacom->hdev) {
+			wacom_wac->shared->type = wacom_wac->features.type;
+			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
+		}
 	}
 
 	if (wacom_wac->has_mute_touch_switch) {
@@ -2362,11 +2374,14 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 	}
 
 	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
+	    rcu_access_pointer(wacom_wac->shared->touch_input)) {
+		struct input_dev *touch_input = rcu_dereference_protected(wacom_wac->shared->touch_input,
+									lockdep_is_held(&wacom_udev_list_lock));
+		set_bit(EV_SW, touch_input->evbit);
+		input_set_capability(touch_input, EV_SW, SW_MUTE_DEVICE);
 	}
+
+	mutex_unlock(&wacom_udev_list_lock);
 }
 
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
@@ -2442,10 +2457,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail;
 	}
 
-	error = wacom_add_shared_data(hdev);
-	if (error)
-		goto fail;
-
 	error = wacom_setup_inputs(wacom);
 	if (error)
 		goto fail;
@@ -2496,6 +2507,10 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		}
 	}
 
+	error = wacom_add_shared_data(hdev);
+	if (error)
+		goto fail_quirks;
+
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..c7cf1aaab903 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -650,11 +650,18 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	input_report_key(input, KEY_CONTROLPANEL, menu);
 	input_report_key(input, KEY_INFO, info);
 
-	if (wacom->shared && wacom->shared->touch_input) {
-		input_report_switch(wacom->shared->touch_input,
-				    SW_MUTE_DEVICE,
-				    !wacom->shared->is_touch_on);
-		input_sync(wacom->shared->touch_input);
+	if (wacom->shared) {
+		struct input_dev *touch_input;
+
+		rcu_read_lock();
+		touch_input = rcu_dereference(wacom->shared->touch_input);
+		if (touch_input) {
+			input_report_switch(touch_input,
+					    SW_MUTE_DEVICE,
+					    !wacom->shared->is_touch_on);
+			input_sync(touch_input);
+		}
+		rcu_read_unlock();
 	}
 
 	input_report_abs(input, ABS_RX, strip1);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 126bec6e5c0c..a8bbba4a6f37 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -285,7 +285,7 @@ struct wacom_shared {
 	/* for wireless device to access USB interfaces */
 	unsigned touch_max;
 	int type;
-	struct input_dev *touch_input;
+	struct input_dev __rcu *touch_input;
 	struct hid_device *pen;
 	struct hid_device *touch;
 	bool has_mute_touch_switch;
-- 
2.54.0.823.g6e5bcc1fc9-goog

