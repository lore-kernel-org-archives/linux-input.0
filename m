Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A03FBB50;
	Tue,  7 Jul 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426269; cv=none; b=Fvh48fp6hJTLeC6UZV2GVoWgSEjaR6l7KV8eT6Dnpkgego3HX8d+OXcS2BVANlMUAT1yiQpJJogY1dBj5gMtkD1RU/8Ktke9slvDBtxbkjkLLKG4HBTljU50QdVshjN3rQG9ZPOYoruzTjXrMZfmX1aussfMsOaHAfLzELcvrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426269; c=relaxed/simple;
	bh=X2RH7suBswLyYQeOL/YFBP25S5l65QSfkcED5qGB0IY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niRWiEvgSvqCeQNyq5Up1QbpvMSBschjqtl8/08m7pSw7e1OVNSq9dHInmJwlPYD+gFyft6F1aPxw/4GowiyJ6D0G6ETUbRA+V1dlq+ei5E9pP3EXXdEAjMFU1ew+eK/klxElWBRPHEpumAcNqyWbdswB+DXYfdZCV9MqJ4cD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSTwxtfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSTwxtfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967821F00A3D;
	Tue,  7 Jul 2026 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783426267;
	bh=8ctzs3m/Po3GUYIbDuC77s8xP+6x0FOAOGrwy5o+w7M=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=dSTwxtfHYdAyC+1qFMJz/d7PPxKVGnGYc/DIxzep58dkB0ofCbTnx6BIL0XWLAsio
	 3pCiSge6raohEBft1MBqxAyfKubkGP6nKzjhGk7DVxAo3t+/dIiLMqrRT9SXmV1egw
	 DVziwuSqg6L62GJWT2uqi+81B9bIajQ/aoTARI12hcxIJEyCK/nVanUVraFibWaxPx
	 jMp6B4RajZl8mLs79ySWNnB6XtmTlVcq7eO+m82dkIPWpucErgClIzQ1QyFCQOnsx9
	 cjVKQt383ey0RT1ENSu4OIBiOtXlplTO20KakEn3ERBmP5U5JyZSUdCQyXrmkv+0A8
	 u4yHQ6qiiI7VQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Date: Tue,  7 Jul 2026 12:10:41 +0000
Message-ID: <20260707121051.1683937-2-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260707121051.1683937-1-lee@kernel.org>
References: <20260707121051.1683937-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
inside the interrupt handler context.  If the Touch sibling device
is disconnected, wacom_remove_shared_data() clears 'touch_input'
outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
race condition where a preempted reader in interrupt context
dereferences the freed pointer, leading to a Use-After-Free.

Resolve this by introducing RCU protection for the touch_input
pointer:

 - Annotate 'touch_input' in wacom_shared struct with __rcu
 - Wrap all lockless readers in wacom_wac.c with guard(rcu)() and
   rcu_dereference() using a unified wacom_report_touch_mute()
   helper
 - Update writers in wacom_sys.c using rcu_assign_pointer()
 - Call synchronize_rcu() in wacom_remove_shared_data() to ensure
   all active RCU readers have finished before the input device is
   freed

Also wrap wacom_set_shared_values() and touch/pen assignments in
wacom_add_shared_data() inside the wacom_udev_list_lock to serialize
concurrent probe assignments, and verify that 'shared->touch == hdev'
before setting touch_input to prevent concurrent sibling probe state
desynchronization.

Fixes: 961794a00eab ("Input: wacom - add reporting of SW_MUTE_DEVICE events")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes
v3 -> v4: Dmitry's review [redundant check and guard()]
v4 -> v5: Jason's review [split, remove "awkward if"]

 drivers/hid/wacom_sys.c | 35 +++++++++++++++++++++++------------
 drivers/hid/wacom_wac.c | 36 ++++++++++++++++++------------------
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 60b380efdfb7..86895f13dbae 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
-		if (wacom_wac->shared->touch == wacom->hdev)
-			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == wacom->hdev)
-			wacom_wac->shared->pen = NULL;
+		scoped_guard(mutex, &wacom_udev_list_lock) {
+			if (wacom_wac->shared->touch == wacom->hdev) {
+				wacom_wac->shared->touch = NULL;
+				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
+			} else if (wacom_wac->shared->pen == wacom->hdev) {
+				wacom_wac->shared->pen = NULL;
+			}
+		}
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
+	guard(mutex)(&wacom_udev_list_lock);
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
@@ -2360,7 +2372,6 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		if (wacom_wac->is_soft_touch_switch)
 			wacom_wac->shared->is_touch_on = true;
 	}
-
 }
 
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a31325be50f8..f3429a2c8f36 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -510,6 +510,18 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
 	}
 }
 
+static void wacom_report_touch_mute(struct wacom_wac *wacom_wac, bool mute)
+{
+	struct input_dev *touch_input;
+
+	guard(rcu)();
+	touch_input = rcu_dereference(wacom_wac->shared->touch_input);
+	if (touch_input) {
+		input_report_switch(touch_input, SW_MUTE_DEVICE, mute);
+		input_sync(touch_input);
+	}
+}
+
 static int wacom_intuos_pad(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -650,12 +662,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	input_report_key(input, KEY_CONTROLPANEL, menu);
 	input_report_key(input, KEY_INFO, info);
 
-	if (wacom->shared && wacom->shared->touch_input) {
-		input_report_switch(wacom->shared->touch_input,
-				    SW_MUTE_DEVICE,
-				    !wacom->shared->is_touch_on);
-		input_sync(wacom->shared->touch_input);
-	}
+	if (wacom->shared)
+		wacom_report_touch_mute(wacom, !wacom->shared->is_touch_on);
 
 	input_report_abs(input, ABS_RX, strip1);
 	input_report_abs(input, ABS_RY, strip2);
@@ -2153,7 +2161,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	 */
 	if ((equivalent_usage == WACOM_HID_WD_MUTE_DEVICE) ||
 	   (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)) {
-		if (wacom_wac->shared->touch_input) {
+		if (wacom_wac->shared) {
 			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
 
 			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
@@ -2161,9 +2169,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
 				*is_touch_on = value;
 
-			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !(*is_touch_on));
-			input_sync(wacom_wac->shared->touch_input);
+			wacom_report_touch_mute(wacom_wac, !(*is_touch_on));
 		}
 		return;
 	}
@@ -3381,11 +3387,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 		if ((wacom->shared->type == INTUOSHT ||
 		    wacom->shared->type == INTUOSHT2) &&
-		    wacom->shared->touch_input &&
 		    wacom->shared->touch_max) {
-			input_report_switch(wacom->shared->touch_input,
-					SW_MUTE_DEVICE, data[5] & 0x40);
-			input_sync(wacom->shared->touch_input);
+			wacom_report_touch_mute(wacom, data[5] & 0x40);
 		}
 
 		pid = get_unaligned_be16(&data[6]);
@@ -3420,11 +3423,8 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	if ((features->type == INTUOSHT ||
 	    features->type == INTUOSHT2) &&
-	    wacom_wac->shared->touch_input &&
 	    features->touch_max) {
-		input_report_switch(wacom_wac->shared->touch_input,
-				    SW_MUTE_DEVICE, data[8] & 0x40);
-		input_sync(wacom_wac->shared->touch_input);
+		wacom_report_touch_mute(wacom_wac, data[8] & 0x40);
 	}
 
 	if (data[9] & 0x02) { /* wireless module is attached */
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
2.55.0.rc2.803.g1fd1e6609c-goog

