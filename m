Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8183264E4;
	Wed, 27 May 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890859; cv=none; b=gx2DiwXaPHTcTSOudA88GRcZ0lQ7jwhKdG8BPRFzCCyP9QviFgf1y1icmxJeRcBSdbEYZzOvmJzpxRvU6TqfD/2T0FLXKNgS35633cPZN/KL442RnRRZFNnvPtD/Xb4bdwqAEY6ke6pPK0Sr5MFNiMG4H9ksuwgHCVM5755aYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890859; c=relaxed/simple;
	bh=IwkngIzVUiOUrO3djls0YJbKCXacDOaTQ7MgNs9ICNw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g42cEep9zBV/K/7RGYKwdALGKnNh3XZQEcrB2M0cmFf9gbmvGUKfrl8DMefiu0E5TcH8IJQT2acHdhVUTdPJwhTf2Yfs/R04ZAlzBI5T4Kk021T7YF8vj8GcO4yIcsa25YZXUJVHAVKnUemR3C9ekeUVfTUcad/hwIwk9ThXQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLggw33b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLggw33b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F1A1F000E9;
	Wed, 27 May 2026 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890857;
	bh=zFu1QHo8dW+U91VCVWeBTlW9O/fncRXcF+MI/cFUFfY=;
	h=From:To:Subject:Date;
	b=YLggw33b9gWz3jcKj/eJUKLg9jslmfzWrAUX4YfAI5IPJ/virGWnUgxkB5L3Yj5Nu
	 KborML5mOEj+FHiwDxm57lhiym3+0sHZetxR1ddUc/dKKo3tm4v5k6XREXfijxp9do
	 DbJv3uAThAKbLr7/PvMczqZLLv13o5obVfpkQRkt60AoJCMQ4oInqPPPdGKplkuBN1
	 8n4bRrzvFWD35mGzRsqtHqRFX3ZznGxuJo/z9+x36qno36fobzX8LzUpJrJvaJ6cf0
	 ys4sAtSD3wHIICghm8QIg5e/VuoVOcTysavQ/yIXoV4gvZHMJnZRAORaEZo2hl3lGc
	 RBCpLfVta/9Yw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: wacom: Fix multiple Use-After-Free issues in shared state
Date: Wed, 27 May 2026 15:07:30 +0100
Message-ID: <20260527140731.642783-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Wacom driver coordinates state between sibling interfaces of the same
physical device (like Pen, Touch, Pad) using a shared structure
'wacom_shared' inside 'wacom_hdev_data'.  The driver kept a volatile
representative pointer 'data->dev' pointing to a sibling 'hid_device'
for physical path comparisons during sibling matching.

This pointer management is fragile.  When the representative device is
disconnected, wacom_remove_shared_data() failed to clear/update
'data->dev' or wacom_wac->shared->touch_input, leading to two Use-After-Free
vulnerabilities:

  1. dangling 'touch_input' dereferenced during touch switch sync.
  2. dangling 'data->dev' dereferenced during subsequent sibling probes.

Instead of adding complex pointer handover logic to keep 'data->dev'
updated (which has logic gaps with Pad siblings and introduces race
conditions), completely eliminate 'data->dev' pointer.

Redesign 'wacom_hdev_data' to store stable static copies of the required
representative attributes when it is first allocated:

  - Copy 'phys' path string (stored in data->phys) for stable path comparison.
  - Copy 'vendor' and 'product' IDs.
  - Copy and accumulate 'device_type' capabilities as siblings are probed.

Also explicitly clear 'touch_input = NULL' in wacom_remove_shared_data()
under wacom_udev_list_lock to safely avoid the touch_input UAF.

This resolves all vulnerabilities permanently at the design level without
complex pointer lifecycles or race-prone swaps on device removal.

Fixes: 471d17148c8b ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 58 ++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b351e3..9e4819c197c1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -753,27 +753,40 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
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
@@ -781,11 +794,11 @@ static bool wacom_are_sibling(struct hid_device *hdev,
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
 
@@ -798,7 +811,7 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * devices.
 	 */
 	if ((features->device_type & WACOM_DEVICETYPE_DIRECT) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
+	    !(data->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
 	/*
@@ -806,17 +819,17 @@ static bool wacom_are_sibling(struct hid_device *hdev,
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
@@ -832,7 +845,7 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Try to find an already-probed interface from the same device */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (hid_compare_device_paths(hdev, data->dev, '/')) {
+		if (wacom_compare_device_paths(hdev, data->phys, '/')) {
 			kref_get(&data->kref);
 			return data;
 		}
@@ -840,7 +853,7 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Fallback to finding devices that appear to be "siblings" */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (wacom_are_sibling(hdev, data->dev)) {
+		if (wacom_are_sibling(hdev, data)) {
 			kref_get(&data->kref);
 			return data;
 		}
@@ -871,10 +884,14 @@ static void wacom_remove_shared_data(void *res)
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
-		if (wacom_wac->shared->touch == wacom->hdev)
+		mutex_lock(&wacom_udev_list_lock);
+		if (wacom_wac->shared->touch == wacom->hdev) {
 			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == wacom->hdev)
+			wacom_wac->shared->touch_input = NULL;
+		} else if (wacom_wac->shared->pen == wacom->hdev) {
 			wacom_wac->shared->pen = NULL;
+		}
+		mutex_unlock(&wacom_udev_list_lock);
 
 		kref_put(&data->kref, wacom_release_shared_data);
 		wacom_wac->shared = NULL;
@@ -899,8 +916,13 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		}
 
 		kref_init(&data->kref);
-		data->dev = hdev;
+		strscpy(data->phys, hdev->phys, sizeof(data->phys));
+		data->vendor = hdev->vendor;
+		data->product = hdev->product;
+		data->device_type = wacom_wac->features.device_type;
 		list_add_tail(&data->list, &wacom_udev_list);
+	} else {
+		data->device_type |= wacom_wac->features.device_type;
 	}
 
 	mutex_unlock(&wacom_udev_list_lock);
-- 
2.54.0.746.g67dd491aae-goog

