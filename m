Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94F503904
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584809; cv=none; b=C07PWjV/kxuJ8KhBTsszyg6gxzbK+fv95bU4b3u0HHTHTGAWpwEQzBMlEZlTT1wfWo1DcFKXcrbn2HaLvHw1gMZYN2G1j0KS8HLFc7PlB+JXvSxR99lJhDTu+PeTLe9RScJ7A0iHsSKVJm+dD7nk61lwFJuJQ4/JYq88loQqa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584809; c=relaxed/simple;
	bh=XOjiJdXwPwm/c4LclbiP3cLrOoStPf3EVMuD+NkRGGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDsdO6e5ImPpLSoAP/UarybCKAGl+cFNIIALLyCICcPTFy9R5z5KD/tRlV8QAyR04FCLgjLizfDU/DtZ3NSnvLoJU241J2WR0DP5xtJKoalW/eR0gEqLr9psl8ONfxZRxn/bym4FJ/TqLB8Hn+Swr0tgiXXld1ZFBxQljDbD7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c3HkUxDc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3HkUxDc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e836252e1dso1472395ad.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584802; x=1792189602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7HZJ28jTOJEKus2v6oMRJGzro//bA+gIPgJaOoQnL1E=;
        b=c3HkUxDcllT1SC7Epz7+QrNuzJYKEYlemOWm7SJYIV1OVLQlFnyahA4kV2LpbHfcx0
         CLSACExLfauj+F81Ug03T5BA/oi2gjGUoLQiEgyyoek4Ww3vUW5chJPrAqzRBsfLqLOh
         T7Pj9ucWEWJbIzaP3XnaddMh1NiU07gzy61DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584802; x=1792189602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HZJ28jTOJEKus2v6oMRJGzro//bA+gIPgJaOoQnL1E=;
        b=f265CixpW9rYqqbBkrWhzi6sNNcd0Tax6k5RXWH2+rAp79trLeI7FyqK6ARwDVX+Li
         OA2SRRH/9Z8k14l8cx5k4nyhyBksIUaFxeX0jysvgU4D/feK6iw0BnhcO0zVsckZRdfd
         woJy9mvjs7DtvvGC086XKIj7NHw1T71D7lem7GCLrq6VGTR+TptE8yK6p6JZ6xu3xP5f
         qIpYD0kR4CUdARYE3/3ABiY5cVbHbZu0EP+T8gWrPV+Z36xYxYPWP25mI6A/YVGcYLG4
         sT4LZWUW3EfJiIY3k3Imp/CQk3NeT6B58jo6V6qD/ih1rzTavGCk5aFUPCTtiuc5pYYh
         u1jg==
X-Gm-Message-State: AFq9FYJLt6vsbgThOud4JiXXn5SpdBELPV68TY0vNF4sQ6ejRJz/kjWu
	BMHTxajyMuwDMPBbmGm/gIXJ9g+2dv44tbeOa5ZX/eVdh+j0k6b1EfuUkZ6apyUrKEtdZCZLaHp
	Js67pIQ==
X-Gm-Gg: AYBFou23DzGaQa1PfikOsqSb8hv4RUiDWXZrZ5p2UxKS287mR6VWlg8iwgP56t3yr1H
	AQUkYvQkLLI2NJk0p2AJTQk1d5iX9iGy+CxaO3XZh/ekdJWPD9hABL23LAPyNJhVuJZU1PdPqtY
	hhyyBsapCPsKTn3A4NH419OAHxdhfOmapv2vmEnX3245RDFP+dTFunm63ELLn41Qllloz9kR2dT
	Ol/K5Wj0BRM/NyhOzSZ27ovoqNM5JUtPFbpboBHRYY8C13EBHbB5bwtqwRGTqjlQgp7sEDjiOej
	pH228BtSNfxPu7KuChHeHvOx5EaTillaK6GdrzpOKxlxwZX1AS0efIwqvBhCTdMXQvIoSYdPxoA
	fX4ya6YYGfdo8gsnGnUekRBjBbMwyh/Gqe7xbutP+0LK9tx8y/nQ2g3WgKdtK85Z7zfGbXP+6fk
	jPNKJwLOoUYNhRKbZqVAUTkbshXMnIi/Gei5+3JZrabfHMeHFxEaamzTuo+MATvIqQVQB5ULiOe
	BgGWnNUKce9wm8Qv8DxmtHOyNAk6ZxBdYdTGU8phQezjKxxNKAKqawkc1HY0qHSIBuTgoGSKwkT
X-Received: by 2002:a17:902:cec2:b0:2dd:c053:a6ee with SMTP id d9443c01a7336-2e842abfd6amr27793845ad.32.1791584801847;
        Fri, 09 Oct 2026 15:26:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:30 +0000
Subject: [PATCH v5 05/11] HID: spi-hid: add HID SPI protocol implementation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-5-384af01da3ee@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=33103;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=XOjiJdXwPwm/c4LclbiP3cLrOoStPf3EVMuD+NkRGGo=;
 b=NWbLy1nAqjUs61So3GPz3pTPU4kzNrtnPKOuc9kHkUPYe5jda0MJddYc6PFoPhwQoXMsCTQE+
 qYO3MMGtcgjBRnk6mFpqLT9aAHWJH7mmTD9Ax+bT2HXT7EI1rWyaE99
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
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 777 +++++++++++++++++++++++++++++++++++--
 1 file changed, 743 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index fca7a44eeb9f..447ba178d5bf 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -20,14 +20,20 @@
  *  Copyright (c) 2006-2010 Jiri Kosina
  */
 
+#include <linux/cache.h>
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
@@ -35,12 +41,22 @@
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
@@ -49,6 +65,26 @@
  * requests. The FW becomes ready after sending the report descriptor.
  */
 #define SPI_HID_READY	0
+/*
+ * refresh_in_progress is set to true while the refresh_device worker
+ * thread is destroying and recreating the hidraw device. When this flag
+ * is set to true, input reports are dropped.
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
+/*
+ * started is set while the HID device is open, i.e. between ll_open and
+ * ll_close. Input reports are only forwarded while this flag is set.
+ */
+#define SPI_HID_STARTED	6
 
 /* Raw input buffer with data from the bus */
 struct spi_hid_input_buf {
@@ -57,6 +93,22 @@ struct spi_hid_input_buf {
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
@@ -114,6 +166,9 @@ struct spi_hid {
 	struct spi_device	*spi;	/* spi device. */
 	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
 
+	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
+	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
+
 	struct spihid_ops	*ops;
 	struct spi_hid_conf	*conf;
 
@@ -124,6 +179,10 @@ struct spi_hid {
 
 	u16 response_length;
 	u16 bufsize;
+	/* Response type awaited by a sync request, 0 if none. Protected by io_lock. */
+	u8 expected_response;
+	/* Content ID of that request. Protected by io_lock. */
+	u8 expected_content_id;
 
 	enum hidspi_power_state power_state;
 
@@ -131,8 +190,28 @@ struct spi_hid {
 
 	unsigned long flags;	/* device flags. */
 
-	/* Control lock to make sure one output transaction at a time. */
+	struct work_struct reset_work;
+
+	/*
+	 * Serializes request/response transactions: held from sending a
+	 * request until its response in shid->response has been consumed.
+	 * Taken before io_lock.
+	 */
 	struct mutex output_lock;
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
 	struct completion output_done;
 
 	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
@@ -142,10 +221,67 @@ struct spi_hid {
 	u32 bus_error_count;
 	int bus_last_error;
 	u32 dir_count;	/* device initiated reset count. */
+
+	/* DMA-safe transfer buffers */
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN] ____cacheline_aligned;
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
 };
 
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
+					struct spi_hid_input_report *body)
+{
+	body->report_type = buf[0];
+	body->content_length = get_unaligned_le16(&buf[1]);
+	body->content_id = buf[3];
+}
+
+static void spi_hid_input_report_prepare(struct spi_hid_input_buf *buf,
+					 struct spi_hid_input_report *report)
+{
+	spi_hid_populate_input_body(buf->body, report);
+	report->content = buf->content;
+}
+
 static void spi_hid_populate_output_header(u8 *buf,
 					   const struct spi_hid_conf *conf,
 					   const struct spi_hid_output_report *report)
@@ -157,6 +293,33 @@ static void spi_hid_populate_output_header(u8 *buf,
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
+		dev_err(&shid->spi->dev, "Error starting sync transfer: %d\n", error);
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
@@ -187,17 +350,94 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 
 static void spi_hid_stop_hid(struct spi_hid *shid)
 {
-	struct hid_device *hid = shid->hid;
+	struct hid_device *hid;
 
-	shid->hid = NULL;
-	clear_bit(SPI_HID_READY, &shid->flags);
+	scoped_guard(mutex, &shid->io_lock) {
+		hid = shid->hid;
+		shid->hid = NULL;
+		clear_bit(SPI_HID_READY, &shid->flags);
+	}
 
 	if (hid)
 		hid_destroy_device(hid);
 }
 
+static void spi_hid_error_handler(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	guard(mutex)(&shid->power_lock);
+	if (shid->power_state == HIDSPI_OFF)
+		return;
+
+	disable_irq(shid->spi->irq);
+
+	if (shid->reset_attempts++ >= SPI_HID_MAX_RESET_ATTEMPTS) {
+		dev_err(dev, "unresponsive device, aborting\n");
+		spi_hid_stop_hid(shid);
+		shid->ops->assert_reset(shid->ops);
+		error = shid->ops->power_down(shid->ops);
+		if (error) {
+			dev_err(dev, "failed to disable regulator\n");
+			shid->regulator_error_count++;
+			shid->regulator_last_error = error;
+		}
+		shid->power_state = HIDSPI_OFF;
+		/* Dead device: leave the IRQ permanently disabled. */
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
+
+	enable_irq(shid->spi->irq);
+}
+
+/* Map an output report type to the response type the device sends back. */
+static u8 spi_hid_response_type(u8 report_type)
+{
+	switch (report_type) {
+	case DEVICE_DESCRIPTOR:
+		return DEVICE_DESCRIPTOR_RESPONSE;
+	case REPORT_DESCRIPTOR:
+		return REPORT_DESCRIPTOR_RESPONSE;
+	case SET_FEATURE:
+		return SET_FEATURE_RESPONSE;
+	case GET_FEATURE:
+		return GET_FEATURE_RESPONSE;
+	case OUTPUT_REPORT:
+		return OUTPUT_REPORT_RESPONSE;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * If expected_response is non-zero, arm the response tracking under io_lock
+ * before the write so that the IRQ path only accepts a response of that type.
+ */
 static int __spi_hid_send_output_report(struct spi_hid *shid,
-					struct spi_hid_output_report *report)
+					struct spi_hid_output_report *report,
+					u8 expected_response)
 {
 	struct spi_hid_output_buf *buf = shid->output;
 	struct device *dev = &shid->spi->dev;
@@ -206,6 +446,14 @@ static int __spi_hid_send_output_report(struct spi_hid *shid,
 	u8 padding;
 	int error;
 
+	lockdep_assert_held(&shid->output_lock);
+
+	/* While not READY, only (re)init descriptor requests may be sent. */
+	if (report->report_type != DEVICE_DESCRIPTOR &&
+	    report->report_type != REPORT_DESCRIPTOR &&
+	    !test_bit(SPI_HID_READY, &shid->flags))
+		return -ENODEV;
+
 	if (report->content_length > shid->desc.max_output_length ||
 	    report->content_length > shid->bufsize) {
 		dev_err(dev, "Output report too big, content_length 0x%x\n",
@@ -213,6 +461,7 @@ static int __spi_hid_send_output_report(struct spi_hid *shid,
 		return -E2BIG;
 	}
 
+	guard(mutex)(&shid->io_lock);
 	spi_hid_populate_output_header(buf->header, shid->conf, report);
 
 	if (report->content_length)
@@ -223,9 +472,17 @@ static int __spi_hid_send_output_report(struct spi_hid *shid,
 	padding = padded_length - report_length;
 	memset(&buf->content[report->content_length], 0, padding);
 
+	if (expected_response) {
+		reinit_completion(&shid->output_done);
+		shid->expected_response = expected_response;
+		shid->expected_content_id = report->content_id;
+	}
+
 	error = spi_hid_output(shid, buf, padded_length);
-	if (error)
+	if (error) {
 		dev_err(dev, "Failed output transfer: %d\n", error);
+		shid->expected_response = 0;
+	}
 
 	return error;
 }
@@ -234,7 +491,7 @@ static int spi_hid_send_output_report(struct spi_hid *shid,
 				      struct spi_hid_output_report *report)
 {
 	guard(mutex)(&shid->output_lock);
-	return __spi_hid_send_output_report(shid, report);
+	return __spi_hid_send_output_report(shid, report, 0);
 }
 
 static int __spi_hid_sync_request(struct spi_hid *shid,
@@ -243,22 +500,26 @@ static int __spi_hid_sync_request(struct spi_hid *shid,
 	struct device *dev = &shid->spi->dev;
 	int error;
 
-	reinit_completion(&shid->output_done);
-
-	error = __spi_hid_send_output_report(shid, report);
+	error = __spi_hid_send_output_report(shid, report,
+					     spi_hid_response_type(report->report_type));
 	if (error)
 		return error;
 
-	error = wait_for_completion_interruptible_timeout(&shid->output_done,
-							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
-	if (error == 0) {
-		dev_err(dev, "Response timed out\n");
-		return -ETIMEDOUT;
+	if (wait_for_completion_timeout(&shid->output_done,
+					msecs_to_jiffies(SPI_HID_RESP_TIMEOUT)))
+		return 0;
+
+	/* Drop late responses and block new HID requests until the reset. */
+	scoped_guard(mutex, &shid->io_lock) {
+		shid->expected_response = 0;
+		clear_bit(SPI_HID_READY, &shid->flags);
 	}
-	if (error < 0)
-		return error;
 
-	return 0;
+	dev_err(dev, "Response timed out\n");
+	/* The device may still answer later: resync it with a reset. */
+	set_bit(SPI_HID_ERROR, &shid->flags);
+	schedule_work(&shid->reset_work);
+	return -ETIMEDOUT;
 }
 
 static int spi_hid_sync_request(struct spi_hid *shid,
@@ -268,9 +529,174 @@ static int spi_hid_sync_request(struct spi_hid *shid,
 	return __spi_hid_sync_request(shid, report);
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
+		dev_err(dev, "Spontaneous FW reset!\n");
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
+			      "Failed to send device descriptor request: %d\n", error);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
+	}
+}
+
+static int spi_hid_input_report_handler(struct spi_hid *shid,
+					struct spi_hid_input_buf *buf)
+{
+	struct device *dev = &shid->spi->dev;
+	struct hid_device *hid;
+	struct spi_hid_input_report r;
+	int error = 0;
+
+	scoped_guard(mutex, &shid->io_lock) {
+		if (!test_bit(SPI_HID_READY, &shid->flags) ||
+		    !test_bit(SPI_HID_STARTED, &shid->flags) ||
+		    test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) || !shid->hid) {
+			dev_dbg(dev, "HID not ready (flags 0x%lx), dropping input report\n",
+				shid->flags);
+			return 0;
+		}
+
+		hid = shid->hid;
+		spi_hid_input_report_prepare(buf, &r);
+	}
+
+	/*
+	 * Safe after dropping io_lock: hid is only freed, and bufsize only
+	 * changed, after disable_irq(), which waits for this handler. The
+	 * buffer is the content ID byte at r.content - 1 plus bufsize bytes.
+	 */
+	error = hid_safe_input_report(hid, HID_INPUT_REPORT, r.content - 1,
+				      shid->bufsize + 1,
+				      r.content_length + 1, 1);
+
+	if (error == -ENODEV || error == -EBUSY) {
+		dev_err(dev, "ignoring report --> %d\n", error);
+		return 0;
+	} else if (error) {
+		dev_err(dev, "Bad input report: %d\n", error);
+	}
+
+	return error;
+}
+
+/*
+ * Validate a device descriptor response and, if valid, publish it to
+ * shid->desc and request device creation.
+ */
+static int spi_hid_dev_desc_response(struct spi_hid *shid,
+				     struct spi_hid_input_report *body)
+{
+	struct hidspi_dev_descriptor *raw =
+		(struct hidspi_dev_descriptor *)shid->input->content;
+	struct device *dev = &shid->spi->dev;
+
+	/* Validate device descriptor length before parsing */
+	if (body->content_length != HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
+		dev_err(dev, "Invalid content length %d, expected %zu\n",
+			body->content_length, HIDSPI_DEVICE_DESCRIPTOR_SIZE);
+		return -EPROTO;
+	}
+
+	if (le16_to_cpu(raw->dev_desc_len) != HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
+		dev_err(dev, "Invalid wDeviceDescLength %d, expected %zu\n",
+			le16_to_cpu(raw->dev_desc_len),
+			HIDSPI_DEVICE_DESCRIPTOR_SIZE);
+		return -EPROTO;
+	}
+
+	if (le16_to_cpu(raw->bcd_ver) != SPI_HID_SUPPORTED_VERSION) {
+		dev_err(dev, "Unsupported device descriptor version %4x\n",
+			le16_to_cpu(raw->bcd_ver));
+		return -EPROTONOSUPPORT;
+	}
+
+	/* Fail before reset_attempts is cleared so resets stay bounded. */
+	if (!le16_to_cpu(raw->rep_desc_len) ||
+	    le16_to_cpu(raw->rep_desc_len) > HID_MAX_DESCRIPTOR_SIZE) {
+		dev_err(dev, "Invalid wReportDescLength %d, max %d\n",
+			le16_to_cpu(raw->rep_desc_len),
+			HID_MAX_DESCRIPTOR_SIZE);
+		return -EPROTO;
+	}
+
+	spi_hid_parse_dev_desc(raw, &shid->desc);
+
+	/* Reset attempts at every device descriptor fetch */
+	shid->reset_attempts = 0;
+	set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
+	schedule_work(&shid->reset_work);
+
+	return 0;
+}
+
+static int spi_hid_response_handler(struct spi_hid *shid,
+				    struct spi_hid_input_report *body)
+{
+	int error = 0;
+
+	guard(mutex)(&shid->io_lock);
+
+	/*
+	 * Drop late or unsolicited responses. With no request IDs, also match
+	 * the report ID for GET_FEATURE so it can't get another report's data.
+	 */
+	if (!shid->expected_response ||
+	    body->report_type != shid->expected_response ||
+	    (body->report_type == GET_FEATURE_RESPONSE &&
+	     body->content_id != shid->expected_content_id)) {
+		dev_err(&shid->spi->dev, "Unexpected response report 0x%x\n",
+			body->report_type);
+		return 0;
+	}
+	shid->expected_response = 0;
+
+	shid->response_length = body->content_length;
+	if (body->report_type == REPORT_DESCRIPTOR_RESPONSE ||
+	    body->report_type == GET_FEATURE_RESPONSE) {
+		memcpy(shid->response->body, shid->input->body,
+		       sizeof(shid->input->body));
+		memcpy(shid->response->content, shid->input->content,
+		       body->content_length);
+	} else if (body->report_type == DEVICE_DESCRIPTOR_RESPONSE) {
+		/*
+		 * Publish the descriptor before complete() so reset_work never
+		 * sees a partially written shid->desc.
+		 */
+		error = spi_hid_dev_desc_response(shid, body);
+	}
+
+	/* Wake the waiter even on error so it doesn't wait for the timeout. */
+	complete(&shid->output_done);
+
+	return error;
+}
+
 /*
  * This function returns the length of the report descriptor, or a negative
- * error code if something went wrong.
+ * error code if something went wrong. Caller must hold output_lock.
  */
 static int spi_hid_report_descriptor_request(struct spi_hid *shid)
 {
@@ -283,10 +709,14 @@ static int spi_hid_report_descriptor_request(struct spi_hid *shid)
 	};
 	int ret;
 
-	ret =  spi_hid_sync_request(shid, &report);
+	lockdep_assert_held(&shid->output_lock);
+
+	ret = __spi_hid_sync_request(shid, &report);
 	if (ret) {
 		dev_err(dev,
 			"Expected report descriptor not received: %d\n", ret);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
 		return ret;
 	}
 
@@ -325,7 +755,9 @@ static int spi_hid_create_device(struct spi_hid *shid)
 		 hid->vendor, hid->product);
 	strscpy(hid->phys, dev_name(&shid->spi->dev), sizeof(hid->phys));
 
-	shid->hid = hid;
+	scoped_guard(mutex, &shid->io_lock) {
+		shid->hid = hid;
+	}
 
 	error = hid_add_device(hid);
 	if (error) {
@@ -334,13 +766,204 @@ static int spi_hid_create_device(struct spi_hid *shid)
 		 * We likely got here because report descriptor request timed
 		 * out. Let's disconnect and destroy the hid_device structure.
 		 */
-		spi_hid_stop_hid(shid);
+		scoped_guard(disable_irq, &shid->spi->irq)
+			spi_hid_stop_hid(shid);
 		return error;
 	}
 
 	return 0;
 }
 
+static void spi_hid_refresh_device(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	u32 new_crc32 = 0;
+	int error = 0;
+
+	/* Keep shid->response stable until the CRC is computed. */
+	scoped_guard(mutex, &shid->output_lock) {
+		error = spi_hid_report_descriptor_request(shid);
+		if (error < 0) {
+			dev_err(dev,
+				"%s: failed report descriptor request: %d\n",
+				__func__, error);
+			return;
+		}
+		new_crc32 = crc32_le(0, (unsigned char const *)shid->response->content,
+				     (size_t)error);
+	}
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
+	/*
+	 * Disable the IRQ only for tear-down: creation needs it to receive
+	 * the report descriptor. REFRESH_IN_PROGRESS drops input meanwhile.
+	 */
+	scoped_guard(disable_irq, &shid->spi->irq) {
+		spi_hid_stop_hid(shid);
+	}
+
+	error = spi_hid_create_device(shid);
+	clear_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags);
+
+	if (error)
+		dev_err(dev, "%s: Failed to create hid device: %d\n", __func__, error);
+}
+
+static void spi_hid_reset_work(struct work_struct *work)
+{
+	struct spi_hid *shid =
+		container_of(work, struct spi_hid, reset_work);
+	struct device *dev = &shid->spi->dev;
+	int error = 0;
+	bool resched = false;
+
+	if (test_and_clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags)) {
+		spi_hid_reset_response(shid);
+		resched = true;
+	} else if (test_and_clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags)) {
+		guard(mutex)(&shid->power_lock);
+		if (shid->power_state != HIDSPI_OFF) {
+			if (!shid->hid) {
+				error = spi_hid_create_device(shid);
+				if (error) {
+					dev_err(dev, "%s: Failed to create hid device: %d\n",
+						__func__, error);
+				}
+			} else {
+				spi_hid_refresh_device(shid);
+			}
+		} else {
+			dev_err(dev, "%s: Powered off, returning\n", __func__);
+		}
+		resched = true;
+	} else if (test_and_clear_bit(SPI_HID_ERROR, &shid->flags)) {
+		spi_hid_error_handler(shid);
+	}
+
+	/*
+	 * If other flags are still pending, safely reschedule ourselves
+	 * to process them in the next workqueue cycle.
+	 */
+	if (resched && (shid->flags & (BIT(SPI_HID_RESET_RESPONSE) |
+				       BIT(SPI_HID_CREATE_DEVICE) |
+				       BIT(SPI_HID_ERROR)))) {
+		schedule_work(&shid->reset_work);
+	}
+}
+
+static int spi_hid_process_input_report(struct spi_hid *shid,
+					struct spi_hid_input_buf *buf)
+{
+	struct spi_hid_input_header header;
+	struct spi_hid_input_report body;
+	struct device *dev = &shid->spi->dev;
+
+	spi_hid_populate_input_header(buf->header, &header);
+	spi_hid_input_report_prepare(buf, &body);
+
+	if (HIDSPI_INPUT_BODY_SIZE(body.content_length) > header.report_length) {
+		dev_err(dev, "Bad body length %zu > %u\n",
+			HIDSPI_INPUT_BODY_SIZE(body.content_length),
+			header.report_length);
+		return -EPROTO;
+	}
+
+	switch (body.report_type) {
+	case DATA:
+		return spi_hid_input_report_handler(shid, buf);
+	case RESET_RESPONSE:
+		clear_bit(SPI_HID_RESET_PENDING, &shid->flags);
+		set_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
+		schedule_work(&shid->reset_work);
+		break;
+	case DEVICE_DESCRIPTOR_RESPONSE:
+		return spi_hid_response_handler(shid, &body);
+	case OUTPUT_REPORT_RESPONSE:
+		if (shid->desc.no_output_report_ack) {
+			dev_err(dev, "Unexpected output report response\n");
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
+		dev_err(dev, "Not a supported report type: 0x%x\n",
+			body.report_type);
+		break;
+	default:
+		dev_err(dev, "Unknown input report: 0x%x\n", body.report_type);
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
+	/*
+	 * Body capacity of shid->input, matching spi_hid_alloc_buffers().
+	 * shid->bufsize only changes with the IRQ disabled, so it is stable here.
+	 */
+	u32 max_body = round_up(sizeof(shid->input->header) +
+				sizeof(shid->input->body) + shid->bufsize, 4) -
+		       sizeof(shid->input->header);
+
+	if (header->version != SPI_HID_INPUT_HEADER_VERSION) {
+		dev_err(dev, "Unknown input report version (v 0x%x)\n",
+			header->version);
+		return -EINVAL;
+	}
+
+	/*
+	 * report_length is device-provided and is used as the size of the body
+	 * transfer, so it must never exceed the input buffer.
+	 */
+	if (header->report_length > max_body) {
+		dev_err(dev, "Input report too big: %u > %u\n",
+			header->report_length, max_body);
+		return -EMSGSIZE;
+	}
+
+	if (shid->desc.max_input_length != 0 &&
+	    header->report_length > shid->desc.max_input_length) {
+		dev_err(dev, "Input report body size %u > max expected of %u\n",
+			header->report_length, shid->desc.max_input_length);
+		return -EMSGSIZE;
+	}
+
+	if (header->last_fragment_flag != 1) {
+		dev_err(dev, "Multi-fragment reports not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (header->sync_const != SPI_HID_INPUT_HEADER_SYNC_BYTE) {
+		dev_err(dev, "Invalid input report sync constant (0x%x)\n",
+			header->sync_const);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int spi_hid_get_request(struct spi_hid *shid, u8 content_id,
 			       u8 *buf, size_t len)
 {
@@ -365,6 +988,8 @@ static int spi_hid_get_request(struct spi_hid *shid, u8 content_id,
 		dev_err(dev,
 			"Expected get request response not received! Error %d\n",
 			error);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
 		return error;
 	}
 
@@ -397,9 +1022,81 @@ static int spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 arg_len,
 	return spi_hid_sync_request(shid, &report);
 }
 
-/* This is a placeholder. Will be implemented in the next patch. */
+/* Schedule a reset to recover from an error in the IRQ handler. */
+static irqreturn_t spi_hid_irq_error(struct spi_hid *shid)
+{
+	set_bit(SPI_HID_ERROR, &shid->flags);
+	schedule_work(&shid->reset_work);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 {
+	struct spi_hid *shid = _shid;
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_input_header header;
+	int error = 0;
+
+	scoped_guard(mutex, &shid->io_lock) {
+		if (shid->power_state == HIDSPI_OFF) {
+			dev_warn(dev, "Device is off, ignoring interrupt\n");
+			return IRQ_NONE;
+		}
+
+		error = spi_hid_input_sync(shid, shid->input->header,
+					   sizeof(shid->input->header), true);
+		if (error) {
+			dev_err(dev, "Failed to transfer header: %d\n", error);
+			return spi_hid_irq_error(shid);
+		}
+
+		if (shid->input_message.status < 0) {
+			dev_warn(dev, "Error reading header: %d\n",
+				 shid->input_message.status);
+			shid->bus_error_count++;
+			shid->bus_last_error = shid->input_message.status;
+			return spi_hid_irq_error(shid);
+		}
+
+		spi_hid_populate_input_header(shid->input->header, &header);
+
+		error = spi_hid_bus_validate_header(shid, &header);
+		if (error) {
+			if (!test_bit(SPI_HID_RESET_PENDING, &shid->flags)) {
+				dev_err(dev, "Failed to validate header: %d\n", error);
+				print_hex_dump(KERN_ERR, "spi_hid: header buffer: ",
+					       DUMP_PREFIX_NONE, 16, 1, shid->input->header,
+					       sizeof(shid->input->header), false);
+				shid->bus_error_count++;
+				shid->bus_last_error = error;
+				return spi_hid_irq_error(shid);
+			}
+			return IRQ_HANDLED;
+		}
+
+		error = spi_hid_input_sync(shid, shid->input->body, header.report_length,
+					   false);
+		if (error) {
+			dev_err(dev, "Failed to transfer body: %d\n", error);
+			return spi_hid_irq_error(shid);
+		}
+
+		if (shid->input_message.status < 0) {
+			dev_warn(dev, "Error reading body: %d\n",
+				 shid->input_message.status);
+			shid->bus_error_count++;
+			shid->bus_last_error = shid->input_message.status;
+			return spi_hid_irq_error(shid);
+		}
+	}
+
+	error = spi_hid_process_input_report(shid, shid->input);
+	if (error) {
+		dev_err(dev, "Failed to process input report: %d\n", error);
+		return spi_hid_irq_error(shid);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -496,6 +1193,10 @@ static void spi_hid_ll_stop(struct hid_device *hid)
 
 static int spi_hid_ll_open(struct hid_device *hid)
 {
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+
+	set_bit(SPI_HID_STARTED, &shid->flags);
 	return 0;
 }
 
@@ -504,6 +1205,7 @@ static void spi_hid_ll_close(struct hid_device *hid)
 	struct spi_device *spi = hid->driver_data;
 	struct spi_hid *shid = spi_get_drvdata(spi);
 
+	clear_bit(SPI_HID_STARTED, &shid->flags);
 	shid->reset_attempts = 0;
 }
 
@@ -535,11 +1237,8 @@ static int spi_hid_ll_parse(struct hid_device *hid)
 		return -EINVAL;
 	}
 
-	if (rsize > shid->bufsize) {
-		error = spi_hid_alloc_buffers(shid, rsize);
-		if (error)
-			return error;
-	}
+	/* Keep shid->response stable until done. */
+	guard(mutex)(&shid->output_lock);
 
 	len = spi_hid_report_descriptor_request(shid);
 	if (len < 0) {
@@ -730,12 +1429,21 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->power_state = HIDSPI_ON;
 	shid->ops = ops;
 	shid->conf = conf;
+	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
 
 	spi_set_drvdata(spi, shid);
 
+	/* Using now populated conf let's pre-calculate the read approvals */
+	spi_hid_populate_read_approvals(shid->conf, shid->read_approval_header,
+					shid->read_approval_body);
+
 	mutex_init(&shid->output_lock);
+	mutex_init(&shid->power_lock);
+	mutex_init(&shid->io_lock);
 	init_completion(&shid->output_done);
 
+	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+
 	/*
 	 * we need to allocate the buffer without knowing the maximum
 	 * size of the reports. Let's use HID_MAX_DESCRIPTOR_SIZE, then we do the
@@ -760,7 +1468,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->ops->sleep_minimal_reset_delay(shid->ops);
 
 	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
-					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(&spi->dev), shid);
 	if (error) {
 		dev_err(dev, "%s: unable to request threaded IRQ\n", __func__);
 		return error;
@@ -774,13 +1482,11 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 
 	shid->ops->deassert_reset(shid->ops);
 
+	enable_irq(spi->irq);
+
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
-	error = spi_hid_create_device(shid);
-	if (error)
-		return error;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
@@ -791,6 +1497,9 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	disable_irq(spi->irq);
+	disable_work_sync(&shid->reset_work);
+
 	spi_hid_stop_hid(shid);
 
 	shid->ops->assert_reset(shid->ops);

-- 
2.56.0.385.gd3acb90ef8-goog

