Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156322083
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783816282; cv=none; b=C2hRmrbn2X0OG4IuAOZ3ENuWjTOzb9R47UV1oWu8TBUK4S44C6ahBjz3hbzEza69viD0tFy3N/B5AlbOpAuoJExp5i1k7Eb/1FUIh6qRzjqFuBYYZJN9d37yTyrexlnxgnU8Iy2VEg7l9kAIdy4eu/aH1nBk6sLhrKOYERFtYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783816282; c=relaxed/simple;
	bh=qNfFZP7AfnOcmUW0QHz98+2CFd0PxxJKCgqWuva3G/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4XenrWsus7ySkYxiKGTRyoZScSJaah2XN4B9EXzATHcjfXrdp8OegS3dWDHKHLeJtWXI0XzoDoFM4TZpQfXy95AVgBaOhPss8nDYAxJF+24cKnfj0+LNF0K0lv2lzQH6l09utf/8Hr3WZrlxFGq6KPqvaLk+breQ5L/8CsOwag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlDJ6F18; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlDJ6F18"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso2947644a12.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783816279; x=1784421079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jnnT6+ueFlufbumDS0YKnsjj4wZbZ5+mKOtFOW0VQTE=;
        b=qlDJ6F18AzuvxL5MGd8NBbbV3xzsucMkDHqKCgDp9ve1MZmIBKo35m8E4aM9Sfojn6
         YdBdwnkEiKO9OgWhfcMC17TC4+dkFPE+MmGRPjsPLCeblqhVFa+jNjMTOCBhA9b8NtLs
         vx5eMN49ZFdgESMLVnXfBtYRC3gn5IhNMn7kQWlpjKFd1pQLH5lPXF+4CVQskkswBa4R
         32aHMFs4BKxmCVBOmLeYFDeHuqbzsbIzz+WBnPFb1U1QfQWGwFxgf4LFyheMwbN//rvy
         +b9MflST3dp73yAgcWWzmBdKdv6qjpNrfrbGJZe8u1BvYfHNG0hIVW7EsK9yGMrF/5Ur
         YuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783816279; x=1784421079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnnT6+ueFlufbumDS0YKnsjj4wZbZ5+mKOtFOW0VQTE=;
        b=AQDzJi6txnUSsa7WPeMZHX+FGI0WdVVcAUk/aA5/LNUbyKa+tLR3U3JGGMAPetyjHa
         VfE8AWiy9jp4VjVk6CH5xqtbLeTXTMRdGfDm8nMz9hIxLEBGNjHI7V9c7aj6HZQcInSA
         LKSMM/E7YBr354VsaKfvzG0CP6WeKyB+EAUfAf1p41TWMp2hM175ohAswdqegWdMQOQU
         FIjo91N+9roC0UHCgeJB7IILFHgVKaFW/WCYGQRfk+tZ+z0d4KwB40/zi7is0h7lWnHs
         ZzkE+olEelGjWRSYPOmXNCEN+SLvqXCWYtwFb5iOvhPa81qmisGfAJxbD00PdV5+Zrk6
         AMCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNSSOhKneYPXu4T0ClYY41UHlVVuxIKRMbWISz7tJRF/VwrM+m8MsGDwzAdIEE15A+OGOjqnP6cCib6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQR5kmfBLs2b/7rr8MZi8QLj6MtsrwYqoonzr6N143jfIKgU45
	3R8m7wAdQ/0Pyg2ockC/Z8LnFEo/PbniX++qDHdEc0IXsqVe1MX9Ct56
X-Gm-Gg: AfdE7cmSUrVTE4haQLYxBqTVt/0uhcPT9ZqrgiZVKMpealFD8rosRK4igpRnDbe4+8V
	MiehL3eqvmiaGzw8wT5J4BjB68ogiwv2oGoVEv/IqaBj44bHs22MFj3W+k0jpZ5Y5HKcEf2UtiB
	DB6IG4jNaG5GGfdcMBQ8Mqnv0PGiZbOPsZRz8zEOdehqBCAcMQK4TALG6VONXO6Zp2AHVLeX2Rm
	f33KtGIjVzYb2G1vzzlh8ea0qwWphVUFGn6UvIlaHjl3Mzjp7N39u5juCY2heJuCkpZ/M0l5UqS
	7iq6UspUPUsPE01xQ62FbXjvDUJGkGnhXTie2F2aNdN1h7yUf03qZX6P0eitY2taQSsIW58DumV
	3YQIjd0h9VBqRp60HYnoFL43ZZI5AfyGHe/mZqiXDqVm98V8T9xRF8iZKmM7eYgWR7zwQZu6s/L
	h4Q5HghjIjVstKzv7VPSPZozOnGc2r1mxS+A1n9fqZMFQm
X-Received: by 2002:a05:6402:13c8:b0:698:5f89:9a51 with SMTP id 4fb4d7f45d1cf-69c5ef84df7mr1776164a12.5.1783816279007;
        Sat, 11 Jul 2026 17:31:19 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm7512380a12.0.2026.07.11.17.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 17:31:17 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH 1/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Sun, 12 Jul 2026 02:30:51 +0200
Message-ID: <20260712003051.338194-2-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712003051.338194-1-erikhakan@gmail.com>
References: <20260712003051.338194-1-erikhakan@gmail.com>
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

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-dj.c    | 10 +++++++
 drivers/hid/hid-logitech-hidpp.c | 48 ++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 9c574ab8b60b..518a9ee662b0 100644
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
@@ -1894,6 +1899,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	case recvr_type_27mhz:		no_dj_interfaces = 2; break;
 	case recvr_type_bluetooth:	no_dj_interfaces = 2; break;
 	case recvr_type_dinovo:		no_dj_interfaces = 2; break;
+	case recvr_type_bolt:		no_dj_interfaces = 3; break;
 	}
 	if (hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
@@ -2103,6 +2109,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
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

base-commit: 44696aa3a489d2baf58efa61b37833f100072bee
-- 
2.55.0

