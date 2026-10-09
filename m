Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A64503BD4
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584809; cv=none; b=KKlzgFHjuMUZgzDl2pvrxQP3Rko7CANm2/YRXZqNSYbuTe+xqALACLQVqWlsBGqjxq0WGFTi859hTdyhD5h6Gb7aZetmfzv+wUZ+rLHpYZZK7alzsWC6/bmHB9vC9e1GLH7+rU5rLfXwBV1D7qtowj8fwgJVMxntjPXFOcYeX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584809; c=relaxed/simple;
	bh=WbdBJfp8+7Rjry8GQJ6Z1HrYPQJgIggBbwO6uZQzXuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmRUNOv57ZnPuGx7EJn7CW2kd0bqvoTmUdHwYkTFxMAlF9LHA+vEWtstyXT0gAOzgvoXEucxSYcgO8BUm+jAfFgcmM7Ywj2YXMgiM1O+O+1pCpPIyfWpKjLjCClt33IAxi+q5OUNYX7L55u64za2y4H4v8EV+f5vjDji/7DG4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TpvWeqZG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpvWeqZG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e608cd460eso975915ad.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584803; x=1792189603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WwsxxWRlg6RupoSWv1FviQVZva9S/r01tPGEo8srbc=;
        b=TpvWeqZGXYIpck6VwJ/FlDwa4+hQAa3mbLLD762nmXzgJ3ue/LxICvy/J3tJ43ZIUq
         hUldj6QhWsAKjL17ziAyFOiHFXgBDPUlwPDPpv/nbglAphThn5KYJz7fH26zcr26OM+0
         uxobYz+7EvfGURt3Zu4a84tyU1fD3tExvnIuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584803; x=1792189603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WwsxxWRlg6RupoSWv1FviQVZva9S/r01tPGEo8srbc=;
        b=RJr+ug14Wpov+asc8TZhCriGqopFR4a+Cdk9YQZq7eN4KIUb3uAEAKGdbfREC8Ljl0
         p7jNtSz0FOZNvbw6nGF1PyhbTfhOog+7JtaWFM2eG7Rkc0XRmAcVB7y5MvbtR0Lfjvvg
         DpmCXJMG2hSnUIojfUBQOwCbNItBmhZnyfY2sZgEWN5GyRjBTEdNvfvrqpJqg2GFD5pv
         ZHYvY6YHfkvWB1A4VKvDi3BqnXlPTTdOGH+yvsOyKHfkCGXHy3x0VMI653ldPwVAqaWO
         s9S0ELq3deBex/buhV0LdzyV2a7deSJTqgTidGbjcgAeuIDCiKTP4sNgZt4IwG2AEa3c
         QcDw==
X-Gm-Message-State: AFq9FYIzGWtJ/77xmQ/z/PQuNHoFEJUTc3yVU+xPW2uyt5vrkmQhJs7O
	zXtbp45sdmzAgxy/bMLblGo04PgNAi2HItFpYqgZ3gNcSQaHEMTeKIoARxRDRoKuqmlY+OcBtoD
	RNv7FFw==
X-Gm-Gg: AYBFou11HHHQaNsG69keyAYu0wOS/qDf0tZYs2ii+RXWd/onxcYFMyqaZxzXmeMOoc4
	VERTOAU2fwtYPIJdevJo3gGv2pCAhtpJSotU/+7IpM8EZQMZO2i1VJFu6Gg1jIOOsjlJc0qGH/S
	uY9+lnJiWxP7vitz8Q9FSL/0v8/zc3ca/xgn8kbTAL5lFALlEACjlVKHBN+s0Tbqg8Syi3vguzE
	2An+4SgWbw5q94q13NqrFv8jgcrM9yQL0O3qp3Lpaq0BmGnSfswgEBFx1sl0VgkPIevBd9TkVFA
	2/2fF/uX1CzA7tjYALL2walmEmDhfVI0p4hqJWBV9J694iY7ED1cvQiCAbWv67RB4hZ8yBfz6uN
	4P3gfRspvmCd+Uf6a+f3Y8ATpNnVsipf6KLSdh/uPpuvguxfsh2hGSxqHA/uODNXh9ba72Y7EAv
	lrTGSrQhI9RyjAVNDQn1C30B/y8asBPVwETns8xAgwZ+yT0jm1eHG7VtACAapn7oMDwKrm/fRua
	FhkfuMtVACMtUs3Hd2DtvqIpDvEo9mYb6ixQ8FwTigMGk+hSewOR7eBCG9JyaTeCOPutnDnklBQ
	qJGGjGtDpuA=
X-Received: by 2002:a17:902:ce84:b0:2e6:5ef:abe9 with SMTP id d9443c01a7336-2e8429addfcmr24339815ad.37.1791584802851;
        Fri, 09 Oct 2026 15:26:42 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:42 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:31 +0000
Subject: [PATCH v5 06/11] HID: spi-hid: add spi_hid traces
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-6-384af01da3ee@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=19082;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=WbdBJfp8+7Rjry8GQJ6Z1HrYPQJgIggBbwO6uZQzXuk=;
 b=RS0c6vViBccrNe4uzpQf7nbKT7YZ4a/PN6KQaZL5MGG0eAoCT9gnOIUvZeEMYYGisB9nr757N
 56R52FYwh2/C0avlGfhp4whDMM8NAWQ2S2VgD4GtMpfe2sb58k82EwY
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add traces for the purpose of debugging spi_hid driver.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Makefile        |   1 +
 drivers/hid/spi-hid/spi-hid-core.c  | 132 ++++++++------------------
 drivers/hid/spi-hid/spi-hid-core.h  | 109 +++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-trace.h | 184 ++++++++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+), 92 deletions(-)

diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 92e24cddbfc2..733e006df56e 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -7,3 +7,4 @@
 
 obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
+CFLAGS_spi-hid-core.o 		:= -I$(src)
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 447ba178d5bf..83678e683581 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -44,6 +44,11 @@
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
@@ -86,13 +91,6 @@
  */
 #define SPI_HID_STARTED	6
 
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
@@ -109,12 +107,6 @@ struct spi_hid_input_report {
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
@@ -123,19 +115,6 @@ struct spi_hid_output_report {
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
@@ -161,72 +140,6 @@ struct spihid_ops {
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
-	/* Response type awaited by a sync request, 0 if none. Protected by io_lock. */
-	u8 expected_response;
-	/* Content ID of that request. Protected by io_lock. */
-	u8 expected_content_id;
-
-	enum hidspi_power_state power_state;
-
-	u8 reset_attempts;	/* The number of reset attempts. */
-
-	unsigned long flags;	/* device flags. */
-
-	struct work_struct reset_work;
-
-	/*
-	 * Serializes request/response transactions: held from sending a
-	 * request until its response in shid->response has been consumed.
-	 * Taken before io_lock.
-	 */
-	struct mutex output_lock;
-	/* Power lock to make sure one power state change at a time. */
-	struct mutex power_lock;
-	/*
-	 * Serializes SPI bus transfers (output writes vs. IRQ-thread reads) and
-	 * protects shid->expected_response, updates to shid->desc and
-	 * publication of shid->hid. Held only briefly and never while waiting
-	 * for a response, since the IRQ thread needs it to deliver that
-	 * response. Nests inside output_lock.
-	 *
-	 * It does not keep the hid_device alive: the IRQ must be quiesced with
-	 * disable_irq() before the hid_device is destroyed.
-	 */
-	struct mutex io_lock;
-
-	struct completion output_done;
-
-	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
-
-	u32 regulator_error_count;
-	int regulator_last_error;
-	u32 bus_error_count;
-	int bus_last_error;
-	u32 dir_count;	/* device initiated reset count. */
-
-	/* DMA-safe transfer buffers */
-	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN] ____cacheline_aligned;
-	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
-};
-
 static struct hid_ll_driver spi_hid_ll_driver;
 
 static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
@@ -309,6 +222,11 @@ static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
 	spi_message_init_with_transfers(&shid->input_message,
 					shid->input_transfer, 2);
 
+	/* rx_buf is not filled yet; received data is traced by *_complete. */
+	trace_spi_hid_input_sync(shid, shid->input_transfer[0].tx_buf,
+				 shid->input_transfer[0].len,
+				 shid->input_transfer[1].rx_buf, 0, 0);
+
 	error = spi_sync(shid->spi, &shid->input_message);
 	if (error) {
 		dev_err(&shid->spi->dev, "Error starting sync transfer: %d\n", error);
@@ -367,6 +285,8 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 	struct device *dev = &shid->spi->dev;
 	int error;
 
+	trace_spi_hid_error_handler(shid);
+
 	guard(mutex)(&shid->power_lock);
 	if (shid->power_state == HIDSPI_OFF)
 		return;
@@ -544,6 +464,8 @@ static void spi_hid_reset_response(struct spi_hid *shid)
 	};
 	int error;
 
+	trace_spi_hid_reset_response(shid);
+
 	if (test_bit(SPI_HID_READY, &shid->flags)) {
 		dev_err(dev, "Spontaneous FW reset!\n");
 		clear_bit(SPI_HID_READY, &shid->flags);
@@ -571,6 +493,8 @@ static int spi_hid_input_report_handler(struct spi_hid *shid,
 	int error = 0;
 
 	scoped_guard(mutex, &shid->io_lock) {
+		trace_spi_hid_input_report_handler(shid);
+
 		if (!test_bit(SPI_HID_READY, &shid->flags) ||
 		    !test_bit(SPI_HID_STARTED, &shid->flags) ||
 		    test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) || !shid->hid) {
@@ -673,6 +597,8 @@ static int spi_hid_response_handler(struct spi_hid *shid,
 	}
 	shid->expected_response = 0;
 
+	trace_spi_hid_response_handler(shid);
+
 	shid->response_length = body->content_length;
 	if (body->report_type == REPORT_DESCRIPTOR_RESPONSE ||
 	    body->report_type == GET_FEATURE_RESPONSE) {
@@ -736,6 +662,8 @@ static int spi_hid_create_device(struct spi_hid *shid)
 	struct device *dev = &shid->spi->dev;
 	int error;
 
+	trace_spi_hid_create_device(shid);
+
 	hid = hid_allocate_device();
 	error = PTR_ERR_OR_ZERO(hid);
 	if (error) {
@@ -780,6 +708,8 @@ static void spi_hid_refresh_device(struct spi_hid *shid)
 	u32 new_crc32 = 0;
 	int error = 0;
 
+	trace_spi_hid_refresh_device(shid);
+
 	/* Keep shid->response stable until the CRC is computed. */
 	scoped_guard(mutex, &shid->output_lock) {
 		error = spi_hid_report_descriptor_request(shid);
@@ -867,6 +797,8 @@ static int spi_hid_process_input_report(struct spi_hid *shid,
 	struct spi_hid_input_report body;
 	struct device *dev = &shid->spi->dev;
 
+	trace_spi_hid_process_input_report(shid);
+
 	spi_hid_populate_input_header(buf->header, &header);
 	spi_hid_input_report_prepare(buf, &body);
 
@@ -1038,6 +970,9 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 	struct spi_hid_input_header header;
 	int error = 0;
 
+	trace_spi_hid_dev_irq(shid, irq);
+	trace_spi_hid_header_transfer(shid);
+
 	scoped_guard(mutex, &shid->io_lock) {
 		if (shid->power_state == HIDSPI_OFF) {
 			dev_warn(dev, "Device is off, ignoring interrupt\n");
@@ -1051,6 +986,13 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 			return spi_hid_irq_error(shid);
 		}
 
+		trace_spi_hid_input_header_complete(shid,
+						    shid->input_transfer[0].tx_buf,
+						    shid->input_transfer[0].len,
+						    shid->input_transfer[1].rx_buf,
+						    shid->input_transfer[1].len,
+						    shid->input_message.status);
+
 		if (shid->input_message.status < 0) {
 			dev_warn(dev, "Error reading header: %d\n",
 				 shid->input_message.status);
@@ -1082,6 +1024,12 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 			return spi_hid_irq_error(shid);
 		}
 
+		trace_spi_hid_input_body_complete(shid, shid->input_transfer[0].tx_buf,
+						  shid->input_transfer[0].len,
+						  shid->input_transfer[1].rx_buf,
+						  shid->input_transfer[1].len,
+						  shid->input_message.status);
+
 		if (shid->input_message.status < 0) {
 			dev_warn(dev, "Error reading body: %d\n",
 				 shid->input_message.status);
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
new file mode 100644
index 000000000000..1d8356f787f3
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -0,0 +1,109 @@
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
+	/* Response type awaited by a sync request, 0 if none. Protected by io_lock. */
+	u8 expected_response;
+	/* Content ID of that request. Protected by io_lock. */
+	u8 expected_content_id;
+
+	enum hidspi_power_state power_state;
+
+	u8 reset_attempts;	/* The number of reset attempts. */
+
+	unsigned long flags;	/* device flags. */
+
+	struct work_struct reset_work;
+
+	/*
+	 * Serializes request/response transactions: held from sending a
+	 * request until its response in shid->response has been consumed.
+	 * Taken before io_lock.
+	 */
+	struct mutex output_lock;
+	/* Power lock to make sure one power state change at a time. */
+	struct mutex power_lock;
+	/*
+	 * Serializes SPI bus transfers (output writes vs. IRQ-thread reads) and
+	 * protects shid->expected_response, updates to shid->desc and
+	 * publication of shid->hid. Held only briefly and never while waiting
+	 * for a response, since the IRQ thread needs it to deliver that
+	 * response. Nests inside output_lock.
+	 *
+	 * It does not keep the hid_device alive: the IRQ must be quiesced with
+	 * disable_irq() before the hid_device is destroyed.
+	 */
+	struct mutex io_lock;
+
+	struct completion output_done;
+
+	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
+
+	u32 regulator_error_count;
+	int regulator_last_error;
+	u32 bus_error_count;
+	int bus_last_error;
+	u32 dir_count;	/* device initiated reset count. */
+
+	/* DMA-safe transfer buffers */
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN] ____cacheline_aligned;
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
+};
+
+#endif /* SPI_HID_CORE_H */
diff --git a/drivers/hid/spi-hid/spi-hid-trace.h b/drivers/hid/spi-hid/spi-hid-trace.h
new file mode 100644
index 000000000000..a36e07b95001
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-trace.h
@@ -0,0 +1,184 @@
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
+/*
+ * Maximum number of tx/rx bytes copied into the ring buffer per event. This
+ * matches the most %*ph will print, keeps events small, and ensures the copy
+ * never depends on the caller-supplied length fitting inside the buffer.
+ */
+#define SPI_HID_TRACE_BUF_MAX	64
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
+		__field(int, tx_len)
+		__field(u16, rx_len)
+		__dynamic_array(u8, rx_buf,
+				min_t(u16, rx_len, SPI_HID_TRACE_BUF_MAX))
+		__dynamic_array(u8, tx_buf,
+				min_t(int, tx_len, SPI_HID_TRACE_BUF_MAX))
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = spi_get_chipselect(shid->spi, 0);
+		__entry->ret = ret;
+		__entry->tx_len = tx_len;
+		__entry->rx_len = rx_len;
+
+		memcpy(__get_dynamic_array(tx_buf), tx_buf,
+		       __get_dynamic_array_len(tx_buf));
+		memcpy(__get_dynamic_array(rx_buf), rx_buf,
+		       __get_dynamic_array_len(rx_buf));
+	),
+
+	TP_printk("spi%d.%d: len=%d tx=[%*phD] rx=[%*phD] --> %d",
+		  __entry->bus_num, __entry->chip_select,
+		  __entry->tx_len + __entry->rx_len,
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
+		__entry->chip_select = spi_get_chipselect(shid->spi, 0);
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
+		__entry->chip_select = spi_get_chipselect(shid->spi, 0);
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
2.56.0.385.gd3acb90ef8-goog

