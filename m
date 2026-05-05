Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44D3BFE5C
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957238; cv=none; b=JSSSZwk7loNrcJZBTymj+CTkLMHy8HO8IWCgSbT5JDG7tAR17SrOMZeDqUVJ62ILuRm3wtNdd5Rd2yaek+zlWX19FizITHyFLkjq1nXsSkhG3azPptNeMom/Rf3bQoNYQXznGIJxKJe8jmDojSgf2Ue51I7okZfwlh8UPO1wEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957238; c=relaxed/simple;
	bh=rYyrtkS1s3v08J9XuxN1618fd5a2rPbK4DeoCZTfexo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jymrEP40Mfz4dxNM3qcxzDaSw3sDVbk6kUxCdpgIEIPhmKMgOlqocKvfmcbtwYRb5NDR3uK+IOj29vRk0RKi1LW3+Pvgeh7EAnTe90AXghsHr0J+ACg1NGXPDXm98gSBWHPnooex1V20o3Cv9HbKn6lfAo08Roy5T9y75OdTxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw9sRp+F; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw9sRp+F"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-130c653cce4so60507c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957236; x=1778562036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uaJ7LWkWOPRSzpB3wqarxvxz0jK9evZYaIV3Ue+Tj8=;
        b=hw9sRp+F/LHWCLeRra0UT29WalInzq/FMsFF4um0QrDcFId1uEWIoggPsHyCpHIsGj
         CUAcPsMZZx5Hlm2bK+KpKP8UMqIDExhuTPlqI7vyV/LTzXw0mCI1uLA3CfR9lIXLvmKI
         4QhEj7AlGPRgtOkCChI+LK1BZwG8nzOtNb+GRLVuurSxzznxDoRTzX8GOn7TadZ6WZq6
         QmnxEGL9cSRiBqsji+1x4VrRqkoEoRzDp6/9StO+BdotQWE9Z76vTbyI8FLs0vnf+0ch
         njl2GugRWZavGUDRfzWErerl53Y2ggNyWG3uYDMn6wLgFT4NvGukVSnP89LPPoHxQEAa
         KLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957236; x=1778562036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/uaJ7LWkWOPRSzpB3wqarxvxz0jK9evZYaIV3Ue+Tj8=;
        b=Twp6uaebSWqiKw5arJLolk6IAOhfFimWsGwxfDUgOLfXdRsJmfnpYf04fp3AaYoJ6N
         Kt4qNadRdib/jpiNzUYmW/afOR4A9bIuQYLyj3vRyENWRtCub+HGFz7C94KzfExj8eW+
         jJvmpn8p4BN81VRJTfJ5iArZlOKhx8u1Jux/2zWiNt+rbkD2Bq2k7foz/BDgn7D+DoLs
         WvaFV2ckrKm6zyfPnrHXrXWd7qhijimOMFB1g0fV84uJ9kJ4CrZcDUb4bJCvKbNKYNvN
         ABl4qDCoVr9nmTlV6nslSpxe8yRsgo27mJDxkpvilLo9aPNiqVMvmfD6vwv7JnDjj0xQ
         1Cmw==
X-Gm-Message-State: AOJu0Yw5H/AGBJyyjpF6qYjWKBWwO7xAmyyrOo56mGiuYcSPCXV5yCPb
	Mjhzg7QXPhtsT8TKMuzkkvEaalrb360pyOrItpPDiedYzLf4c8qi3zBqRPP2Cg==
X-Gm-Gg: AeBDieu2FZUJGil92VuH+gm36P6pKdoUZ0AMRk9+MM8lJVIFcJB2/zgJX8ceoqTcW7u
	vVvIXJorYmeWDb0t+o26sbOezmfvz4x9zO/NrM0c4T9IGYWIrlggiALDRph0sHlfuOoA9/YktCo
	uGHcM6kmF0XgjW+MsXu8g+5v/JSnkNms7QjLMJ+gBIgvYzMrRgAQWjB3d/Il5+tXCV9T23zrEb0
	H/an6jJTOm6339tfArczwbop3rWeLciMIXmZ9Bkh3YqHHEQUiYQxYEuCsPoq/6zNqoLzTpj4vwi
	aFuL4xGeIqBW+bM5/ZV5Rkq71dUP77Aq5qTgOecvc5PNLrp+XcMAY4yaF30UUeSZ9+LLrWgPT/x
	g0D3K2BRucuFajVdxHZ5FjS9g7Ym2dPm64Z/OYlIpQtlj0nTMOgviw/Aa6qAlT/UEWvbQyzVzoN
	SzK8DwuiZ19DIKz9SmGlO7yzhftqFt76l40CS4y01dC6xLmTtdjb8F4NkOGzi6fXmBpadCutfXp
	Bq4mUtdKBMjjOx3c+vTN9Z1WQ==
X-Received: by 2002:a05:701a:c94e:b0:119:e56b:c75b with SMTP id a92af1059eb24-12dfd85eb0dmr5821126c88.32.1777957235380;
        Mon, 04 May 2026 22:00:35 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:33 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/20] Input: rmi4 - update formatting in F12
Date: Mon,  4 May 2026 21:59:50 -0700
Message-ID: <20260505045952.1570713-20-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up various style and formatting issues in the F12 code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 120 +++++++++++++++++------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index bf8c4a0e10de..88c28089de99 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -51,7 +51,6 @@ struct f12_data {
 	const struct rmi_register_desc_item *data6;
 	u16 data6_offset;
 
-
 	/* F12 Data9 reports relative data */
 	const struct rmi_register_desc_item *data9;
 	u16 data9_offset;
@@ -124,8 +123,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 		return -ENODEV;
 	}
 
-	ret = rmi_read_block(rmi_dev, fn->fd.control_base_addr + offset, buf,
-				item->reg_size);
+	ret = rmi_read_block(rmi_dev, fn->fd.control_base_addr + offset,
+			     buf, item->reg_size);
 	if (ret)
 		return ret;
 
@@ -163,7 +162,7 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	if (rmi_get_register_desc_item(&f12->query_reg_desc,
 				       RMI_F12_QUERY_RESOLUTION)) {
 		offset = rmi_register_desc_calc_reg_offset(&f12->query_reg_desc,
-						RMI_F12_QUERY_RESOLUTION);
+							   RMI_F12_QUERY_RESOLUTION);
 		query_dpm_addr = fn->fd.query_base_addr	+ offset;
 		ret = rmi_read(fn->rmi_dev, query_dpm_addr, buf);
 		if (ret) {
@@ -248,18 +247,17 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, u32 size)
 
 static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 {
-	int retval;
 	struct rmi_function *fn = ctx;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
 	struct rmi_2d_sensor *sensor = &f12->sensor;
 	u32 valid_bytes = sensor->pkt_size;
+	int retval;
 
 	if (drvdata->attn_data.data) {
 		valid_bytes = min_t(u32, sensor->attn_size, drvdata->attn_data.size);
-		memcpy(sensor->data_pkt, drvdata->attn_data.data,
-			valid_bytes);
+		memcpy(sensor->data_pkt, drvdata->attn_data.data, valid_bytes);
 		drvdata->attn_data.data += valid_bytes;
 		drvdata->attn_data.size -= valid_bytes;
 	} else {
@@ -273,70 +271,74 @@ static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 	}
 
 	if (f12->data1)
-		rmi_f12_process_objects(f12,
-			&sensor->data_pkt[f12->data1_offset], valid_bytes);
+		rmi_f12_process_objects(f12, &sensor->data_pkt[f12->data1_offset],
+					valid_bytes);
 
 	input_mt_sync_frame(sensor->input);
 
 	return IRQ_HANDLED;
 }
 
-static int rmi_f12_write_control_regs(struct rmi_function *fn)
+static int rmi_f12_update_dribble(struct rmi_function *fn, struct f12_data *f12)
 {
-	int ret;
 	const struct rmi_register_desc_item *item;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
-	int control_size;
-	char buf[3];
-	u16 control_offset = 0;
 	u8 subpacket_offset = 0;
+	u16 control_offset;
+	u32 control_size;
+	int error;
+	u8 buf[3];
 
-	if (f12->has_dribble
-	    && (f12->sensor.dribble != RMI_REG_STATE_DEFAULT)) {
-		item = rmi_get_register_desc_item(&f12->control_reg_desc, 20);
-		if (item) {
-			control_offset = rmi_register_desc_calc_reg_offset(
-						&f12->control_reg_desc, 20);
-
-			/*
-			 * The byte containing the EnableDribble bit will be
-			 * in either byte 0 or byte 2 of control 20. Depending
-			 * on the existence of subpacket 0. If control 20 is
-			 * larger then 3 bytes, just read the first 3.
-			 */
-			control_size = min(item->reg_size, 3U);
-
-			ret = rmi_read_block(rmi_dev, fn->fd.control_base_addr
-					+ control_offset, buf, control_size);
-			if (ret)
-				return ret;
-
-			if (rmi_register_desc_has_subpacket(item, 0))
-				subpacket_offset += 1;
-
-			switch (f12->sensor.dribble) {
-			case RMI_REG_STATE_OFF:
-				buf[subpacket_offset] &= ~BIT(2);
-				break;
-			case RMI_REG_STATE_ON:
-				buf[subpacket_offset] |= BIT(2);
-				break;
-			case RMI_REG_STATE_DEFAULT:
-			default:
-				break;
-			}
+	item = rmi_get_register_desc_item(&f12->control_reg_desc, 20);
+	if (!item)
+		return 0;
 
-			ret = rmi_write_block(rmi_dev,
-				fn->fd.control_base_addr + control_offset,
-				buf, control_size);
-			if (ret)
-				return ret;
-		}
+	control_offset = rmi_register_desc_calc_reg_offset(&f12->control_reg_desc, 20);
+
+	/*
+	 * The byte containing the EnableDribble bit will be
+	 * in either byte 0 or byte 2 of control 20. Depending
+	 * on the existence of subpacket 0. If control 20 is
+	 * larger then 3 bytes, just read the first 3.
+	 */
+	control_size = min(item->reg_size, 3U);
+
+	error = rmi_read_block(rmi_dev, fn->fd.control_base_addr + control_offset,
+			       buf, control_size);
+	if (error)
+		return error;
+
+	if (rmi_register_desc_has_subpacket(item, 0))
+		subpacket_offset += 1;
+
+	switch (f12->sensor.dribble) {
+	case RMI_REG_STATE_OFF:
+		buf[subpacket_offset] &= ~BIT(2);
+		break;
+	case RMI_REG_STATE_ON:
+		buf[subpacket_offset] |= BIT(2);
+		break;
+	case RMI_REG_STATE_DEFAULT:
+	default:
+		break;
 	}
 
+	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr + control_offset,
+				buf, control_size);
+	if (error)
+		return error;
+
 	return 0;
+}
 
+static int rmi_f12_write_control_regs(struct rmi_function *fn)
+{
+	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
+
+	if (f12->has_dribble && f12->sensor.dribble != RMI_REG_STATE_DEFAULT)
+		return rmi_f12_update_dribble(fn, f12);
+
+	return 0;
 }
 
 static int rmi_f12_config(struct rmi_function *fn)
@@ -362,7 +364,7 @@ static int rmi_f12_config(struct rmi_function *fn)
 	ret = rmi_f12_write_control_regs(fn);
 	if (ret)
 		dev_warn(&fn->dev,
-			"Failed to write F12 control registers: %d\n", ret);
+			 "Failed to write F12 control registers: %d\n", ret);
 
 	return 0;
 }
@@ -433,16 +435,14 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	}
 	sensor->pkt_size = pkt_size;
 
-	sensor->axis_align =
-		f12->sensor_pdata.axis_align;
+	sensor->axis_align = f12->sensor_pdata.axis_align;
 
 	sensor->x_mm = f12->sensor_pdata.x_mm;
 	sensor->y_mm = f12->sensor_pdata.y_mm;
 	sensor->dribble = f12->sensor_pdata.dribble;
 
 	if (sensor->sensor_type == rmi_sensor_default)
-		sensor->sensor_type =
-			f12->sensor_pdata.sensor_type;
+		sensor->sensor_type = f12->sensor_pdata.sensor_type;
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %u\n", __func__,
 		sensor->pkt_size);
-- 
2.54.0.545.g6539524ca2-goog

