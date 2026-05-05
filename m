Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C563CFF48
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957223; cv=none; b=PqF+lbtMRI2xAatq6Cw8CVurrfAFWAnN/MPYJnrKcnpwl2cmqaKLuS9jgGwGGWsBkaAVg0R4TbyZd0ZYKIBnbb1St650fSIePVZ4sG6zCwO3SODo3GT7EQnisfqtjtEn0thPXyZgOVFZOXn8MmG6rNgXSDVjgVq6WZWNAwXDko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957223; c=relaxed/simple;
	bh=vOZr8E6d+Ct5ei4QbGCEnKUd9VQnIb4DLJavJQZjEVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDurtp0b2aQmxzpkvAA5MUsrHG7eh5Ujt0pis4J18Eqv/UvBVd2KRDE+bb4onClkVGaoDbap9loZ0DwAwSy5JmzAmiPnl3zwqC4hCzL/Q9IOBQH07NzYO3WILGRImekqaRzE1ZlbP/dHahxYN6Y/Kx/319na3/Qt9zKylvI4etA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUg5ovtB; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUg5ovtB"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12dca45ca21so6478653c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957220; x=1778562020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7XtBd5QdRW8akjANHG0GJFuNhgmqRyOfs64M/w+ez0=;
        b=hUg5ovtBHIpiUqdv2w2yVwdXqaibeQQcwZ2cEA6VVc+T9pm+ntr7L3eTlKrHntUq5y
         gInrWICU3mnKdR71BLVz6ux4WXAvDfccgDD0oaBIfG01VGtfcRs1TruBH2nNlKdRa1iU
         JTHnatMaLKRy7rnL+BrfXYHL6xpv5Xyp/0VO1lbN3o+eHfR3tDz1exoDvMkjdtXpDDJD
         IBeUgWwzYC8zJb34vG+bm9XltjCgC3gLEWTiqVYVNCdVMauX6mGeGvcZggiC+Lu6EGU/
         D0IF9NCZS+TvVO+rwhjCLrB2pdAQ22hTBCNCk8Ty96xgMsDtn9UZCNTKVasb5NnML1tu
         BFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957220; x=1778562020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7XtBd5QdRW8akjANHG0GJFuNhgmqRyOfs64M/w+ez0=;
        b=Xy5CORzlrvAes7z25q8tozfXQr4Rthfx+rFtDQetgez2cRyYMvLTwPXEkW2avtMCZe
         afzIVMBUoGpvJIpXYO9lyhQNESGmTEwZ+ZMdjfLmav3hWAzzTsLx76nsBCIm6YlqALnp
         pCRSEY1Kj6aol87cvUg8E5rhRtk+bB8WSTfYL/hQ4DfrR2CdmVvJQNDC5ArsaEqB2io6
         sZ0B+E3h7hYv1XFjhnExkvE5bGcberzkdQp/ALdNhaOKF+gzIzJYYB9YN+MVrgbpZ3b6
         McXj5LAdAI2MJLPtztbM75XUYR6lHGFU+T1Ko8ROJkBty3YX5dgOUORT9jDHz/+4I+xx
         IxhA==
X-Gm-Message-State: AOJu0YxfeipUZPDdVc4oRGJBWaxJC3C7oFG1d1cqllMEr3O02QpbMpO1
	DkqV/GoXehhanXGmsdwptfPPRU+TsoPNwcZ2mjftSFPJN6W1CbnpRDYebcRnTw==
X-Gm-Gg: AeBDietUkzYO8EcKjJWrOxqyI5xdkqXrcXbFWsSP81Bg8+6vLZgpjvmKIKzsjakYyoE
	JThJrHY+nWxeLQGvoRvd6pdZu+CgOgFEqGRLW3AS7sPUG2OQjJRYS4xf//1+n0wmYRai+gVjSN3
	A7Zn+a4+2rmWqyNRnlAZVKBLm24DicoopEc8vZo7juFOIH5wOGx4TgiCTPwSRWi+/5zg/U0vUHH
	OAn4BfJuLeEG/rgQFmcUsR42odSQMRzqtYZg0wSu1BcMYkukJW/nd65YIVPlCiZPWxc2T+K8z/G
	+uepCFcmqtGeG946jVY8ziXxQ7uby6aj8Orj5slwBpaUKS1dJHUXHETioYQLvRsfE4etxVwLCvK
	q/xH9782mENFVCeM84XFAyy4eMVYRvuPQi3qaPpegEin+FIWntpVP/yQZXLVErOaA2zhlGRb2e3
	b1Yx2vv/5X1WvfdZ8uRY0N4XnDnn+BDFkabJ2/JSUC/GohhNdw5e8bnWdmmhgjjjuXjF9u5XInt
	YyG123kn2QOu6EddOyVv+Bdeg==
X-Received: by 2002:a05:7022:160a:b0:130:ab68:2b5e with SMTP id a92af1059eb24-130b163fb9fmr784101c88.4.1777957220136;
        Mon, 04 May 2026 22:00:20 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:19 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/20] Input: rmi4 - change reg_size type to u32
Date: Mon,  4 May 2026 21:59:43 -0700
Message-ID: <20260505045952.1570713-13-dmitry.torokhov@gmail.com>
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

Change reg_size from unsigned long to u32 to save space and ensure
consistent size across 32-bit and 64-bit architectures, and use
DECLARE_BITMAP() for subpacket_map.

Also pack the structure by rearranging the members to avoid holes,
and use size_add() to prevent potential integer overflows when
calculating the total size of registers.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_2d_sensor.h |  4 ++--
 drivers/input/rmi4/rmi_driver.c    |  4 ++--
 drivers/input/rmi4/rmi_driver.h    |  5 ++---
 drivers/input/rmi4/rmi_f11.c       |  2 +-
 drivers/input/rmi4/rmi_f12.c       | 25 +++++++++++++++++++------
 5 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.h b/drivers/input/rmi4/rmi_2d_sensor.h
index 61a99c8a7a26..f9d9c1dd5eb0 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.h
+++ b/drivers/input/rmi4/rmi_2d_sensor.h
@@ -56,8 +56,8 @@ struct rmi_2d_sensor {
 	u16 max_y;
 	u8 nbr_fingers;
 	u8 *data_pkt;
-	int pkt_size;
-	int attn_size;
+	u32 pkt_size;
+	u32 attn_size;
 	bool topbuttonpad;
 	enum rmi_sensor_type sensor_type;
 	struct input_dev *input;
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index aae4a9bb76fb..6416c1d97a6d 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -713,7 +713,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		offset += item_size;
 
 		rmi_dbg(RMI_DEBUG_CORE, &d->dev,
-			"%s: reg: %d reg size: %ld subpackets: %d\n", __func__,
+			"%s: reg: %d reg size: %u subpackets: %d\n", __func__,
 			item->reg, item->reg_size, item->num_subpackets);
 
 		reg = find_next_bit(presence_map,
@@ -746,7 +746,7 @@ size_t rmi_register_desc_calc_size(struct rmi_register_descriptor *rdesc)
 
 	for (i = 0; i < rdesc->num_registers; i++) {
 		item = &rdesc->registers[i];
-		size += item->reg_size;
+		size = size_add(size, item->reg_size);
 	}
 	return size;
 }
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index b93905a6a43a..abeafb77a483 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -52,11 +52,10 @@ struct pdt_entry {
 
 /* describes a single packet register */
 struct rmi_register_desc_item {
+	u32 reg_size;
 	u16 reg;
-	unsigned long reg_size;
 	u16 num_subpackets;
-	unsigned long subpacket_map[BITS_TO_LONGS(
-				RMI_REG_DESC_SUBPACKET_BITS)];
+	DECLARE_BITMAP(subpacket_map, RMI_REG_DESC_SUBPACKET_BITS);
 };
 
 /*
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 49ca9168685a..9ade74b36edb 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1304,7 +1304,7 @@ static irqreturn_t rmi_f11_attention(int irq, void *ctx)
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 	u16 data_base_addr = fn->fd.data_base_addr;
 	int error;
-	int valid_bytes = f11->sensor.pkt_size;
+	u32 valid_bytes = f11->sensor.pkt_size;
 
 	if (drvdata->attn_data.data) {
 		/*
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 973288103b6a..b179980003f1 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -5,6 +5,7 @@
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/rmi.h>
+#include <linux/sizes.h>
 #include "rmi_driver.h"
 #include "rmi_2d_sensor.h"
 
@@ -118,7 +119,7 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 
 	if (item->reg_size > sizeof(buf)) {
 		dev_err(&fn->dev,
-			"F12 control8 should be no bigger than %zd bytes, not: %ld\n",
+			"F12 control8 should be no bigger than %zd bytes, not: %u\n",
 			sizeof(buf), item->reg_size);
 		return -ENODEV;
 	}
@@ -256,7 +257,7 @@ static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
 	struct rmi_2d_sensor *sensor = &f12->sensor;
-	int valid_bytes = sensor->pkt_size;
+	u32 valid_bytes = sensor->pkt_size;
 
 	if (drvdata->attn_data.data) {
 		if (sensor->attn_size > drvdata->attn_data.size)
@@ -310,7 +311,7 @@ static int rmi_f12_write_control_regs(struct rmi_function *fn)
 			 * on the existence of subpacket 0. If control 20 is
 			 * larger then 3 bytes, just read the first 3.
 			 */
-			control_size = min(item->reg_size, 3UL);
+			control_size = min(item->reg_size, 3U);
 
 			ret = rmi_read_block(rmi_dev, fn->fd.control_base_addr
 					+ control_offset, buf, control_size);
@@ -379,7 +380,8 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	struct rmi_2d_sensor *sensor;
 	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
-	u16 data_offset = 0;
+	size_t data_offset = 0;
+	size_t pkt_size;
 	int mask_size;
 	int i;
 
@@ -431,7 +433,12 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	sensor = &f12->sensor;
 	sensor->fn = fn;
 	f12->data_addr = fn->fd.data_base_addr;
-	sensor->pkt_size = rmi_register_desc_calc_size(&f12->data_reg_desc);
+	pkt_size = rmi_register_desc_calc_size(&f12->data_reg_desc);
+	if (pkt_size > SZ_1M) {
+		dev_err(&fn->dev, "Invalid data packet size: %zu\n", pkt_size);
+		return -EINVAL;
+	}
+	sensor->pkt_size = pkt_size;
 
 	sensor->axis_align =
 		f12->sensor_pdata.axis_align;
@@ -444,7 +451,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		sensor->sensor_type =
 			f12->sensor_pdata.sensor_type;
 
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %d\n", __func__,
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %u\n", __func__,
 		sensor->pkt_size);
 	sensor->data_pkt = devm_kzalloc(&fn->dev, sensor->pkt_size, GFP_KERNEL);
 	if (!sensor->data_pkt)
@@ -471,6 +478,12 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		if (drvdata->attn_data.data && i != 1 && i != 5)
 			continue;
 
+		if (data_offset > U16_MAX) {
+			dev_err(&fn->dev, "Invalid offset for data%d: %zu\n",
+				i, data_offset);
+			return -EINVAL;
+		}
+
 		switch (i) {
 		case 1:
 			f12->data1 = item;
-- 
2.54.0.545.g6539524ca2-goog

