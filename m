Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77833D6EE
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095188; cv=none; b=d4bH4yfVdbvhXf9q5OVDIJ0AgrsET+L7R9PFsufBwQPRIV69QQUkXKYOzoAbspBvv5jhR8tlVuXwthU3V/KzTufSV+1K8b4l2Vh1JdfkYCGghNNONozo/2BRcNfZ3kRq8CGh6k9wta43r9X325fnZcybmyoLIOiQ2VGRdHJwHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095188; c=relaxed/simple;
	bh=EnqLNJCTcvH0q+/xqzcK90S2pdO7Zg4AFKyEqEget/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuR7S6Sm7GErRW8taEGsopAlxHA8xHAcy+lkQ8x14Y35Ozl6B9zGW1Kx8uwPys1w2kL2oYVdlHHVLZ+CgQLeHJYRoGss1z4+WqyW37Q6/uowpv0N5ZcYD8bhZpLR6P/VgEKQ80X3qAKPXlOk74vkkcwAF1KQQTjM3TmWFhmISYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c8lW/ZjC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c8lW/ZjC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2503753efso2713135ad.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095184; x=1775699984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9lFXpOnmNivau0HIkBY2iJi8wwoteY30kbns1hbNbw=;
        b=c8lW/ZjChoqM5/pAl6z2en1cqs4ODyMR0PwUba9Cc7KvawqPTxFMsgzH9Z2OBsm3Ru
         X9YC23eFUCbT3w5l7KyiKT2kRaZd19h1PZ0mbndGyWeTF8Q9N7JenmQao53JGxpDUuH2
         apeRvwJ45eWjssW74JnuCiBYORqfYGTxffgwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095184; x=1775699984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9lFXpOnmNivau0HIkBY2iJi8wwoteY30kbns1hbNbw=;
        b=KIjOcpT/o4Pwc5Q3WHlnWXz+dHMSDK05cH1XaoerX6IHkmJFkrTiWMoJtsO04BYxnw
         zxNWcJ+S7ZWT5zblOZmWuWWaOeNgPtCSdaUmA4G5+0lBrJTNc+SB+2xUK6kXAs7kSVzc
         idOiEdo0YlpGXVeqiDj15cRjS3L1rYrf2MWt+SXo8aq3heUyBUzIqFeMNnqE3fI28iEd
         zRoDZ/LNvOeTnp74ys/wXYaEtAU/dRNH5Df3IU35USL+UUEtN5UCRG+qrseX+qymqEf0
         4ZxpqQdMa0wu27EgCtooITsh83oLxZ+o7GNC3ZyU3TEv9np948HwgL+aRmTXp+MJXbRZ
         eVVg==
X-Gm-Message-State: AOJu0Ywn/ozOsd2CBjiRVAFqSff4KSQ4NkJUtHz6GlZtwKRerMbvtMpN
	i8RTC0VoXdJbSu+uzUWjVb+b1tePY3/hpZcZrf1w44FUfTpk4qReLemWZLG+dqDgiVWO2k48niU
	Jqw8=
X-Gm-Gg: ATEYQzxPEMP3cj8qS0aBX9zz947bdknwkLvykS79B9mPDJEgPGVXLQKvz8V/JvyI8EK
	f4HTRw9feFj+sZhaOS4EdZ7gaxB0qoqYOQxVFOKVPEUhvcTg10YX5fFxX8q0LUc3abtrFuzLvU7
	xMWadLnch/dkNOqN7WRlvndlz9GdzPpMF1zSd63admNAWeV4sWIPB6Iv4thTLgNekY07zCLmEha
	Vi2wPTAVQxPWcwM7GhuipgtH1jbTpXzoux0Vbf2/Mc8fXH8AXVjMQbU1MZl70YYQ4FfbvHIs6w/
	xG1qUYyEtmG5R5oiKnR17DJ8FOONXzeh5MLSbRxkWIVBAoVoWTzbwe9BTAgkoFp4TPU4pJoqfnN
	0zq7VVju8SnNcngT4flXHgr5VkCu/vYWH16+xgyKIB4cFJL9Jc6dEzDAG+XGU8Q2G35oKQOms6j
	4LQZJVFFTSX3mj5eaeChFMVFm19Wkkd/rGttdSDoNEiWnk6p4OOFmhxdVicNkv5JnQ7d2NoE7HL
	5HEo68N1bjvNLAN5MuEDIgZWx+zX/gSTg==
X-Received: by 2002:a17:902:e851:b0:2ae:b9cd:d2ce with SMTP id d9443c01a7336-2b275b4a227mr15040575ad.27.1775095183891;
        Wed, 01 Apr 2026 18:59:43 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:43 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:41 +0000
Subject: [PATCH v3 04/11] HID: spi-hid: add spi-hid driver HID layer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-4-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=16407;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=EnqLNJCTcvH0q+/xqzcK90S2pdO7Zg4AFKyEqEget/Q=;
 b=OP0zkCq23IY9fMPPmA1mIvs+C4YYM+3vU4P6rzGd4BPoFUAyIo1CqlScI5LFcrtDmj3CJFOhv
 RYlLuw3ZFX2BS1Ish9HjYsYS0YizCZxemcOuXXsCIRdVlQ7Ap5YBkrI
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add HID low level driver callbacks to register SPI as a HID driver, and
an external touch device as a HID device.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 519 +++++++++++++++++++++++++++++++++++++
 1 file changed, 519 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index d7b4d4adad95..4723b87346d4 100644
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
@@ -84,11 +185,416 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
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
+static int spi_hid_send_output_report(struct spi_hid *shid,
+				      struct spi_hid_output_report *report)
+{
+	struct spi_hid_output_buf *buf = shid->output;
+	struct device *dev = &shid->spi->dev;
+	u16 report_length;
+	u16 padded_length;
+	u8 padding;
+	int error;
+
+	guard(mutex)(&shid->output_lock);
+	if (report->content_length > shid->desc.max_output_length) {
+		dev_err(dev, "Output report too big, content_length 0x%x.",
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
+	padded_length = round_up(report_length,	4);
+	padding = padded_length - report_length;
+	memset(&buf->content[report->content_length], 0, padding);
+
+	error = spi_hid_output(shid, buf, padded_length);
+	if (error)
+		dev_err(dev, "Failed output transfer: %d.", error);
+
+	return error;
+}
+
+static int spi_hid_sync_request(struct spi_hid *shid,
+				struct spi_hid_output_report *report)
+{
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	error = spi_hid_send_output_report(shid, report);
+	if (error)
+		return error;
+
+	error = wait_for_completion_interruptible_timeout(&shid->output_done,
+							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
+	if (error == 0) {
+		dev_err(dev, "Response timed out.");
+		return -ETIMEDOUT;
+	}
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
+			"Expected report descriptor not received: %d.", ret);
+		return ret;
+	}
+
+	ret = shid->response_length;
+	if (ret != shid->desc.report_descriptor_length) {
+		ret = min_t(unsigned int, ret, shid->desc.report_descriptor_length);
+		dev_err(dev, "Received report descriptor length doesn't match device descriptor field, using min of the two: %d.",
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
+		dev_err(dev, "Failed to allocate hid device: %d.", error);
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
+		dev_err(dev, "Failed to add hid device: %d.", error);
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
+			"Expected get request response not received! Error %d.",
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
+	int inbufsize = sizeof(shid->input->header) + sizeof(shid->input->body) + report_size;
+	int outbufsize = sizeof(shid->output->header) + report_size;
+
+	// devm_krealloc with __GFP_ZERO ensures the new memory is initialized
+	shid->output = devm_krealloc(dev, shid->output, outbufsize, GFP_KERNEL | __GFP_ZERO);
+	shid->input = devm_krealloc(dev, shid->input, inbufsize, GFP_KERNEL | __GFP_ZERO);
+	shid->response = devm_krealloc(dev, shid->response, inbufsize, GFP_KERNEL | __GFP_ZERO);
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
+	return ((report->size - 1) >> 3) + 1 +
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
+			"HID_MIN_BUFFER_SIZE > max_input_length (%d).",
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
+	int error, len;
+
+	len = spi_hid_report_descriptor_request(shid);
+	if (len < 0) {
+		dev_err(dev, "Report descriptor request failed, %d.", len);
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
+		dev_err(dev, "failed parsing report: %d.", error);
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
+			dev_err(dev, "report id mismatch.");
+			return -EINVAL;
+		}
+
+		ret = spi_hid_set_request(shid, &buf[1], len - 1,
+					  reportnum);
+		if (ret) {
+			dev_err(dev, "failed to set report.");
+			return ret;
+		}
+
+		ret = len;
+		break;
+	case HID_REQ_GET_REPORT:
+		ret = spi_hid_get_request(shid, reportnum);
+		if (ret) {
+			dev_err(dev, "failed to get report.");
+			return ret;
+		}
+
+		ret = min_t(size_t, len,
+			    (shid->response->body[1] | (shid->response->body[2] << 8)) + 1);
+		buf[0] = shid->response->body[3];
+		memcpy(&buf[1], &shid->response->content, ret);
+		break;
+	default:
+		dev_err(dev, "invalid request type.");
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
+		dev_err(dev, "%s called in unready state", __func__);
+		return -ENODEV;
+	}
+
+	if (shid->desc.no_output_report_ack)
+		error = spi_hid_send_output_report(shid, &report);
+	else
+		error = spi_hid_sync_request(shid, &report);
+
+	if (error) {
+		dev_err(dev, "failed to send output report.");
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
@@ -159,6 +665,15 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 
 	spi_set_drvdata(spi, shid);
 
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
@@ -191,6 +706,8 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	dev_dbg(dev, "%s: d3 -> %s.", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
+	spi_hid_create_device(shid);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
@@ -201,6 +718,8 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	spi_hid_stop_hid(shid);
+
 	shid->ops->assert_reset(shid->ops);
 	error = shid->ops->power_down(shid->ops);
 	if (error)

-- 
2.53.0.1185.g05d4b7b318-goog

