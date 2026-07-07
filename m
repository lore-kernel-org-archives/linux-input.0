Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A593FC5CD;
	Tue,  7 Jul 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426271; cv=none; b=RpIbMznSc5p4g3pJnsfIll5yKduDXY1H7YEnjFqQZHhq27hZS39CUTcz/C2bUn4NylA2WHCiLtlpkhN+2iQPOkDz8B2jQ2rf6RnNgeyWRHcAhkt8m5cAZIpV6qeeE+aCCNFWLcIJig0kIsqw1mrGjC6mH+fGEpt+QVnTwwJdFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426271; c=relaxed/simple;
	bh=LztdSwfFpzT/1fa4SDhQ1v3VBjVknR2/RaoVkg7DDRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/yWz3HNEVP+HX/mw7dXwSh1BpMRNdRdD3KbvW3XsP2a9f6OQIRehV3gBKCH5GP1kz0VqorAoIFxSkrrkqVyNJsokUjt1mx0jecrFkVJeZcBT9VkNrYcja2msIbJm6z9a51eZmA1BsZ/8/OtIumeDXMedrz2cUg0qioE93xZlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPgK0Bnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPgK0Bnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685D81F000E9;
	Tue,  7 Jul 2026 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783426270;
	bh=Wb/+p+Vv+e2goP1NBNPfTLwBkaxVc/hInMXcAh5J8CQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=KPgK0BncWlJGkWPZ6CDRPruwv2JXA7f80Cam1uQ5wJYpTgMx98YqxxMyy4Q6WJXyR
	 2dDe8ovfCkzxcqCTOM4zGSU+C2QDo3PAAZbY0fWeo/Uxtma5lhONhjcDj4C57wS2xk
	 h5ZFfZhpq9ifN67Cc++XpqAkRSpuSI9WxXhJWgoOtb2DBciRcy6EJJmL/Cg9ODxame
	 2/AcLedZV0yVb2xApVYhhQHIC/Enn76tToAuJ3AsTettJPiyAOLThzAoglhMMMdFqI
	 IkXYc38cSL64/d3d3ZxvMonK9UNylLEodR0qukzKID9v+n7TiEDx0EsqbL5KCBMCGW
	 5WRC4ySDXB/ow==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Date: Tue,  7 Jul 2026 12:10:42 +0000
Message-ID: <20260707121051.1683937-3-lee@kernel.org>
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
---

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes
v3 -> v4: Dmitry's review [guard()]
v4 -> v5: No change

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
index f3429a2c8f36..8581c33fac59 100644
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
2.55.0.rc2.803.g1fd1e6609c-goog

