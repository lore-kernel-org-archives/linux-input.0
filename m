Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081622;
	b=K2vmA10U03vOIqsHMwC774UnqHGAEDcshbcFMHHGuotQ12bVP4F6C0Nih2HOUSw45X8y
	 0iiuqWQOhj/UH5eAFfbexrs+3BC8rY9AYr7RIvXaf8OopRq2xElZGdyOcJcaf4s2DiRa0
	 Ofif18axGoSgIp0DBQOwovL0IVBJ/+UN32ekvNDeNS3rH44x9CpGkaobCvDfWEKHgB11b
	 2bF9jhADlTC+6atP5956+XY8UzuOYp3sHYIa0YUqx59ee5/TeohUFoig64F/3g1070Bb8
	 3cNJ0wVSvsDGXUPx7FbKkwODIjdY6FfOvRhPjlBYAA0jj8uxVLq4pnrocDFu5ZfhDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=f7jaCg8WRne6yjvM4RTZWaJveCSVces6jBOrWR6zygc=;
	b=4/sNqIAvx1Gyie04UDW+coNZvVpAhodJKr7R/XF+k3ELtzd2rVWw+poKVnFuFOgkOpQF
	 Z64P1S6ynQI6Tp8UfBpx5aGmeybfguvwP7FWPFbgTE9t6g4fjlV9dyoZeYXdjSNIv+RrL
	 bYGL28FqAX6TzP2kKRWdKeY541zyeooL9Dm6kEKZZohWdLnqqbtWmmT4xHHNrGqfJ+pXO
	 G+Y6v1hpneDSsefZplgsX377Fa6nYX/1nTVmC+yheaLvXXPlPjmkMPsp8sNTdSvqXLbFp
	 klHWV0iAXNwEv5WZf1fAUtFIlHI90LStLCheED56Zv9Zfu7EBlc9BCpJpDOKVAGvv5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BeBQnwi8;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5D606A31B
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 06:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F5D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BeBQnwi8
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad7030e886so4078549a91.0
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793081621; x=1793686421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7jaCg8WRne6yjvM4RTZWaJveCSVces6jBOrWR6zygc=;
        b=BeBQnwi8c+tJ+27RWYlCJUi2uTt5wP+3ns9Petb2hEa1X6PcyEKG23e5Gee+nYXDT4
         CJOVKqSy8YhSBkdOnHqc0g/8Pw+WpXIGYnVcBbt3QnaXcyODAkKxntrS3FiJGYuNLhkM
         xHZePZQ2tKzuduGz9+uKPuHuHG/QSk+VH2iSpHO+iaeNahUr9VAO2hkYerhdfUUM8B6z
         KcfeYeUEa4tOYnBp0ftxEDSy4NVQp0UMi9CifiISpi3Hn++ipyCKHCgHY3z/1yZ/8gx7
         zhsBF5DdnIWkEUCoMc4udmrONh7AVRRyYwOuNJ2AGb0HBrumDUKu4Z4byveEJTEolxcT
         ZjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081621; x=1793686421;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7jaCg8WRne6yjvM4RTZWaJveCSVces6jBOrWR6zygc=;
        b=mR0Yz5Anrqk6/V1e8wLO+QD9t82ONCZY+7lOBgLh0mzD5jHuHKJGrlVSMx+LEm0ktF
         cLS1g7D1qwBDhwO+kT+C2D/GjRfEIuEE2ejMm7JQUDefr4NF/+ph9xzQE3yZ1eKhXBJV
         csBdgSjzDI/UkGHjZb6AiJMDb9oHtxfNJ2OnG969hReYnH4JNZCiksF8QcbUGJK3nUsN
         VQnxsjfKxCW5LRz8RAKDASVshXuNQXhiwv0gCdxCAiXgQNxMeEX1qRoU8xqhurZfTsRv
         Xnu3QjU86mx9KT9wazPU+tC70BfZG2VZYQ32PIzr6yw1ufL9B5vPJfeU6VBIVpN1BRFZ
         POZw==
X-Gm-Message-State: AFq9FYLEYLF2ARIUoM9+aoB9YWOPOwzwMtpktPMjY1Y6y8M8JUJT6h4m
	UdOu/pdk9Mb5PN1140Jxd+Q7g+ONRHjMkzVMYh/UYct4H+4Tv2KhYaW0c89IZmiKjYMm01sHQAu
	HpC2ZOiLe68pGGBNNnzsrnLhd1kTSPAJD1zPFcwMU2KkGteq9BThJS7cqvRIUj4xMwE4Gs2Oear
	78PEKCr4LXHsMF7YtDZ4BnAJDE9obievVTMFP1saiA+5J9kDbY
X-Received: from pjhr18.prod.google.com ([2002:a17:90a:5012:b0:3aa:ee30:1a77])
 (user=apusaka job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2891:b0:3ab:24b2:9016
 with SMTP id 98e67ed59e1d1-3adead488d1mr7764219a91.25.1793081620686; Mon, 26
 Oct 2026 23:13:40 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:12:58 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027061258.3900768-1-apusaka@google.com>
Subject: [PATCH] HID: logitech-hidpp: connect Bluetooth devices before HID++ handshake
From: Archie Pusaka <apusaka@google.com>
To: linux-input@vger.kernel.org, jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, hadess@hadess.net, linux-kernel@vger.kernel.org, 
	Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"

hidpp_probe() opens the device and runs the HID++ handshake before
calling hid_connect(), so that the HID++ name can be stored in
hdev->name before hid-input and hidraw expose it. Opening the device
tells the transport that I/O may start (for uhid, UHID_OPEN), but any
non-HID++ input report received before hid_connect() has no consumer
and is dropped. Over BLE the handshake takes several hundred ms, thus a
reconnecting keyboard might lose the first keystrokes.

Bluetooth devices already get their name and serial from the transport,
so connect hid-input and hidraw before opening the device, like
hid-generic effectively does. hidpp_connect_event() still fetches the
HID++ name into hidpp->name, so the battery model name is unchanged.

As a consequence, the input and hidraw nodes of Bluetooth devices are
named after the transport-provided name rather than the "Logitech "-
prefixed HID++ name. Non-Bluetooth (USB, Unifying/DJ) and DELAYED_INIT
devices keep the original ordering and naming.

Signed-off-by: Archie Pusaka <apusaka@google.com>
---
 drivers/hid/hid-logitech-hidpp.c | 67 ++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 27d83b8bb..b552f31f0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4673,6 +4673,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct hidpp_device *hidpp;
 	int ret;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
+	bool early_connect;
 
 	/* report_fixup needs drvdata to be set before we call hid_parse */
 	hidpp = devm_kzalloc(&hdev->dev, sizeof(*hidpp), GFP_KERNEL);
@@ -4734,12 +4735,31 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			 hdev->name);
 
 	/*
-	 * First call hid_hw_start(hdev, 0) to allow IO without connecting any
-	 * hid subdrivers (hid-input, hidraw). This allows retrieving the dev's
-	 * name and serial number and store these in hdev->name and hdev->uniq,
-	 * before the hid-input and hidraw drivers expose these to userspace.
+	 * hid_hw_open() below tells the transport that I/O may start. However,
+	 * Any non-HID++ input report (e.g. regular keystrokes) received before
+	 * hid-input is connected will be dropped, and over BLE the HID++
+	 * handshake below takes several hundred milliseconds.
+	 *
+	 * Bluetooth devices already get their name and serial number from the
+	 * transport, so for them there is no need to delay exposing the input
+	 * and hidraw nodes until the handshake is done: connect them right
+	 * away, like hid-generic does. hidpp_connect_event() still fetches the
+	 * HID++ name into hidpp->name (used e.g. for the battery model name).
+	 *
+	 * DELAYED_INIT devices create their input device from
+	 * hidpp_connect_event() and keep the original ordering.
 	 */
-	ret = hid_hw_start(hdev, 0);
+	early_connect = hdev->bus == BUS_BLUETOOTH &&
+			!(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT);
+
+	/*
+	 * Otherwise, first call hid_hw_start(hdev, 0) to allow IO without
+	 * connecting any hid subdrivers (hid-input, hidraw). This allows
+	 * retrieving the dev's name and serial number and store these in
+	 * hdev->name and hdev->uniq, before the hid-input and hidraw drivers
+	 * expose these to userspace.
+	 */
+	ret = hid_hw_start(hdev, early_connect ? connect_mask : 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
 		goto hid_hw_start_fail;
@@ -4755,25 +4775,32 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
 
-	/* Get name + serial, store in hdev->name + hdev->uniq */
-	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
-		hidpp_unifying_init(hidpp);
-	else
-		hidpp_non_unifying_init(hidpp);
+	if (!early_connect) {
+		/* Get name + serial, store in hdev->name + hdev->uniq */
+		if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
+			hidpp_unifying_init(hidpp);
+		else
+			hidpp_non_unifying_init(hidpp);
 
-	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
-		connect_mask &= ~HID_CONNECT_HIDINPUT;
+		if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
+			connect_mask &= ~HID_CONNECT_HIDINPUT;
 
-	/* Now export the actual inputs and hidraw nodes to the world */
-	hid_device_io_stop(hdev);
-	ret = hid_connect(hdev, connect_mask);
-	if (ret) {
-		hid_err(hdev, "%s:hid_connect returned error %d\n", __func__, ret);
-		goto hid_hw_init_fail;
+		/* Now export the actual inputs and hidraw nodes to the world */
+		hid_device_io_stop(hdev);
+		ret = hid_connect(hdev, connect_mask);
+		if (ret) {
+			hid_err(hdev, "%s:hid_connect returned error %d\n",
+				__func__, ret);
+			goto hid_hw_init_fail;
+		}
+
+		/*
+		 * Check for connected devices now that incoming packets will
+		 * not be disabled again
+		 */
+		hid_device_io_start(hdev);
 	}
 
-	/* Check for connected devices now that incoming packets will not be disabled again */
-	hid_device_io_start(hdev);
 	schedule_work(&hidpp->work);
 	flush_work(&hidpp->work);
 

base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
-- 
2.56.0.307.g5fe7bd680c-goog

