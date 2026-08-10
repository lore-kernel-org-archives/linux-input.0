Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF4440A26
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395409; cv=none; b=DexE5XDbDbr8Hdsis3t7zEBTNfDoVGoc0JlrJJqpKcto7DaSDuxDeIyi7WcawaNKieRcgaR8uEENDln1pen9M5GPbZWp6A8UgJQFQCpycvrPWq0hPcwl5Dh7jUykeUneO1aQw7fhQUuHSTxkdv+2Ybp2stmsu/5lGfDvLo30iKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395409; c=relaxed/simple;
	bh=ZItw7XewoZcpHnlVwfxMbNUG5Ox2zA7qc0+aaDLg9OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLpnzAQE0Eer8YrlIyZ5yKT6f+Id2ZT57ndgQfESIuqvZYpXna9nBet+cS8vkPyKOc9YXyINxJ9VO/O8nRUhx/6ycEsRm+wl+Xd28w6mIWu6/mmZhcLCSNRaokUx7Fb8mKQJUxw8mM8TzZkjRYBs0xaM32hTBMJ9CaOb96TpQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXMN0K8L; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXMN0K8L"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso2837992a12.0
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786395406; x=1787000206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=57YvbXHCc9MK47m5AGkLA0ocAFSGzKZgx6LyaqvKhBI=;
        b=DXMN0K8LjcJ880xJXBGFzw5Ok2L28Ss4jtP6Tgdx3tDdRJiv9pwbWutUD6hw7nBZnO
         1Tg1N1e6AXnJAEqlufpUjPB6A0SvOQhQBGKvWqvV0fqezE8BS38/UGyIVkgZWi32pxih
         xW7x193/ojA/Vtha3RrgnAig+o2PQGy1tD6gF1UA3nu4kf8NXcn+avGfArlvp8ybM7/V
         J9sz1ExamPG5RuO4Huv7c00XJBGCo1l/Cpqeu3PF0DfBGjBJNbkKo4ctHBYOIUc26mRg
         Vg02DS/Xfok8Y9hWJXzY1TmTB7jN+/4TF2743HjYXKkAe3YKnRpd+lFmRep7O0IsHL1l
         ZFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395406; x=1787000206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57YvbXHCc9MK47m5AGkLA0ocAFSGzKZgx6LyaqvKhBI=;
        b=mvOejbZkSlUuQQkhMjpHZJX+KRTO/iKJusYpg/1jxW+yl7a8v8gLlGLu8L8UnSZGPv
         6JzF0RaPhGWMNazGdRCyFEm2Ww5HNwTaePz4fMthc+Du/KhHPX1SNBQbwyP0IPoEY5UR
         1C6TxGsjDwTts9Skt6Zjs2eHbm5WBEH9w7S1m4zF/Ak5PvcpiQ5Y7FZjATJftuJOsebv
         yUC2XA0YlDeUw+Y70dTWjHj3uV0ZO5lv81P/vnqGr1xFG2bg82Yzzw75qokquRx8gC9D
         FnISY+zHnXvdq5Er4UhNM5d4eUgylmaUFfl7lYFEG3WTvJXHIVOzTgs/M8RETZfvbjcV
         eFpA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0abBY43cIUqkFMWGKh3FJeq2m+ouEztTYEoq7eo0zD0OYKpFCWY7xZMSdmM8/o5BBSMSMWRs+RoHXbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFC97BH/W8MnUaZvsB52KjnkV4gEsw7TRA387HVa1HNcAJaZY
	EwKxZ5sSkCRrDHckozKPVzVuxtWhv6/ro9uzp73CHTm7q4Snv0/VRGZSACdy9wD8SNg=
X-Gm-Gg: AR+sD1200Z7EzxZB8sMPCfFWbBexolwG4E54VUzyBeMafM31PT9efIE27MrpckcFY+A
	7AxICG/lXx/8um7JarriZ8d6B7hrX65Ru37sg9hH5WAPlxvfplx+t8SjshDwEGquT2w+z6IjEcY
	OXoT5cyrl5v0CnEuMwy3sNXalY3cEPhFTkJlgGRc3ZxEDi60FMFjdaP/yn3bjFlTdcg3W9my+I8
	ez6bP4xoS3DJnicV44EjxaWfOzyu1QrVmEZMjNCyIXemFCBNBwx5vmQRAME2uTQ2Hg0LhTFUae3
	fADA/RcNPH2qE6EpU76Khd9Bn2t3zopxG8z5hf5RkNgtdSTc3FUUCFX6E3drGQxIcDXnrnDJYh9
	qGT7/WufPcm+qBl2X7GmtcZo3u7vZNRlszIRA0wjbREqpd/+LFER9DGa+xUyCH5jk4lYKtksTa1
	TEQsWloKcKcI1zb1IAcFOa4TmpqqzF7Mef90+2raBZe3S9h/eRXn54yBtZ0rt8dPU0JaYYI75QN
	l37MZViZZ0tRCTTdHrW
X-Received: by 2002:a05:6402:5048:b0:698:b6c8:70db with SMTP id 4fb4d7f45d1cf-6a355d93f93mr2643123a12.8.1786395406037;
        Mon, 10 Aug 2026 13:56:46 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7c9d912sm4450986a12.2.2026.08.10.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:56:45 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	k8ie@mcld.eu,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH v3 1/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Mon, 10 Aug 2026 22:56:34 +0200
Message-ID: <20260810205634.209099-2-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810205634.209099-1-erikhakan@gmail.com>
References: <f44b06b1-e1fd-4d96-9728-4567fe62c501@gmail.com>
 <20260810205634.209099-1-erikhakan@gmail.com>
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

Also, treat HIDPP_ERROR_CONNECT_FAIL like other disconnected-device
errors when retrieving protocol version to avoid protocol error messages
when a Bolt device powers off.

Tested with:
- Logitech MX Keys for Business via Bolt receiver

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-dj.c    | 48 +++++++++++++++++++++++++++---
 drivers/hid/hid-logitech-hidpp.c | 51 +++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 8 deletions(-)

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
index 90b0184df777..37f941ef6946 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -983,7 +983,8 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 	}
 
 	/* the device might not be connected */
-	if (ret == HIDPP_ERROR_RESOURCE_ERROR ||
+	if (ret == HIDPP_ERROR_CONNECT_FAIL ||
+	    ret == HIDPP_ERROR_RESOURCE_ERROR ||
 	    ret == HIDPP_ERROR_UNKNOWN_DEVICE)
 		return -EIO;
 
@@ -4161,8 +4162,50 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
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
@@ -4510,9 +4553,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
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

