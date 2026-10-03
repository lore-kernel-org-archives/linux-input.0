Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4A2E7367;
	Sat,  3 Oct 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037677; cv=none; b=cecZLtTu7T2H9HO+RLr7QCeWcCIiyEvdQKP5NOkyt6aXrEzkWJ2g7w2e424wn9cDsD++YtwShAziBuhe4UUiKMXEo90i18ngKbnwM1u4ajTScDOUF4QyHipYSvpW8+85yV9Bf1wcmWt58QrS9x4ViMPMqYdn2ixB2AxsR+Bi5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037677; c=relaxed/simple;
	bh=XqCWkgfqw+hMDm3yM9yHPr8Mh9uRobz+FUj5vmgfGzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJ9n2I296i566gDHN9mjp/n2Vnj6m11PzFCchHTJgLggBHbfaTdLTN384AlCcnsmOVxLPnDAvtPKT7SApRGqfqtZKoDTVDWN3Ngki3e21/y9q1YMQIS1Idz67ZdQWxN/pMUjSMtWr2nN5l9fEihpVFolqpib1UXMBgIrhgERfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=gNR1hzBM; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="gNR1hzBM"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791037674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4icjsWdDNkFPI9eCM7uyv38hNANdJsnlkRLB77xRkU=;
	b=gNR1hzBMANQJtp5eKwFLNMI/JAJCj/zB4hjVIa03gke5UjqsZSjQlOdgoXI3utwQnWxNvl
	bVAgWQvJ9F3b95nWfzzgnCFY9hNCZsSe4Yvk9lb2cCjGRalafrIY/W4vqxUAZrT7O1SAJv
	Zl94AIVh6jyKGKrJ95DUfU1VShlZH8BSVVwgfrHxRURkC0FaLjqkQ4+cZndEsclg2SFU9T
	vUixe6mZ543af2DCnhZ5SR84yIvUdUMniTphj40qAq7VH3/ZlVZEcmSM4l3W6wwZ81usUe
	Mp4xAODyyqaC59HlpjAehxtE+TJ6RcWu+fpXEs3TklgJUrFi2/fXX6cHEfaG9A==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Allen Lin <allencl_lin@hotmail.com>,
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
	Felix Kaechele <felix@kaechele.ca>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v5 5/6] HID: himax: Report the touch and heatmap data
Date: Sat,  3 Oct 2026 16:27:40 +0200
Message-ID: <20261003142741.48634-6-michal@nozomi.space>
In-Reply-To: <20261003142741.48634-1-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the HX83102J firmware on Ciri, every interrupt delivers a frame
with the touch report, the stylus report and a heatmap. The driver only
passed the stylus report to HID core, so touches were never reported.
The firmware report descriptor also declares the heatmap as input
report 97, and hid-multitouch rejected the frames that did not carry it
in full, after which the driver reset the controller over and over.

Report the touch report as well, and size the transfer buffer for the
heatmap that follows the stylus report. The IC packs the heatmap as
12-bit values, while report 97 declares 16-bit ones, so unpack it into
a separate buffer before reporting it.

The heatmap handling is based on Tylor Yang's change to the ChromeOS
kernel driver.

Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5326106
Co-developed-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 drivers/hid/hid-himax.c | 51 +++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-himax.h |  6 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
index 533d7be629147..40abae724743d 100644
--- a/drivers/hid/hid-himax.c
+++ b/drivers/hid/hid-himax.c
@@ -2150,6 +2150,37 @@ static void himax_hid_remove(struct himax_ts_data *ts)
 	ts->hid = NULL;
 }
 
+/**
+ * himax_decompress_heatmap() - Unpack the heatmap into its HID report
+ * @ts: Himax touch screen data
+ * @src: Heatmap as read from the event stack
+ *
+ * The IC packs two 12-bit heatmap values into three bytes, while the HID
+ * report descriptor of the firmware declares 16-bit values. Copy the report
+ * ID and heatmap info header, then widen every pair of values to the
+ * little-endian 16-bit layout of the report.
+ *
+ * Return: None
+ */
+static void himax_decompress_heatmap(struct himax_ts_data *ts, const u8 *src)
+{
+	u32 i;
+	u32 count = ts->ic_data.rx_num * ts->ic_data.tx_num;
+	const u32 header_size = HIMAX_HEAT_MAP_INFO_SZ + 1;
+	u8 *dst = ts->heatmap_buf;
+
+	memcpy(dst, src, header_size);
+	for (i = 0; i < count; i += 2) {
+		const u8 *packed = src + header_size + i * 3 / 2;
+		u8 *unpacked = dst + header_size + i * 2;
+
+		unpacked[0] = packed[0];
+		unpacked[1] = packed[2] >> 4;
+		unpacked[2] = packed[1];
+		unpacked[3] = packed[2] & 0x0f;
+	}
+}
+
 /**
  * himax_ts_operation() - Process the touch interrupt data
  * @ts: Himax touch screen data
@@ -2175,6 +2206,10 @@ static int himax_ts_operation(struct himax_ts_data *ts)
 	if (ret == HIMAX_TS_GET_DATA_FAIL)
 		return ret;
 	if (ts->hid_probed) {
+		ret = himax_hid_report(ts,
+				       ts->xfer_buf + HIMAX_HID_REPORT_HDR_SZ,
+				       ts->hid_desc.max_input_length -
+				       HIMAX_HID_REPORT_HDR_SZ);
 		offset = ts->hid_desc.max_input_length;
 		if (ts->ic_data.stylus_function) {
 			ret += himax_hid_report(ts,
@@ -2183,6 +2218,11 @@ static int himax_ts_operation(struct himax_ts_data *ts)
 						HIMAX_HID_REPORT_HDR_SZ);
 			offset += ts->hid_desc.max_input_length;
 		}
+		himax_decompress_heatmap(ts,
+					 ts->xfer_buf + offset + HIMAX_HID_REPORT_HDR_SZ);
+		ret += himax_hid_report(ts, ts->heatmap_buf,
+					(ts->ic_data.rx_num * ts->ic_data.tx_num * 2) +
+					HIMAX_HEAT_MAP_INFO_SZ + 1);
 	}
 
 	if (ret != 0)
@@ -2322,6 +2362,9 @@ static int himax_hid_report_data_init(struct himax_ts_data *ts)
 	ts->touch_data_sz = ts->hid_desc.max_input_length;
 	if (ts->ic_data.stylus_function)
 		ts->touch_data_sz += ts->hid_desc.max_input_length;
+	ts->heatmap_data_size = ts->ic_data.rx_num * ts->ic_data.tx_num * 3 / 2;
+	ts->touch_data_sz += HIMAX_HEAT_MAP_HEADER_SZ +
+			     HIMAX_HEAT_MAP_INFO_SZ + ts->heatmap_data_size;
 	if (ts->touch_data_sz != ts->xfer_buf_sz) {
 		kfree(ts->xfer_buf);
 		ts->xfer_buf_sz = 0;
@@ -2331,6 +2374,14 @@ static int himax_hid_report_data_init(struct himax_ts_data *ts)
 		ts->xfer_buf_sz = ts->touch_data_sz;
 	}
 
+	if (!ts->heatmap_buf) {
+		ts->heatmap_buf = devm_kzalloc(ts->dev,
+					       ts->ic_data.rx_num * ts->ic_data.tx_num * 2 +
+					       HIMAX_HEAT_MAP_INFO_SZ + 1, GFP_KERNEL);
+		if (!ts->heatmap_buf)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/hid/hid-himax.h b/drivers/hid/hid-himax.h
index 71599520b8006..3582f8e00ef1b 100644
--- a/drivers/hid/hid-himax.h
+++ b/drivers/hid/hid-himax.h
@@ -52,6 +52,8 @@
 #define HIMAX_ZF_PARTITION_DESC_SZ			16U
 /* HIDRAW report header size */
 #define HIMAX_HID_REPORT_HDR_SZ				2U
+#define HIMAX_HEAT_MAP_HEADER_SZ			3U
+#define HIMAX_HEAT_MAP_INFO_SZ				20U
 /* hx83102j IC parameters */
 #define HIMAX_HX83102J_DSRAM_SZ				73728U
 #define HIMAX_HX83102J_FLASH_SIZE			261120U
@@ -392,11 +394,13 @@ struct himax_platform_data {
  * @xfer_buf: Interrupt data buffer
  * @xfer_rx_data: SPI Transfer receive data buffer
  * @xfer_tx_data: SPI Transfer transmit data buffer
+ * @heatmap_buf: Decompressed heatmap HID report
  * @zf_update_cfg_buffer: Zero flash update configuration buffer
  * @himax_irq: IRQ number
  * @chip_max_dsram_size: Maximum size of DSRAM
  * @spi_xfer_max_sz: Size of SPI controller max transfer size
  * @xfer_buf_sz: Size of interrupt data buffer
+ * @heatmap_data_size: Packed heatmap data size
  * @irq_state: IRQ state
  * @irq_lock: Spin lock for irq
  * @initialized: Indicate the driver is initialized
@@ -424,11 +428,13 @@ struct himax_ts_data {
 	u8 *xfer_buf;
 	u8 *xfer_rx_data;
 	u8 *xfer_tx_data;
+	u8 *heatmap_buf;
 	u8 *zf_update_cfg_buffer;
 	s32 himax_irq;
 	u32 chip_max_dsram_size;
 	u32 spi_xfer_max_sz;
 	u32 xfer_buf_sz;
+	u32 heatmap_data_size;
 	atomic_t irq_state;
 	/* lock for irq_save */
 	spinlock_t irq_lock;
-- 
2.55.0

