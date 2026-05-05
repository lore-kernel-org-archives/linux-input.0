Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EB3D332B
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957226; cv=none; b=NrT0egYDhZlPdch6o6TGpai/KF+xOPju2+xsFu0/Lmz7XZK+IpfWJBkVUi/bs0SI63NXHhrsAx1si2nEQ4UbCo2jcEOMQ2GuA8C4qA7K4W/J7J9VdJ9v/sZUHeiykftL+mu0Sm1O6G5ra77uVpl9JXjjDzSqXVWW0ESKNT1GwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957226; c=relaxed/simple;
	bh=/XcQ/vHrQKND6P1keM0qbILLtaIrPDLZPJklV8CW56s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQnEJ1/D366cj8A4Lqo/23e9c0PCXBzDvhHoYlDex5jgU2hntORTAB20Nxxm/Q//cYZNFFPRyXnQJe45kYZ2ns0K2XrGzKqYkdPggHdSlkYcIU8OHW8aptPW3JL3+Br1yhx/0QZt0Rmu0thl7f8kN0g4vLlCiebD0rwZVryFysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtunkJYK; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtunkJYK"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-130c653cce4so60169c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957223; x=1778562023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrRIUSCQHk+6yCp7kcAAyv8TYXxHCFqbx+b4o8R1yqo=;
        b=TtunkJYKeDQPDbegv03r/+VZwMfL4fHi1Zx4fnswEaTKKBj10m0aHmCu5L523i1z6+
         NSiJRcDpPHDkTv5HyxZbFfyKS7Z8Nl2iCRD0QWWr63mCenVHc7rKFSB6Luu1ed6FUMv0
         4+rdGSdA9gc96rw6K2TJhYfg0hC0ac7m4MLhP+6pLdZZ8G5uuT5gkEsLRw2yJqcDlIW1
         hG96G0zF7p4tbjIfy0KwbbSNMLv4XNFB2eVdqOoRDbIRva4VbwagvYXdDnZe3KXMNwqU
         4U7j06oiv8WfEoHBDZtcf3SxASkhTvKOoN2AgYpOOOM3m9all4YuGSNB5vonoy+VGjCJ
         W+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957223; x=1778562023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MrRIUSCQHk+6yCp7kcAAyv8TYXxHCFqbx+b4o8R1yqo=;
        b=IrckfJm6FoYf5bTi3woo/SLynnMpe+NN/UcsdKCwF8UHq/oZz4Dz8jKjKejbiuvnXo
         6rMJhfP26BECMd+s5oxNRjHU0YAJ88rGwKqUN4ujoZNEGJ60woICt9F+cuh73wGIg7/+
         B8uQggeDOEcIav7IamNbLYjIwxQ90vNS1PY+diHTTeWH3tW+F+Mc+37myY/CLXyobQak
         Pn1pA8dHn26Gbz0ptTDhoWJz6fRHTa6LJbIFdFIHE9BUt9OrVWh6gdGfjhpXzOqqDixl
         wWqGf6mU0cG5S0hxA+xV2jsdMbnQBWqczlnbof0s0icuubcD4bPGwgp70ac3efctnlGp
         RXJg==
X-Gm-Message-State: AOJu0Yym/T1fkUETT1cjD0AwhlDnz79ez8UDYLlclhN6plqedVlNKJ3a
	7Ch4mWeOKAQYNA4Sk8N9h/wiNy1Hq7LlbbNL84+1M9bn/NbhLrpZTV2LY3sKlA==
X-Gm-Gg: AeBDiesxmtcaR8hXChFRVCDO7FToleaJ0ktczF0kSbc1ZyC4M5kD3lI4WRCBdaJCObr
	8mzQ9pV/32Hb0SxhP0LRuBqP6yugqlhBH4wLsPLdJmOD3npZY52gR9tQ/GVuOtD9+T7pWlzVBKR
	LcCZCbjZoUirfzDMqtuM4Vs45YZOf5RSXTw50yGz2nOu29wqiyT5IHJ1ZOYvKYObzGn4pIoxCjr
	XHlaXqc8+2zoBOzQClakY/wAIO2kYcOWwvuMFUX2R7VhoxU/xCvmGSxFgnFqTRFk44Gx9A+J5Yi
	6eRNHr4CmAEK1MIpluD6y8fZB/4GMmGV5VDMOTkZFDmMNOKYKb+U9iqNKyFDpmUizgCai7v14y7
	70CMSa/oUqaCsRotFWXHJogZhOyj2X/Sfg56zn2o2RdrMxtrTgLhOnsH9hSq3wKrWMbFuRK8H07
	BlcI+xJ9Fo79DOmxSyuiisoGbE0bQrbgrToODAk/D9K6TL/0WsvsJB2jsBPtYNrVTz3Cblrzw/U
	hbJyDy7QRLPvJeIodmo4LQTZw==
X-Received: by 2002:a05:7022:78f:b0:12a:713b:8964 with SMTP id a92af1059eb24-12dfd7ec572mr5932633c88.11.1777957218594;
        Mon, 04 May 2026 22:00:18 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:17 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/20] Input: rmi4 - refactor F12 probe function
Date: Mon,  4 May 2026 21:59:42 -0700
Message-ID: <20260505045952.1570713-12-dmitry.torokhov@gmail.com>
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

The F12 probe function contains highly repetitive logic for parsing
register descriptors and their individual data items. Refactor the
function to use loops to eliminate redundancy, and clarify the code.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 197 ++++++++++++++---------------------
 1 file changed, 81 insertions(+), 116 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index c2b07c6905d7..973288103b6a 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -61,6 +61,36 @@ struct f12_data {
 	unsigned long *rel_mask;
 };
 
+static int rmi_f12_read_register_descs(struct rmi_function *fn,
+				       struct f12_data *f12, u16 query_addr)
+{
+	struct {
+		struct rmi_register_descriptor *desc;
+		const char *name;
+	} descriptors[] = {
+		{ &f12->query_reg_desc, "Query" },
+		{ &f12->control_reg_desc, "Control" },
+		{ &f12->data_reg_desc, "Data" },
+	};
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	int error;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(descriptors); i++) {
+		error = rmi_read_register_desc(rmi_dev, query_addr,
+					       descriptors[i].desc);
+		if (error) {
+			dev_err(&fn->dev,
+				"Failed to read the %s Register Descriptor: %d\n",
+				descriptors[i].name, error);
+			return error;
+		}
+		query_addr += 3;
+	}
+
+	return 0;
+}
+
 static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 {
 	const struct rmi_register_desc_item *item;
@@ -351,6 +381,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	u16 data_offset = 0;
 	int mask_size;
+	int i;
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s\n", __func__);
 
@@ -393,35 +424,9 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		f12->sensor_pdata = pdata->sensor_pdata;
 	}
 
-	ret = rmi_read_register_desc(rmi_dev, query_addr,
-					&f12->query_reg_desc);
-	if (ret) {
-		dev_err(&fn->dev,
-			"Failed to read the Query Register Descriptor: %d\n",
-			ret);
-		return ret;
-	}
-	query_addr += 3;
-
-	ret = rmi_read_register_desc(rmi_dev, query_addr,
-						&f12->control_reg_desc);
-	if (ret) {
-		dev_err(&fn->dev,
-			"Failed to read the Control Register Descriptor: %d\n",
-			ret);
-		return ret;
-	}
-	query_addr += 3;
-
-	ret = rmi_read_register_desc(rmi_dev, query_addr,
-						&f12->data_reg_desc);
-	if (ret) {
-		dev_err(&fn->dev,
-			"Failed to read the Data Register Descriptor: %d\n",
-			ret);
+	ret = rmi_f12_read_register_descs(fn, f12, query_addr);
+	if (ret)
 		return ret;
-	}
-	query_addr += 3;
 
 	sensor = &f12->sensor;
 	sensor->fn = fn;
@@ -452,101 +457,61 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		return ret;
 
 	/*
-	 * Figure out what data is contained in the data registers. HID devices
-	 * may have registers defined, but their data is not reported in the
-	 * HID attention report. Registers which are not reported in the HID
-	 * attention report check to see if the device is receiving data from
-	 * HID attention reports.
+	 * Identify available data registers and calculate their offsets within
+	 * the attention report. For HID devices, only Data1 and Data5 are
+	 * included in the report; other registers may be described but are
+	 * not transmitted in the attention packet and thus skipped here.
 	 */
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 0);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 1);
-	if (item) {
-		f12->data1 = item;
-		f12->data1_offset = data_offset;
-		data_offset += item->reg_size;
-
-		if (item->num_subpackets > 255) {
-			dev_err(&fn->dev, "Too many fingers declared: %d\n",
-				item->num_subpackets);
-			return -EINVAL;
-		}
-
-		sensor->nbr_fingers = item->num_subpackets;
-		sensor->report_abs = 1;
-		sensor->attn_size += item->reg_size;
-	}
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 2);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 3);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 4);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 5);
-	if (item) {
-		f12->data5 = item;
-		f12->data5_offset = data_offset;
-		data_offset += item->reg_size;
-		sensor->attn_size += item->reg_size;
-	}
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 6);
-	if (item && !drvdata->attn_data.data) {
-		f12->data6 = item;
-		f12->data6_offset = data_offset;
-		data_offset += item->reg_size;
-	}
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 7);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 8);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
-
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 9);
-	if (item && !drvdata->attn_data.data) {
-		f12->data9 = item;
-		f12->data9_offset = data_offset;
-		data_offset += item->reg_size;
-		if (!sensor->report_abs)
-			sensor->report_rel = 1;
-	}
+	for (i = 0; i < 16; i++) {
+		item = rmi_get_register_desc_item(&f12->data_reg_desc, i);
+		if (!item)
+			continue;
+
+		/* HID attention reports only contain Data1 and Data5 */
+		if (drvdata->attn_data.data && i != 1 && i != 5)
+			continue;
+
+		switch (i) {
+		case 1:
+			f12->data1 = item;
+			f12->data1_offset = data_offset;
+
+			if (item->num_subpackets > 255) {
+				dev_err(&fn->dev,
+					"Too many fingers declared: %d\n",
+					item->num_subpackets);
+				return -EINVAL;
+			}
 
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 10);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
+			sensor->nbr_fingers = item->num_subpackets;
+			sensor->report_abs = 1;
+			sensor->attn_size += item->reg_size;
+			break;
 
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 11);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
+		case 5:
+			f12->data5 = item;
+			f12->data5_offset = data_offset;
+			sensor->attn_size += item->reg_size;
+			break;
 
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 12);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
+		case 6:
+			f12->data6 = item;
+			f12->data6_offset = data_offset;
+			break;
 
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 13);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
+		case 9:
+			f12->data9 = item;
+			f12->data9_offset = data_offset;
+			if (!sensor->report_abs)
+				sensor->report_rel = 1;
+			break;
 
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 14);
-	if (item && !drvdata->attn_data.data)
-		data_offset += item->reg_size;
+		case 15:
+			f12->data15 = item;
+			f12->data15_offset = data_offset;
+			break;
+		}
 
-	item = rmi_get_register_desc_item(&f12->data_reg_desc, 15);
-	if (item && !drvdata->attn_data.data) {
-		f12->data15 = item;
-		f12->data15_offset = data_offset;
 		data_offset += item->reg_size;
 	}
 
-- 
2.54.0.545.g6539524ca2-goog

