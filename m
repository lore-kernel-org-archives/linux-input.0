Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956D3446C4
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095193; cv=none; b=NfMF2H0fUitAXCHF6+qrlHTKcuvfzjaVesf5dJWyduaH5QRkM8q8frkVd787EYA8tqwOfOcS5oz2A3cIhORiiY9aNO5rtuRC7jWt2Epi3KVUb/d0Z59di3+ZI+fMuweNFgrMtfLw4BXYSDXlh3fUu010+W5Y7OL6u+QZtI+ipLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095193; c=relaxed/simple;
	bh=vDHaoV/gYpkl6O82neaWLp853ITUnPEedYwKE5Cx7o8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOhNMJ1xubaXgjjZUODSg1zUt1TDpKvITlgayosWpAj2Ld495e5T53LueRoTaBhtkNECykh/1nBJw/2iIvG4UzJYnWhLu3jShjUxaQQqtd54P2cjhRMi66xg/rrB5+FB7B9LeEH7YSS70z/B8WU4eGUGpYK6T2dWXHH26UL6leY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MJWITZib; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJWITZib"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b256a4c6b5so1863955ad.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095186; x=1775699986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRpz9hV8ktD4Npg0jOlXpgMkGgUebLGK5shW3+Bc4Yo=;
        b=MJWITZibi6gzThyU35pRGi1sW/RjDVC7nOnb2b7xHWqnbX0IMbJjx8c1ARzh9c7Da6
         /XbdqWl/i4rh/ABtiIAjrZxkinR9GU/lwSUoNZ1JUj+VHRmL8wK3pRaj1AgEjgpbg/6u
         gUZttM3By3zqgzY+Swub+d5dDr0kb6fV6Wnec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095186; x=1775699986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tRpz9hV8ktD4Npg0jOlXpgMkGgUebLGK5shW3+Bc4Yo=;
        b=YyscFUft9VSLXrkN7guffOO58Ufaq2OtP5HpmhMxIjyYAwG61bjlBkHoWIaW0Wb3/Q
         pwNvlknxWk/waweXvvg0MdgxZlsBfG7QkW2BrUYLUsUeyjka2I9LhhBPRZgD2+WOFKv4
         0cjdBnbRKqSQzwhVGuXvu53qMOn/h58iNo0lxqcqxXGUoVO1+6nr7Dquno394MasnI6h
         n2DTYFZXFTvbM/dZnNRuI6UekLuayks6cqjpP5TE8XTqWjOLAoN4EXCRKWvd75tnAeE7
         kDana8f9GxqvVo9If6ffVB6lcgpPaf9BcU0jFDCHmfxR02ewqqS6EknnOkNT9qO28ON7
         KOdQ==
X-Gm-Message-State: AOJu0YwIGZv/PqbN3pqcIHb+MYryw3xn2BPdIxCUzKm5fimJOhyhj9qd
	rbXL+Rc1u4MVsVw3gSGIrFsqgU/E12ITIv2INOwkLZeclAv+hRcG0l8ufNQAOJadWEYwyXl85Fo
	Kd0o=
X-Gm-Gg: ATEYQzwOeizxg3AKbpVjwRGMJrxqAwDPUJ1wRvfd9sf2osSR4KGWLYs6UxeEjXUXl1P
	z4rc5y0P67bitWrfjsk+EeATJ7CZRcu7LkFJa+NWx25dmiNsiwowofmBp7zFSiuBFz3jF1EopXD
	0kj7HEAdMsbZZunKICCoK2YNfzYkkppFh0lARGTjc0mJ5RCPio5xI96YRwW0DlCWolgZZpLZBfg
	/wXdPw4PLGGc1YcXIjesmSVLrMUw8ZhTMdO2zZCML2/SB23/B4Tz/2XsdsC0j3FXgBGAEnFPfkG
	NXIVpbAD6cMg6s2Y1/MK1AHfxbXCdmmk19wXh21HI0UPndL0C+DYBxa6lj8ONMZ+Rka1GwEicXs
	r1JOV7QtGc9x1ta/MYcqwLfW6Tpklj6NmKKvQqoDUU4mfsMEH6KKMXOOOnVHNHCPfp2jJSpN1Im
	IpzNe5goCMSiRtOCGlKXiaXmCosRUOI56C91TvE0fmhgc1olWdm4vCAXOum32yi/6pM5hZrQsbI
	v1EqTovaogntiw7iU4N1KZNWaiJdKz4bA==
X-Received: by 2002:a17:903:22d2:b0:2b2:57ee:c047 with SMTP id d9443c01a7336-2b269cc2f42mr56517835ad.47.1775095185541;
        Wed, 01 Apr 2026 18:59:45 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:45 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:43 +0000
Subject: [PATCH v3 06/11] HID: spi_hid: add spi_hid traces
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-6-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=17241;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=vDHaoV/gYpkl6O82neaWLp853ITUnPEedYwKE5Cx7o8=;
 b=eglUqnsoIwIXYiY2KrrqMu9mlaIdxPZ6AZoIet1ltfoL/QP0sQmr/7p0GsxqE1gCOFUwEn/6U
 A/z6xAglRUQDxQ5AWAuxA35hPz7EDKSTfQbNorno8SBHyClYCtdXf2E
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add traces for purposed of debugging spi_hid driver.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Makefile        |   1 +
 drivers/hid/spi-hid/spi-hid-core.c  | 118 +++++++++----------------
 drivers/hid/spi-hid/spi-hid-core.h  |  91 +++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-trace.h | 169 ++++++++++++++++++++++++++++++++++++
 4 files changed, 303 insertions(+), 76 deletions(-)

diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 92e24cddbfc2..733e006df56e 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -7,3 +7,4 @@
 
 obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
+CFLAGS_spi-hid-core.o 		:= -I$(src)
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 00b9718ba2c3..802615565541 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -43,6 +43,11 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#include "spi-hid-core.h"
+
+#define CREATE_TRACE_POINTS
+#include "spi-hid-trace.h"
+
 /* Protocol constants */
 #define SPI_HID_READ_APPROVAL_CONSTANT		0xff
 #define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
@@ -81,13 +86,6 @@
 #define SPI_HID_CREATE_DEVICE	4
 #define SPI_HID_ERROR	5
 
-/* Raw input buffer with data from the bus */
-struct spi_hid_input_buf {
-	u8 header[HIDSPI_INPUT_HEADER_SIZE];
-	u8 body[HIDSPI_INPUT_BODY_HEADER_SIZE];
-	u8 content[];
-};
-
 /* Processed data from input report header */
 struct spi_hid_input_header {
 	u8 version;
@@ -104,12 +102,6 @@ struct spi_hid_input_report {
 	u8 *content;
 };
 
-/* Raw output report buffer to be put on the bus */
-struct spi_hid_output_buf {
-	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
-	u8 content[];
-};
-
 /* Data necessary to send an output report */
 struct spi_hid_output_report {
 	u8 report_type;
@@ -118,19 +110,6 @@ struct spi_hid_output_report {
 	u8 *content;
 };
 
-/* Processed data from a device descriptor */
-struct spi_hid_device_descriptor {
-	u16 hid_version;
-	u16 report_descriptor_length;
-	u16 max_input_length;
-	u16 max_output_length;
-	u16 max_fragment_length;
-	u16 vendor_id;
-	u16 product_id;
-	u16 version_id;
-	u8 no_output_report_ack;
-};
-
 /* struct spi_hid_conf - Conf provided to the core */
 struct spi_hid_conf {
 	u32 input_report_header_address;
@@ -156,54 +135,6 @@ struct spihid_ops {
 	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
 };
 
-/* Driver context */
-struct spi_hid {
-	struct spi_device	*spi;	/* spi device. */
-	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
-
-	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
-	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
-
-	struct spihid_ops	*ops;
-	struct spi_hid_conf	*conf;
-
-	struct spi_hid_device_descriptor desc;	/* HID device descriptor. */
-	struct spi_hid_output_buf *output;	/* Output buffer. */
-	struct spi_hid_input_buf *input;	/* Input buffer. */
-	struct spi_hid_input_buf *response;	/* Response buffer. */
-
-	u16 response_length;
-	u16 bufsize;
-
-	enum hidspi_power_state power_state;
-
-	u8 reset_attempts;	/* The number of reset attempts. */
-
-	unsigned long flags;	/* device flags. */
-
-	struct work_struct reset_work;
-
-	/* Control lock to ensure complete output transaction. */
-	struct mutex output_lock;
-	/* Power lock to make sure one power state change at a time. */
-	struct mutex power_lock;
-	/* I/O lock to prevent concurrent output writes during the input read. */
-	struct mutex io_lock;
-
-	struct completion output_done;
-
-	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
-	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
-
-	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
-
-	u32 regulator_error_count;
-	int regulator_last_error;
-	u32 bus_error_count;
-	int bus_last_error;
-	u32 dir_count;	/* device initiated reset count. */
-};
-
 static struct hid_ll_driver spi_hid_ll_driver;
 
 static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
@@ -293,6 +224,11 @@ static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
 	spi_message_init_with_transfers(&shid->input_message,
 					shid->input_transfer, 2);
 
+	trace_spi_hid_input_sync(shid,	shid->input_transfer[0].tx_buf,
+				 shid->input_transfer[0].len,
+				 shid->input_transfer[1].rx_buf,
+				 shid->input_transfer[1].len, 0);
+
 	error = spi_sync(shid->spi, &shid->input_message);
 	if (error) {
 		dev_err(&shid->spi->dev, "Error starting sync transfer: %d.", error);
@@ -343,11 +279,13 @@ static void spi_hid_stop_hid(struct spi_hid *shid)
 		hid_destroy_device(hid);
 }
 
-static void spi_hid_error(struct spi_hid *shid)
+static void spi_hid_error_handler(struct spi_hid *shid)
 {
 	struct device *dev = &shid->spi->dev;
 	int error;
 
+	trace_spi_hid_error_handler(shid);
+
 	guard(mutex)(&shid->power_lock);
 	if (shid->power_state == HIDSPI_OFF)
 		return;
@@ -457,6 +395,8 @@ static void spi_hid_reset_response(struct spi_hid *shid)
 	};
 	int error;
 
+	trace_spi_hid_reset_response(shid);
+
 	if (test_bit(SPI_HID_READY, &shid->flags)) {
 		dev_err(dev, "Spontaneous FW reset!");
 		clear_bit(SPI_HID_READY, &shid->flags);
@@ -482,6 +422,8 @@ static int spi_hid_input_report_handler(struct spi_hid *shid,
 	struct spi_hid_input_report r;
 	int error = 0;
 
+	trace_spi_hid_input_report_handler(shid);
+
 	if (!test_bit(SPI_HID_READY, &shid->flags) ||
 	    test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) || !shid->hid) {
 		dev_err(dev, "HID not ready");
@@ -506,6 +448,8 @@ static int spi_hid_input_report_handler(struct spi_hid *shid,
 static void spi_hid_response_handler(struct spi_hid *shid,
 				     struct input_report_body_header *body)
 {
+	trace_spi_hid_response_handler(shid);
+
 	shid->response_length = body->content_len;
 	/* completion_done returns 0 if there are waiters, otherwise 1 */
 	if (completion_done(&shid->output_done)) {
@@ -562,6 +506,8 @@ static int spi_hid_create_device(struct spi_hid *shid)
 	struct device *dev = &shid->spi->dev;
 	int error;
 
+	trace_spi_hid_create_device(shid);
+
 	hid = hid_allocate_device();
 	error = PTR_ERR_OR_ZERO(hid);
 	if (error) {
@@ -603,6 +549,8 @@ static void spi_hid_refresh_device(struct spi_hid *shid)
 	u32 new_crc32 = 0;
 	int error = 0;
 
+	trace_spi_hid_refresh_device(shid);
+
 	error = spi_hid_report_descriptor_request(shid);
 	if (error < 0) {
 		dev_err(dev,
@@ -668,7 +616,7 @@ static void spi_hid_reset_work(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(SPI_HID_ERROR, &shid->flags)) {
-		spi_hid_error(shid);
+		spi_hid_error_handler(shid);
 		return;
 	}
 }
@@ -681,6 +629,8 @@ static int spi_hid_process_input_report(struct spi_hid *shid,
 	struct device *dev = &shid->spi->dev;
 	struct hidspi_dev_descriptor *raw;
 
+	trace_spi_hid_process_input_report(shid);
+
 	spi_hid_populate_input_header(buf->header, &header);
 	spi_hid_populate_input_body(buf->body, &body);
 
@@ -840,6 +790,9 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 	struct spi_hid_input_header header;
 	int error = 0;
 
+	trace_spi_hid_dev_irq(shid, irq);
+	trace_spi_hid_header_transfer(shid);
+
 	scoped_guard(mutex, &shid->io_lock) {
 		error = spi_hid_input_sync(shid, shid->input->header,
 					   sizeof(shid->input->header), true);
@@ -853,6 +806,13 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 			goto out;
 		}
 
+		trace_spi_hid_input_header_complete(shid,
+						    shid->input_transfer[0].tx_buf,
+						    shid->input_transfer[0].len,
+						    shid->input_transfer[1].rx_buf,
+						    shid->input_transfer[1].len,
+						    shid->input_message.status);
+
 		if (shid->input_message.status < 0) {
 			dev_warn(dev, "Error reading header: %d.",
 				 shid->input_message.status);
@@ -889,6 +849,12 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 			goto out;
 		}
 
+		trace_spi_hid_input_body_complete(shid, shid->input_transfer[0].tx_buf,
+						  shid->input_transfer[0].len,
+						  shid->input_transfer[1].rx_buf,
+						  shid->input_transfer[1].len,
+						  shid->input_message.status);
+
 		if (shid->input_message.status < 0) {
 			dev_warn(dev, "Error reading body: %d.",
 				 shid->input_message.status);
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
new file mode 100644
index 000000000000..293e2cfcfbf7
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ */
+
+#ifndef SPI_HID_CORE_H
+#define SPI_HID_CORE_H
+
+#include <linux/hid-over-spi.h>
+#include <linux/spi/spi.h>
+
+/* Protocol message size constants */
+#define SPI_HID_READ_APPROVAL_LEN		5
+#define SPI_HID_OUTPUT_HEADER_LEN		8
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
+
+/* Driver context */
+struct spi_hid {
+	struct spi_device	*spi;	/* spi device. */
+	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
+
+	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
+	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
+
+	struct spihid_ops	*ops;
+	struct spi_hid_conf	*conf;
+
+	struct spi_hid_device_descriptor desc;	/* HID device descriptor. */
+	struct spi_hid_output_buf *output;	/* Output buffer. */
+	struct spi_hid_input_buf *input;	/* Input buffer. */
+	struct spi_hid_input_buf *response;	/* Response buffer. */
+
+	u16 response_length;
+	u16 bufsize;
+
+	enum hidspi_power_state power_state;
+
+	u8 reset_attempts;	/* The number of reset attempts. */
+
+	unsigned long flags;	/* device flags. */
+
+	struct work_struct reset_work;
+
+	/* Control lock to ensure complete output transaction. */
+	struct mutex output_lock;
+	/* Power lock to make sure one power state change at a time. */
+	struct mutex power_lock;
+	/* I/O lock to prevent concurrent output writes during the input read. */
+	struct mutex io_lock;
+
+	struct completion output_done;
+
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
+
+	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
+
+	u32 regulator_error_count;
+	int regulator_last_error;
+	u32 bus_error_count;
+	int bus_last_error;
+	u32 dir_count;		/* device initiated reset count. */
+};
+
+#endif /* SPI_HID_CORE_H */
diff --git a/drivers/hid/spi-hid/spi-hid-trace.h b/drivers/hid/spi-hid/spi-hid-trace.h
new file mode 100644
index 000000000000..cc13d71a14de
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-trace.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi_hid
+
+#if !defined(_SPI_HID_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SPI_HID_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include "spi-hid-core.h"
+
+DECLARE_EVENT_CLASS(spi_hid_transfer,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		 const void *rx_buf, u16 rx_len, int ret),
+
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, ret)
+		__dynamic_array(u8, rx_buf, rx_len)
+		__dynamic_array(u8, tx_buf, tx_len)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->ret = ret;
+
+		memcpy(__get_dynamic_array(tx_buf), tx_buf, tx_len);
+		memcpy(__get_dynamic_array(rx_buf), rx_buf, rx_len);
+	),
+
+	TP_printk("spi%d.%d: len=%d tx=[%*phD] rx=[%*phD] --> %d",
+		  __entry->bus_num, __entry->chip_select,
+		  __get_dynamic_array_len(tx_buf) + __get_dynamic_array_len(rx_buf),
+		  __get_dynamic_array_len(tx_buf), __get_dynamic_array(tx_buf),
+		  __get_dynamic_array_len(rx_buf), __get_dynamic_array(rx_buf),
+		  __entry->ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_sync,
+	     TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		      const void *rx_buf, u16 rx_len, int ret),
+	     TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret));
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_header_complete,
+	     TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		      const void *rx_buf, u16 rx_len, int ret),
+	     TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret));
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_body_complete,
+	     TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		      const void *rx_buf, u16 rx_len, int ret),
+	     TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret));
+
+DECLARE_EVENT_CLASS(spi_hid_irq,
+	TP_PROTO(struct spi_hid *shid, int irq),
+
+	TP_ARGS(shid, irq),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, irq)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->irq = irq;
+	),
+
+	TP_printk("spi%d.%d: IRQ %d",
+		  __entry->bus_num, __entry->chip_select, __entry->irq)
+);
+
+DEFINE_EVENT(spi_hid_irq, spi_hid_dev_irq,
+	     TP_PROTO(struct spi_hid *shid, int irq), TP_ARGS(shid, irq));
+
+DECLARE_EVENT_CLASS(spi_hid,
+	TP_PROTO(struct spi_hid *shid),
+
+	TP_ARGS(shid),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, power_state)
+		__field(u32, flags)
+
+		__field(int, vendor_id)
+		__field(int, product_id)
+		__field(int, max_input_length)
+		__field(int, max_output_length)
+		__field(u16, hid_version)
+		__field(u16, report_descriptor_length)
+		__field(u16, version_id)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->power_state = shid->power_state;
+		__entry->flags = shid->flags;
+
+		__entry->vendor_id = shid->desc.vendor_id;
+		__entry->product_id = shid->desc.product_id;
+		__entry->max_input_length = shid->desc.max_input_length;
+		__entry->max_output_length = shid->desc.max_output_length;
+		__entry->hid_version = shid->desc.hid_version;
+		__entry->report_descriptor_length =
+					shid->desc.report_descriptor_length;
+		__entry->version_id = shid->desc.version_id;
+	),
+
+	TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state p:%d len i:%d o:%d r:%d flags 0x%08x",
+		  __entry->bus_num, __entry->chip_select,
+		  __entry->vendor_id, __entry->product_id, __entry->version_id,
+		  __entry->hid_version >> 8, __entry->hid_version & 0xff,
+		  __entry->power_state,	__entry->max_input_length,
+		  __entry->max_output_length, __entry->report_descriptor_length,
+		  __entry->flags)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_header_transfer, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_process_input_report,
+	     TP_PROTO(struct spi_hid *shid), TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_input_report_handler,
+	     TP_PROTO(struct spi_hid *shid), TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_reset_response, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_create_device, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_refresh_device, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_response_handler, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_error_handler, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+#endif /* _SPI_HID_TRACE_H */
+
+/*
+ * The following must be outside the protection of the above #if block.
+ */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+
+/*
+ * It is required that the TRACE_INCLUDE_FILE be the same
+ * as this file without the ".h".
+ */
+#define TRACE_INCLUDE_FILE spi-hid-trace
+#include <trace/define_trace.h>

-- 
2.53.0.1185.g05d4b7b318-goog

