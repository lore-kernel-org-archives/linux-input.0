Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03334DB74
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973556; cv=none; b=D1i0aheOU57FKgeTIcR5w1Pjj/gOhojBzayZgsDaMwuZp2YJ33wr4m30/83afC7h8Cetm9zIjBFn/MqO6HbjdRF73hpRcNUslID7ANrkHTDjcQOiGAqexR8rHovqQ7p4yk8A2Fed/x0ul0K2eWOMf0QVznJHTEGYpETMz38ShfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973556; c=relaxed/simple;
	bh=sQcpp2Vtj1/vmlIXIiZlNKd0kaAEYOjiPymlIJrCyvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHodqEQFsvL6yoUHcTregFP8Gytx2/0OWMK4hz+ZtqGF3F2WkuJ35Uqk7XOS25QUQgu1Lt6Uf7hFti5OVPfdPRiNaeuCKA9h9eKPhYqk/O1GXhfub/VLK0Qk7BDQMFmNw5uDbzRpQLtMTJxHh6ZNtnCjTzdnY+R8CZ/lpDkzpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQwxoaZY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQwxoaZY"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so2801888e87.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973553; x=1784578353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u7dVviGGWTuL5pgPeNLkvccoYzizCrHagts5TJl7KNM=;
        b=LQwxoaZYo+Qn8l7A1H8GzFljaRndjJyOTZ1V+wjzVPG8t85gTyI2nW2fUftSMKHLY2
         dvu9A6aBd/sGpUmbBkqorQgNxu0Mqm6DLHZ9BIq4MvftXCGBQyl9z3VitpFZ1XVEMTMv
         2ri4AntUJZa7FkXmdgDAt0CR1K7BafoZ2K8sTCkhCO0e1GV8LxdVPBseO8A3dyKI1hgX
         WYob8x/i+2KuQYfLWFuvTMueDzcVH8Il+S6Cn8p+1MXqrCO9uxeOJ2YZnq7iSshNzyLy
         07ObdsAnodBTCYgNDVe1j3bUxECeTfmb/54JEk/Cp4X/Npqgw2t+EHzv0rC2BsR5E2ql
         wROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973553; x=1784578353;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7dVviGGWTuL5pgPeNLkvccoYzizCrHagts5TJl7KNM=;
        b=MGKPBS0DeQwHD75ItDKSA3hEuhRk/ZmmMXXV4pE3sWd8T7v72z3e7BZWTueeNFJKCf
         O/2LcT5za7EaGvSpkmkPpcHj7VtEIDQXwdeGo03djmVYJ/PfPX6r8wuE+Nd5Rt8UamTR
         TzUESO1MF9Rcw0MdCMNfyWPXw6XXjSi/Bos6BSZY4w0hLJ71ghZrBITF6PVgz/jbaG5k
         tSWU66BqGUNdqPbx3j0fT64aeOppYTQwpO5jenhowtoRBp8JGLiILgNHYGSwcDQv8wFW
         hpzWdNmjdrwJCeXSEseghiTW8d6ilfjNm+CvQLU2lzy2UrbeKToOyYjccZFLhoTXULCh
         Pv3w==
X-Forwarded-Encrypted: i=1; AHgh+RqLo0LBCR8hLSEhHAMRFevWWGMxYqssIQOlG+HZ3YFByEQXCxqPBvRnf+btm88WyZvk5DfQLEp/74Elbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUswh48Wyu3XZ2uvdTcCbgTfXGq0m8VgMeYrsTHQ+mYkh7wapD
	B3G2f1EEQFMwBWrbXhRUifvxH8Om7RiEROtCnmX9dxpf9+PmuOZAFtcl
X-Gm-Gg: AfdE7clUKF1EKZP4ZyQgm3cqGblytQ6AuuLREDVRYpaj6gKZ0DGCqYSKHwvS6u7bFMY
	OiEYCV7T4+TzbzDSVEtnHtxT0Ip+ga0s3Sa2NcRXUh7SUHClcQQW68vBFuyjfYXcV1Ods4sDxum
	ndKD+Iv6lCjarN1Wv8YkGH6mIieEabZcy244/f4615dI5sJTzhGkPvK9PRCJ9SkDO9eeabuG1Ge
	G5WKgaZ9y+3T/cm4iuSLeYFFH3yM+VP8rAetVLZkf9RXGPdpCCFVjO9ZDgr8lowNYzCVP3w8Amh
	ixCk5xpJMWdli3nCx7o1Zd9TJZM9k2hWsHy9utJvVag2vSfCAhTACv/7Cw30TCFniTtGMgoENny
	OH0TAnqhcT4I4IZy0lfCqRh0b/hB23MblI6eQeVyGVKID+O5EWXNdNrGC7batTUaRfZb9+mKZcC
	NIHfKSXuxmeakM5udnTvAaRfwpdCkxFnheuHE+whW9kGbu
X-Received: by 2002:a05:6512:5c9:b0:5ae:c4e0:6a05 with SMTP id 2adb3069b0e04-5b0236deac0mr1542166e87.50.1783973552487;
        Mon, 13 Jul 2026 13:12:32 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b023b59381sm2303465e87.41.2026.07.13.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:12:31 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	k8ie@mcld.eu,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Mon, 13 Jul 2026 22:12:01 +0200
Message-ID: <20260713201201.391538-2-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713201201.391538-1-erikhakan@gmail.com>
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
 <20260713201201.391538-1-erikhakan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Logitech Bolt receiver support to the Logitech HID receiver and
HID++ drivers.

Handle Bolt receiver notifications in hid-logitech-dj and add a
Bolt-specific initialization path in hid-logitech-hidpp, separate from
the existing Unifying receiver path.

This allows Bolt-connected HID++ devices to expose battery information
through the kernel power_supply path, so userspace tools can report
their battery status with the correct device model.

Tested with:
- Logitech MX Keys for Business via Bolt receiver

Reported-by: Kateřina Medvědová <k8ie@mcld.eu>
Link: https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu/
Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
Changes in v2:
- Handle only the Bolt receiver/control interface in hid-logitech-dj and
  leave the other Bolt receiver interfaces to generic HID handling.
- Handle Bolt HID++ unpair notifications so child HID devices are removed
  after unpairing.

 drivers/hid/hid-logitech-dj.c    | 48 +++++++++++++++++++++++++++++---
 drivers/hid/hid-logitech-hidpp.c | 48 ++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 9c574ab8b60b..571d5caa5bb5 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -121,6 +121,7 @@ enum recvr_type {
 	recvr_type_27mhz,
 	recvr_type_bluetooth,
 	recvr_type_dinovo,
+	recvr_type_bolt,
 };
 
 struct dj_report {
@@ -1156,6 +1157,10 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		workitem.reports_supported |= STD_KEYBOARD;
 		break;
+	case 0x10:
+		device_type = "Bolt";
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
+		break;
 	}
 
 	/* custom receiver device (eg. powerplay) */
@@ -1745,6 +1750,24 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 
 	dj_dev = djrcv_dev->paired_dj_devices[device_index];
 
+	/*
+	 * Bolt receivers send explicit unpair notifications as HID++ events;
+	 * queue device removal when we receive one.
+	 */
+	if (djrcv_dev->type == recvr_type_bolt &&
+	    hidpp_report->report_id == REPORT_ID_HIDPP_SHORT &&
+	    hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
+		struct dj_workitem workitem = {
+			.device_index = device_index,
+			.type = WORKITEM_TYPE_UNPAIRED,
+		};
+
+		kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
+		schedule_work(&djrcv_dev->work);
+		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
+		return false;
+	}
+
 	/*
 	 * With 27 MHz receivers, we do not get an explicit unpair event,
 	 * remove the old device if the user has paired a *different* device.
@@ -1884,6 +1907,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 	 * treat these as logitech-dj interfaces then this causes input events
 	 * reported through this extra interface to not be reported correctly.
 	 * To avoid this, we treat these as generic-hid devices.
+	 *
+	 * Bolt receivers only use LOGITECH_DJ_INTERFACE_NUMBER for receiver
+	 * reporting. Treat all other Bolt interfaces as generic-hid devices.
 	 */
 	switch (id->driver_data) {
 	case recvr_type_dj:		no_dj_interfaces = 3; break;
@@ -1897,10 +1923,20 @@ static int logi_dj_probe(struct hid_device *hdev,
 	}
 	if (hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
-		if (intf && intf->altsetting->desc.bInterfaceNumber >=
-							no_dj_interfaces) {
-			hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
-			return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (intf) {
+			bool generic_hid_interface;
+
+			if (id->driver_data == recvr_type_bolt)
+				generic_hid_interface =
+					intf->altsetting->desc.bInterfaceNumber !=
+					LOGITECH_DJ_INTERFACE_NUMBER;
+			else
+				generic_hid_interface =
+					intf->altsetting->desc.bInterfaceNumber >= no_dj_interfaces;
+			if (generic_hid_interface) {
+				hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+				return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+			}
 		}
 	}
 
@@ -2103,6 +2139,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
 	 .driver_data = recvr_type_gaming_hidpp_ls_1_3},
+	{ /* Logitech Bolt receiver (0xc548) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
+	 .driver_data = recvr_type_bolt},
 	{ /* Logitech lightspeed receiver (0xc54d) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..0b5d0a322ae8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4161,8 +4161,50 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	return ret;
 }
 
+static bool hidpp_is_bolt_child(struct hid_device *hdev)
+{
+	struct device *parent = hdev->dev.parent;
+	struct hid_device *receiver_hdev;
+
+	if (!parent)
+		return false;
+
+	receiver_hdev = to_hid_device(parent);
+	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
+	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
+}
+
+static int hidpp_bolt_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	char *name;
+	int ret;
+
+	ret = hidpp_serial_init(hidpp);
+	if (ret)
+		return ret;
+
+	name = hidpp_get_device_name(hidpp);
+	if (!name)
+		return -EIO;
+
+	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
+	dbg_hid("HID++ Bolt: Got name: %s\n", name);
+
+	kfree(name);
+	return 0;
+}
+
+static int hidpp_receiver_init(struct hidpp_device *hidpp)
+{
+	if (hidpp_is_bolt_child(hidpp->hid_dev))
+		return hidpp_bolt_init(hidpp);
+
+	return hidpp_unifying_init(hidpp);
+}
+
 /* Get name + serial for USB and Bluetooth HID++ devices */
-static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
+static void hidpp_non_receiver_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
 	char *name;
@@ -4510,9 +4552,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/* Get name + serial, store in hdev->name + hdev->uniq */
 	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
-		hidpp_unifying_init(hidpp);
+		hidpp_receiver_init(hidpp);
 	else
-		hidpp_non_unifying_init(hidpp);
+		hidpp_non_receiver_init(hidpp);
 
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
-- 
2.55.0

