Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8FA2D97A6
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365238; cv=none; b=kL/kkFigYCS1ybhkz8JLGeA5o8C0vkJSX2kqWox3d7TCc8ppDow0rNx7I2GkRjvET1BWBA/xClx4x8AtyBZa/2BbKLLOQSgUeVQfBhiUUbXhLtPFXCENcTwPVVdUSeeQkhdN++/7h0wnLNbChGOKGyZwcXC+1zjurO2Ap09rCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365238; c=relaxed/simple;
	bh=LxApIdJDA4GykJAWbHT+/5mjoQzKocPYv/7H2yhgehE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKbN3ansRxNgYJEYONeYevdmdTdTf/KcDrLooYLoZdFvFYSQQD3tIvq3mOCQaGmA4H88gDyOr63QpwfZPYy9PE4d4a+9Wv8VyU2F+MZF/CYu88PUtR13pbu4NJJ6TEo12UnFHFx2qydmKViG0RdNMRvo90Cj9N90Tmy30Vch1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Did9t4Gw; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Did9t4Gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364799; bh=LxApIdJDA4GykJAWbHT+/5mjoQzKocPYv/7H2yhgehE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Did9t4GwdysG3M+RMbSqLQfLgePwek76NVA3FtZnbe7DhSvJXDlbbPZyX/dZRirrI
	 k+tIc4MLR28n/VxfIonl/XUA9sJL+zmDbT8jkGCznL4SAy+K47AYgdGBlt8Ni2WWwE
	 m9cIUmXDsY/6RALPnMjGNiOA+szcb524PxetXok8JjUearizib8PDFHU0Md2Ssp8/E
	 PVetsMdqPUZv7ANDZSCT/J2xeW8VuURue/GkhuCo8PuMOZeXj3HFWNHqZP0YYxyt3I
	 +XrVjcO98OIamhFHM+TbqDpdoH11+CSfMMpUU016JuFrVRU6cAb1VH+4XfAP2Z33Gx
	 Kj80FRl3KiWTw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 53CA4A13A;
	Fri, 21 Aug 2026 19:13:19 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 04/12] Input: xbox_gip - Add HID relaying
Date: Fri, 21 Aug 2026 19:11:28 -0700
Message-ID: <20260822021140.1149546-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822021140.1149546-1-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 94 ++++++++++++++++++++++++++-
 drivers/input/joystick/gip/gip.h      |  2 +
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 15f8ed210711..c833b10259ab 100644
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
@@ -1361,7 +1409,34 @@ static int gip_send_init_sequence(struct gip_attachment *attachment)
 	if (rc)
 		return rc;
 
-	return 0;
+	if (attachment->metadata.device.hid_descriptor) {
+		struct hid_device *hdev = hid_allocate_device();
+
+		if (IS_ERR(hdev))
+			return PTR_ERR(hdev);
+
+		hdev->ll_driver = &gip_hid_ll_driver;
+		hdev->bus = BUS_USB;
+		hdev->vendor = attachment->vendor_id;
+		hdev->product = attachment->product_id;
+		hdev->dev.parent = to_gip_device(attachment);
+		hdev->driver_data = attachment;
+		if (attachment->name)
+			strscpy(hdev->name, attachment->name);
+		else
+			strscpy(hdev->name, "Xbox Chatpad");
+		strscpy(hdev->phys, attachment->phys);
+		rc = hid_add_device(hdev);
+		if (rc) {
+			gip_err(attachment, "HID device add failed: %d\n", rc);
+			hid_destroy_device(hdev);
+		} else {
+			rcu_assign_pointer(attachment->hdev, hdev);
+			synchronize_rcu();
+		}
+	}
+
+	return rc;
 }
 
 static void gip_fragment_timeout(struct work_struct *work)
@@ -1769,9 +1844,16 @@ static int gip_handle_command_firmware(struct gip_attachment *attachment,
 static int gip_handle_command_hid_report(struct gip_attachment *attachment,
 	const struct gip_header *header, uint8_t *bytes, int num_bytes)
 {
-	gip_warn(attachment, "Unimplemented HID report message\n");
+	struct hid_device *hdev;
 
-	return -EOPNOTSUPP;
+	guard(rcu)();
+	hdev = rcu_dereference(attachment->hdev);
+	if (hdev)
+		return hid_input_report(hdev, HID_INPUT_REPORT, bytes, num_bytes, true);
+
+	gip_warn(attachment, "Got HID report with no HID descriptor\n");
+
+	return -EPROTO;
 }
 
 static int gip_handle_command_extended(struct gip_attachment *attachment,
@@ -2527,6 +2609,7 @@ static int gip_shutdown(struct gip_device *device)
 	for (i = 0; i < MAX_ATTACHMENTS; i++) {
 		struct gip_attachment *attachment = device->attachments[i];
 		struct input_dev *input;
+		struct hid_device *hdev;
 
 		if (!attachment)
 			continue;
@@ -2537,14 +2620,19 @@ static int gip_shutdown(struct gip_device *device)
 
 			rcu_read_lock();
 			input = rcu_dereference(attachment->input);
+			hdev = rcu_dereference(attachment->hdev);
 			rcu_read_unlock();
 
 			rcu_assign_pointer(attachment->input, NULL);
+			rcu_assign_pointer(attachment->hdev, NULL);
 			synchronize_rcu();
 		}
 
 		if (input)
 			input_unregister_device(input);
+
+		if (hdev)
+			hid_destroy_device(hdev);
 	}
 
 	return 0;
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
-- 
2.54.0

