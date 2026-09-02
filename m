Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682ED33CEBD
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311066; cv=none; b=Fb+IFQSvDIn+Ijha+GHGIVT/ojaB5KXMF6QlQryWIx39zMsBDleP044sxLLYdV8arY5eZ3NE3/POUaG0Ib/uJ12bMORHapv0hJtvV+n1mQwuVJ80NLlYWhSNMPraZYCUmTMzO7XO6m0USQ4Jw+dg5hNYilhjMtcVrzYM9CNPg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311066; c=relaxed/simple;
	bh=1BN7SKIcdtvXsXiShDhZDkPEmBkvVA5U0zvVDSPBzOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWb0FG7jWl+njyHXNFHfM0J7LaXI0EMdY+mQ4quTRCELzumzHmAjaE5WYY4kD4Rtm/548jxCi1DelgpnMKwpsYSFDdzCknxpuseIkm/O4OKO2q9H3hCePLMF69TQnc+1Ab2JxqHKqeNL63fk7ZRBvk6Vbd1j9vbxBiH0PAgsqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ltuqQGQw; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ltuqQGQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311058; bh=1BN7SKIcdtvXsXiShDhZDkPEmBkvVA5U0zvVDSPBzOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltuqQGQwPnTSPc040T3vRf3ScQbv+xrau1hI7K7BtEolyFkBYoeHElrba0KzCUV4d
	 7IyObcgUa0qAjgzLoQau/4IsnNy64VGiCc7XMtv9qFxTUSgOUr5RMNEeP0aTTh9ENy
	 BXRqZ8ApZdLIMLFGWedcmAe9asnikrlFolVItyeDrSj6EhA2G0ywDigN1Q7WP/jVju
	 NFE/gqBBZU1l34sjaJrrX6hzm9NmuKH96/ClAOgOAcA07iyZ5SG0XfG02MNa4s2gk3
	 io6PXc6y2a3z1cMTmmJfbsgRXVuaIY49WyqJ2g5aDvjN0Q5ZnyGsuZbJAUGLYxCasK
	 Byg1EV49osKnQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 73B4B132033;
	Tue, 01 Sep 2026 18:04:18 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 04/12] Input: xbox_gip - Add HID relaying
Date: Tue,  1 Sep 2026 18:02:25 -0700
Message-ID: <20260902010237.865772-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902010237.865772-1-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GIP allows tunneling of HID packets, with the HID descriptor embedded in
the GIP metadata exchanged during the initial handshake. This patch creates
a hid_device for this HID descriptor if found, as well as relaying the HID
packets.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/gip-core.c | 114 +++++++++++++++++++++++++-
 drivers/input/joystick/gip/gip.h      |   2 +
 include/uapi/linux/input.h            |   1 +
 3 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 23ab0768580f..3b033fe65dc4 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -560,6 +560,54 @@ int gip_send_vendor_message(struct gip_attachment *attachment,
 		bytes, num_bytes);
 }
 
+static int gip_hid_ll_parse(struct hid_device *hdev)
+{
+	struct gip_attachment *attachment = hdev->driver_data;
+
+	return hid_parse_report(hdev,
+		attachment->metadata.device.hid_descriptor,
+		attachment->metadata.device.hid_descriptor_size);
+}
+
+static int gip_hid_ll_start(struct hid_device *hdev)
+{
+	return 0;
+}
+
+static void gip_hid_ll_stop(struct hid_device *hdev)
+{
+}
+
+static int gip_hid_ll_open(struct hid_device *hdev)
+{
+	return 0;
+}
+
+static void gip_hid_ll_close(struct hid_device *hdev)
+{
+}
+
+static int gip_hid_ll_raw_request(struct hid_device *hdev,
+	unsigned char reportnum, uint8_t *buf, size_t count,
+	unsigned char report_type, int reqtype)
+{
+	/*
+	 * TODO: Based on the metadata, output reports appear to be possible,
+	 * but the chatpad doesn't have the LEDs it claims to support, so
+	 * it's not clear how to test we're sending them properly.
+	 */
+	return 0;
+}
+
+static const struct hid_ll_driver gip_hid_ll_driver = {
+	.parse = gip_hid_ll_parse,
+	.start = gip_hid_ll_start,
+	.stop = gip_hid_ll_stop,
+	.open = gip_hid_ll_open,
+	.close = gip_hid_ll_close,
+	.raw_request = gip_hid_ll_raw_request,
+};
+
 static void gip_metadata_free(struct device *dev, struct gip_metadata *metadata)
 {
 	devm_kfree(dev, metadata->device.audio_formats);
@@ -1303,6 +1351,48 @@ static int gip_init_input_device(struct gip_attachment *attachment)
 	return rc;
 }
 
+static int gip_create_hdev(struct gip_attachment *attachment)
+{
+	struct hid_device *hdev;
+	int rc;
+
+	if (!attachment->metadata.device.hid_descriptor)
+		return 0;
+
+	rcu_read_lock();
+	hdev = rcu_dereference(attachment->hdev);
+	rcu_read_unlock();
+	if (hdev)
+		return 0;
+
+	hdev = hid_allocate_device();
+
+	if (IS_ERR(hdev))
+		return PTR_ERR(hdev);
+
+	hdev->ll_driver = &gip_hid_ll_driver;
+	hdev->bus = BUS_GIP;
+	hdev->vendor = attachment->vendor_id;
+	hdev->product = attachment->product_id;
+	hdev->dev.parent = to_gip_device(attachment);
+	hdev->driver_data = attachment;
+	if (attachment->name)
+		strscpy(hdev->name, attachment->name);
+	else
+		strscpy(hdev->name, "Xbox Chatpad");
+	strscpy(hdev->phys, attachment->phys);
+	rc = hid_add_device(hdev);
+	if (rc) {
+		gip_err(attachment, "HID device add failed: %d\n", rc);
+		hid_destroy_device(hdev);
+	} else {
+		rcu_assign_pointer(attachment->hdev, hdev);
+		synchronize_rcu();
+	}
+
+	return rc;
+}
+
 static int gip_send_init_sequence(struct gip_attachment *attachment)
 {
 	int rc = 0;
@@ -1368,7 +1458,11 @@ static int gip_send_init_sequence(struct gip_attachment *attachment)
 	if (rc)
 		return rc;
 
-	return 0;
+	rc = gip_create_hdev(attachment);
+	if (rc)
+		return rc;
+
+	return rc;
 }
 
 static void gip_fragment_timeout(struct work_struct *work)
@@ -1388,19 +1482,25 @@ static void gip_fragment_timeout(struct work_struct *work)
 static void gip_free_devices(struct gip_attachment *attachment)
 {
 	struct input_dev *input;
+	struct hid_device *hdev;
 
 	if (attachment->driver && attachment->driver->remove)
 		attachment->driver->remove(attachment);
 
 	rcu_read_lock();
 	input = rcu_dereference(attachment->input);
+	hdev = rcu_dereference(attachment->hdev);
 	rcu_read_unlock();
 
 	rcu_assign_pointer(attachment->input, NULL);
+	rcu_assign_pointer(attachment->hdev, NULL);
 	synchronize_rcu();
 
 	if (input)
 		input_unregister_device(input);
+
+	if (hdev)
+		hid_destroy_device(hdev);
 }
 
 static void gip_reset_metadata(struct gip_attachment *attachment)
@@ -1768,9 +1868,17 @@ static int gip_handle_command_firmware(struct gip_attachment *attachment,
 static int gip_handle_command_hid_report(struct gip_attachment *attachment,
 	const struct gip_header *header, uint8_t *bytes, int num_bytes)
 {
-	gip_warn(attachment, "Unimplemented HID report message\n");
+	struct hid_device *hdev;
 
-	return -EOPNOTSUPP;
+	guard(rcu)();
+	hdev = rcu_dereference(attachment->hdev);
+	if (hdev)
+		return hid_safe_input_report(hdev, HID_INPUT_REPORT, bytes,
+			num_bytes, umin(header->length, num_bytes), true);
+
+	gip_warn(attachment, "Got HID report with no HID descriptor\n");
+
+	return -EPROTO;
 }
 
 static int gip_handle_command_extended(struct gip_attachment *attachment,
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 2e78aad508c3..fbcf66e18158 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -12,6 +12,7 @@
 #ifndef _GIP_H
 #define _GIP_H
 
+#include <linux/hid.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
@@ -250,6 +251,7 @@ struct gip_attachment {
 	int extra_axes;
 
 	bool dpad_as_buttons;
+	struct hid_device __rcu *hdev;
 };
 
 struct gip_urb {
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 6aa703fcfcfb..d9c630ff8292 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -276,6 +276,7 @@ struct input_mask {
 #define BUS_INTEL_ISHTP		0x1F
 #define BUS_AMD_SFH		0x20
 #define BUS_SDW			0x21
+#define BUS_GIP			0x22
 
 /*
  * MT_TOOL types
-- 
2.54.0

