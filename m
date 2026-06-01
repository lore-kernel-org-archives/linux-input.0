Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAB37C918;
	Mon,  1 Jun 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322948; cv=none; b=FveO3rK4mwc8P8JbgTdYrhTtPGAsLTtv5+KU3lq4l26/3UdN5Nywj+m8kzRoNAa1UDC+GfTaFcaBVnuJM8lxJ22WU97p4BckldDpIEGXK28SBYyAwfYUHs0eSjHjUYRK+ZFOw3WuZ/TUPzicxqXKz9Q/HIi7Ocxko+fCCaHi6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322948; c=relaxed/simple;
	bh=eG+5TkBThzJ+biVxcGEc1FI0I9DMmJ9bOXo0AVyNMTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFbDgJ5OXrnM0hNLSvAYdC93k9qChdgkOlc2o9cEnw5Xms6+cjubtFJNrvs7WeaYC6nY/Wq2JY9kopbQYcUsFoYaCCATGk7Sb9osj1dDVywq07DnblZlOVATsQFrulK7W5a40IJOcU3mv2gxcvm5NbxfE0QobM7+q34sCUV+6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4vU2w0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4vU2w0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEE81F00893;
	Mon,  1 Jun 2026 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322947;
	bh=HYWt0WjPkzY0DE6dLaJOtbT8FOOAY3bzj5S3yeQ978s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=D4vU2w0Y7YNDlS1km6NfnBgQZo84eJafMG9hD/ewMj71wI+Vjii0zt6PuHvmr8Iab
	 nHQKTqYUMMHhnta/13MryYzsf2tKGqySYIxNGiRHQ7QW9vEofKCsjxJHJLrDagCFE6
	 jGDI3+Oj6lDASuWiiKtHK3u+YhZdtqbnMK9I6GXtEg38we5u2RjNJJ4v51wW2zaY8P
	 hmQLXoDh0hIn74RX4YGpFeANVEC8kHAsBwnKEadOFV8H0cLY1ADJ8+v1V0OVl/l/lF
	 DA7o5Twe9ygyZ0y5SpFtmqmJqOXU3QNjg8Cph2097LapOiy++gbVsPHGZbMbI3nukC
	 YmQph4gWqkg3A==
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
Subject: [PATCH v2 2/2] HID: wacom: Redesign shared sibling data lifecycle
Date: Mon,  1 Jun 2026 15:08:38 +0100
Message-ID: <20260601140845.1237227-2-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <20260601140845.1237227-1-lee@kernel.org>
References: <20260601140845.1237227-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Wacom driver coordinates state between sibling interfaces of the same
physical device using a shared structure 'wacom_shared' inside
'wacom_hdev_data'.  The driver kept a volatile representative pointer
'data->dev' pointing to a sibling 'hid_device' for physical path comparisons
during sibling matching.

This pointer management is fragile.  When the representative device is
disconnected, wacom_remove_shared_data() failed to clear/update
'data->dev', leading to a Use-After-Free vulnerability when subsequent
sibling probes dereference the dangling 'data->dev' pointer.

Resolve this issue by redesigning the sibling data lifecycle:

 - Eliminate the volatile 'data->dev' representative pointer completely
 - Redesign 'wacom_hdev_data' to store stable static copies of the required
   attributes upon first allocation: 'phys' path string, 'vendor', 'product
   IDs and the sibling's 'device_type'
 - Use these static attributes for stable sibling matching in
   wacom_are_sibling() and wacom_get_hdev_data()

This ensures sibling matching remains safe and stable even if individual
siblings are dynamically added or removed.

To secure the lifecycle against concurrent probe/disconnect races:

- Switch kref_put() to kref_put_mutex() in wacom_remove_shared_data() to
  serialize refcount drops with list traversal and lookup
- Modify wacom_release_shared_data() to assume the list lock is already held

Also, do not accumulate the 'device_type' capability flag during subsequent
sibling probes.  Keeping only the first probed sibling's device_type exactly
preserves the original sibling matching behavior without introducing side
effects.

Fixes: 4492efffffeb ("Input: wacom - share pen info with touch of the same ID")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2: Split and use RCU as per Dmitry's review

drivers/hid/wacom_sys.c | 63 +++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 26fce6d3198a..7cd0b0ff3128 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -759,27 +759,40 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 struct wacom_hdev_data {
 	struct list_head list;
 	struct kref kref;
-	struct hid_device *dev;
+	char phys[64];
+	__u32 vendor;
+	__u32 product;
+	__u32 device_type;
 	struct wacom_shared shared;
 };
 
+static bool wacom_compare_device_paths(struct hid_device *hdev_a,
+				       const char *phys_b, char separator)
+{
+	int n1 = strrchr(hdev_a->phys, separator) - hdev_a->phys;
+	int n2 = strrchr(phys_b, separator) - phys_b;
+
+	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+		return false;
+
+	return !strncmp(hdev_a->phys, phys_b, n1);
+}
+
 static LIST_HEAD(wacom_udev_list);
 static DEFINE_MUTEX(wacom_udev_list_lock);
 
 static bool wacom_are_sibling(struct hid_device *hdev,
-		struct hid_device *sibling)
+		struct wacom_hdev_data *data)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_features *features = &wacom->wacom_wac.features;
-	struct wacom *sibling_wacom = hid_get_drvdata(sibling);
-	struct wacom_features *sibling_features = &sibling_wacom->wacom_wac.features;
 	__u32 oVid = features->oVid ? features->oVid : hdev->vendor;
 	__u32 oPid = features->oPid ? features->oPid : hdev->product;
 
 	/* The defined oVid/oPid must match that of the sibling */
-	if (features->oVid != HID_ANY_ID && sibling->vendor != oVid)
+	if (features->oVid != HID_ANY_ID && data->vendor != oVid)
 		return false;
-	if (features->oPid != HID_ANY_ID && sibling->product != oPid)
+	if (features->oPid != HID_ANY_ID && data->product != oPid)
 		return false;
 
 	/*
@@ -787,11 +800,11 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * device path, while those with different VID/PID must share
 	 * the same physical parent device path.
 	 */
-	if (hdev->vendor == sibling->vendor && hdev->product == sibling->product) {
-		if (!hid_compare_device_paths(hdev, sibling, '/'))
+	if (hdev->vendor == data->vendor && hdev->product == data->product) {
+		if (!wacom_compare_device_paths(hdev, data->phys, '/'))
 			return false;
 	} else {
-		if (!hid_compare_device_paths(hdev, sibling, '.'))
+		if (!wacom_compare_device_paths(hdev, data->phys, '.'))
 			return false;
 	}
 
@@ -804,7 +817,7 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * devices.
 	 */
 	if ((features->device_type & WACOM_DEVICETYPE_DIRECT) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
+	    !(data->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
 	/*
@@ -812,17 +825,17 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * devices.
 	 */
 	if (!(features->device_type & WACOM_DEVICETYPE_DIRECT) &&
-	    (sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
+	    (data->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
 	/* Pen devices may only be siblings of touch devices */
 	if ((features->device_type & WACOM_DEVICETYPE_PEN) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_TOUCH))
+	    !(data->device_type & WACOM_DEVICETYPE_TOUCH))
 		return false;
 
 	/* Touch devices may only be siblings of pen devices */
 	if ((features->device_type & WACOM_DEVICETYPE_TOUCH) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_PEN))
+	    !(data->device_type & WACOM_DEVICETYPE_PEN))
 		return false;
 
 	/*
@@ -838,7 +851,7 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Try to find an already-probed interface from the same device */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (hid_compare_device_paths(hdev, data->dev, '/')) {
+		if (wacom_compare_device_paths(hdev, data->phys, '/')) {
 			kref_get(&data->kref);
 			return data;
 		}
@@ -846,7 +859,7 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Fallback to finding devices that appear to be "siblings" */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (wacom_are_sibling(hdev, data->dev)) {
+		if (wacom_are_sibling(hdev, data)) {
 			kref_get(&data->kref);
 			return data;
 		}
@@ -860,35 +873,34 @@ static void wacom_release_shared_data(struct kref *kref)
 	struct wacom_hdev_data *data =
 		container_of(kref, struct wacom_hdev_data, kref);
 
-	mutex_lock(&wacom_udev_list_lock);
 	list_del(&data->list);
-	mutex_unlock(&wacom_udev_list_lock);
-
 	kfree(data);
 }
 
 static void wacom_remove_shared_data(void *res)
 {
-	struct wacom *wacom = res;
+	struct wacom *res_wacom = res;
 	struct wacom_hdev_data *data;
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_wac *wacom_wac = &res_wacom->wacom_wac;
 
 	if (wacom_wac->shared) {
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
 		mutex_lock(&wacom_udev_list_lock);
-		if (wacom_wac->shared->touch == wacom->hdev) {
+		if (wacom_wac->shared->touch == res_wacom->hdev) {
 			wacom_wac->shared->touch = NULL;
 			rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
-		} else if (wacom_wac->shared->pen == wacom->hdev) {
+		} else if (wacom_wac->shared->pen == res_wacom->hdev) {
 			wacom_wac->shared->pen = NULL;
 		}
 		mutex_unlock(&wacom_udev_list_lock);
 
 		synchronize_rcu();
 
-		kref_put(&data->kref, wacom_release_shared_data);
+		if (kref_put_mutex(&data->kref, wacom_release_shared_data, &wacom_udev_list_lock))
+			mutex_unlock(&wacom_udev_list_lock);
+
 		wacom_wac->shared = NULL;
 	}
 }
@@ -911,7 +923,10 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		}
 
 		kref_init(&data->kref);
-		data->dev = hdev;
+		strncpy(data->phys, hdev->phys, sizeof(data->phys) - 1);
+		data->vendor = hdev->vendor;
+		data->product = hdev->product;
+		data->device_type = wacom_wac->features.device_type;
 		list_add_tail(&data->list, &wacom_udev_list);
 	}
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

