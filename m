Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD763C1F54
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980093; cv=none; b=mQlpdQeaQoPICyyMx7YDqFZ6Rqvt3uResvy4SLFXZF8YrClS3k32AVXyn4CtuHg93ELFDz8cjDZelvGa8CaSwyLlMq1bQySIHFeyQ8vtr6FZVLpFuHSdAct2C9ZqCBx2+uX6F4pPnUaY0P2yksIuECenJgaXk5pVwfMwqGpKejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980093; c=relaxed/simple;
	bh=0fiT4mr7+EvL0R+wO38NzAsTi8BrTYbnYuxvTVi/+V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfL4P53299B6G9S8gfcAMjsgw09cQ0JPD/1PrZH3H67K0Ymz/Jtg4+xK2orTL8u0OCPzykeKXU7r5Sik+HDKjEaJ/aZ/vAFVvP+2q/fyVNlguitZFAnFC/rnq9mZo/xqnigj05taQ7r/4dNM24I9MwRgCwDziZe4KCMJt+S+QZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HwzuHR0e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HwzuHR0e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so41908135ad.2
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 21:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980088; x=1781584888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfoJnBmgbOHWHkNR16loOnW5aF/CWhqGHBZuh9Ih0aA=;
        b=HwzuHR0eg25v1BbtW6F4b3KGCkOrqfiy4G9Y4OGKVOgBl52pfdcaOdm7wuWQI02H4V
         2EhU1nQ1lXl2zVrnkPXsOZx0YdIZAypSPwdpyOw44x4wbx1Y7K30uZfoWKhSaDMtOdqJ
         jNfT2GC2bCle9xMfGXLrOeiLh4XkZ6o0tj4p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980088; x=1781584888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BfoJnBmgbOHWHkNR16loOnW5aF/CWhqGHBZuh9Ih0aA=;
        b=SkxIRwZm5twFIPSmObzfYigeBOLHOmGrkseIJI7qPQoDm6AFTb5jMfHuqiAOf6U5u7
         Y/AZlF6m8nCzF/PwyXGr9wtNV64Vz0CW1qf80aWz65a1atluKVrNfw7saolepzpLNLTG
         gK3+bKUBvk6mhHfjHMn/OU2JkkTeTC6O9OVkWWnffu6NQsDAG2OzNCIdecafUaoRdlx8
         7LRf5mg6ivt7ai9bmcR/k3BzgCuRUvANUkDLd2xXrwXe2uZdcWhsEYPaAx2cmEjqmkEQ
         +Kb00qoK2hld6rkbQYuMCjrsiTnvuGYHbfbpZIB7+apFEdO7B+5QourJcVXsKWuBJPDc
         ARag==
X-Gm-Message-State: AOJu0Ywd630O1px7RHRtXeqJZYCGTomSrHCCboZkM4aP4U96M4AzprnL
	bOLtghLHVaOuvAzWf0qV8Pz6toDOVTOWkC/v/wbP5V/Ls2h5ODqmm5pNdOIVN6ARjg==
X-Gm-Gg: Acq92OHb+ljlUCXMcH2VZ99+iKbYLdcEUkjrsDaEiYDV5e0PG/Fpd6utDx2RLFtO2eh
	2gZt7yZJIn1QG1kqC1q/0MyjLv/gaMhHZz7mS8BsV2PQ7O3iw6a0hjRraGGzM9tmqDbcta2VKqP
	7/SkZsE+pQtSBAilIePuZ+H/7YvFyvRQbSnMoqZ+9rDQh0ye3yKApVf6rejNJwgsx9Q1jd+2oah
	XCjrKPNxQboMCv/QmsuvX29g48Cy5CJXx9wQuYMJCGDN3p/o8cfYSnYVgpSEOz9X4rK7zw/wdiO
	KkIftYGMcFffvPZOtwlbc3XzlojJOg2w6BYOhWkCki+UW/r69CiMuiO+GvHQvjAblIOD6E/TzUB
	NkHQiEatf39YxdVFOdAd7E0rak/8Bo9muQXxT9iLkdTLN/jy+A/wCpgwdB63Z5AmlLLoOkULeMr
	z05Z5ufzL3E6My/c9pHsJK+4QOU9k+Lyl2RNQ6nn7cgf4LzoY0t6dozntNJKltlP5pBKaysINpM
	N7kTeHx32KcZ+nzzStfchd0wPSxHCyJXUb4QE+bj1C9BBo4VYndXGM=
X-Received: by 2002:a17:903:1965:b0:2bf:172d:ef7e with SMTP id d9443c01a7336-2c1e8346fefmr206336495ad.34.1780980087810;
        Mon, 08 Jun 2026 21:41:27 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:27 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 09 Jun 2026 04:40:55 +0000
Subject: [PATCH v4 04/11] HID: spi-hid: add spi-hid driver HID layer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-send-upstream-v4-4-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
In-Reply-To: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=17398;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=0fiT4mr7+EvL0R+wO38NzAsTi8BrTYbnYuxvTVi/+V8=;
 b=yBgodQRlJbsoJ1YDg8Tq2TeWZZtl7xodBQfqxyvgzbRv2U4ivH0PnK+gBgSZgvT2oFE9De09f
 NOA0CpGquL+AeEuvPXEU2jJ6clV7OGsBpMCuLMt6ku2oLmsuZ1Ikn78
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add HID low level driver callbacks to register SPI as a HID driver, and
an external touch device as a HID device.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 563 +++++++++++++++++++++++++++++++++++++
 1 file changed, 563 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 02a7608c4b88..72c2e1ce3e8d 100644
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
@@ -84,11 +185,455 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
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
+static int spi_hid_sync_request(struct spi_hid *shid,
+				struct spi_hid_output_report *report)
+{
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	guard(mutex)(&shid->output_lock);
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
+static int spi_hid_get_request(struct spi_hid *shid, u8 content_id)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = GET_FEATURE,
+		.content_length = 0,
+		.content_id = content_id,
+		.content = NULL,
+	};
+	int error;
+
+	error = spi_hid_sync_request(shid, &report);
+	if (error) {
+		dev_err(dev,
+			"Expected get request response not received! Error %d\n",
+			error);
+		return error;
+	}
+
+	return 0;
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
+	u16 bufsize = 0;
+
+	spi_hid_find_max_report(hid, HID_INPUT_REPORT, &bufsize);
+	spi_hid_find_max_report(hid, HID_OUTPUT_REPORT, &bufsize);
+	spi_hid_find_max_report(hid, HID_FEATURE_REPORT, &bufsize);
+
+	if (bufsize < HID_MIN_BUFFER_SIZE) {
+		dev_err(&spi->dev,
+			"HID_MIN_BUFFER_SIZE > max_input_length (%d)\n",
+			bufsize);
+		return -EINVAL;
+	}
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
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+
+	set_bit(SPI_HID_READY, &shid->flags);
+	return 0;
+}
+
+static void spi_hid_ll_close(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+
+	clear_bit(SPI_HID_READY, &shid->flags);
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
+	return 0;
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
+		ret = spi_hid_get_request(shid, reportnum);
+		if (ret) {
+			dev_err(dev, "failed to get report\n");
+			return ret;
+		}
+
+		ret = min_t(size_t, len,
+			    (shid->response->body[1] | (shid->response->body[2] << 8)) + 1);
+		buf[0] = shid->response->body[3];
+		memcpy(&buf[1], &shid->response->content, ret);
+		break;
+	default:
+		dev_err(dev, "invalid request type\n");
+		return -EIO;
+	}
+
+	return ret;
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
@@ -159,6 +704,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 
 	spi_set_drvdata(spi, shid);
 
+	mutex_init(&shid->output_lock);
+	init_completion(&shid->output_done);
+
+	/*
+	 * we need to allocate the buffer without knowing the maximum
+	 * size of the reports. Let's use SZ_2K, then we do the
+	 * real computation later.
+	 */
+	error = spi_hid_alloc_buffers(shid, SZ_2K);
+	if (error)
+		return error;
+
 	/*
 	 * At the end of probe we initialize the device:
 	 *   0) assert reset, bias the interrupt line
@@ -191,6 +748,10 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
+	error = spi_hid_create_device(shid);
+	if (error)
+		return error;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
@@ -201,6 +762,8 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	spi_hid_stop_hid(shid);
+
 	shid->ops->assert_reset(shid->ops);
 	error = shid->ops->power_down(shid->ops);
 	if (error)

-- 
2.54.0.1064.gd145956f57-goog

