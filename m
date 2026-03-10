Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418D2877FC
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120035; cv=none; b=g/VaMccAo2Sz5zOA1OPynSuPpwhnGNv839N6/RuaUmtxhsjHegKVd1Irt03oLslLALSFbEh4DCiiphidX2HwU3dVzhBsC1Ckdt8j7qdpCXEGnca12hHxi7BroIrRu+zQ0e4AEfyM0GLzJ+TT/PgtkCkxiSl15EYMzxWAat34HF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120035; c=relaxed/simple;
	bh=ZSv75E/+Ini82HZe/iPpr+QKRl1F9GODRWi3qSmERPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNpDt6d43xaT/nMxnNYhFY2rfNsFnAq3lnk1PkCtESQ8glqrKbo6FA9pxd40wRDMZmZKrPI2hwN7H7HBQCSXfQE9Rg++ujc16JfyAJhAKBbuQBRlFyvDZ4G2FViBR9XkIpjAJG+n6wPPdcQ299UuThJhDpDrUYv4CH4xOQ8s9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=hZMjBHJ9; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="hZMjBHJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120033; bh=ZSv75E/+Ini82HZe/iPpr+QKRl1F9GODRWi3qSmERPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZMjBHJ9SSjb61djvmcwXN7V3/N0j66W7snQHyxHNccyLQPqcpSEaaWNuh95trifi
	 HDgyjOkzyo6LwYj0vG7HAJlQxgOYjcMQnRglq6aeDCKn9AypPuJ403ArKWx3K9qezj
	 qSpow9b9+qv7AUvvVo6fKLzXVVi3iCmbbEPTRR5rMV1otGLXuBCUZ8QZ4heX76Dlbg
	 oc10nS/8YBLNZZKJ6mfwMXe3sBI5yLuRQ3Ls/hX9d5oA7AC1/1yPLE60IVXYTSCibT
	 Jsu/mNZr5cdqEqPYk7XXgeHmk0IjgvuYnap2czPPPB3wqlp2YiRXJPzAaeOV+yWwwf
	 XoNDHPUgGcbOA==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 4DAB9A0B6;
	Mon, 09 Mar 2026 22:20:33 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 04/10] Input: xbox_gip - Add HID relaying
Date: Mon,  9 Mar 2026 22:19:58 -0700
Message-ID: <20260310052017.1289494-5-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310052017.1289494-1-vi@endrift.com>
References: <20260310052017.1289494-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 95 ++++++++++++++++++++++++++-
 drivers/input/joystick/gip/gip.h      |  2 +
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 223668ca2b2a9..7355737b29d19 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -547,6 +547,54 @@ int gip_send_vendor_message(struct gip_attachment *attachment,
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
@@ -1350,8 +1398,36 @@ static int gip_send_init_sequence(struct gip_attachment *attachment)
 		if (rc)
 			return rc;
 	}
+	rc = 0;
 
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
+		hdev->dev.parent = GIP_DEV(attachment);
+		hdev->driver_data = attachment;
+		if (attachment->name)
+			strscpy(hdev->name, attachment->name);
+		else
+			strscpy(hdev->name, "Xbox Chatpad");
+		strscpy(hdev->phys, attachment->phys);
+		rc = hid_add_device(hdev);
+		if (rc) {
+			dev_err(GIP_DEV(attachment), "HID device add failed: %d\n", rc);
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
@@ -1784,9 +1860,16 @@ static int gip_handle_command_firmware(struct gip_attachment *attachment,
 static int gip_handle_command_hid_report(struct gip_attachment *attachment,
 	const struct gip_header *header, uint8_t *bytes, int num_bytes)
 {
-	dev_warn(GIP_DEV(attachment), "Unimplemented HID report message\n");
+	struct hid_device *hdev;
 
-	return -ENOTSUPP;
+	guard(rcu)();
+	hdev = rcu_dereference(attachment->hdev);
+	if (hdev)
+		return hid_input_report(hdev, HID_INPUT_REPORT, bytes, num_bytes, true);
+
+	dev_warn(GIP_DEV(attachment), "Got HID report with no HID descriptor\n");
+
+	return -EINVAL;
 }
 
 static int gip_handle_command_extended(struct gip_attachment *attachment,
@@ -2501,6 +2584,7 @@ static int gip_shutdown(struct gip_device *device)
 	for (i = 0; i < MAX_ATTACHMENTS; i++) {
 		struct gip_attachment *attachment = device->attachments[i];
 		struct input_dev *input;
+		struct hid_device *hdev;
 
 		if (!attachment)
 			continue;
@@ -2511,14 +2595,19 @@ static int gip_shutdown(struct gip_device *device)
 
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
index 63b4929b14e7f..c9d1c4f16c760 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -12,6 +12,7 @@
 #ifndef _GIP_H
 #define _GIP_H
 
+#include <linux/hid.h>
 #ifdef CONFIG_JOYSTICK_XBOX_GIP_LEDS
 #include <linux/led-class-multicolor.h>
 #endif
@@ -221,6 +222,7 @@ struct gip_attachment {
 	int extra_axes;
 
 	bool dpad_as_buttons;
+	struct hid_device __rcu *hdev;
 };
 
 struct gip_urb {
-- 
2.53.0

