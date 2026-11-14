Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636020;
	b=IvYtBrGkK3kDno0qRKgd/cwuZ6FrKn1MuHwcr3ZOUaLGYmgKkRYl4oSy5HxIxcl9gW92
	 FEEmRPyAbhSbMKY8Wms/7NGlBxmwMh7QEgcLe5Xoa1jepGvwMc3kHKzaVDErft8lSS/kZ
	 roC8cmHENM0y8qDciw8ahQC10abW5c/1XoKdmVmWyXqe78mkU7HUyzyaYKUqk7nDvG9Ln
	 yfspFulFIbIgOpzUq20837K2pvEI04huOQ/cqVz+ifbZttkgNglMb3ZSwKVsYrGa+c9i3
	 B2ggJ8fseEEAnf5NrqVyfiz0SnuLr0JK+V06SdJ9OenzZLdj2mhO+IIIAsoiuc4DQnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=6D1DtAQ45na1bJp3KYolLryCl2gvpo4YOuSak76Ty7o=;
	b=mxs0XhuNg6124nJWGsC4SeEsTO9vFzvIb6TmMDprE3hSyb83Tgskk2Hj69IcKy5iaDEY
	 l8O18oYTRW8hPuEzb9OXRl5mOFZyewq990pczDVSRBHtE9au1zi5nEHpmxAUFNxunyYTI
	 eS0ufXi/vtCa3BehcQ6AjWvlZ1BktlRH29MVeYkN1vG1JRXM1o1x1qn/2nmEhrdeswJaK
	 vdzbY+REJM2EzGBZTvJSlAr0QP4OYHf69BaiLKwdax9C16QObzcEM6Gvd70F9uNIcls/H
	 BCA9db7EQMkTPiOXmbjzDgyV3YR8KWnQ6XAqJ1eghOZYuUijeCJnUsUGl0izIQ/qE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAt47y+p;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351660A5BD5
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D351660A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAt47y+p
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so2227602c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636019; x=1795240819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6D1DtAQ45na1bJp3KYolLryCl2gvpo4YOuSak76Ty7o=;
        b=DAt47y+pBlaQ8PAQy2jCfu89v2oOxhTFQWHMa/JDw7tMsu5d0W4NcMdDU+RIJqHPXW
         cMJ3kVNiKlsVbqnpehlssARS5JbiqD6O0pqgPGY7TqseZ/kz8K+4JSQ85z/Wy67B+uYK
         bFzibOQi9CXggws2aaJNGTYf0Zr/xU9udQSZn1n8v2EDiJcNVuA0UZucrN7sosropLUS
         F+y75jWwvKeP8fC9CVSWxRpPC9cKMoPYo0wlJuFcZDXCCHxRFTZyFnA3qRKV6RDfTp2m
         9FVb0qMuGne/I6GnamIR/M68twmStPdazNdfL/DG92RrScLsn2vhG3pTpi0Es4p03q9k
         +zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636019; x=1795240819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6D1DtAQ45na1bJp3KYolLryCl2gvpo4YOuSak76Ty7o=;
        b=b3a9Ad2u8Pu/FTaMCoM0F5zIxaiLaS/Kj3yIflYNbWxw8jZKOgsr+ZXATEYTpNXMH+
         5dtl9h+tuYxu3cM/nMLKf4Q7IjfKpWzWB4iqFKL5EXY/PIL7uejmUoGlIcFTWbVoZ484
         3vWC5d3VPEbVTuYG7fDFn8F5k5Ri+aV2MDd3VHPRft6oL/3OaZo+lmMdrCx7s35ZWMLD
         zchCK+4zJj4ugakwPJ+7jW9wxkRk23bk2OLHlaxGtPIZaR3QvWBcp46hPhluIrAKMkiU
         RMlIwfSD6HdQZpIjBSN/jYo1naoHZDjAnwEIriUhK4vJhm4iCr9YDlcSCeq7HSM5Ky5L
         UTuQ==
X-Gm-Message-State: APuU4Z+zpBQPBwmwZlx/gGIXU44wgcnl0GyD4gJj4G1yDKztZ1gnsSDY
	mnTZlL8RMKEWicK/Kkcuubiy/M9jONDEagmSGom2KaZFMjVB56wyUc/2WA3PcQ==
X-Gm-Gg: AYBFou1Zw0uizei+dzgUb/iZ/dWrmAh6MdvXyYHwbgaAaZtFFVbjEJUVLdNQPrB9c3k
	8kjDTOE4FAq+AzPlixFP46x76x3y7gGHVm61lgkndG5K3k4Auxe4BAQfuYZzGeM9Sr7GDWdDfg0
	6+O8cL0jbyXhSBddSF8a7TY9HA29mi7gRTIrKgK0wlBeohYWVQnHam1TSL6zLETl3iUSGfiYBF5
	pmIgt0gl6YmaTO+5g7/71mfF7XrCY1+qeNd6wl0dgLBXeVaFKQYj3/636Pg11r5cJ3Ag4ChML9r
	t969S7L+3dtHuenb6WMFXPvsYzoLny1HuV4eoIQXOBqbX2Sp+c5tNVPPmWGiId8JEcDGlhaQz72
	1PhrUH2bctQjuo3ufMGCLx86DL+bQtmfRkINDDsDZtq6WtJXIqVsGyMxYmonN5wdKcpgQ+7gAHh
	gAj+dJ9CziGGYE8byRfij7FeAvTM8Nv5DWeuBqzIjRQ1kNZqxPk0iHa3oDbnLn7DqbTwx9SqGI3
	hdXmTv1Z6i6fNW1ylOB7Qh0AHDENy/AUdQVsclGyko+pr1d7/Pd8qfXclLlDiEZgfOf7g6whgR/
	dDeSEkR6fB4WB81l+/3GzSPFiWHn5/9Cx1wrKG68Xy3wxCOwNoPzgMCYz0Z4CrAwOl/YbhCssji
	Glry7+2yTAZfQimFo
X-Received: by 2002:a05:7022:108e:b0:1aa:47e7:97e3 with SMTP id a92af1059eb24-1b5030d78c8mr4666022c88.15.1794636018593;
        Fri, 13 Nov 2026 22:00:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:17 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 22:00:02 -0800
Subject: [PATCH 12/12] HID: rmi: clean up coding style and logging
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
Message-Id: <20261113-hid-rmi-v1-12-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Inconsistent naming, mixed status return conventions, non-uniform error
logging, and comment typos reduce code clarity.

Standardize buffer names, use standard negative error code conventions,
switch to subsystem-specific error logging, and fix comment typos and
checkpatch formatting issues.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 310 +++++++++++++++++++++++++-------------------------
 1 file changed, 155 insertions(+), 155 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d5961d408e72..3403c4b90d87 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -39,7 +39,6 @@
 #define RMI_DEVICE_HAS_PHYS_BUTTONS	BIT(1)
 #define RMI_DEVICE_OUTPUT_SET_REPORT	BIT(2)
 
-
 enum rmi_mode_type {
 	RMI_MODE_OFF			= 0,
 	RMI_MODE_ATTN_REPORTS		= 1,
@@ -55,8 +54,8 @@ enum rmi_mode_type {
  *
  * @wait: Used for waiting for read data
  *
- * @writeReport: output buffer when writing RMI registers
- * @readReport: input buffer when reading RMI registers
+ * @tx_buf: output buffer when writing RMI registers
+ * @rx_buf: input buffer when reading RMI registers
  *
  * @input_report_size: size of an input report (advertised by HID)
  * @output_report_size: size of an output report (advertised by HID)
@@ -72,14 +71,14 @@ enum rmi_mode_type {
  * @rmi_irq: the irq that will be used to generate events to rmi-core
  */
 struct rmi_data {
-	struct mutex page_mutex;
+	struct mutex page_mutex; /* locks current virtual page */
 	int page;
 	struct rmi_transport_dev xport;
 
 	wait_queue_head_t wait;
 
-	u8 *writeReport;
-	u8 *readReport;
+	u8 *tx_buf;
+	u8 *rx_buf;
 
 	u32 input_report_size;
 	u32 output_report_size;
@@ -100,26 +99,27 @@ struct rmi_data {
 static int rmi_write_report(struct hid_device *hdev, u8 *report, int len)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
-	int ret;
+	int error;
 
 	if (data->device_flags & RMI_DEVICE_OUTPUT_SET_REPORT) {
 		/*
 		 * Talk to device by using SET_REPORT requests instead.
 		 */
-		ret = hid_hw_raw_request(hdev, report[0], report,
-				len, HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+		error = hid_hw_raw_request(hdev, report[0], report,
+					   len, HID_OUTPUT_REPORT,
+					   HID_REQ_SET_REPORT);
 	} else {
-		ret = hid_hw_output_report(hdev, report, len);
+		error = hid_hw_output_report(hdev, report, len);
 	}
 
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to write hid report (%d)\n", ret);
-		return ret;
+	if (error < 0) {
+		hid_err(hdev, "failed to write hid report (%d)\n", error);
+		return error;
 	}
 
-	if (ret != len) {
-		dev_err(&hdev->dev, "short write to hid device (%d < %d)\n",
-			ret, len);
+	if (error != len) {
+		hid_err(hdev, "short write to hid device (%d < %d)\n",
+			error, len);
 		return -EIO;
 	}
 
@@ -143,19 +143,18 @@ static int rmi_write_report(struct hid_device *hdev, u8 *report, int len)
 static int rmi_set_page(struct hid_device *hdev, u8 page)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
-	int retval;
-
-	data->writeReport[0] = RMI_WRITE_REPORT_ID;
-	data->writeReport[1] = 1;
-	put_unaligned_le16(0x00ff, &data->writeReport[2]);
-	data->writeReport[4] = page;
-
-	retval = rmi_write_report(hdev, data->writeReport,
-			data->output_report_size);
-	if (retval) {
-		dev_err(&hdev->dev,
-			"%s: set page failed: %d.", __func__, retval);
-		return retval;
+	int error;
+
+	data->tx_buf[0] = RMI_WRITE_REPORT_ID;
+	data->tx_buf[1] = 1;
+	put_unaligned_le16(0x00ff, &data->tx_buf[2]);
+	data->tx_buf[4] = page;
+
+	error = rmi_write_report(hdev, data->tx_buf,
+				 data->output_report_size);
+	if (error) {
+		hid_err(hdev, "%s: set page failed: %d\n", __func__, error);
+		return error;
 	}
 
 	data->page = page;
@@ -165,33 +164,34 @@ static int rmi_set_page(struct hid_device *hdev, u8 page)
 static int rmi_set_mode(struct hid_device *hdev, u8 mode)
 {
 	const u8 txbuf[2] = {RMI_SET_RMI_MODE_REPORT_ID, mode};
-	int ret;
+	int error;
 
 	u8 *buf __free(kfree) = kmemdup(txbuf, sizeof(txbuf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(hdev, RMI_SET_RMI_MODE_REPORT_ID, buf,
-			sizeof(txbuf), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "unable to set rmi mode to %d (%d)\n", mode,
-			ret);
-		return ret;
+	error = hid_hw_raw_request(hdev, RMI_SET_RMI_MODE_REPORT_ID, buf,
+				   sizeof(txbuf), HID_FEATURE_REPORT,
+				   HID_REQ_SET_REPORT);
+	if (error < 0) {
+		hid_err(hdev, "unable to set rmi mode to %d (%d)\n", mode,
+			error);
+		return error;
 	}
 
 	return 0;
 }
 
 static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
-		void *buf, size_t len)
+			      void *buf, size_t len)
 {
 	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
 	struct hid_device *hdev = data->hdev;
-	int ret;
-	int retries;
 	size_t bytes_read;
 	size_t bytes_needed;
 	size_t read_input_count;
+	int retries;
+	int error;
 
 	if (len > U16_MAX)
 		return -EINVAL;
@@ -199,25 +199,24 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 	guard(mutex)(&data->page_mutex);
 
 	if (RMI_PAGE(addr) != data->page) {
-		ret = rmi_set_page(hdev, RMI_PAGE(addr));
-		if (ret)
-			return ret;
+		error = rmi_set_page(hdev, RMI_PAGE(addr));
+		if (error)
+			return error;
 	}
 
 	for (retries = 5; retries > 0; retries--) {
-		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
-		data->writeReport[1] = 0; /* old 1 byte read count */
-		put_unaligned_le16(addr, &data->writeReport[2]);
-		put_unaligned_le16(len, &data->writeReport[4]);
+		data->tx_buf[0] = RMI_READ_ADDR_REPORT_ID;
+		data->tx_buf[1] = 0; /* old 1 byte read count */
+		put_unaligned_le16(addr, &data->tx_buf[2]);
+		put_unaligned_le16(len, &data->tx_buf[4]);
 
 		set_bit(RMI_READ_REQUEST_PENDING, &data->flags);
 
-		ret = rmi_write_report(hdev, data->writeReport,
-						data->output_report_size);
-		if (ret) {
-			dev_err(&hdev->dev,
-				"failed to write request output report (%d)\n",
-				ret);
+		error = rmi_write_report(hdev, data->tx_buf,
+					 data->output_report_size);
+		if (error) {
+			hid_err(hdev, "failed to write request output report (%d)\n",
+				error);
 			break;
 		}
 
@@ -225,46 +224,45 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 		bytes_needed = len;
 		while (bytes_read < len) {
 			if (!wait_event_timeout(data->wait,
-				test_bit(RMI_READ_DATA_PENDING, &data->flags),
-					msecs_to_jiffies(1000))) {
+						test_bit(RMI_READ_DATA_PENDING,
+							 &data->flags),
+						msecs_to_jiffies(1000))) {
 				hid_warn(hdev, "%s: timeout elapsed\n",
 					 __func__);
-				ret = -EAGAIN;
+				error = -EAGAIN;
 				break;
 			}
 
-			read_input_count = data->readReport[1];
+			read_input_count = data->rx_buf[1];
 			if (read_input_count == 0 ||
 			    read_input_count > data->input_report_size - 2) {
 				clear_bit(RMI_READ_DATA_PENDING, &data->flags);
-				ret = -EPROTO;
+				error = -EPROTO;
 				break;
 			}
 
-			memcpy(buf + bytes_read, &data->readReport[2],
-				min(read_input_count, bytes_needed));
+			memcpy(buf + bytes_read, &data->rx_buf[2],
+			       min(read_input_count, bytes_needed));
 
 			bytes_read += read_input_count;
 			bytes_needed -= read_input_count;
 			clear_bit(RMI_READ_DATA_PENDING, &data->flags);
 		}
 
-		if (ret >= 0) {
-			ret = 0;
+		if (!error)
 			break;
-		}
 	}
 
 	clear_bit(RMI_READ_REQUEST_PENDING, &data->flags);
-	return ret;
+	return error;
 }
 
 static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
-		const void *buf, size_t len)
+			       const void *buf, size_t len)
 {
 	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
 	struct hid_device *hdev = data->hdev;
-	int ret;
+	int error;
 
 	if (len > data->output_report_size - 4 || len > U8_MAX)
 		return -EINVAL;
@@ -272,23 +270,23 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 	guard(mutex)(&data->page_mutex);
 
 	if (RMI_PAGE(addr) != data->page) {
-		ret = rmi_set_page(hdev, RMI_PAGE(addr));
-		if (ret < 0)
-			return ret;
+		error = rmi_set_page(hdev, RMI_PAGE(addr));
+		if (error)
+			return error;
 	}
 
-	data->writeReport[0] = RMI_WRITE_REPORT_ID;
-	data->writeReport[1] = len;
-	put_unaligned_le16(addr, &data->writeReport[2]);
-	memcpy(&data->writeReport[4], buf, len);
+	data->tx_buf[0] = RMI_WRITE_REPORT_ID;
+	data->tx_buf[1] = len;
+	put_unaligned_le16(addr, &data->tx_buf[2]);
+	memcpy(&data->tx_buf[4], buf, len);
 
-	ret = rmi_write_report(hdev, data->writeReport,
-			       data->output_report_size);
-	if (ret) {
-		dev_err(&hdev->dev,
+	error = rmi_write_report(hdev, data->tx_buf,
+				 data->output_report_size);
+	if (error) {
+		hid_err(hdev,
 			"failed to write request output report (%d)\n",
-			ret);
-		return ret;
+			error);
+		return error;
 	}
 
 	return 0;
@@ -298,22 +296,22 @@ static int rmi_reset_attn_mode(struct hid_device *hdev)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	struct rmi_device *rmi_dev = data->xport.rmi_dev;
-	int ret;
+	int error;
 
-	ret = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
-	if (ret)
-		return ret;
+	error = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
+	if (error)
+		return error;
 
 	scoped_guard(mutex, &data->page_mutex) {
-		ret = rmi_set_page(hdev, 0);
-		if (ret)
-			return ret;
+		error = rmi_set_page(hdev, 0);
+		if (error)
+			return error;
 	}
 
 	if (test_bit(RMI_STARTED, &data->flags))
-		ret = rmi_dev->driver->reset_handler(rmi_dev);
+		error = rmi_dev->driver->reset_handler(rmi_dev);
 
-	return ret;
+	return error;
 }
 
 static void rmi_reset_work(struct work_struct *work)
@@ -374,9 +372,9 @@ static int rmi_read_data_event(struct hid_device *hdev, u8 *data, int size)
 
 	copy_size = min_t(size_t, size, hdata->input_report_size);
 	if (copy_size < 3 || data[1] == 0 || data[1] > copy_size - 2)
-		hdata->readReport[1] = 0;
+		hdata->rx_buf[1] = 0;
 	else
-		memcpy(hdata->readReport, data, copy_size);
+		memcpy(hdata->rx_buf, data, copy_size);
 
 	set_bit(RMI_READ_DATA_PENDING, &hdata->flags);
 	wake_up(&hdata->wait);
@@ -385,7 +383,7 @@ static int rmi_read_data_event(struct hid_device *hdev, u8 *data, int size)
 }
 
 static int rmi_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+			 struct hid_report *report, u8 *data, int size)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
 
@@ -406,7 +404,7 @@ static int rmi_raw_event(struct hid_device *hdev,
 }
 
 static int rmi_event(struct hid_device *hdev, struct hid_field *field,
-			struct hid_usage *usage, __s32 value)
+		     struct hid_usage *usage, __s32 value)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 
@@ -414,13 +412,13 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
 	    test_bit(RMI_STARTED, &data->flags) &&
 	    !test_bit(RMI_SUSPENDED, &data->flags) &&
 	    (field->application == HID_GD_POINTER ||
-	    field->application == HID_GD_MOUSE)) {
+	     field->application == HID_GD_MOUSE)) {
 		if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS) {
 			if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON)
 				return 0;
 
-			if ((usage->hid == HID_GD_X || usage->hid == HID_GD_Y)
-			    && !value)
+			if ((usage->hid == HID_GD_X || usage->hid == HID_GD_Y) &&
+			    !value)
 				return 1;
 		}
 
@@ -452,7 +450,7 @@ static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	struct rmi_device *rmi_dev = data->xport.rmi_dev;
-	int ret;
+	int error;
 
 	if (!test_bit(RMI_STARTED, &data->flags))
 		return 0;
@@ -460,11 +458,11 @@ static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
 	set_bit(RMI_SUSPENDED, &data->flags);
 	cancel_work_sync(&data->reset_work);
 
-	ret = rmi_driver_suspend(rmi_dev, false);
-	if (ret) {
-		hid_warn(hdev, "Failed to suspend device: %d\n", ret);
+	error = rmi_driver_suspend(rmi_dev, false);
+	if (error) {
+		hid_warn(hdev, "Failed to suspend device: %d\n", error);
 		clear_bit(RMI_SUSPENDED, &data->flags);
-		return ret;
+		return error;
 	}
 
 	return 0;
@@ -474,33 +472,33 @@ static int rmi_post_resume(struct hid_device *hdev)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	struct rmi_device *rmi_dev = data->xport.rmi_dev;
-	int ret;
+	int error;
 	int err;
 
 	if (!test_bit(RMI_STARTED, &data->flags))
 		return 0;
 
 	/* Make sure the HID device is ready to receive events */
-	ret = hid_hw_open(hdev);
-	if (ret)
+	error = hid_hw_open(hdev);
+	if (error)
 		goto out;
 
-	ret = rmi_reset_attn_mode(hdev);
-	if (ret)
-		hid_warn(hdev, "Failed to reset attention mode: %d\n", ret);
+	error = rmi_reset_attn_mode(hdev);
+	if (error)
+		hid_warn(hdev, "Failed to reset attention mode: %d\n", error);
 
 	err = rmi_driver_resume(rmi_dev, false);
 	if (err) {
 		hid_warn(hdev, "Failed to resume device: %d\n", err);
-		if (!ret)
-			ret = err;
+		if (!error)
+			error = err;
 	}
 
 	hid_hw_close(hdev);
 
 out:
 	clear_bit(RMI_SUSPENDED, &data->flags);
-	return ret;
+	return error;
 }
 
 static int rmi_hid_reset(struct rmi_transport_dev *xport, u16 reset_addr)
@@ -515,7 +513,7 @@ static int rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	struct input_dev *input = hi->input;
-	int ret = 0;
+	int error = 0;
 
 	if (!(data->device_flags & RMI_DEVICE))
 		return 0;
@@ -523,28 +521,28 @@ static int rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	data->xport.input = input;
 
 	hid_dbg(hdev, "Opening low level driver\n");
-	ret = hid_hw_open(hdev);
-	if (ret)
-		return ret;
+	error = hid_hw_open(hdev);
+	if (error)
+		return error;
 
 	/* Allow incoming hid reports */
 	hid_device_io_start(hdev);
 
-	ret = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to set rmi mode\n");
+	error = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
+	if (error) {
+		hid_err(hdev, "failed to set rmi mode\n");
 		goto exit;
 	}
 
-	ret = rmi_set_page(hdev, 0);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to set page select to 0.\n");
+	error = rmi_set_page(hdev, 0);
+	if (error) {
+		hid_err(hdev, "failed to set page select to 0\n");
 		goto exit;
 	}
 
-	ret = rmi_register_transport_device(&data->xport);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to register transport driver\n");
+	error = rmi_register_transport_device(&data->xport);
+	if (error) {
+		hid_err(hdev, "failed to register transport driver\n");
 		goto exit;
 	}
 
@@ -553,18 +551,19 @@ static int rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
 exit:
 	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
-	return ret;
+	return error;
 }
 
 static int rmi_input_mapping(struct hid_device *hdev,
-		struct hid_input *hi, struct hid_field *field,
-		struct hid_usage *usage, unsigned long **bit, int *max)
+			     struct hid_input *hi, struct hid_field *field,
+			     struct hid_usage *usage, unsigned long **bit,
+			     int *max)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 
 	/*
 	 * we want to make HID ignore the advertised HID collection
-	 * for RMI deivces
+	 * for RMI devices
 	 */
 	if (data->device_flags & RMI_DEVICE) {
 		if ((data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS) &&
@@ -577,15 +576,17 @@ static int rmi_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 
-static int rmi_check_valid_report_id(struct hid_device *hdev, unsigned type,
-		unsigned id, struct hid_report **report)
+static int rmi_check_valid_report_id(struct hid_device *hdev,
+				     unsigned int type, unsigned int id,
+				     struct hid_report **report)
 {
 	int i;
 
 	*report = hdev->report_enum[type].report_id_hash[id];
 	if (*report) {
 		for (i = 0; i < (*report)->maxfield; i++) {
-			unsigned app = (*report)->field[i]->application;
+			unsigned int app = (*report)->field[i]->application;
+
 			if ((app & HID_USAGE_PAGE) >= HID_UP_MSVENDOR)
 				return 1;
 		}
@@ -639,16 +640,16 @@ static const struct irq_domain_ops rmi_irq_ops = {
 static int rmi_setup_irq_domain(struct hid_device *hdev)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
-	int ret;
+	int error;
 
 	hdata->domain = irq_domain_create_linear(hdev->dev.fwnode, 1,
 						 &rmi_irq_ops, hdata);
 	if (!hdata->domain)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
-	if (ret)
-		return ret;
+	error = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
+	if (error)
+		return error;
 
 	hdata->rmi_irq = irq_create_mapping(hdata->domain, 0);
 	if (hdata->rmi_irq <= 0) {
@@ -661,14 +662,14 @@ static int rmi_setup_irq_domain(struct hid_device *hdev)
 
 static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	struct rmi_data *data = NULL;
-	int ret;
+	struct rmi_data *data;
+	int error;
 	size_t alloc_size;
 	struct hid_report *input_report;
 	struct hid_report *output_report;
 	struct hid_report *feature_report;
 
-	data = devm_kzalloc_obj(&hdev->dev, struct rmi_data);
+	data = devm_kzalloc_obj(&hdev->dev, *data);
 	if (!data)
 		return -ENOMEM;
 
@@ -680,35 +681,36 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
 
-	ret = hid_parse(hdev);
-	if (ret) {
+	error = hid_parse(hdev);
+	if (error) {
 		hid_err(hdev, "parse failed\n");
-		return ret;
+		return error;
 	}
 
 	/*
 	 * RMI_DEVICE can only mean "this probe validated the RMI reports and
-	 * allocated writeReport": every bail-out to start below skips that
+	 * allocated tx_buf": every bail-out to start below skips that
 	 * allocation, and device_flags left carrying RMI_DEVICE from
 	 * driver_data would send rmi_input_configured() into rmi_set_page()
-	 * with writeReport still NULL.  A bind through the new_id sysfs
+	 * with tx_buf still NULL.  A bind through the new_id sysfs
 	 * attribute can supply driver_data with the bit set, so do not let
 	 * driver_data grant it.
 	 */
 	data->device_flags = id->driver_data & ~RMI_DEVICE;
 
 	/*
-	 * Check for the RMI specific report ids. If they are misisng
+	 * Check for the RMI specific report ids. If they are missing
 	 * simply return and let the events be processed by hid-input
 	 */
 	if (!rmi_check_valid_report_id(hdev, HID_FEATURE_REPORT,
-	    RMI_SET_RMI_MODE_REPORT_ID, &feature_report)) {
+				       RMI_SET_RMI_MODE_REPORT_ID,
+				       &feature_report)) {
 		hid_dbg(hdev, "device does not have set mode feature report\n");
 		goto start;
 	}
 
 	if (!rmi_check_valid_report_id(hdev, HID_INPUT_REPORT,
-	    RMI_ATTN_REPORT_ID, &input_report)) {
+				       RMI_ATTN_REPORT_ID, &input_report)) {
 		hid_dbg(hdev, "device does not have attention input report\n");
 		goto start;
 	}
@@ -722,7 +724,7 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	data->input_report_size = hid_report_len(input_report);
 
 	if (!rmi_check_valid_report_id(hdev, HID_OUTPUT_REPORT,
-	    RMI_WRITE_REPORT_ID, &output_report)) {
+				       RMI_WRITE_REPORT_ID, &output_report)) {
 		hid_dbg(hdev,
 			"device does not have rmi write output report\n");
 		goto start;
@@ -739,22 +741,20 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	data->device_flags |= RMI_DEVICE;
 	alloc_size = data->output_report_size + data->input_report_size;
 
-	data->writeReport = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);
-	if (!data->writeReport) {
-		hid_err(hdev, "failed to allocate buffer for HID reports\n");
+	data->tx_buf = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);
+	if (!data->tx_buf)
 		return -ENOMEM;
-	}
 
-	data->readReport = data->writeReport + data->output_report_size;
+	data->rx_buf = data->tx_buf + data->output_report_size;
 
 	init_waitqueue_head(&data->wait);
 
 	mutex_init(&data->page_mutex);
 
-	ret = rmi_setup_irq_domain(hdev);
-	if (ret) {
+	error = rmi_setup_irq_domain(hdev);
+	if (error) {
 		hid_err(hdev, "failed to allocate IRQ domain\n");
-		return ret;
+		return error;
 	}
 
 	data->xport.dev = hdev->dev.parent;
@@ -767,10 +767,10 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	data->xport.ops = &hid_rmi_ops;
 
 start:
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret) {
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (error) {
 		hid_err(hdev, "hw start failed\n");
-		return ret;
+		return error;
 	}
 
 	return 0;

-- 
2.56.0.679.gc527c65306-goog

