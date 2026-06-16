Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BE4218B4;
	Tue, 16 Jun 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602035; cv=none; b=ff3GxpjSlYdpOHYFZjCR/Kq8aQNedZMlw9duB2rA8R1l2RJYiwn82t0vQDr6fd1VI1XdKCo5O3osdnBfo6E5XJDs7hEtQYosTZU6JNWU4EzbAjrYqJWFLLjA6QU7LLBKny2s9VnKCuT4VktgiMdmCOMSr6ljZ/5KarFlQFUZl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602035; c=relaxed/simple;
	bh=p1fWYtFWpi6rVAj1mOV1VgBde4CTTSP9oAyr3hKBs7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puCe6qNGDTyhlBAqtfTeqb/ehMHw8a8ntfDcnwDGme2Xf33pkuEW0wMQSPNg2IgWurczrynmfb0R+XWVAYglmT5LyiSQyEl3mIC2JQ3Xyk8e4MKyvSpbTXZDXY14bspjsqgsLkI1Xlm3oTKzjNwHQ6dxrEZqK50Z8EjvM1JvlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osphoAeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osphoAeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B142A1F000E9;
	Tue, 16 Jun 2026 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781602034;
	bh=jtO7fH1au0bUoO9+S5Hr6Tq+O95SWec7DRMD2ndsuJA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=osphoAeIO2ZRGKH2tfqOI1Tq+P9Yoe2U0wNh9mKlCnw6wf1+dmLFbSAsjsxeczGiU
	 /BNie6zMuK+NrlJsmscIRA+9VqKzPU4+H4peRcPT/gBr10ZVa3ZrvGFaj9SSjrTDYf
	 jafBttyiL3BiL05U+nLoneIk8LSSBUVJ/uhtnEVkcrIU6SlpQcU2E9a6ns/jdsgD5X
	 A7V4qQ7VLSKB8JYpZtdXdsUACArVpvhIqb8KVqeEXZ6r4iPoIEGmjeox6JpD78EvaO
	 gbowGYdUY6OUvGhjRssH79EPVknYUHxUtdCwiqGFDPA5N6FPXZ/UkRJzsbgRKpIy9b
	 lCO/qcRD8QDHQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Date: Tue, 16 Jun 2026 09:26:50 +0000
Message-ID: <20260616092658.1714548-2-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616092658.1714548-1-lee@kernel.org>
References: <20260616092658.1714548-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_bamboo_pad_pen_event() accesses wacom->shared->pen locklessly
relative to wacom_remove_shared_data() which nullifies it.  This
can lead to a Use-After-Free if the sibling device is removed while
events are being processed.

Resolve this by introducing RCU protection for pen and touch
pointers:

 - Annotate 'pen' and 'touch' in wacom_shared struct with __rcu.
 - Wrap lockless readers in wacom_bamboo_pad_pen_event() with
   rcu_read_lock() and rcu_dereference().
 - Update writers in wacom_sys.c using rcu_assign_pointer().
 - Use rcu_dereference_protected for comparisons under
   wacom_udev_list_lock.
 - Also use rcu_access_pointer in wacom_mode_change_work() to avoid
   warnings (while lockless access there remains a pre-existing issue).

Fixes: 8c97a765467c ("HID: wacom: add full support of the Wacom Bamboo PAD")
Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes
v3 -> v4: Dmitry's review [guard()]

 drivers/hid/wacom_sys.c | 36 +++++++++++++++++++++++++-----------
 drivers/hid/wacom_wac.c | 13 ++++++-------
 drivers/hid/wacom_wac.h |  4 ++--
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 86895f13dbae..3990d8d0b40c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -878,11 +878,18 @@ static void wacom_remove_shared_data(void *res)
 				    shared);
 
 		scoped_guard(mutex, &wacom_udev_list_lock) {
-			if (wacom_wac->shared->touch == wacom->hdev) {
-				wacom_wac->shared->touch = NULL;
+			struct hid_device *touch =
+				rcu_dereference_protected(wacom_wac->shared->touch,
+							  lockdep_is_held(&wacom_udev_list_lock));
+			struct hid_device *pen =
+				rcu_dereference_protected(wacom_wac->shared->pen,
+							  lockdep_is_held(&wacom_udev_list_lock));
+
+			if (touch == wacom->hdev) {
+				rcu_assign_pointer(wacom_wac->shared->touch, NULL);
 				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
-			} else if (wacom_wac->shared->pen == wacom->hdev) {
-				wacom_wac->shared->pen = NULL;
+			} else if (pen == wacom->hdev) {
+				rcu_assign_pointer(wacom_wac->shared->pen, NULL);
 			}
 		}
 
@@ -916,9 +923,9 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		data->shared.touch = hdev;
+		rcu_assign_pointer(data->shared.touch, hdev);
 	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		data->shared.pen = hdev;
+		rcu_assign_pointer(data->shared.pen, hdev);
 
 	mutex_unlock(&wacom_udev_list_lock);
 
@@ -2356,7 +2363,11 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 	guard(mutex)(&wacom_udev_list_lock);
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		if (wacom_wac->shared->touch == wacom->hdev) {
+		struct hid_device *touch =
+			rcu_dereference_protected(wacom_wac->shared->touch,
+						  lockdep_is_held(&wacom_udev_list_lock));
+
+		if (touch == wacom->hdev) {
 			wacom_wac->shared->type = wacom_wac->features.type;
 			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
 		}
@@ -2795,16 +2806,19 @@ static void wacom_mode_change_work(struct work_struct *work)
 	bool is_direct = wacom->wacom_wac.is_direct_mode;
 	int error = 0;
 
-	if (shared->pen) {
-		wacom1 = hid_get_drvdata(shared->pen);
+	struct hid_device *pen = rcu_access_pointer(shared->pen);
+	struct hid_device *touch = rcu_access_pointer(shared->touch);
+
+	if (pen) {
+		wacom1 = hid_get_drvdata(pen);
 		wacom_release_resources(wacom1);
 		hid_hw_stop(wacom1->hdev);
 		wacom1->wacom_wac.has_mode_change = true;
 		wacom1->wacom_wac.is_direct_mode = is_direct;
 	}
 
-	if (shared->touch) {
-		wacom2 = hid_get_drvdata(shared->touch);
+	if (touch) {
+		wacom2 = hid_get_drvdata(touch);
 		wacom_release_resources(wacom2);
 		hid_hw_stop(wacom2->hdev);
 		wacom2->wacom_wac.has_mode_change = true;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 23eaa81cd827..92d2f2f3f552 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3292,6 +3292,7 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 		unsigned char *data)
 {
+	struct hid_device *pen;
 	unsigned char prefix;
 
 	/*
@@ -3304,13 +3305,11 @@ static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 	prefix = data[0];
 	data[0] = WACOM_REPORT_BPAD_PEN;
 
-	/*
-	 * actually reroute the event.
-	 * No need to check if wacom->shared->pen is valid, hid_input_report()
-	 * will check for us.
-	 */
-	hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data,
-			 WACOM_PKGLEN_PENABLED, 1);
+	guard(rcu)();
+	pen = rcu_dereference(wacom->shared->pen);
+	if (pen)
+		hid_input_report(pen, HID_INPUT_REPORT, data,
+				 WACOM_PKGLEN_PENABLED, 1);
 
 	data[0] = prefix;
 }
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index a8bbba4a6f37..170d6adbe02a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -286,8 +286,8 @@ struct wacom_shared {
 	unsigned touch_max;
 	int type;
 	struct input_dev __rcu *touch_input;
-	struct hid_device *pen;
-	struct hid_device *touch;
+	struct hid_device __rcu *pen;
+	struct hid_device __rcu *touch;
 	bool has_mute_touch_switch;
 	bool is_touch_on;
 };
-- 
2.54.0.1136.gdb2ca164c4-goog

