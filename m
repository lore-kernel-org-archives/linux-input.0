Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0D382F3E
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518441; cv=none; b=GxaJ1o2mq8srtiOxwlgMEBup5eqD0lbqrLC62ynLJu1P4DWsZVPcHnnWldZ219HbILQRInwLNP+iVv+bCrCVyAEqQ9dzELX3E+MViK/84az8GGSzNhVMSJ8hzNpxGebPHzSzeRkz2VRx41kBQ3Qg3M4v2t6xWvRpGmcAYbTKgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518441; c=relaxed/simple;
	bh=RuF4EBelwWjX4MVB7wRAKwjHLIyH356VR5EZd3QmjHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApVYojkm99SJYFfSkU1w0+pXOIIFRuZ3bbmPt0M5gE4ZAZKfJ0LPKdI1gHW9b+5Acfsn8a3oL8Mr6qXoHrQs14p63WpFPlGu2pCJHL/wxQIiBz7DW6Ue94MFcBzEGOYLI4B7hMNaoyGBI0Gx1dO+YWi5vRNPFeVH/9YpA5SYpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e+9q8H9Z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e+9q8H9Z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaed195901so25013375ad.0
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 22:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518437; x=1773123237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTYYpNGe7aJcDLJJdiqjkV8VqGfZqV4Qv94rVv/ZSwU=;
        b=e+9q8H9Z2qaUbup2uhMXSUAKhFg4kP8EaZTJCDbEtlMY+sjG2idWUzGG1GalnklDbq
         raUw8Zf/h+acrwI14KJAwQvza07p9H78YbNaSXlXXCEIVKfAC/pgoJmTo9aVbwrhqhh7
         3BFB1AizMh3VTRYKE5TM+u5QAbuW000RDS1hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518437; x=1773123237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTYYpNGe7aJcDLJJdiqjkV8VqGfZqV4Qv94rVv/ZSwU=;
        b=E5aiy/vzzClGpx9POSnsDgKCzceaQmzxK2pom9P5+XjVz0KblCPYourhTZMRwqo+fv
         u8go2x5RYklRBFmi2/ZTKxKC6cVzCJ7sfMi/KowjNXxmVrwxRGwkDwhDdZv2ApevF5rl
         7fgGhTJIBsVhgUzrUEXKjx5w8zQA3MnIsyVUXllfImxqSL1yrcZsjL6wUjTFvT0OfU5r
         WaonGdYv7Qohij5uILqRbgGSg/2RYQLNMMlW2DSU6jFke4bx0+jPsIFVTpADzWyAeT5I
         Qk7lLwlHb8XORkB9uEPuJC/5wq/g+7fO/suujh5tAonW+NjFZarB0LxCAx4Riv9jcMMZ
         9UEg==
X-Gm-Message-State: AOJu0YwAqrMDwL+g5shbaaGAoA7imeAdC5SsFMkzH4ximZZlZ6Atti5S
	iGCLAO18d3sHLuzg53SwJJj792FIQy61Io47lRBE9NjD9McCIlf2gq3Yq5ScPpJ4Xw==
X-Gm-Gg: ATEYQzxBGQNCeriI7YnE9zNvRXeNYYXOydS3xN2KOkaOAzPXSyfBggZSPLmuxRsRxP9
	PF76SoHj5S340GMpxZyne3O74/lHQyIapeyi/y/AidbV1EQzhwU+mmgWSPmnIhosowKHgzJY5cl
	ByLdUy1wZPpS4CD2uMVf8tJFfhXIPFxhHgqB02EfZispwHSotVezLt4P9hU14yGXAzfh+XO1g9J
	L2f6AA0TpP6WgHStdGnnxtUDAN+td6leKstBboUo3mA/+QOZSk/qIEgw0zCsNob2So+5ABxkVb7
	/Wjb1mIXRMltbIOtv1iSpQ35SP8a9nOlnSIkaqlo6rNJRwaYX0+lNhTYRiaZDZpemP9/alb+TJj
	WK2Y9lq7DkWvFod/VV8g0qdIMVKSEoEzZo191HhRdRlbPPT8hLzVk8ALwUmfb3xKm/hi76sfrwi
	zz5aDNuUMcZ5HQd8/liyRulGNNtZ5fvoFiBRvqG1DCD3xMa1bkA8nPwAhr1AGkgobNeSaFyRQnH
	x4ZwsLD8WaFsSGahStR4hSK/Y9CheeSEw==
X-Received: by 2002:a17:903:b0d:b0:2ae:5598:1db3 with SMTP id d9443c01a7336-2ae55982a32mr46227035ad.53.1772518437154;
        Mon, 02 Mar 2026 22:13:57 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:56 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:13:04 +0000
Subject: [PATCH 12/12] HID: spi-hid: add quirkis to support mode switch for
 Ilitek touch
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-12-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=7060;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=RuF4EBelwWjX4MVB7wRAKwjHLIyH356VR5EZd3QmjHw=;
 b=yqf3lINoDU5izp7XLxBncUEfy96hR5Uvs/pFDvxmmcHDmeFoqVujMRkAE6X/GypO/8SUjW/3o
 lT326CxlFyPDmz4HEgVb+PXKKZ5GIdZgPXaG1pCF1ZDP2sH2scC1goy
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add quirks to support mode switch among Ilitek normal, debug and test mode
and allow delay before send output reports.
Add a shared variable to configure response timeout value for Ilitek
touch controllers.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 84 +++++++++++++++++++++++++++++++++++++-
 drivers/hid/spi-hid/spi-hid-core.h |  4 ++
 drivers/hid/spi-hid/spi-hid.h      |  6 +++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 893a0d4642d2..736e51f10cfc 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -22,6 +22,7 @@
 
 #include <linux/completion.h>
 #include <linux/crc32.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -45,9 +46,14 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#include "../hid-ids.h"
 #include "spi-hid.h"
 #include "spi-hid-core.h"
 
+/* quirks to control the device */
+#define SPI_HID_QUIRK_MODE_SWITCH	BIT(0)
+#define SPI_HID_QUIRK_READ_DELAY	BIT(1)
+
 /* Protocol constants */
 #define SPI_HID_READ_APPROVAL_CONSTANT		0xff
 #define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
@@ -86,6 +92,16 @@
 #define SPI_HID_CREATE_DEVICE	4
 #define SPI_HID_ERROR	5
 
+static const struct spi_hid_quirks {
+	__u16 idVendor;
+	__u16 idProduct;
+	__u32 quirks;
+} spi_hid_quirks[] = {
+	{ USB_VENDOR_ID_ILITEK, HID_ANY_ID,
+		SPI_HID_QUIRK_MODE_SWITCH | SPI_HID_QUIRK_READ_DELAY },
+	{ 0, 0 }
+};
+
 /* Processed data from input report header */
 struct spi_hid_input_header {
 	u8 version;
@@ -112,6 +128,27 @@ struct spi_hid_output_report {
 
 static struct hid_ll_driver spi_hid_ll_driver;
 
+/**
+ * spi_hid_lookup_quirk: return any quirks associated with a SPI HID device
+ * @idVendor: the 16-bit vendor ID
+ * @idProduct: the 16-bit product ID
+ *
+ * Returns: a u32 quirks value.
+ */
+static u32 spi_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
+{
+	u32 quirks = 0;
+	int n;
+
+	for (n = 0; spi_hid_quirks[n].idVendor; n++)
+		if (spi_hid_quirks[n].idVendor == idVendor &&
+		    (spi_hid_quirks[n].idProduct == (__u16)HID_ANY_ID ||
+		     spi_hid_quirks[n].idProduct == idProduct))
+			quirks = spi_hid_quirks[n].quirks;
+
+	return quirks;
+}
+
 static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
 					    u8 *header_buf, u8 *body_buf)
 {
@@ -382,6 +419,9 @@ static int spi_hid_send_output_report(struct spi_hid *shid,
 	u8 padding;
 	int error;
 
+	if (shid->quirks & SPI_HID_QUIRK_READ_DELAY)
+		usleep_range(2000, 2100);
+
 	guard(mutex)(&shid->output_lock);
 	if (report->content_length > shid->desc.max_output_length) {
 		dev_err(dev, "Output report too big, content_length 0x%x.",
@@ -406,18 +446,38 @@ static int spi_hid_send_output_report(struct spi_hid *shid,
 	return error;
 }
 
+static const u32 spi_hid_get_timeout(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	u32 timeout;
+
+	timeout = READ_ONCE(shid->ops->response_timeout_ms);
+
+	if (timeout < SPI_HID_RESP_TIMEOUT || timeout > 10000) {
+		dev_dbg(dev, "Response timeout is out of range, using default %d",
+			SPI_HID_RESP_TIMEOUT);
+		timeout = SPI_HID_RESP_TIMEOUT;
+	}
+
+	return timeout;
+}
+
 static int spi_hid_sync_request(struct spi_hid *shid,
 				struct spi_hid_output_report *report)
 {
 	struct device *dev = &shid->spi->dev;
+	u32 timeout = SPI_HID_RESP_TIMEOUT;
 	int error;
 
 	error = spi_hid_send_output_report(shid, report);
 	if (error)
 		return error;
 
+	if (shid->quirks & SPI_HID_QUIRK_MODE_SWITCH)
+		timeout = spi_hid_get_timeout(shid);
+
 	error = wait_for_completion_interruptible_timeout(&shid->output_done,
-							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
+							  msecs_to_jiffies(timeout));
 	if (error == 0) {
 		dev_err(dev, "Response timed out.");
 		return -ETIMEDOUT;
@@ -561,6 +621,8 @@ static int spi_hid_create_device(struct spi_hid *shid)
 	hid->vendor = shid->desc.vendor_id;
 	hid->product = shid->desc.product_id;
 
+	shid->quirks = spi_hid_lookup_quirk(hid->vendor, hid->product);
+
 	snprintf(hid->name, sizeof(hid->name), "spi %04X:%04X",
 		 hid->vendor, hid->product);
 	strscpy(hid->phys, dev_name(&shid->spi->dev), sizeof(hid->phys));
@@ -836,6 +898,24 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 		goto out;
 	}
 
+	if (shid->quirks & SPI_HID_QUIRK_MODE_SWITCH) {
+		/*
+		 * Update reset_pending on mode transitions inferred from
+		 * response timeout (entering/exiting a mode).
+		 */
+		u32 timeout = spi_hid_get_timeout(shid);
+		bool mode_enabled = timeout > SPI_HID_RESP_TIMEOUT;
+
+		if (mode_enabled != shid->prev_mode_enabled) {
+			if (mode_enabled)
+				set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+			else
+				clear_bit(SPI_HID_RESET_PENDING, &shid->flags);
+		}
+
+		shid->prev_mode_enabled = mode_enabled;
+	}
+
 	if (shid->input_message.status < 0) {
 		dev_warn(dev, "Error reading header: %d.",
 			 shid->input_message.status);
@@ -1190,6 +1270,8 @@ static int spi_hid_dev_init(struct spi_hid *shid)
 	struct device *dev = &spi->dev;
 	int error;
 
+	shid->ops->custom_init(shid->ops);
+
 	shid->ops->assert_reset(shid->ops);
 
 	shid->ops->sleep_minimal_reset_delay(shid->ops);
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 88e9020d37aa..8441dbad95d4 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -62,6 +62,10 @@ struct spi_hid {
 	u16 response_length;
 	u16 bufsize;
 
+	bool prev_mode_enabled;	/* Previous device mode tracked for SPI_HID_QUIRK_MODE_SWITCH. */
+
+	unsigned long quirks;	/* Various quirks. */
+
 	enum hidspi_power_state power_state;
 
 	u8 reset_attempts;	/* The number of reset attempts. */
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index 5651c7fb706a..3c0369bdb4ab 100644
--- a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -25,6 +25,9 @@ struct spi_hid_conf {
  * @power_down: do sequencing to power down the device
  * @assert_reset: do sequencing to assert the reset line
  * @deassert_reset: do sequencing to deassert the reset line
+ * @sleep_minimal_reset_delay: minimal sleep delay during reset
+ * @custom_init: customized device init
+ * @response_timeout_ms: output report response timeout in ms
  */
 struct spihid_ops {
 	int (*power_up)(struct spihid_ops *ops);
@@ -32,6 +35,9 @@ struct spihid_ops {
 	int (*assert_reset)(struct spihid_ops *ops);
 	int (*deassert_reset)(struct spihid_ops *ops);
 	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
+	int (*custom_init)(struct spihid_ops *ops);
+
+	u32 response_timeout_ms;
 };
 
 int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,

-- 
2.53.0.473.g4a7958ca14-goog

