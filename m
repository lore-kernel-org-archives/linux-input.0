Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2707263C8C;
	Sun, 14 Jun 2026 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409677; cv=none; b=tpOATwJ5LckpN2vK33951b4jsDAY+kQBhEz4H6z0zd1K67ZsZgG4cI6hH0n792ZVIbhT/mZE/MwqewxKA3/PCAK9UgSOlzYSQ3R6EFvM+RiRt74h4sNS+VD3MjIwud0NEBiWQ9bFbNLk0IcWNpvnjhhc6UUESKrQbkzJG1UPWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409677; c=relaxed/simple;
	bh=aL42zk5j0bjHeo8BU0zIH10nFddFtJ1Y+qFwl6oSzsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I7IirlI2VreV7gXzPSYyTHBBq4F6ecRK+mThEzdMwfyMj/lRkfwHhrE1u8Q7Sc0xml2FKumgSb5Ttbk85QwU2fWG2K6tChADhKyr2Gj3NlLUS2GJtwQ/2zGIiHEGDX7DL8sI9C8mhji9IDnVjG3Iqi3YcwOoWV1aaTB/Sz6GiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/jgGpLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/jgGpLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B2C8C2BCC7;
	Sun, 14 Jun 2026 04:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781409677;
	bh=aL42zk5j0bjHeo8BU0zIH10nFddFtJ1Y+qFwl6oSzsg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=j/jgGpLZT7n9wfTa77+9DmqNGojP1Q8JhA9vXmAPMrrMJ1xL4MLV8n9OeW5LQ7Xrf
	 qeSQy9h+P54lipwXk1kEDMZs+/S6yj6xzYW1qiFV8LPr7T05BIDM+jtVN2WGo5SI/u
	 xBNH+mgMiCF+fBCbcAotPQtXOhxBaNChqrToohGvhLvxUUlJgDmVyPUEpRp4cXZOVr
	 sofBRNI0e+p9vF1eReEsKwGDIVUWomNODCyTKOwfAJqG6MMZC/pq34fq96SJvFw7ED
	 lCO4Rt6gLnB3qEuhX/5yP/Vjg3rO1L5+5+39tAsLk+9g7WjrkmUlYgHkov5Gz5LOw0
	 YkjZo2AY8u+pQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A89CCD8CA8;
	Sun, 14 Jun 2026 04:01:17 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 13 Jun 2026 23:01:16 -0500
Subject: [PATCH] Input: synaptics-rmi4 - bound the F54 report size to the
 allocated buffer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-b4-disp-6721686c-v1-1-4d5bb84ee520@proton.me>
X-B4-Tracking: v=1; b=H4sIAIsnLmoC/x3MMQqAMAxA0atIZgNtI1G8ijjUNmqWKi2IIN7d4
 viG/x8oklUKjM0DWS4teqQK2zYQdp82QY3V4Ixjw5Zw6TBqOZF7Z3nggESeluhDXGmAmp1ZVr3
 /5TS/7wcbhn6zYgAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781409675; l=4630;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=sNbCJ52oiyGr4TBOccsRGX4oDsTWqoiOMNGFe75RiB0=;
 b=FzlqKEOczHlHZZE4f2sdpxbPy29RzKHQqiGMPW6NtJer2YdpRUsH6SFqpUBEBYLhw0G7vE6ea
 Wp3qpygDa79AyrUTbWZ59CvmfDXyHyH9fIPM32nhu6QdNT7pP4TVwg4
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

rmi_f54_work() reads a diagnostics report from the device into
f54->report_data, sizing the transfer with rmi_f54_get_report_size():

	report_size = rmi_f54_get_report_size(f54);
	...
	for (i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
		int size = min(F54_REPORT_DATA_SIZE, report_size - i);
		...
		rmi_read_block(.., f54->report_data + i, size);
	}

report_data is allocated once at probe from F54's own electrode counts
(array3_size(f54->num_tx_electrodes, f54->num_rx_electrodes, sizeof(u16))),
but rmi_f54_get_report_size() computes the size from
drv_data->num_*_electrodes when those are set, i.e. from the F55
function's electrode counts. Both counts come straight from device
queries (F54 and F55 each report up to 255 electrodes) and nothing
constrains the F55 counts to the F54 ones.

A malicious or malfunctioning RMI4 device that reports larger F55
electrode counts than its F54 counts makes report_size exceed the
allocation, so the read loop writes past report_data (and the V4L2
dequeue memcpy() then reads past it). On conforming hardware the F55
configured electrodes are a subset of the F54 physical electrodes, so
report_size never exceeds the buffer and well-behaved devices are
unaffected.

Record the allocation size and reject a report that does not fit,
mirroring the existing zero-size check.

Fixes: c762cc68b6a1 ("Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reachable from a malicious or counterfeit RMI4 peripheral (HID/I2C/SPI)
that exposes both an F54 diagnostics function and an F55 sensor-tuning
function reporting more electrodes than F54; the report is filled when a
local client drives an F54 capture through the V4L2 touch device node.

Verified with an in-kernel KASAN litmus that allocates report_data from
the F54 dims and fills it from the F55-preferred dims (the verbatim
rmi_f54_get_report_size() preference and the rmi_f54_work() 32-byte read
loop), Linux 7.1.0-rc5, CONFIG_KASAN=y, kasan.fault=panic, x86_64:

  Arm A, F54 8x8 (capacity 128) vs F55 8x24 (report_size 384):
    BUG: KASAN: slab-out-of-bounds in ... Write of size 32
    located 0 bytes to the right of the allocated 128-byte region
    ... cache kmalloc-128 of size 128
    Kernel panic - not syncing: kasan.fault=panic set
  Arm B, with this patch (oversize report rejected): clean
  Arm C, conforming device (F55 dims == F54 dims): clean

  AddressSanitizer (x86_64 and i386): heap-buffer-overflow WRITE of size 32,
  0 bytes after the 128-byte region.

The same rmi_f54_get_report_size() value drives the V4L2 dequeue
memcpy(.., report_size) on the read side, so an oversize report also
over-reads report_data; rejecting it in rmi_f54_work() (report_size then
stays 0) closes both. Reproducer and full logs available on request.

This is independent of the in-flight "Input: rmi4 - release F54 queue on
video registration failure" change, which touches only the probe error
path (vb2_queue_release in rmi_f54_probe); it applies cleanly alongside it.
---
 drivers/input/rmi4/rmi_f54.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 61909e1a39e2..7a7508a4de85 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -104,6 +104,7 @@ struct f54_data {
 
 	enum rmi_f54_report_type report_type;
 	u8 *report_data;
+	size_t report_data_size;
 	int report_size;
 
 	bool is_busy;
@@ -548,6 +549,13 @@ static void rmi_f54_work(struct work_struct *work)
 		goto error;     /* retry won't help */
 	}
 
+	if (report_size > f54->report_data_size) {
+		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
+			report_size, f54->report_data_size);
+		error = -EINVAL;
+		goto error;
+	}
+
 	/*
 	 * Need to check if command has completed.
 	 * If not try again later.
@@ -678,8 +686,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
 
 	rx = f54->num_rx_electrodes;
 	tx = f54->num_tx_electrodes;
-	f54->report_data = devm_kzalloc(&fn->dev,
-					array3_size(tx, rx, sizeof(u16)),
+	f54->report_data_size = array3_size(tx, rx, sizeof(u16));
+	f54->report_data = devm_kzalloc(&fn->dev, f54->report_data_size,
 					GFP_KERNEL);
 	if (f54->report_data == NULL)
 		return -ENOMEM;

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260613-b4-disp-6721686c-33a3bdacdf38

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


