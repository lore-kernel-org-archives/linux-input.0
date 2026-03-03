Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA9382293
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518434; cv=none; b=Ec9ZkYdiXCVt1SyT4ZjJ3jeg1/sDHCJO6YFVS5/ajARrOJ6vZN+K+5ZDnGdZbjmNWGoRcF0zWj5FDedqM6J0GiirSxp5uw74rQx56rC2+PMY/OwZhX+vjhPm5IRQSR/9zBH3PhQ1IRp3Jn6ayw4DTiT2lFPMTBDlN5tGZ28J3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518434; c=relaxed/simple;
	bh=C4LZDlU0Fvnpa+YtYAHxmO1B30tTrWCHU+SIbyuNZAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnJJXTAD56859tGMuuoxKtU/DLn5CIPMOXgTuBGz+898vkcx86VW7P6M311RuJ1gJCORM7zUGMq2OQ1fqdf6O6sDJFP8mbgGLGNObodrnHuC90ISI6YoG72u8CgV3y5jDQExBwe7WZ4z0NJ9MufRoiqPH4jxc+Q9z6WnrffjQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iEc/LWA0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iEc/LWA0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae5636ab04so16335625ad.3
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 22:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518429; x=1773123229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEPl8FXJ36FwTyRODKjg7eAVmOxPOUrqwiKxceJZPPc=;
        b=iEc/LWA0lbfC7i03qxKGwR0G0d0F6Rp/jZmCvjat1cODUimfAaFBtu7J+bbp3+5anU
         wkVG6IMbPmz77aNsZ7KY5QKv862+H5KrCt7WMmHZHkVOGghJIGIbzYlGGwQdMs0d6i0q
         IpMHxZjB6cM1/dGm/JshwwavFdzqBvR1oMxnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518429; x=1773123229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vEPl8FXJ36FwTyRODKjg7eAVmOxPOUrqwiKxceJZPPc=;
        b=sJy4NHQx+PA71UdGgzc8//mmQZdMMCZWAkHBdYFJcBeklW9Zy55I7Zc2NpcJF9ReX7
         fVWxjesOI/X1mYDkkSfI+AZKuyE5WVK8FVJoN2rjE7EQcllElNMC+p//+tgihhjoXfH5
         llDHSQ6Q0APG7d3s5ePkE6by6dCU1GmuoCeho55dEaOcqv3eld1TP4iJMB6P2mhl8WZG
         8pZpAQ7jPnC6mVexQYHQoagWT9LjAFWvnti4QNlOtQ0c1KUJ9q/NvvgOT/431W3J7W+J
         bUlalV8YwA30+qT5wkwsL/6IuL1YaqmT2UxeDW1lYcHwOMWcOZOb8T2SYI0NwPdhCJ75
         0EQQ==
X-Gm-Message-State: AOJu0YzUBDbsQrg+ri+dGF3A4P9pzD5axu7Q7VfRkZqSVPW78TVj9f/R
	l6GAq2YsFFSpwP6QQ8Y0RKrHbwV0FCIZOihRAb77/TjvqY3mnCwgB5tkkpJ+BPEd0w==
X-Gm-Gg: ATEYQzyisIWCyQ1k2fTj6zH3M6X+ZPcGELQFTlbaAt3OAoZJ1GqGOulLKttyQhZBUCc
	4P+oh2iafZmjkOK4mKlorP1oQqIlwHbkKEyVdcwckLLq7pOzzOsJv22MQqbXp2X/rdsWxOPD3e5
	QuPPzC0vqtw433nKkX6BlUAo/PCs3bvG4eA3oRVgeqk8CDdYeDJ654fcZM2EqDfZ7TQYT999WI2
	0aPG5t9/KR0aOONNlFDIvdSToS/Qg5u0V5l0CDDymR/zV/ciBHSM3kzPZ76l5C9I3dMLzAZk4PQ
	MbQg4MCLeYm8W1MC3QVNeMGTcP3p2/s5398k3f3FIT/zan21CorESczmnb/GNJX0N5BLWa+d+bt
	DncrQuje0qOBCLlKr4TsQ88KJfJilGVXYq1CJJkFK5h8pDmobOCm/JV3tkAIbpbRWrN2E5j+qeI
	iH3vhvYLPIjvvrd2wTMFQwhpvsxCO0GBHR5cUDmfiwLvrBVFhwu2WJOuKHkwgbU6WO6EV3znFqf
	Xh263mpYYwKRP+jN6u/swZwsGqmnbZw8g==
X-Received: by 2002:a17:903:4b4b:b0:2ae:4d13:ae90 with SMTP id d9443c01a7336-2ae4d13d414mr81370595ad.37.1772518429410;
        Mon, 02 Mar 2026 22:13:49 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:48 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:12:57 +0000
Subject: [PATCH 05/12] HID: spi-hid: add HID SPI protocol implementation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-5-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=21692;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=C4LZDlU0Fvnpa+YtYAHxmO1B30tTrWCHU+SIbyuNZAg=;
 b=w7peWTEp5VBEQqAb0qJbfqEgSNAIrrw4vCSpcG0HOmehKdfHt9FBpsqukgL7OvU9FNL2WsCp9
 bWmf/q0QC94ARDlyQxfpv97Ny7mDfcy98iW6K7zi2HdkHnU/FFdzk0p
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

This driver follows HID Over SPI Protocol Specification 1.0 available at
https://www.microsoft.com/en-us/download/details.aspx?id=103325. The
initial version of the driver does not support: 1) multi-fragment input
reports, 2) sending GET_INPUT and COMMAND output report types and
processing their respective acknowledge input reports, and 3) device
sleep power state.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 562 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 557 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 18b035324f06..08865d42555f 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -23,11 +23,16 @@
 #include <linux/completion.h>
 #include <linux/crc32.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/hid-over-spi.h>
+#include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -35,12 +40,22 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/unaligned.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+/* Protocol constants */
+#define SPI_HID_READ_APPROVAL_CONSTANT		0xff
+#define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
+#define SPI_HID_INPUT_HEADER_VERSION		0x03
+#define SPI_HID_SUPPORTED_VERSION		0x0300
 
 #define SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST	0x00
 
-#define SPI_HID_RESP_TIMEOUT	1000
+#define SPI_HID_MAX_RESET_ATTEMPTS	3
+#define SPI_HID_RESP_TIMEOUT		1000
 
 /* Protocol message size constants */
+#define SPI_HID_READ_APPROVAL_LEN		5
 #define SPI_HID_OUTPUT_HEADER_LEN		8
 
 /* flags */
@@ -49,6 +64,22 @@
  * requests. The FW becomes ready after sending the report descriptor.
  */
 #define SPI_HID_READY	0
+/*
+ * refresh_in_progress is set to true while the refresh_device worker
+ * thread is destroying and recreating the hidraw device. When this flag
+ * is set to true, the ll_close and ll_open functions will not cause
+ * power state changes.
+ */
+#define SPI_HID_REFRESH_IN_PROGRESS	1
+/*
+ * reset_pending indicates that the device is being reset. When this flag
+ * is set to true, garbage interrupts triggered during reset will be
+ * dropped and will not cause error handling.
+ */
+#define SPI_HID_RESET_PENDING	2
+#define SPI_HID_RESET_RESPONSE	3
+#define SPI_HID_CREATE_DEVICE	4
+#define SPI_HID_ERROR	5
 
 /* Raw input buffer with data from the bus */
 struct spi_hid_input_buf {
@@ -57,6 +88,22 @@ struct spi_hid_input_buf {
 	u8 content[];
 };
 
+/* Processed data from input report header */
+struct spi_hid_input_header {
+	u8 version;
+	u16 report_length;
+	u8 last_fragment_flag;
+	u8 sync_const;
+};
+
+/* Processed data from an input report */
+struct spi_hid_input_report {
+	u8 report_type;
+	u16 content_length;
+	u8 content_id;
+	u8 *content;
+};
+
 /* Raw output report buffer to be put on the bus */
 struct spi_hid_output_buf {
 	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
@@ -113,6 +160,9 @@ struct spi_hid {
 	struct spi_device	*spi;	/* spi device. */
 	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
 
+	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
+	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
+
 	struct spihid_ops	*ops;
 	struct spi_hid_conf	*conf;
 
@@ -130,10 +180,17 @@ struct spi_hid {
 
 	unsigned long flags;	/* device flags. */
 
+	struct work_struct reset_work;
+
 	/* Control lock to make sure one output transaction at a time. */
 	struct mutex output_lock;
+	/* Power lock to make sure one power state change at a time. */
+	struct mutex power_lock;
 	struct completion output_done;
 
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
+
 	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
 
 	u32 regulator_error_count;
@@ -145,6 +202,66 @@ struct spi_hid {
 
 static struct hid_ll_driver spi_hid_ll_driver;
 
+static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
+					    u8 *header_buf, u8 *body_buf)
+{
+	header_buf[0] = conf->read_opcode;
+	put_unaligned_be24(conf->input_report_header_address, &header_buf[1]);
+	header_buf[4] = SPI_HID_READ_APPROVAL_CONSTANT;
+
+	body_buf[0] = conf->read_opcode;
+	put_unaligned_be24(conf->input_report_body_address, &body_buf[1]);
+	body_buf[4] = SPI_HID_READ_APPROVAL_CONSTANT;
+}
+
+static void spi_hid_parse_dev_desc(const struct hidspi_dev_descriptor *raw,
+				   struct spi_hid_device_descriptor *desc)
+{
+	desc->hid_version = le16_to_cpu(raw->bcd_ver);
+	desc->report_descriptor_length = le16_to_cpu(raw->rep_desc_len);
+	desc->max_input_length = le16_to_cpu(raw->max_input_len);
+	desc->max_output_length = le16_to_cpu(raw->max_output_len);
+
+	/* FIXME: multi-fragment not supported, field below not used */
+	desc->max_fragment_length = le16_to_cpu(raw->max_frag_len);
+
+	desc->vendor_id = le16_to_cpu(raw->vendor_id);
+	desc->product_id = le16_to_cpu(raw->product_id);
+	desc->version_id = le16_to_cpu(raw->version_id);
+	desc->no_output_report_ack = le16_to_cpu(raw->flags) & BIT(0);
+}
+
+static void spi_hid_populate_input_header(const u8 *buf,
+					  struct spi_hid_input_header *header)
+{
+	header->version            = buf[0] & 0xf;
+	header->report_length      = (get_unaligned_le16(&buf[1]) & 0x3fff) * 4;
+	header->last_fragment_flag = (buf[2] & 0x40) >> 6;
+	header->sync_const         = buf[3];
+}
+
+static void spi_hid_populate_input_body(const u8 *buf,
+					struct input_report_body_header *body)
+{
+	body->input_report_type = buf[0];
+	body->content_len = get_unaligned_le16(&buf[1]);
+	body->content_id = buf[3];
+}
+
+static void spi_hid_input_report_prepare(struct spi_hid_input_buf *buf,
+					 struct spi_hid_input_report *report)
+{
+	struct spi_hid_input_header header;
+	struct input_report_body_header body;
+
+	spi_hid_populate_input_header(buf->header, &header);
+	spi_hid_populate_input_body(buf->body, &body);
+	report->report_type = body.input_report_type;
+	report->content_length = body.content_len;
+	report->content_id = body.content_id;
+	report->content = buf->content;
+}
+
 static void spi_hid_populate_output_header(u8 *buf,
 					   const struct spi_hid_conf *conf,
 					   const struct spi_hid_output_report *report)
@@ -156,6 +273,33 @@ static void spi_hid_populate_output_header(u8 *buf,
 	buf[7] = report->content_id;
 }
 
+static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
+			      bool is_header)
+{
+	int error;
+
+	shid->input_transfer[0].tx_buf = is_header ?
+					 shid->read_approval_header :
+					 shid->read_approval_body;
+	shid->input_transfer[0].len = SPI_HID_READ_APPROVAL_LEN;
+
+	shid->input_transfer[1].rx_buf = buf;
+	shid->input_transfer[1].len = length;
+
+	spi_message_init_with_transfers(&shid->input_message,
+					shid->input_transfer, 2);
+
+	error = spi_sync(shid->spi, &shid->input_message);
+	if (error) {
+		dev_err(&shid->spi->dev, "Error starting sync transfer: %d.", error);
+		shid->bus_error_count++;
+		shid->bus_last_error = error;
+		return error;
+	}
+
+	return 0;
+}
+
 static int spi_hid_output(struct spi_hid *shid, const void *buf, u16 length)
 {
 	int error;
@@ -195,6 +339,50 @@ static void spi_hid_stop_hid(struct spi_hid *shid)
 		hid_destroy_device(hid);
 }
 
+static void spi_hid_error(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	guard(mutex)(&shid->power_lock);
+	if (shid->power_state == HIDSPI_OFF)
+		return;
+
+	if (shid->reset_attempts++ >= SPI_HID_MAX_RESET_ATTEMPTS) {
+		dev_err(dev, "unresponsive device, aborting.");
+		spi_hid_stop_hid(shid);
+		shid->ops->assert_reset(shid->ops);
+		error = shid->ops->power_down(shid->ops);
+		if (error) {
+			dev_err(dev, "failed to disable regulator.");
+			shid->regulator_error_count++;
+			shid->regulator_last_error = error;
+		}
+		return;
+	}
+
+	clear_bit(SPI_HID_READY, &shid->flags);
+	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->power_state = HIDSPI_OFF;
+
+	/*
+	 * We want to cancel pending reset work as the device is being reset
+	 * to recover from an error. cancel_work_sync will put us in a deadlock
+	 * because this function is scheduled in 'reset_work' and we should
+	 * avoid waiting for itself.
+	 */
+	cancel_work(&shid->reset_work);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	shid->power_state = HIDSPI_ON;
+
+	shid->ops->deassert_reset(shid->ops);
+}
+
 static int spi_hid_send_output_report(struct spi_hid *shid,
 				      struct spi_hid_output_report *report)
 {
@@ -249,6 +437,86 @@ static int spi_hid_sync_request(struct spi_hid *shid,
 	return 0;
 }
 
+/*
+ * Handle the reset response from the FW by sending a request for the device
+ * descriptor.
+ */
+static void spi_hid_reset_response(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = DEVICE_DESCRIPTOR,
+		.content_length = 0x0,
+		.content_id = SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
+		.content = NULL,
+	};
+	int error;
+
+	if (test_bit(SPI_HID_READY, &shid->flags)) {
+		dev_err(dev, "Spontaneous FW reset!");
+		clear_bit(SPI_HID_READY, &shid->flags);
+		shid->dir_count++;
+	}
+
+	if (shid->power_state == HIDSPI_OFF)
+		return;
+
+	error = spi_hid_sync_request(shid, &report);
+	if (error) {
+		dev_WARN_ONCE(dev, true,
+			      "Failed to send device descriptor request: %d.", error);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
+	}
+}
+
+static int spi_hid_input_report_handler(struct spi_hid *shid,
+					struct spi_hid_input_buf *buf)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_input_report r;
+	int error = 0;
+
+	if (!test_bit(SPI_HID_READY, &shid->flags) ||
+	    test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) || !shid->hid) {
+		dev_err(dev, "HID not ready");
+		return 0;
+	}
+
+	spi_hid_input_report_prepare(buf, &r);
+
+	error = hid_input_report(shid->hid, HID_INPUT_REPORT,
+				 r.content - 1, r.content_length + 1, 1);
+
+	if (error == -ENODEV || error == -EBUSY) {
+		dev_err(dev, "ignoring report --> %d.", error);
+		return 0;
+	} else if (error) {
+		dev_err(dev, "Bad input report: %d.", error);
+	}
+
+	return error;
+}
+
+static void spi_hid_response_handler(struct spi_hid *shid,
+				     struct input_report_body_header *body)
+{
+	shid->response_length = body->content_len;
+	/* completion_done returns 0 if there are waiters, otherwise 1 */
+	if (completion_done(&shid->output_done)) {
+		dev_err(&shid->spi->dev, "Unexpected response report.");
+	} else {
+		if (body->input_report_type == REPORT_DESCRIPTOR_RESPONSE ||
+		    body->input_report_type == GET_FEATURE_RESPONSE) {
+			memcpy(shid->response->body, shid->input->body,
+			       sizeof(shid->input->body));
+			memcpy(shid->response->content, shid->input->content,
+			       body->content_len);
+		}
+		complete(&shid->output_done);
+	}
+}
+
 /*
  * This function returns the length of the report descriptor, or a negative
  * error code if something went wrong.
@@ -268,6 +536,8 @@ static int spi_hid_report_descriptor_request(struct spi_hid *shid)
 	if (ret) {
 		dev_err(dev,
 			"Expected report descriptor not received: %d.", ret);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
 		return ret;
 	}
 
@@ -322,6 +592,205 @@ static int spi_hid_create_device(struct spi_hid *shid)
 	return 0;
 }
 
+static void spi_hid_refresh_device(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	u32 new_crc32 = 0;
+	int error = 0;
+
+	error = spi_hid_report_descriptor_request(shid);
+	if (error < 0) {
+		dev_err(dev,
+			"%s: failed report descriptor request: %d",
+			__func__, error);
+		return;
+	}
+	new_crc32 = crc32_le(0, (unsigned char const *)shid->response->content,
+			     (size_t)error);
+
+	/* Same report descriptor, so no need to create a new hid device. */
+	if (new_crc32 == shid->report_descriptor_crc32) {
+		set_bit(SPI_HID_READY, &shid->flags);
+		return;
+	}
+
+	shid->report_descriptor_crc32 = new_crc32;
+
+	set_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags);
+
+	spi_hid_stop_hid(shid);
+
+	error = spi_hid_create_device(shid);
+	if (error) {
+		dev_err(dev, "%s: Failed to create hid device: %d.", __func__, error);
+		return;
+	}
+
+	clear_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags);
+}
+
+static void spi_hid_reset_work(struct work_struct *work)
+{
+	struct spi_hid *shid =
+		container_of(work, struct spi_hid, reset_work);
+	struct device *dev = &shid->spi->dev;
+	int error = 0;
+
+	if (test_and_clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags)) {
+		spi_hid_reset_response(shid);
+		return;
+	}
+
+	if (test_and_clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags)) {
+		guard(mutex)(&shid->power_lock);
+		if (shid->power_state == HIDSPI_OFF) {
+			dev_err(dev, "%s: Powered off, returning", __func__);
+			return;
+		}
+
+		if (!shid->hid) {
+			error = spi_hid_create_device(shid);
+			if (error) {
+				dev_err(dev, "%s: Failed to create hid device: %d.",
+					__func__, error);
+				return;
+			}
+		} else {
+			spi_hid_refresh_device(shid);
+		}
+
+		return;
+	}
+
+	if (test_and_clear_bit(SPI_HID_ERROR, &shid->flags)) {
+		spi_hid_error(shid);
+		return;
+	}
+}
+
+static int spi_hid_process_input_report(struct spi_hid *shid,
+					struct spi_hid_input_buf *buf)
+{
+	struct spi_hid_input_header header;
+	struct input_report_body_header body;
+	struct device *dev = &shid->spi->dev;
+	struct hidspi_dev_descriptor *raw;
+
+	spi_hid_populate_input_header(buf->header, &header);
+	spi_hid_populate_input_body(buf->body, &body);
+
+	if (body.content_len > header.report_length) {
+		dev_err(dev, "Bad body length %d > %d.", body.content_len,
+			header.report_length);
+		return -EPROTO;
+	}
+
+	switch (body.input_report_type) {
+	case DATA:
+		return spi_hid_input_report_handler(shid, buf);
+	case RESET_RESPONSE:
+		clear_bit(SPI_HID_RESET_PENDING, &shid->flags);
+		set_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
+		schedule_work(&shid->reset_work);
+		break;
+	case DEVICE_DESCRIPTOR_RESPONSE:
+		/* Mark the completion done to avoid timeout */
+		spi_hid_response_handler(shid, &body);
+
+		/* Reset attempts at every device descriptor fetch */
+		shid->reset_attempts = 0;
+		raw = (struct hidspi_dev_descriptor *)buf->content;
+
+		/* Validate device descriptor length before parsing */
+		if (body.content_len != HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
+			dev_err(dev, "Invalid content length %d, expected %lu.",
+				body.content_len,
+				HIDSPI_DEVICE_DESCRIPTOR_SIZE);
+			return -EPROTO;
+		}
+
+		if (le16_to_cpu(raw->dev_desc_len) !=
+		    HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
+			dev_err(dev,
+				"Invalid wDeviceDescLength %d, expected %lu.",
+				raw->dev_desc_len,
+				HIDSPI_DEVICE_DESCRIPTOR_SIZE);
+			return -EPROTO;
+		}
+
+		spi_hid_parse_dev_desc(raw, &shid->desc);
+
+		if (shid->desc.hid_version != SPI_HID_SUPPORTED_VERSION) {
+			dev_err(dev,
+				"Unsupported device descriptor version %4x.",
+				shid->desc.hid_version);
+			return -EPROTONOSUPPORT;
+		}
+
+		set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
+		schedule_work(&shid->reset_work);
+
+		break;
+	case OUTPUT_REPORT_RESPONSE:
+		if (shid->desc.no_output_report_ack) {
+			dev_err(dev, "Unexpected output report response.");
+			break;
+		}
+		fallthrough;
+	case GET_FEATURE_RESPONSE:
+	case SET_FEATURE_RESPONSE:
+	case REPORT_DESCRIPTOR_RESPONSE:
+		spi_hid_response_handler(shid, &body);
+		break;
+	/*
+	 * FIXME: sending GET_INPUT and COMMAND reports not supported, thus
+	 * throw away responses to those, they should never come.
+	 */
+	case GET_INPUT_REPORT_RESPONSE:
+	case COMMAND_RESPONSE:
+		dev_err(dev, "Not a supported report type: 0x%x.",
+			body.input_report_type);
+		break;
+	default:
+		dev_err(dev, "Unknown input report: 0x%x.", body.input_report_type);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int spi_hid_bus_validate_header(struct spi_hid *shid,
+				       struct spi_hid_input_header *header)
+{
+	struct device *dev = &shid->spi->dev;
+
+	if (header->version != SPI_HID_INPUT_HEADER_VERSION) {
+		dev_err(dev, "Unknown input report version (v 0x%x).",
+			header->version);
+		return -EINVAL;
+	}
+
+	if (shid->desc.max_input_length != 0 &&
+	    header->report_length > shid->desc.max_input_length) {
+		dev_err(dev, "Input report body size %u > max expected of %u.",
+			header->report_length, shid->desc.max_input_length);
+		return -EMSGSIZE;
+	}
+
+	if (header->last_fragment_flag != 1) {
+		dev_err(dev, "Multi-fragment reports not supported.");
+		return -EOPNOTSUPP;
+	}
+
+	if (header->sync_const != SPI_HID_INPUT_HEADER_SYNC_BYTE) {
+		dev_err(dev, "Invalid input report sync constant (0x%x).",
+			header->sync_const);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int spi_hid_get_request(struct spi_hid *shid, u8 content_id)
 {
 	struct device *dev = &shid->spi->dev;
@@ -338,6 +807,8 @@ static int spi_hid_get_request(struct spi_hid *shid, u8 content_id)
 		dev_err(dev,
 			"Expected get request response not received! Error %d.",
 			error);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
 		return error;
 	}
 
@@ -357,9 +828,81 @@ static int spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 arg_len,
 	return spi_hid_sync_request(shid, &report);
 }
 
-/* This is a placeholder. Will be implemented in the next patch. */
 static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 {
+	struct spi_hid *shid = _shid;
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_input_header header;
+	int error = 0;
+
+	error = spi_hid_input_sync(shid, shid->input->header,
+				   sizeof(shid->input->header), true);
+	if (error) {
+		dev_err(dev, "Failed to transfer header: %d.", error);
+		goto err;
+	}
+
+	if (shid->power_state == HIDSPI_OFF) {
+		dev_warn(dev, "Device is off after header was received.");
+		goto out;
+	}
+
+	if (shid->input_message.status < 0) {
+		dev_warn(dev, "Error reading header: %d.",
+			 shid->input_message.status);
+		shid->bus_error_count++;
+		shid->bus_last_error = shid->input_message.status;
+		goto err;
+	}
+
+	spi_hid_populate_input_header(shid->input->header, &header);
+
+	error = spi_hid_bus_validate_header(shid, &header);
+	if (error) {
+		if (!test_bit(SPI_HID_RESET_PENDING, &shid->flags)) {
+			dev_err(dev, "Failed to validate header: %d.", error);
+			print_hex_dump(KERN_ERR, "spi_hid: header buffer: ",
+				       DUMP_PREFIX_NONE, 16, 1, shid->input->header,
+				       sizeof(shid->input->header), false);
+			shid->bus_error_count++;
+			shid->bus_last_error = error;
+			goto err;
+		}
+		goto out;
+	}
+
+	error = spi_hid_input_sync(shid, shid->input->body, header.report_length,
+				   false);
+	if (error) {
+		dev_err(dev, "Failed to transfer body: %d.", error);
+		goto err;
+	}
+
+	if (shid->power_state == HIDSPI_OFF) {
+		dev_warn(dev, "Device is off after body was received.");
+		goto out;
+	}
+
+	if (shid->input_message.status < 0) {
+		dev_warn(dev, "Error reading body: %d.",
+			 shid->input_message.status);
+		shid->bus_error_count++;
+		shid->bus_last_error = shid->input_message.status;
+		goto err;
+	}
+
+	error = spi_hid_process_input_report(shid, shid->input);
+	if (error) {
+		dev_err(dev, "Failed to process input report: %d.", error);
+		goto err;
+	}
+
+out:
+	return IRQ_HANDLED;
+
+err:
+	set_bit(SPI_HID_ERROR, &shid->flags);
+	schedule_work(&shid->reset_work);
 	return IRQ_HANDLED;
 }
 
@@ -661,11 +1204,22 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->power_state = HIDSPI_ON;
 	shid->ops = ops;
 	shid->conf = conf;
+	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
 
 	spi_set_drvdata(spi, shid);
 
+	/* Using now populated conf let's pre-calculate the read approvals */
+	spi_hid_populate_read_approvals(shid->conf, shid->read_approval_header,
+					shid->read_approval_body);
+
+	mutex_init(&shid->output_lock);
+	mutex_init(&shid->power_lock);
+	init_completion(&shid->output_done);
+
+	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+
 	/*
-	 * we need to allocate the buffer without knowing the maximum
+	 * We need to allocate the buffer without knowing the maximum
 	 * size of the reports. Let's use SZ_2K, then we do the
 	 * real computation later.
 	 */
@@ -705,8 +1259,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	dev_dbg(dev, "%s: d3 -> %s.", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
-	spi_hid_create_device(shid);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);

-- 
2.53.0.473.g4a7958ca14-goog

