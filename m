Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05072931EE
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182382; cv=none; b=aIwV+ST/YF13YYVaov35j51rKr/lZsTan/1Dvig9cDxCqsUqsxdtfeEpVCLbqI8Yjeegf450ti9dW4BN+aJnC9sTYaI+x53LFVOes/vHNaXLFW9DeV7NRA8pygrM8IGlaz1WAPLAqsbQ/0W5uyIImgc/VoYj2797fYCUN4KI0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182382; c=relaxed/simple;
	bh=TP133d9T1eT2wSeWudL2B9vA/tlXkUDuuPMRMdZp1fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0+6hsE/Qw7fYOZRWJu/9P8bxFYCs0/S278qqJM2KYzDjzOD7XgKNXSN8se5UEFhYDZpRn7pi+773c7+smvqsdhPkyylibWIBdUov7ri8y1xQbKMjXSib+90AIHMwczo+2pT87NCbRN7dB35kfCfTTNsax4lg63pboTuki27l/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=o+rotV0b; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="o+rotV0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1789182374; bh=TP133d9T1eT2wSeWudL2B9vA/tlXkUDuuPMRMdZp1fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+rotV0b+8+2mRDkSqdW5FWK+8TyEd134MSg2i2seoIqBBuxZCshIiqkNb9vOF2Tw
	 i33yeoqWcSkF28xfs5XmETTOrXSK78oLaGs6iR8vwjCm2MOSXNdwjbyrHidi1wo1Ms
	 owoqWqvUNs23mmtwAKdIxX2SxDu0ybgV5WsWyX1qvi75jhhqSBgZGsQR3mtvlvKxHB
	 8dHxCFUqG9hl0NTh5Scw4ERkw4WktCpGUkGcLsS2bf5j+Z6V/V9ROP7RMfCUfxiu5X
	 OGytdK208F9cI6HAe09mqVMUc7MB6KS268248tNW/GGUZxpQlswCWL0TXm0pjjgkIJ
	 dqbZJgyL3ZO3A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id C5627132035;
	Fri, 11 Sep 2026 20:06:13 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v7 04/12] Input: xbox_gip - Add HID relaying
Date: Fri, 11 Sep 2026 20:04:15 -0700
Message-ID: <20260912030426.2997003-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912030426.2997003-1-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 116 +++++++++++++++++++++++++-
 drivers/input/joystick/gip/gip.h      |   2 +
 include/uapi/linux/input.h            |   1 +
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 9371d860a59b..411b67399e01 100644
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
@@ -1322,6 +1370,51 @@ static int gip_init_input_device(struct gip_attachment *attachment)
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
+	hdev->version = 0x0100;
+	hdev->country = 0;
+	hdev->dev.parent = to_gip_device(attachment);
+	hdev->driver_data = attachment;
+	if (attachment->name)
+		strscpy(hdev->name, attachment->name);
+	else
+		strscpy(hdev->name, "Xbox Chatpad");
+	strscpy(hdev->phys, attachment->phys);
+	strscpy(hdev->uniq, attachment->uniq);
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
@@ -1387,7 +1480,11 @@ static int gip_send_init_sequence(struct gip_attachment *attachment)
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
@@ -1405,19 +1502,25 @@ static void gip_fragment_timeout(struct work_struct *work)
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
@@ -1783,9 +1886,16 @@ static int gip_handle_command_firmware(struct gip_attachment *attachment,
 static int gip_handle_command_hid_report(struct gip_attachment *attachment,
 	const struct gip_header *header, uint8_t *bytes, int num_bytes)
 {
-	gip_warn_ratelimited(attachment, "Unimplemented HID report message\n");
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
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index dc972ff168d7..525d04b83837 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -12,6 +12,7 @@
 #ifndef _GIP_H
 #define _GIP_H
 
+#include <linux/hid.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
@@ -256,6 +257,7 @@ struct gip_attachment {
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

