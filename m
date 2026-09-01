Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAC4A2A59
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294694; cv=none; b=NKApir7NDuf0/V7ilv9+Kwn0o9vkMrhkXXdIlenU0Xqls+sm325DaM+v5wTEpx8M+nmF+5lKGBdTPd3ng778lhUFxsIzQzAWGxVDAGt0+bwP5DOTYWWYgixuCc1F1aUsy5xVzhU16y1C9WYaCnoBTH7RcyLC+a10PIDwtpfmJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294694; c=relaxed/simple;
	bh=r2/YOQb9T6MzaMYg03CbDO9GwKYIeSlAMq/CQUL7ps4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bg0uLvJ7Rp3xok8pYgWaKpZTfQWmMCCJFbrVox5pxVH+LmNZ/RGt++N+tFwjSTtpKaC2zWuUmEupEbr+1JCQGXZv7hag9knxGsQEAreCcHAMovxgT1sCke3TlgdC1Gd5N9A9K0Bm1jI1irFHjMSy7rXuO58mEi6Leeor99ySYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn5UMKso; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn5UMKso"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2020421077so30575366b.3
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788294688; x=1788899488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPYLUdopWsrdngJNQNul9EKNO0vgvEEJ19NOW58wdpM=;
        b=Cn5UMKso6GJFp8FtHuL0M7U4NaWkBPdJwTt1Q2amSyhjfKyqi6+dRNtE2YcczGPugE
         3l6V3V6rvVEUSMdzBaineDpW1yzsk8vUn3usVD9jPlK1uumTGB+iPlGM6jPzjIcMxv7m
         qCuGAFRucLXJy5xHdFjBkNyPenoIdR5R1ahSueT2aNm8Fpv6VAWzMy+zIbmKLV6R2SNo
         Y9uvD8ESLo1o3HMaxwgcsWpJ6Ya7yWEbjdhab1nt8YbPFje7SfbmCX0te9Kips9a9aKf
         S7jIxIhcfX4vBVc4PjIUOJMiQMBXNOtU59wYVH9s0bIYWJFzvBTv70xYWWNaUlfXT6jl
         cpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788294688; x=1788899488;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPYLUdopWsrdngJNQNul9EKNO0vgvEEJ19NOW58wdpM=;
        b=e/cpdoTJISDiS61rbCY1Wq/NURGUgbYmq/mV8IVc8FJ/jmCLI5BgUuFPYmt36Lb1NU
         dfNcpUyhUE5VBefuuDEEKup8T0HjYqFd9EfaD9oE4ThCRUaUhXNF74g7lpt5vuOA9QpP
         TRrKolLIJ3qEF6zma71H7ZYDFlHb4kDQsWZb5RGikm6G8rtCt5+NC2SxmeOn6qjT/85u
         /ZzmpENOoZOFkrweuspQz3q2kPIn8ROPP32L1aVpQ7osvET6GowAkPyNvhqkVsQS3tdw
         RLAbplVUE1SNpO/VNAM5+M1ACxPLvUmi/CZ2iBddroUdXqSy6/k87WL5gfk+BiboqrZt
         p5Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpCmMB9l7wsMQ69PlP6xi3FcgBkHz0Ysg/LT/9ObBQUVDtfAOrDU9iF8VVObmYr+jDj0TXp4MOU2sz97Q==@vger.kernel.org
X-Gm-Message-State: AFuF++ksspSfYIJ8QtqozJHd5xBY60fXODbHKP6vYegjSMQRWqMzrWtt
	ofCeGDhf/quPwcu4meOUOrEAye9OQDJSsAHpPzCXex4xz2tIQeXN9bO/
X-Gm-Gg: AR+sD12rwXsFmwCVCST15+MPJ40kabbMCnjjQbmR11JL0iMpPUpiYsJhh7w0dkxmhwx
	WTrwUCCxujxqLmQ5vxMhPLMVQCeORdwEd7X0ro8IfhI3GRjzpfM0FJazzFNKHOvUhjc82qlgEKs
	s0ImZ4cKkCcnAkIDHFse0JFQgAvOXbevoQR+B8VYhxl/ZwJmfFE49P/P30hY7zUC7g3hv/w0JhO
	qogssw28xTFzsyNR/11aCUF9Myy6TSg0NNu29Csn7+eBVKPCeDsMNYhqiAXf3awD3Itm149lovv
	6smCTvzkQMUWrjyW6kdiU9AA48G59qs6bXar4MnN3LbERyh0nyw8MQ2Cg8detLMkarcXUAVpYzK
	1+C42qcSufHSLIBGVRUmt/S2aeVEr3NYqHR12X7hQekTUpBpcO4+BP0V0MuT4rPIgMNFlAWlcbu
	R4fR+GrA9oSf9gDy5W3Mtac/iB7j9BEJhWigyIHmYkQFn1G57EuJ1CmFjIsVrNyLfMst4qXU+wP
	rSwstVj7v4yQ4c7Cq6j
X-Received: by 2002:a17:907:1b20:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c25d11c031bmr38819166b.9.1788294688376;
        Tue, 01 Sep 2026 13:31:28 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7116sm20111766b.9.2026.09.01.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 13:31:26 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH] HID: steelseries: Add support for Arctis 7 (2018)
Date: Tue,  1 Sep 2026 22:30:44 +0200
Message-ID: <20260901203044.459972-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The headset reports connection and battery status on HID interface
5. When the device is disconnected, ignore incoming battery
reports as they will incorrectly report battery level 0.

Clamp overreported battery values to 100% and add USB ID 1038:12ad
to the driver's device tables.

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
Information available online suggests that at least two other Arctis 7
revisions (2017 and 2019) exist, with different device IDs.  Without
access to those devices, their protocol compatibility cannot be
verified, so this patch only adds support for the 2018 model.

 drivers/hid/Kconfig                  |  3 +-
 drivers/hid/hid-ids.h                |  1 +
 drivers/hid/hid-quirks.c             |  1 +
 drivers/hid/hid-steelseries-arctis.c | 44 ++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index aa7fa11a0197..06f7c35b619f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1210,7 +1210,8 @@ config HID_STEELSERIES
 	depends on USB_HID
 	help
 	Support for Steelseries SRW-S1 steering wheel, and the Steelseries
-	Arctis 1 Wireless for XBox headset.
+	Arctis 1 Wireless for XBox, Arctis 7 (2018), Arctis 9, and Arctis
+	Nova headsets.
 
 config HID_SUNPLUS
 	tristate "Sunplus wireless desktop"
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 341bf587863b..1867f480ebc0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1394,6 +1394,7 @@
 #define USB_VENDOR_ID_STEELSERIES	0x1038
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_2018	0x12ad
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X	0x2253
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7	0x2202
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 8a0b51d47040..4862d7356120 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -751,6 +751,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_STEELSERIES)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_2018) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7) },
diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 23fb0cebd72a..fa33fbd94889 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -101,6 +101,19 @@ static int steelseries_arctis_1_request_status(struct hid_device *hdev)
 	return steelseries_send_output_report(hdev, data, sizeof(data));
 }
 
+static int steelseries_arctis_7_2018_request_status(struct hid_device *hdev)
+{
+	const u8 connection[] = { 0x06, 0x14 };
+	const u8 battery[] = { 0x06, 0x18 };
+	int ret;
+
+	ret = steelseries_send_output_report(hdev, connection, sizeof(connection));
+	if (ret)
+		return ret;
+
+	return steelseries_send_output_report(hdev, battery, sizeof(battery));
+}
+
 static int steelseries_arctis_9_request_status(struct hid_device *hdev)
 {
 	const u8 data[] = { 0x00, 0x20 };
@@ -152,6 +165,27 @@ static void steelseries_arctis_1_parse_status(struct steelseries_device *sd,
 	sd->battery_capacity = data[3];
 }
 
+static void steelseries_arctis_7_2018_parse_status(struct steelseries_device *sd,
+						      u8 *data, int size)
+{
+	if (size < 3 || data[0] != 0x06)
+		return;
+
+	switch (data[1]) {
+	case 0x14:
+		/* 0x03 means that the headset is connected to the transmitter. */
+		sd->headset_connected = data[2] == 0x03;
+		break;
+	case 0x18:
+		if (!sd->headset_connected)
+			break;
+
+		/* The Arctis 7 sometimes overreports battery. Cap to 100. */
+		sd->battery_capacity = steelseries_map_capacity(data[2], 0, 100);
+		break;
+	}
+}
+
 static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 					      u8 *data, int size)
 {
@@ -232,6 +266,13 @@ static const struct steelseries_device_info arctis_1_info = {
 	.parse_status = steelseries_arctis_1_parse_status,
 };
 
+static const struct steelseries_device_info arctis_7_2018_info = {
+	.sync_interface = 5,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_7_2018_request_status,
+	.parse_status = steelseries_arctis_7_2018_parse_status,
+};
+
 static const struct steelseries_device_info arctis_9_info = {
 	.sync_interface = 0,
 	.capabilities = SS_CAP_BATTERY,
@@ -653,6 +694,9 @@ static const struct hid_device_id steelseries_arctis_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
 	  .driver_data = (unsigned long)&arctis_1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_2018),
+	  .driver_data = (unsigned long)&arctis_7_2018_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
 	  .driver_data = (unsigned long)&arctis_9_info },

base-commit: 786262be6048deab760f68c8acc2c85607165894
-- 
2.55.0

