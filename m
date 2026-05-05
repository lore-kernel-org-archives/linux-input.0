Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A1824A3
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957227; cv=none; b=oDqcKBMhIyzLnLBhz2CxI4Yxy5wQeIV/JxMdupzlvWCZmG7A/F6rffUlkTdFoNCxeltfIee6iWEyztYUmV0PdYqW7U1FXhtW7KbXY0BDsR4lS0VtpCFjoAEsjlDHHy07Vn42271TnJFHnGqe9nr7cqvyN5HZnkRonYhtUSrDD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957227; c=relaxed/simple;
	bh=XKXhp2PYjeUjK/lLoRSHxtPOlk4BUHxMq7GSeBcodAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7G3kGlTAlbQcvc9B4saQkD4bQvwNjAGGbbo6FJp/bngDZBTvmhBoMRlsZ4i8O9o6/wA+3M8bHzBi1RkROur7n0UgBFrh6Lt5opzgVPs3k2xlZL0phLU2hOKdu+x9P2YuPirMqncxE9buGfxBpm3btOpq+tRvM5v5d2c96WCe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWa1yoKv; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWa1yoKv"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12dfbcc0703so5023731c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957225; x=1778562025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM0LUXFU/CXLJcTNmTZrhP+neNgrwKc7IQkU5qqbQwQ=;
        b=KWa1yoKv/tNsWpCKVF3Z/uvIFe9s6tsw3eyxjs9b5uzEoiDqu+liblg/ruPefgYV59
         vOIWivXgI9OlBBu2JT34tPkmca6shHpWcowFcOjcAwm2lv8ZFeEtqMbTI7UgRreya9y8
         rVOHY04+z/n/rMiaStY+Fwb8zLTtuKl/ton1XnTjkGo5wnoOlq/84Oz06q1nLApDZido
         vVijgitl5apg0nOui2oSlSX9WZQEwaGgFZhiqI/LwXrscRzCmqE6xpOnU6aLTTZMcDnc
         4nc9634vZLD/FwSsW2ab1+QjeWajL7l/9/2YJ5O9SbDolReGlWlqLZCbG9rFmYAPVoRR
         bSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957225; x=1778562025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zM0LUXFU/CXLJcTNmTZrhP+neNgrwKc7IQkU5qqbQwQ=;
        b=EKeNdIqqOKS/GYbfWV6nsW1qazfqg6kre4b8lJnZgVrX6BbHUcAHhme55YtqBCu7Wh
         Lg4yWWUNQDzc0Aez5x9aX86MpGKARLaBxTiWxAiS1TLoqEVHkUn4NNc40+mUbeVdGFHY
         XgL7pX/WWxD3NM/hCY9oiVG/8RIFfbtzbr7Gtoq/0sUgnJTs7md3QK4IH897MGT5azGt
         sNrLayaXD9JxEUfv+UVU+3hBnr84MElh1fRF+b7ezb6sG27LjASRLUqPtWLXWaz1fgcV
         BZQtg4Eo/kCkutmsFlY+0Ra9jnmKDzNzYTECZT5gQX5Ed97ybE0Kz96vn/gUh/sZeQZ7
         IFQA==
X-Gm-Message-State: AOJu0YylPQe7SFB6kcBaijXARKz02Xh1vn2DQyN9rkGXrimKqsUmhR/f
	AnoRZfp9hkyxmdr0DUoJ/el4fVfMy7o5A+3qBXV8P5cdy/fgUJvgfUp4nV0a2A==
X-Gm-Gg: AeBDiesGywCv2j/X9uiftwgUC0yi9SjuZaxC8c32sxWKGhdYnYOqhqp9l/fdGpVhZFe
	k3qTNECQrmDJf+f1MUZS0wYvU8BvDPFS35zz8swUINJAAsMmVxlxHPM7A3QEYyspbooCfsiowD6
	xqYEEziUuTYmLZRGTK6rU+65Kd3dWtQyZ58OAiOejcVgfss+f+Uuz5DyKp+TbXVVHE4GJXtxnwO
	AvzduXATysDvqPm/yceMCHqUCbP7ce4haUOu47pHR62IsLul2CNxaZ5ZSJFw6vIzEFjro/uNKyo
	Vca4Fwjf1UPqMzUioeBiDKM1+lUtSvfGQVTXY9DYdg3iX/0Eq4Hwprq7S6OxU3Bcb5//sGTqu1u
	lV1BJzaUcXhtEgPee0NXL247AEycvNo2pnzHccxlD6X2ZiXbObbsRjoy3fvntXQTJoENRG+lxVd
	esf/gaAp2vU9CL8m4Qvv/4F2sDjJ2yzPavA/3yjSW6khv6p5Gc4JFLycl/vmxi1SSWcfeeJT03x
	SG5+4hGfcRPXq+PTm3uT7Vh3A==
X-Received: by 2002:a05:7022:629e:b0:128:d967:466c with SMTP id a92af1059eb24-12dfd830b8emr6078876c88.24.1777957224923;
        Mon, 04 May 2026 22:00:24 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:22 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/20] Input: rmi4 - use flexible array member for IRQ masks in F12
Date: Mon,  4 May 2026 21:59:45 -0700
Message-ID: <20260505045952.1570713-15-dmitry.torokhov@gmail.com>
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

Use a flexible array member to allocate the IRQ masks at the end of
the f12_data structure, and use the struct_size() helper to
calculate the allocation size safely. This replaces manual pointer
arithmetic.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 752c1d137da0..b9cd70422b68 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -59,8 +59,7 @@ struct f12_data {
 	const struct rmi_register_desc_item *data15;
 	u16 data15_offset;
 
-	unsigned long *abs_mask;
-	unsigned long *rel_mask;
+	unsigned long irq_mask[];
 };
 
 static int rmi_f12_read_register_descs(struct rmi_function *fn,
@@ -350,17 +349,21 @@ static int rmi_f12_config(struct rmi_function *fn)
 {
 	struct rmi_driver *drv = fn->rmi_dev->driver;
 	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&fn->rmi_dev->dev);
+	int irq_mask_size = BITS_TO_LONGS(drvdata->irq_count);
+	unsigned long *abs_mask = f12->irq_mask;
+	unsigned long *rel_mask = f12->irq_mask + irq_mask_size;
 	struct rmi_2d_sensor *sensor;
 	int ret;
 
 	sensor = &f12->sensor;
 
 	if (!sensor->report_abs)
-		drv->clear_irq_bits(fn->rmi_dev, f12->abs_mask);
+		drv->clear_irq_bits(fn->rmi_dev, abs_mask);
 	else
-		drv->set_irq_bits(fn->rmi_dev, f12->abs_mask);
+		drv->set_irq_bits(fn->rmi_dev, abs_mask);
 
-	drv->clear_irq_bits(fn->rmi_dev, f12->rel_mask);
+	drv->clear_irq_bits(fn->rmi_dev, rel_mask);
 
 	ret = rmi_f12_write_control_regs(fn);
 	if (ret)
@@ -383,12 +386,12 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	size_t data_offset = 0;
 	size_t pkt_size;
-	int mask_size;
+	int irq_mask_size;
 	int i;
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s\n", __func__);
 
-	mask_size = BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned long);
+	irq_mask_size = BITS_TO_LONGS(drvdata->irq_count);
 
 	ret = rmi_read(fn->rmi_dev, query_addr, &buf);
 	if (ret < 0) {
@@ -404,18 +407,13 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		return -ENODEV;
 	}
 
-	f12 = devm_kzalloc(&fn->dev, sizeof(struct f12_data) + mask_size * 2,
-			GFP_KERNEL);
+	f12 = devm_kzalloc(&fn->dev, struct_size(f12, irq_mask, irq_mask_size * 2),
+			   GFP_KERNEL);
 	if (!f12)
 		return -ENOMEM;
 
-	f12->abs_mask = (unsigned long *)((char *)f12
-			+ sizeof(struct f12_data));
-	f12->rel_mask = (unsigned long *)((char *)f12
-			+ sizeof(struct f12_data) + mask_size);
-
-	set_bit(fn->irq_pos, f12->abs_mask);
-	set_bit(fn->irq_pos + 1, f12->rel_mask);
+	set_bit(fn->irq_pos, f12->irq_mask);
+	set_bit(fn->irq_pos + 1, f12->irq_mask + irq_mask_size);
 
 	f12->has_dribble = !!(buf & BIT(3));
 
-- 
2.54.0.545.g6539524ca2-goog

