Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BC3B1EC6;
	Sat, 27 Jun 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782572195; cv=none; b=YAxSQWDLqGvrEKKP2dNR1ZP7CNGDqcXbBtXOJ9WxmDvp6JbO+oEQ5TsWWZbw7OM+XGnslaH2j/xdp4kGrvPKU4KUDS3zO2yAdt6a4l963YR/3oH7Y4CkRPFb3K8Q5Su54ZVoB5NrAZpli1sA2LyQghWKr3LqEC1VGWLLFugazxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782572195; c=relaxed/simple;
	bh=sWecVut9IO1UNFSzN7N6qoxmebQ+iLq73k5eThwkTa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aMlv3oVwa6YpsRtGQzVeOX7M2nZw3udb6omYJekbUDSEglv66nUkpOzvaSrIOTBHcl5V9UgqJkRP+wxE6WVKKoMwixIy3OzxZwHS/9SpWGoEMqFewSR4PopBpub6/FBu0JlxypDgct6vK3WFHg8sYf5gi+eJeWV3VUL3Fe+xP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAKcXYG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAKcXYG/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE447C2BCB3;
	Sat, 27 Jun 2026 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782572195;
	bh=sWecVut9IO1UNFSzN7N6qoxmebQ+iLq73k5eThwkTa0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WAKcXYG/V977Q2BqBpWrGJ3eofILvA6j/pX9ImGrDM3QQ9/WangvtFrUhhprP/kc3
	 1YsQgNMaBfDTyQckKM8DthsC5rn8RZDSF2GlzTaLGnaZ5/FsPH9tFJd3imFdQk68+g
	 hut6WRn4yqgHZpQcctopQHrQayR6LEQYaJ9x1xDr4CDdAvaHQ0jYSUAbqYWTErgH0N
	 G7JcyrwBvb55CquH1uUL7D0RA9Q2YWPmNOtLRQjbXjf8BKJ0guhVUkseaM2YT7y8Xp
	 uY+GPrdXtaR6wtKMJZLYoMUtVkqHU/ATAL6vNLmMj6rbeN5KCahpQ7561dVDrsjyp0
	 jlOPNft7bBevg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB74C43458;
	Sat, 27 Jun 2026 14:56:34 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 27 Jun 2026 16:56:32 +0200
Subject: [PATCH] Input: rmi4 - Move sensor initialization into own function
 for F12
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-synaptics-rmi4-fnsplit-v1-1-14a96f4ac4df@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAJ/kP2oC/x3MTQqEMAxA4atI1gZqlfpzFXHR6UQNaC1NkRHx7
 pZZfov3bhCKTAJDcUOkk4UPn1GVBbjV+oWQv9mglTbK6Bbl8jYkdoJx5wZnL2HjhLXpO2u0+rS
 1gxyHSDP//uNxep4XyvzviGgAAAA=
X-Change-ID: 20260627-synaptics-rmi4-fnsplit-3698a620b73c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=QDJN7B9WH2UFwNDJgEJB7okxE7kCxvUO/EcFvb1axfQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqP+ShNex8lRrkCpn1FHVpp3Zxd9XCCV74OEnWl
 RK8/9LF3QmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaj/koQAKCRBgAj/E00kg
 clksD/kBI6CFHNZirEBK3tKhbjb0t9IgG37H1Pgid85G9GUPiCdBoypvbJYeZhnl+hpiojlkSdv
 TSeqAmpqwgCMU1MzclJMIIwDEcE090StT0jsFQGb96gcMo0UAGknAR22k8/CCoqmaLFi0ZiV2CP
 MW60OEDRs/t9uFpEz67ZB2POWx4Nj06glrtIMroAwJl2yj4Jl03e1uYK3uprRmz2H1YkdkBgYDa
 TqwTaxTDRiR7wH1lxrmbDts2f4K0Dnp8/mhN/UDueKkN90pf8ZPsinU1RCUgsneZw34JjHwlU8R
 E8NYu8mmQVyWlLS0sIs1kgylUbdwgYpUfuyIYKichnzZZiOd+cmj8S2+n2GDCmXEvGoZ9Zrk7ys
 8q2zMNi39KnoqxL4c6VyqPuvy375SrxWd42/5XFp0d5gW371bJx1kKiwFoYpw10VxtuI5yYFIPz
 1bKeTQH4kuWLViMdMDbi1Pgn1hZqa5PJ5i7yiXDpGuTXihXRfSMwI2X6ZNPPjCIWIm460w9Anmc
 DwsD+XUGmzqb1ptsyXHxr7K7lvD/F50h1eUWe0oz5ruydyu6hbK7p0SqUEC/GvB9J/8V2ckvb8Q
 8BzFljjh7bibY7s33VjySDXiltJ3MGNeHb9xKBWnjqVIXuaHoywLKqNMmNapuYDXoNwR7NlYZow
 ZlMLIHLs5bK4MJg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Makes rmi_f12_probe function a bit cleaner and more structured.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_f12.c | 58 ++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 88c28089de993..333477bf0663e 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -364,29 +364,60 @@ static int rmi_f12_config(struct rmi_function *fn)
 	ret = rmi_f12_write_control_regs(fn);
 	if (ret)
 		dev_warn(&fn->dev,
 			 "Failed to write F12 control registers: %d\n", ret);
 
 	return 0;
 }
 
+static int rmi_f12_sensor_init(struct rmi_function *fn, struct f12_data *f12)
+{
+	struct rmi_2d_sensor *sensor = &f12->sensor;
+	size_t pkt_size;
+
+	sensor->fn = fn;
+	f12->data_addr = fn->fd.data_base_addr;
+	pkt_size = rmi_register_desc_calc_size(&f12->data_reg_desc);
+	if (pkt_size > SZ_1M) {
+		dev_err(&fn->dev, "Invalid data packet size: %zu\n", pkt_size);
+		return -EINVAL;
+	}
+	sensor->pkt_size = pkt_size;
+
+	sensor->axis_align = f12->sensor_pdata.axis_align;
+
+	sensor->x_mm = f12->sensor_pdata.x_mm;
+	sensor->y_mm = f12->sensor_pdata.y_mm;
+	sensor->dribble = f12->sensor_pdata.dribble;
+
+	if (sensor->sensor_type == rmi_sensor_default)
+		sensor->sensor_type = f12->sensor_pdata.sensor_type;
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %u\n", __func__,
+		sensor->pkt_size);
+	sensor->data_pkt = devm_kmalloc(&fn->dev, sensor->pkt_size, GFP_KERNEL);
+	if (!sensor->data_pkt)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int rmi_f12_probe(struct rmi_function *fn)
 {
 	struct f12_data *f12;
 	int ret;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	char buf;
 	u16 query_addr = fn->fd.query_base_addr;
 	const struct rmi_register_desc_item *item;
 	struct rmi_2d_sensor *sensor;
 	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	size_t data_offset = 0;
-	size_t pkt_size;
 	int irq_mask_size;
 	int i;
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s\n", __func__);
 
 	irq_mask_size = BITS_TO_LONGS(drvdata->irq_count);
 
 	ret = rmi_read(fn->rmi_dev, query_addr, &buf);
@@ -421,39 +452,20 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		f12->sensor_pdata = pdata->sensor_pdata;
 	}
 
 	ret = rmi_f12_read_register_descs(fn, f12, query_addr);
 	if (ret)
 		return ret;
 
 	sensor = &f12->sensor;
-	sensor->fn = fn;
-	f12->data_addr = fn->fd.data_base_addr;
-	pkt_size = rmi_register_desc_calc_size(&f12->data_reg_desc);
-	if (pkt_size > SZ_1M) {
-		dev_err(&fn->dev, "Invalid data packet size: %zu\n", pkt_size);
-		return -EINVAL;
-	}
-	sensor->pkt_size = pkt_size;
-
-	sensor->axis_align = f12->sensor_pdata.axis_align;
 
-	sensor->x_mm = f12->sensor_pdata.x_mm;
-	sensor->y_mm = f12->sensor_pdata.y_mm;
-	sensor->dribble = f12->sensor_pdata.dribble;
-
-	if (sensor->sensor_type == rmi_sensor_default)
-		sensor->sensor_type = f12->sensor_pdata.sensor_type;
-
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %u\n", __func__,
-		sensor->pkt_size);
-	sensor->data_pkt = devm_kmalloc(&fn->dev, sensor->pkt_size, GFP_KERNEL);
-	if (!sensor->data_pkt)
-		return -ENOMEM;
+	ret = rmi_f12_sensor_init(fn, f12);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(&fn->dev, f12);
 
 	ret = rmi_f12_read_sensor_tuning(f12);
 	if (ret)
 		return ret;
 
 	/*

---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260627-synaptics-rmi4-fnsplit-3698a620b73c

Best regards,
-- 
David Heidelberg <david@ixit.cz>


