Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9D453A45
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584805; cv=none; b=reqw6hMjjsw2w2uWNOG0+ZvKJZiDee0+0YYKCRILS1l/auWNq4277arZRS62x0Y400QTVD7OCCwJXJvXr3bHWAFUOXvdN8Tc7lbu6Qh0GNQFLuT05E+LBAvSXwodXwcjKHDVYG6Wm0ENKlUeuDgaFYJFeZIMsFa93+tYX5XgUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584805; c=relaxed/simple;
	bh=8Sl1nvNb8Y04S0DyiwAZI7KOiZEjFzanMQGS2bZlSiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZu4x7Pi/Upy7CW+s1rK3Wy6OsDwDxY8mx7T7Ek/F537aYwNByE/yABNX/Cj6Xesp94z47tDvGxsFXWMLAaceNXgepbbt2SwfKfIKWjygdHx4Y4Rxu7/jcHmlUSq0b3sloB2EzEN0XgpMGJwq1DpZWzDTYEb7uqXDtQZC/3kgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N9H04wAf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N9H04wAf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e87c66e556so1555ad.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584801; x=1792189601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDUe8wAwcC81hNZGeAz424UXICogLUR0kVefzZf5D3E=;
        b=N9H04wAfdEdNwGLoBEeW2QmVtSN/cWYuW7C+84tunZ2/Hn0MxHqYx8mtXEtbRi2Tvc
         0eEMxfdUwdn6GVRclpF8YuNn9DefE1fZAeQgY6ISQa05fZb40pVzJQsSmBYJ93+vdSQv
         fE50ixuAI36ik18kfPOojSNN9BKN169kKOJyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584801; x=1792189601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDUe8wAwcC81hNZGeAz424UXICogLUR0kVefzZf5D3E=;
        b=wmuwYibdx4BJatwU7+R3TIOdIaa8ht41+KyKtPRV7PZTogpZwBR8PKwXPB1UlX8q5k
         QP1yEmCZDUFRIx/e731UJmhKitOCLHvbf2x3betUPLUDADyj/nj2qTLMWb/YzlaSh8ta
         LJZRO95/VSzIHs0i+aMIR/tC6YuRimMVkz8Pj1iNMDVG8sGPOwzrwqz8FEYNQOsLHWx4
         Ef+pnVCY7D3aucmAE4rw2/vaDwGcmzX7fj6HVDFyQcYfjlU1sAdg6o1MdMXkknBq/D8B
         xRViEA+c7UoPflki3ciLz3bKFE1SRz+9a4QVXH6a3uR916FXGrlB/D2l9TBZzlWAQcBg
         PiHA==
X-Gm-Message-State: AFq9FYIu42c8P10oj5NFBExdts5z4rLNxMBMWFY71dZHitksq6ZRdgoi
	dTGwbt/IE8Gn/bQFqicKinLFff1qLlOQiIHt1KjYV2xYKj47YDkDFqnNt3zbm+eqG2P2DXvxmxT
	m1++Jaw==
X-Gm-Gg: AYBFou2k3QQ1UGoojEvJwGyr6KHeEBqzQqK9nhVD0TTLlnyTYI6x+CdKvbUofpOVNiU
	RLYaSvPZw6TSAr1PfLvjcxt4VEjVdxXwJDnOrxAgcWhToiGkqBmKjBCI6L6gKxqK74dfTu0K3+l
	TCUHfYNAeX2HCaNZv9AzW5vCmiQhVjpbFN4iPtnnSffxRfdeb+/ZRyW3hbPergPwm4ttiXtvtNN
	BxMrc8tHhXc+QYAM8FTi2/Xi1Y5o+8mWR61iFmgpOW9NZ/YvQQbSjyccBy6l2JqB8kbNKuqCo8w
	RcKYwXWUiL4Kqkc6aHreA6H4+PX5PxkEG2OyeVbu6k/u5R3l7vy1REf2Gy+nNtodgSWtxSc4z12
	i+E1artlJLf7CF2XTAp4qRqqeycxopDyJRjpwgfA1ob3L6eGk9wMW2+m8jlNsZua3tSZSZR/zbD
	FG4Lng/syXbUh/m1+dP+LJj+//KkUJVxA5JNOsFLJ5w/ogEZfow0EJESgZgxs8x88ZpkQS0G5nk
	GBQrpVZfjWG1UG60Gj8DAZO/mvAyevBU1GFMmZAy0jSsRhzzq8bYIP2idnnCS9idKok+z8HUTtz
X-Received: by 2002:a17:902:fc8f:b0:2e5:cfc5:9b69 with SMTP id d9443c01a7336-2e840512adbmr22463815ad.28.1791584801156;
        Fri, 09 Oct 2026 15:26:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:40 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:29 +0000
Subject: [PATCH v5 04/11] HID: spi-hid: add spi-hid driver HID layer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-4-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=18399;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=8Sl1nvNb8Y04S0DyiwAZI7KOiZEjFzanMQGS2bZlSiE=;
 b=nKCri8zVqIt3VJqMPJwoGkke6B/02b2MPkQUZgfGynNCBjNmDD6ThY5GFjzBWgFyQP7IUQJpW
 EdYlMoOt1C0BFXInQnL5ONkW8mPnKYT7ztP5Ki45k4B/vStYKNyrHa4
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add HID low level driver callbacks to register SPI as a HID driver, and
an external touch device as a HID device.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 592 +++++++++++++++++++++++++++++++++++++
 1 file changed, 592 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 02a7608c4b88..fca7a44eeb9f 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -20,13 +20,69 @@
  *  Copyright (c) 2006-2010 Jiri Kosina
  */
 
+#include <linux/completion.h>
+#include <linux/crc32.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/hid-over-spi.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/unaligned.h>
+
+#define SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST	0x00
+
+#define SPI_HID_RESP_TIMEOUT	1000
+
+/* Protocol message size constants */
+#define SPI_HID_OUTPUT_HEADER_LEN		8
+
+/* flags */
+/*
+ * ready flag indicates that the FW is ready to accept commands and
+ * requests. The FW becomes ready after sending the report descriptor.
+ */
+#define SPI_HID_READY	0
+
+/* Raw input buffer with data from the bus */
+struct spi_hid_input_buf {
+	u8 header[HIDSPI_INPUT_HEADER_SIZE];
+	u8 body[HIDSPI_INPUT_BODY_HEADER_SIZE];
+	u8 content[];
+};
+
+/* Raw output report buffer to be put on the bus */
+struct spi_hid_output_buf {
+	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
+	u8 content[];
+};
+
+/* Data necessary to send an output report */
+struct spi_hid_output_report {
+	u8 report_type;
+	u16 content_length;
+	u8 content_id;
+	u8 *content;
+};
+
+/* Processed data from a device descriptor */
+struct spi_hid_device_descriptor {
+	u16 hid_version;
+	u16 report_descriptor_length;
+	u16 max_input_length;
+	u16 max_output_length;
+	u16 max_fragment_length;
+	u16 vendor_id;
+	u16 product_id;
+	u16 version_id;
+	u8 no_output_report_ack;
+};
 
 /* struct spi_hid_conf - Conf provided to the core */
 struct spi_hid_conf {
@@ -61,8 +117,26 @@ struct spi_hid {
 	struct spihid_ops	*ops;
 	struct spi_hid_conf	*conf;
 
+	struct spi_hid_device_descriptor desc;	/* HID device descriptor. */
+	struct spi_hid_output_buf *output;	/* Output buffer. */
+	struct spi_hid_input_buf *input;	/* Input buffer. */
+	struct spi_hid_input_buf *response;	/* Response buffer. */
+
+	u16 response_length;
+	u16 bufsize;
+
 	enum hidspi_power_state power_state;
 
+	u8 reset_attempts;	/* The number of reset attempts. */
+
+	unsigned long flags;	/* device flags. */
+
+	/* Control lock to make sure one output transaction at a time. */
+	struct mutex output_lock;
+	struct completion output_done;
+
+	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
+
 	u32 regulator_error_count;
 	int regulator_last_error;
 	u32 bus_error_count;
@@ -70,6 +144,33 @@ struct spi_hid {
 	u32 dir_count;	/* device initiated reset count. */
 };
 
+static struct hid_ll_driver spi_hid_ll_driver;
+
+static void spi_hid_populate_output_header(u8 *buf,
+					   const struct spi_hid_conf *conf,
+					   const struct spi_hid_output_report *report)
+{
+	buf[0] = conf->write_opcode;
+	put_unaligned_be24(conf->output_report_address, &buf[1]);
+	buf[4] = report->report_type;
+	put_unaligned_le16(report->content_length, &buf[5]);
+	buf[7] = report->content_id;
+}
+
+static int spi_hid_output(struct spi_hid *shid, const void *buf, u16 length)
+{
+	int error;
+
+	error = spi_write(shid->spi, buf, length);
+
+	if (error) {
+		shid->bus_error_count++;
+		shid->bus_last_error = error;
+	}
+
+	return error;
+}
+
 static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state)
 {
 	switch (power_state) {
@@ -84,11 +185,484 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
+static void spi_hid_stop_hid(struct spi_hid *shid)
+{
+	struct hid_device *hid = shid->hid;
+
+	shid->hid = NULL;
+	clear_bit(SPI_HID_READY, &shid->flags);
+
+	if (hid)
+		hid_destroy_device(hid);
+}
+
+static int __spi_hid_send_output_report(struct spi_hid *shid,
+					struct spi_hid_output_report *report)
+{
+	struct spi_hid_output_buf *buf = shid->output;
+	struct device *dev = &shid->spi->dev;
+	u16 report_length;
+	u16 padded_length;
+	u8 padding;
+	int error;
+
+	if (report->content_length > shid->desc.max_output_length ||
+	    report->content_length > shid->bufsize) {
+		dev_err(dev, "Output report too big, content_length 0x%x\n",
+			report->content_length);
+		return -E2BIG;
+	}
+
+	spi_hid_populate_output_header(buf->header, shid->conf, report);
+
+	if (report->content_length)
+		memcpy(&buf->content, report->content, report->content_length);
+
+	report_length = sizeof(buf->header) + report->content_length;
+	padded_length = round_up(report_length, 4);
+	padding = padded_length - report_length;
+	memset(&buf->content[report->content_length], 0, padding);
+
+	error = spi_hid_output(shid, buf, padded_length);
+	if (error)
+		dev_err(dev, "Failed output transfer: %d\n", error);
+
+	return error;
+}
+
+static int spi_hid_send_output_report(struct spi_hid *shid,
+				      struct spi_hid_output_report *report)
+{
+	guard(mutex)(&shid->output_lock);
+	return __spi_hid_send_output_report(shid, report);
+}
+
+static int __spi_hid_sync_request(struct spi_hid *shid,
+				  struct spi_hid_output_report *report)
+{
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	reinit_completion(&shid->output_done);
+
+	error = __spi_hid_send_output_report(shid, report);
+	if (error)
+		return error;
+
+	error = wait_for_completion_interruptible_timeout(&shid->output_done,
+							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
+	if (error == 0) {
+		dev_err(dev, "Response timed out\n");
+		return -ETIMEDOUT;
+	}
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int spi_hid_sync_request(struct spi_hid *shid,
+				struct spi_hid_output_report *report)
+{
+	guard(mutex)(&shid->output_lock);
+	return __spi_hid_sync_request(shid, report);
+}
+
+/*
+ * This function returns the length of the report descriptor, or a negative
+ * error code if something went wrong.
+ */
+static int spi_hid_report_descriptor_request(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = REPORT_DESCRIPTOR,
+		.content_length = 0,
+		.content_id = SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
+		.content = NULL,
+	};
+	int ret;
+
+	ret =  spi_hid_sync_request(shid, &report);
+	if (ret) {
+		dev_err(dev,
+			"Expected report descriptor not received: %d\n", ret);
+		return ret;
+	}
+
+	ret = shid->response_length;
+	if (ret != shid->desc.report_descriptor_length) {
+		ret = min_t(unsigned int, ret, shid->desc.report_descriptor_length);
+		dev_err(dev, "Received report descriptor length doesn't match device descriptor field, using min of the two: %d\n",
+			ret);
+	}
+
+	return ret;
+}
+
+static int spi_hid_create_device(struct spi_hid *shid)
+{
+	struct hid_device *hid;
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	hid = hid_allocate_device();
+	error = PTR_ERR_OR_ZERO(hid);
+	if (error) {
+		dev_err(dev, "Failed to allocate hid device: %d\n", error);
+		return error;
+	}
+
+	hid->driver_data = shid->spi;
+	hid->ll_driver = &spi_hid_ll_driver;
+	hid->dev.parent = &shid->spi->dev;
+	hid->bus = BUS_SPI;
+	hid->version = shid->desc.hid_version;
+	hid->vendor = shid->desc.vendor_id;
+	hid->product = shid->desc.product_id;
+
+	snprintf(hid->name, sizeof(hid->name), "spi %04X:%04X",
+		 hid->vendor, hid->product);
+	strscpy(hid->phys, dev_name(&shid->spi->dev), sizeof(hid->phys));
+
+	shid->hid = hid;
+
+	error = hid_add_device(hid);
+	if (error) {
+		dev_err(dev, "Failed to add hid device: %d\n", error);
+		/*
+		 * We likely got here because report descriptor request timed
+		 * out. Let's disconnect and destroy the hid_device structure.
+		 */
+		spi_hid_stop_hid(shid);
+		return error;
+	}
+
+	return 0;
+}
+
+static int spi_hid_get_request(struct spi_hid *shid, u8 content_id,
+			       u8 *buf, size_t len)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = GET_FEATURE,
+		.content_length = 0,
+		.content_id = content_id,
+		.content = NULL,
+	};
+	u16 content_len;
+	int error, ret;
+
+	/* buf[0] holds the report ID, so there must be room for at least that. */
+	if (!len)
+		return -EINVAL;
+
+	guard(mutex)(&shid->output_lock);
+
+	error = __spi_hid_sync_request(shid, &report);
+	if (error) {
+		dev_err(dev,
+			"Expected get request response not received! Error %d\n",
+			error);
+		return error;
+	}
+
+	/* Content Length counts only the payload, not the Content ID. */
+	content_len = get_unaligned_le16(&shid->response->body[1]);
+	if (content_len > shid->bufsize) {
+		dev_err(dev, "Get report response too big: %u > %u\n",
+			content_len, shid->bufsize);
+		return -EPROTO;
+	}
+
+	/* buf[0] holds the report ID, the payload follows. */
+	ret = min_t(size_t, len - 1, content_len);
+	buf[0] = shid->response->body[3];
+	memcpy(&buf[1], shid->response->content, ret);
+
+	return ret + 1;
+}
+
+static int spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 arg_len,
+			       u8 content_id)
+{
+	struct spi_hid_output_report report = {
+		.report_type = SET_FEATURE,
+		.content_length = arg_len,
+		.content_id = content_id,
+		.content = arg_buf,
+	};
+
+	return spi_hid_sync_request(shid, &report);
+}
+
+/* This is a placeholder. Will be implemented in the next patch. */
 static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 {
 	return IRQ_HANDLED;
 }
 
+static int spi_hid_alloc_buffers(struct spi_hid *shid, size_t report_size)
+{
+	struct device *dev = &shid->spi->dev;
+	int inbufsize = round_up(sizeof(shid->input->header) +
+				 sizeof(shid->input->body) + report_size, 4);
+	int outbufsize = round_up(sizeof(shid->output->header) + report_size, 4);
+	void *tmp;
+
+	tmp = devm_krealloc(dev, shid->output, outbufsize, GFP_KERNEL | __GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->output = tmp;
+
+	tmp = devm_krealloc(dev, shid->input, inbufsize, GFP_KERNEL | __GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->input = tmp;
+
+	tmp = devm_krealloc(dev, shid->response, inbufsize, GFP_KERNEL | __GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->response = tmp;
+
+	if (!shid->output || !shid->input || !shid->response)
+		return -ENOMEM;
+
+	shid->bufsize = report_size;
+
+	return 0;
+}
+
+static int spi_hid_get_report_length(struct hid_report *report)
+{
+	return DIV_ROUND_UP(report->size, 8) +
+		report->device->report_enum[report->type].numbered + 2;
+}
+
+/*
+ * Traverse the supplied list of reports and find the longest
+ */
+static void spi_hid_find_max_report(struct hid_device *hid, u32 type,
+				    u16 *max)
+{
+	struct hid_report *report;
+	u16 size;
+
+	/*
+	 * We should not rely on wMaxInputLength, as some devices may set it to
+	 * a wrong length.
+	 */
+	list_for_each_entry(report, &hid->report_enum[type].report_list, list) {
+		size = spi_hid_get_report_length(report);
+		if (*max < size)
+			*max = size;
+	}
+}
+
+/* hid_ll_driver interface functions */
+
+static int spi_hid_ll_start(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	int error = 0;
+	/*
+	 * HID_MIN_BUFFER_SIZE is the minimum transport buffer size, not a
+	 * requirement on the device's report sizes. Use it as a floor so
+	 * devices with small reports are still supported.
+	 */
+	u16 bufsize = HID_MIN_BUFFER_SIZE;
+
+	spi_hid_find_max_report(hid, HID_INPUT_REPORT, &bufsize);
+	spi_hid_find_max_report(hid, HID_OUTPUT_REPORT, &bufsize);
+	spi_hid_find_max_report(hid, HID_FEATURE_REPORT, &bufsize);
+
+	if (bufsize > shid->bufsize) {
+		guard(disable_irq)(&shid->spi->irq);
+
+		error = spi_hid_alloc_buffers(shid, bufsize);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+static void spi_hid_ll_stop(struct hid_device *hid)
+{
+	hid->claimed = 0;
+}
+
+static int spi_hid_ll_open(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void spi_hid_ll_close(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+
+	shid->reset_attempts = 0;
+}
+
+static int spi_hid_ll_power(struct hid_device *hid, int level)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	int error = 0;
+
+	guard(mutex)(&shid->output_lock);
+	if (!shid->hid)
+		error = -ENODEV;
+
+	return error;
+}
+
+static int spi_hid_ll_parse(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	unsigned int rsize = shid->desc.report_descriptor_length;
+	int error, len;
+
+	if (rsize > HID_MAX_DESCRIPTOR_SIZE) {
+		dev_err(dev,
+			"Report descriptor size %d is greater than HID_MAX_DESCRIPTOR_SIZE %d\n",
+			rsize, HID_MAX_DESCRIPTOR_SIZE);
+		return -EINVAL;
+	}
+
+	if (rsize > shid->bufsize) {
+		error = spi_hid_alloc_buffers(shid, rsize);
+		if (error)
+			return error;
+	}
+
+	len = spi_hid_report_descriptor_request(shid);
+	if (len < 0) {
+		dev_err(dev, "Report descriptor request failed, %d\n", len);
+		return len;
+	}
+
+	/*
+	 * FIXME: below call returning 0 doesn't mean that the report descriptor
+	 * is good. We might be caching a crc32 of a corrupted r. d. or who
+	 * knows what the FW sent. Need to have a feedback loop about r. d.
+	 * being ok and only then cache it.
+	 */
+	error = hid_parse_report(hid, (u8 *)shid->response->content, len);
+	if (error) {
+		dev_err(dev, "failed parsing report: %d\n", error);
+		return error;
+	}
+	shid->report_descriptor_crc32 = crc32_le(0,
+						 (unsigned char const *)shid->response->content,
+						 len);
+
+	set_bit(SPI_HID_READY, &shid->flags);
+
+	return 0;
+}
+
+static int spi_hid_ll_output_report(struct hid_device *hid, __u8 *buf,
+				    size_t len)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = OUTPUT_REPORT,
+		.content_length = len - 1,
+		.content_id = buf[0],
+		.content = &buf[1],
+	};
+	int error;
+
+	if (!test_bit(SPI_HID_READY, &shid->flags)) {
+		dev_err(dev, "%s called in unready state\n", __func__);
+		return -ENODEV;
+	}
+
+	if (shid->desc.no_output_report_ack)
+		error = spi_hid_send_output_report(shid, &report);
+	else
+		error = spi_hid_sync_request(shid, &report);
+
+	if (error) {
+		dev_err(dev, "failed to send output report\n");
+		return error;
+	}
+
+	return len;
+}
+
+static int spi_hid_ll_raw_request(struct hid_device *hid,
+				  unsigned char reportnum, __u8 *buf,
+				  size_t len, unsigned char rtype, int reqtype)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int ret;
+
+	switch (reqtype) {
+	case HID_REQ_SET_REPORT:
+		if (buf[0] != reportnum) {
+			dev_err(dev, "report id mismatch\n");
+			return -EINVAL;
+		}
+
+		if (rtype == HID_OUTPUT_REPORT)
+			return spi_hid_ll_output_report(hid, buf, len);
+
+		if (rtype != HID_FEATURE_REPORT)
+			return -EINVAL;
+
+		ret = spi_hid_set_request(shid, &buf[1], len - 1,
+					  reportnum);
+		if (ret) {
+			dev_err(dev, "failed to set report\n");
+			return ret;
+		}
+
+		ret = len;
+		break;
+	case HID_REQ_GET_REPORT:
+		/*
+		 * Only feature reports for now: GET_INPUT_REPORT is not
+		 * supported.
+		 */
+		if (rtype != HID_FEATURE_REPORT)
+			return -EOPNOTSUPP;
+
+		ret = spi_hid_get_request(shid, reportnum, buf, len);
+		if (ret < 0) {
+			dev_err(dev, "failed to get report\n");
+			return ret;
+		}
+		break;
+	default:
+		dev_err(dev, "invalid request type\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static struct hid_ll_driver spi_hid_ll_driver = {
+	.start = spi_hid_ll_start,
+	.stop = spi_hid_ll_stop,
+	.open = spi_hid_ll_open,
+	.close = spi_hid_ll_close,
+	.power = spi_hid_ll_power,
+	.parse = spi_hid_ll_parse,
+	.output_report = spi_hid_ll_output_report,
+	.raw_request = spi_hid_ll_raw_request,
+};
+
 static ssize_t bus_error_count_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -159,6 +733,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 
 	spi_set_drvdata(spi, shid);
 
+	mutex_init(&shid->output_lock);
+	init_completion(&shid->output_done);
+
+	/*
+	 * we need to allocate the buffer without knowing the maximum
+	 * size of the reports. Let's use HID_MAX_DESCRIPTOR_SIZE, then we do the
+	 * real computation later.
+	 */
+	error = spi_hid_alloc_buffers(shid, HID_MAX_DESCRIPTOR_SIZE);
+	if (error)
+		return error;
+
 	/*
 	 * At the end of probe we initialize the device:
 	 *   0) assert reset, bias the interrupt line
@@ -191,6 +777,10 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
+	error = spi_hid_create_device(shid);
+	if (error)
+		return error;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
@@ -201,6 +791,8 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	spi_hid_stop_hid(shid);
+
 	shid->ops->assert_reset(shid->ops);
 	error = shid->ops->power_down(shid->ops);
 	if (error)

-- 
2.56.0.385.gd3acb90ef8-goog

