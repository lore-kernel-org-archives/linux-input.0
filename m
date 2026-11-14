Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636006;
	b=gcb1b6F8acCi6xJjWogb9/3K2UzJqG46jdsUoaiYZu6bGdH38HtJ0GYUwNL6+ZAHTvWh
	 zPHIp6bkOi/Lidl7D12mvKKbbNYzP15BLrh/TlyE27XbJYS+g5Rq7jYhQ3Asr0o0raiBw
	 6ZgzyLTMe3FByNPioZil5lDWuWNpmhCED7swY1PMjCkvDKs3p0xOAqEHDdHAtAmaA2f0l
	 V71dFFcKpXYHo9l6a2atFbOoee5OdLdnZG2A2VBvTEqWbiHwcjIjtlxpD61QRnNKMzZVZ
	 AZhzj0jxbhlfPQpU1+27ZJCQcMhQ2vtSNqNezQZk4qWxMUzYwzkqgGnlCoa3QysSbng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=9t8zd5u+23Czp1q8gEHFNS23HaZ00gcM6f8XnrndKQI=;
	b=5Uc3X3m+kR7jvMYm9vSO9IxMptaCFhBtM90txMaJ0ST5pb5VTdbLr8nvnDYFZjl77clm
	 D7vxFMsJjisTOxRmhQnPPGPcJsSXjPDbfvt071zlQu25syqzcft21Wyo3rMtgkRZZ56gS
	 WDICmr9X/w7xDM5gQHT4TBWSms+b1f8IRYS6DzUlkaqF/vnJ4inWgFtJjgYPiL9vnClXG
	 TwPI2mU8m99wPFsCUNuvUcfqTy9lwzJajwGuwXh/JI+16+f/Q4dMiGgXkEFLgPJPZfGSo
	 q3eWTfc/MbA/zhvqhOiw1RaXHrEz2SkNb4V0JPbyY4dUdyZfycAkhqqpkwvTWiwB3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpznC0yu;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66657606A898
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66657606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpznC0yu
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33fb4680717so4986599eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636005; x=1795240805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9t8zd5u+23Czp1q8gEHFNS23HaZ00gcM6f8XnrndKQI=;
        b=OpznC0yuMLkIIxM7Et1GcC/V9j+9B76vebUmfOjYRSX/DkeoHoGfvW2yTJ0LkxY3Zo
         ODBOJBnSo4KLmTwf5rBfqMCUx9TnUqqvHsCl6tY6YIb57ZR3EzQm3JkLytUsyo4Qdbw6
         HWoTvTksSWubQZcnUUlQNp7MlLpAhMajS4okSGsnBY3fO+VA+7U0M9Nvl7096J85ZhbM
         WpKmhmwbBYJoT2HUfxgaXUar4corIWgOyOF7tojotj7C1tLXu8X1mMiylwnn43UdB0oB
         QirKqy4FvSd6kx8SL4iTKLS1RtN8Qo0jiGc71TOKl94rIyG8j4H8QAGReFoW/5OSEnUH
         iLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636005; x=1795240805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9t8zd5u+23Czp1q8gEHFNS23HaZ00gcM6f8XnrndKQI=;
        b=TYqLc8ULnjEV32ueVDrxg/WcD0cekiGr3o18V67yRyVNzeMpw9WcucTd76St9pHekU
         HjEWb38vA+ekCvQzXMdYWTwZ1RLg3i3N+/6rG/UMFgHt1FOfCBjzJ8ZLov9W/XIh9tMV
         vc52jOS6K2/zsyb3/h1ILBGOJD7vIdLqVAjvVIHz33938MjlZO8p7mg+pByEJXKPNaU/
         egwgW5NgVexO3uf495xLqCFN6eL1AtjeNBypJDN8XxdpkAmqa/GtdP3y2pFnQSpuaeS9
         Aua/eZ08vTa7nL7USEsxxKv4/IzQKf3IVr2nt4XEIqsYNLdHy0K3qt8yCJgdqyS74X4y
         Z6XQ==
X-Gm-Message-State: APuU4Z+tbOx5pBsdO3D1jIWNkCeWQ9jCtSrmBxWF1RQ51FyY4yvBAw73
	g36d6ZWK9MRDwZhBRaMezatBG2jDnFWNhst0FfFZIXv2342iIl7/5To7
X-Gm-Gg: AYBFou1glA5hNqvvkiBoePknnY124gBMbd4LnLxg4rhA/hh0xGTXLv4bTieIRChVFkB
	St5WAZKtz2SoU1iLTs8PcC4KWngCswPlB2cDOQtDIdN8geCKpV3hbE7+7SmTKkdcPuHLYKK3o7H
	FPtEv35MH/I6Dts9Dd1l9vaIJYIrQprfC7CzJ9Xy2X0SOBwpWG7MGGRDKdSr2pMJG1O4v6YWzLx
	ffu4BEw4bEXjYS+3fNFtTba8+TReAgIh+KripgaAtVYOcVj2Bfr82Py2H+8tMYsExfSeh+6Uw4Y
	Fb4FcdJnaQETMmhoUxexj8xx6ORJrguX/rzgiuBpW+/wD/2n9HFDY7VNyMf3x2KfRomAwomHlSG
	wdNiheA8IsaBq36PLVrKx3c55z2s3Qmt09WOZQ1/mA1IIswr2O+RFLJOm9LdpcrQcNKa3/zLOEO
	xoYYjBva19EXIyOfsfdV1UiJHSKi2aR2Mwes3Wwaf88jxX/W/j9k561ptNK6M790I9HyH2E4MJf
	VO27sX8W3PhXd0N388wbgv8Lal95r5dyCc07RtKvKhyflonEFxW3rmOAzOacR9Cq95EEZnp3qR7
	tRK9gX8NrW25FjLWoEFIJEEw8WX/qxJbcFCLeeU+JfFfy2Zdhh5nd+nEPViffB7fNOxWpO6jEoy
	sfxs+rADGmel7bdG5
X-Received: by 2002:a05:701b:4194:20b0:1b3:aee5:20c5 with SMTP id a92af1059eb24-1b5030fbe7emr5225013c88.22.1794636005390;
        Fri, 13 Nov 2026 22:00:05 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:04 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:53 -0800
Subject: [PATCH 03/12] HID: rmi: validate read data report and protocol
 transfer bounds
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-hid-rmi-v1-3-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

During probe the input report buffer is sized from the attention report
rather than the read data report that uses it, block read and write
requests do not check that lengths fit within the 16-bit and 8-bit
protocol length fields, write length validation occurs only after
switching pages, and incoming read data events do not verify that the
received report is large enough to hold the advertised payload count.

Size the input report buffer from the read data report during probe,
validate protocol and buffer length bounds upfront in block read and
write transfers, and reject malformed or truncated read data reports
with -EPROTO instead of clamping their length.

Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Fixes: dd8df28459dc ("HID: rmi: Add functions for writing to registers")
Fixes: 4956993bb3be ("HID: rmi: fix OOB access with undersized RMI reports")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 65 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 41676685ce28..d9181fd66c5c 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -197,10 +197,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
 	struct hid_device *hdev = data->hdev;
 	int ret;
-	int bytes_read;
-	int bytes_needed;
 	int retries;
-	int read_input_count;
+	size_t bytes_read;
+	size_t bytes_needed;
+	size_t read_input_count;
+
+	if (len > U16_MAX)
+		return -EINVAL;
 
 	mutex_lock(&data->page_mutex);
 
@@ -241,23 +244,14 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 				break;
 			}
 
-			read_input_count = min_t(int, data->readReport[1],
-						 data->input_report_size - 2);
-			if (!read_input_count) {
-				/*
-				 * A zero length reply advances neither
-				 * bytes_read nor bytes_needed, and because a
-				 * reply did arrive the wait above does not
-				 * time out either, so a device answering 0
-				 * forever would spin here indefinitely with
-				 * page_mutex held.
-				 */
-				hid_warn(hdev, "%s: zero-length read reply\n",
-					 __func__);
+			read_input_count = data->readReport[1];
+			if (read_input_count == 0 ||
+			    read_input_count > data->input_report_size - 2) {
 				clear_bit(RMI_READ_DATA_PENDING, &data->flags);
-				ret = -EIO;
+				ret = -EPROTO;
 				break;
 			}
+
 			memcpy(buf + bytes_read, &data->readReport[2],
 				min(read_input_count, bytes_needed));
 
@@ -285,6 +279,9 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 	struct hid_device *hdev = data->hdev;
 	int ret;
 
+	if (len > data->output_report_size - 4 || len > U8_MAX)
+		return -EINVAL;
+
 	mutex_lock(&data->page_mutex);
 
 	if (RMI_PAGE(addr) != data->page) {
@@ -293,11 +290,6 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 			goto exit;
 	}
 
-	if (len + 4 > data->output_report_size) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
 	data->writeReport[1] = len;
 	data->writeReport[2] = addr & 0xFF;
@@ -305,7 +297,7 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 	memcpy(&data->writeReport[4], buf, len);
 
 	ret = rmi_write_report(hdev, data->writeReport,
-					data->output_report_size);
+			       data->output_report_size);
 	if (ret) {
 		dev_err(&hdev->dev,
 			"failed to write request output report (%d)\n",
@@ -388,13 +380,19 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
 static int rmi_read_data_event(struct hid_device *hdev, u8 *data, int size)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
+	size_t copy_size;
 
 	if (!test_bit(RMI_READ_REQUEST_PENDING, &hdata->flags)) {
 		hid_dbg(hdev, "no read request pending\n");
 		return 0;
 	}
 
-	memcpy(hdata->readReport, data, min((u32)size, hdata->input_report_size));
+	copy_size = min_t(size_t, size, hdata->input_report_size);
+	if (copy_size < 3 || data[1] == 0 || data[1] > copy_size - 2)
+		hdata->readReport[1] = 0;
+	else
+		memcpy(hdata->readReport, data, copy_size);
+
 	set_bit(RMI_READ_DATA_PENDING, &hdata->flags);
 	wake_up(&hdata->wait);
 
@@ -722,6 +720,12 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto start;
 	}
 
+	if (!rmi_check_valid_report_id(hdev, HID_INPUT_REPORT,
+				       RMI_READ_DATA_REPORT_ID, &input_report)) {
+		hid_dbg(hdev, "device does not have read data input report\n");
+		goto start;
+	}
+
 	data->input_report_size = hid_report_len(input_report);
 
 	if (!rmi_check_valid_report_id(hdev, HID_OUTPUT_REPORT,
@@ -733,15 +737,10 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	data->output_report_size = hid_report_len(output_report);
 
-	/*
-	 * The write reports built by this driver occupy 6 bytes and the read
-	 * handshake looks at the first 3 bytes of an input report, so refuse
-	 * to drive a device whose reports cannot hold them.
-	 */
-	if (data->output_report_size < 6 || data->input_report_size < 3) {
-		hid_err(hdev, "rmi reports too small (out=%u in=%u)\n",
-			data->output_report_size, data->input_report_size);
-		goto start;
+	if (data->input_report_size < 3 || data->output_report_size < 6) {
+		hid_err(hdev, "invalid report sizes (in %u, out %u)\n",
+			data->input_report_size, data->output_report_size);
+		return -EINVAL;
 	}
 
 	data->device_flags |= RMI_DEVICE;

-- 
2.56.0.679.gc527c65306-goog

