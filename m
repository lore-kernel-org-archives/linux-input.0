Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBF3C4575
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334418; cv=none; b=E5k3QGIjCde+JkIcjk5jX7RhwU385zd+MCgnYbhIQxAwJknYMXlpmOssta6blcU3zs3ZgTS/cMnfT8JZxmX9z7iPhhu3LOA0eAVwneVfpiTYobDKj6wG2RPAs9NEv4n0TiWGDsWdU3Nd6+v7jzzvnWF+RScXJN6JTI93BBSQZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334418; c=relaxed/simple;
	bh=Nk6TMz3gATQxP2tJVjnvFBAdOOfrIYM1qwnKqS7z+4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rThKJAkbgY58XHOvlvstVlmon7QnvPVyL96ISI08152qmy0ild2rPI7Aygk25bb3jPv2+jsY4qft7LqYM4hQ42cO6gFCa96pw0Uik+/SsY4iLwOMAx1Je8hbKHrXNniEQjnCbPrjxqsWDYErRNGtqvknUzTFozyKg+34MCUVZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PKzZkWge; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKzZkWge"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab077e3f32so16380315ad.3
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334407; x=1774939207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4UWxWM8bTsfx8dDXh7aUXeI85fsX1VHQqdV3p02XRM=;
        b=PKzZkWgeGfv/TOZBRtTlsk9eQlJSvX3eqDv2cbnzrZoEFD7Y26PMONP4njww5TMAmx
         7vbMf2p4G+8iW3G4h/W0lXhUQwF5Uc4cGjcTDsyC5W5zAOJEqLEnxMzYgHwzIk5nWobu
         ypJLkzV/RgmKSI8DMAODBhLYqayedzJAALJM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334407; x=1774939207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4UWxWM8bTsfx8dDXh7aUXeI85fsX1VHQqdV3p02XRM=;
        b=IYBGnoqiBQ+N6VZ9SxCVj6eh17UZcrI1e8U3O/X6AISL5/bJV81UF+Bb3F3Z25S1bd
         5s7nYAw+xozanP1hx+NSW9kQmDbuZkxMW9HzFZYLohbD15LqKxEhQru63bC/MG0ikTDq
         htVRnFbzJIR++zs5pg+M90pfB4Q0dU2ZdM6F1Ry/5JRReV5mXbcy3kZAiwzsNY3TlXB1
         8UF/rog0SyeUh7a2R1VM7J+DkLqqpRq5qxTNXjxMVgUkVSupW+S0MnTyakQOQ61nflbA
         o1CAVr16ooUTjVhtZvE87FUOW/ol0gw9OvmZf5ycK6UJ3qzRHtIcyaGVDMkc8+gkTSYi
         qdXA==
X-Gm-Message-State: AOJu0YwaYQS8Rd/0iAm6RygJgjpcOvm8GsvT7DEDk3XYlhGOHcJlZU/6
	MZ4G4I1z3Y1Bk8bfFPJe+tvJPmiJWn3Tif5LIUphTIkBzoVue2oq5ehvFhXzCIVwAQ==
X-Gm-Gg: ATEYQzzBjLw9WFfF0u5GGC2TwCIiEZhMUaC8kbjFtSH3LUCOuPynS0YTBnxbKAXiAFn
	5PjE3+dn6E9hwDPdSK2qEmz5KXM5WRCrB/TzFwdLK0db5ovzHTrYEk64qZcDIVEvtyiR5VXZcIl
	faCw5gTRUBSfKVZfXIlhfDoPj/z9/aEMKPINzmAeUYgwQzufO06qkCyp6/IcfQvPjWs8SLMSq8D
	Q3XMnejUG99WzgauZIRN9B+2+lnGLCVk322SCqL4XufbAf6Mm426yu/S4l3iINqEluO9f04hDpb
	SJAOlwVxnQVniyMaLFmjVo5NkiX8mrD/aDM0hEcPHXQU7aLEjs23k8QdbD376YYj4qC3W1lZte1
	zZDnsMGJBzXPuKvoHqMB8dYEjj/lmqKUgZpbMERcptZccQKrYe2Wgr2PKUiyuz7+Ta3jcWmuncZ
	yczlkDiUUuaB0L1z+Z847+ZfPgBnaOkKIets3nkuiotVY8L69ZLYi66XwRxzGcZ9mKPYIMA4199
	nDYngsx7Lth4rHSdoli3cY7lKchlceaWw==
X-Received: by 2002:a17:902:cece:b0:2b0:69bf:a3df with SMTP id d9443c01a7336-2b0827a4fd6mr144604265ad.27.1774334406751;
        Mon, 23 Mar 2026 23:40:06 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:05 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:38 +0000
Subject: [PATCH v2 05/11] HID: spi-hid: add HID SPI protocol implementation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-5-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=23192;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Nk6TMz3gATQxP2tJVjnvFBAdOOfrIYM1qwnKqS7z+4U=;
 b=3tkHSVgXm6x6tY2ZvHp4FUQ1sXo4iXwa277nR+b8z9f5C3NkOTYkB8tGTAwMZV2O3cxL7o4M6
 BAoIi1WnO7KBix133i+91VC9shgbiijwnMAmWsDlGW2aUowGNzQ0LAK
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
 drivers/hid/spi-hid/spi-hid-core.c | 581 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 571 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 4723b87346d4..79bec3303968 100644
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
@@ -114,6 +161,9 @@ struct spi_hid {
 	struct spi_device	*spi;	/* spi device. */
 	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
 
+	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
+	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
+
 	struct spihid_ops	*ops;
 	struct spi_hid_conf	*conf;
 
@@ -131,10 +181,20 @@ struct spi_hid {
 
 	unsigned long flags;	/* device flags. */
 
-	/* Control lock to make sure one output transaction at a time. */
+	struct work_struct reset_work;
+
+	/* Control lock to ensure complete output transaction. */
 	struct mutex output_lock;
+	/* Power lock to make sure one power state change at a time. */
+	struct mutex power_lock;
+	/* I/O lock to prevent concurrent output writes during the input read. */
+	struct mutex io_lock;
+
 	struct completion output_done;
 
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
+
 	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
 
 	u32 regulator_error_count;
@@ -146,6 +206,66 @@ struct spi_hid {
 
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
@@ -157,6 +277,33 @@ static void spi_hid_populate_output_header(u8 *buf,
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
@@ -196,6 +343,50 @@ static void spi_hid_stop_hid(struct spi_hid *shid)
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
@@ -206,13 +397,13 @@ static int spi_hid_send_output_report(struct spi_hid *shid,
 	u8 padding;
 	int error;
 
-	guard(mutex)(&shid->output_lock);
 	if (report->content_length > shid->desc.max_output_length) {
 		dev_err(dev, "Output report too big, content_length 0x%x.",
 			report->content_length);
 		return -E2BIG;
 	}
 
+	guard(mutex)(&shid->io_lock);
 	spi_hid_populate_output_header(buf->header, shid->conf, report);
 
 	if (report->content_length)
@@ -236,6 +427,7 @@ static int spi_hid_sync_request(struct spi_hid *shid,
 	struct device *dev = &shid->spi->dev;
 	int error;
 
+	guard(mutex)(&shid->output_lock);
 	error = spi_hid_send_output_report(shid, report);
 	if (error)
 		return error;
@@ -250,6 +442,86 @@ static int spi_hid_sync_request(struct spi_hid *shid,
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
@@ -269,6 +541,8 @@ static int spi_hid_report_descriptor_request(struct spi_hid *shid)
 	if (ret) {
 		dev_err(dev,
 			"Expected report descriptor not received: %d.", ret);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
 		return ret;
 	}
 
@@ -323,6 +597,205 @@ static int spi_hid_create_device(struct spi_hid *shid)
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
@@ -339,6 +812,8 @@ static int spi_hid_get_request(struct spi_hid *shid, u8 content_id)
 		dev_err(dev,
 			"Expected get request response not received! Error %d.",
 			error);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
 		return error;
 	}
 
@@ -358,9 +833,83 @@ static int spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 arg_len,
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
+	scoped_guard(mutex, &shid->io_lock) {
+		error = spi_hid_input_sync(shid, shid->input->header,
+					   sizeof(shid->input->header), true);
+		if (error) {
+			dev_err(dev, "Failed to transfer header: %d.", error);
+			goto err;
+		}
+
+		if (shid->power_state == HIDSPI_OFF) {
+			dev_warn(dev, "Device is off after header was received.");
+			goto out;
+		}
+
+		if (shid->input_message.status < 0) {
+			dev_warn(dev, "Error reading header: %d.",
+				 shid->input_message.status);
+			shid->bus_error_count++;
+			shid->bus_last_error = shid->input_message.status;
+			goto err;
+		}
+
+		spi_hid_populate_input_header(shid->input->header, &header);
+
+		error = spi_hid_bus_validate_header(shid, &header);
+		if (error) {
+			if (!test_bit(SPI_HID_RESET_PENDING, &shid->flags)) {
+				dev_err(dev, "Failed to validate header: %d.", error);
+				print_hex_dump(KERN_ERR, "spi_hid: header buffer: ",
+					       DUMP_PREFIX_NONE, 16, 1, shid->input->header,
+					       sizeof(shid->input->header), false);
+				shid->bus_error_count++;
+				shid->bus_last_error = error;
+				goto err;
+			}
+			goto out;
+		}
+
+		error = spi_hid_input_sync(shid, shid->input->body, header.report_length,
+					   false);
+		if (error) {
+			dev_err(dev, "Failed to transfer body: %d.", error);
+			goto err;
+		}
+
+		if (shid->power_state == HIDSPI_OFF) {
+			dev_warn(dev, "Device is off after body was received.");
+			goto out;
+		}
+
+		if (shid->input_message.status < 0) {
+			dev_warn(dev, "Error reading body: %d.",
+				 shid->input_message.status);
+			shid->bus_error_count++;
+			shid->bus_last_error = shid->input_message.status;
+			goto err;
+		}
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
 
@@ -571,10 +1120,13 @@ static int spi_hid_ll_output_report(struct hid_device *hid, __u8 *buf,
 		return -ENODEV;
 	}
 
-	if (shid->desc.no_output_report_ack)
-		error = spi_hid_send_output_report(shid, &report);
-	else
+	if (shid->desc.no_output_report_ack) {
+		scoped_guard(mutex, &shid->output_lock) {
+			error = spi_hid_send_output_report(shid, &report);
+		}
+	} else {
 		error = spi_hid_sync_request(shid, &report);
+	}
 
 	if (error) {
 		dev_err(dev, "failed to send output report.");
@@ -662,11 +1214,22 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
@@ -706,8 +1269,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	dev_dbg(dev, "%s: d3 -> %s.", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
-	spi_hid_create_device(shid);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);

-- 
2.53.0.983.g0bb29b3bc5-goog

