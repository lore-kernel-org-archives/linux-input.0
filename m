Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F7305057
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758331; cv=none; b=ZNHxpd48rHCAtRam9P2878f0eWFPO6RIloZ/LLDNuJ+q+5GufAulrVRAv/E+uXelCTA15Tc/uArrV4ZqsNe+vyYnRDIVMrTENOBhrOpM2aPdDVrvJOiYHzd16vDcq9ETpwqberqk0j++QqJunGXBo8ykcrdKeZPhIgMafwxwA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758331; c=relaxed/simple;
	bh=5eyF2S7ViTpP1C7easdlz2xSG10ngTk27LKK60dNnt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZQBiqtmszs4/e1IBX9xVXr6s3Ep574r/V9qJZqscstU0d6m2Dmnc5WYV8kvmJ/MIU+EetIz/K/OBQVG1Nxnrxq8XwDRWKiaYHJqsiJQCW2Kbk8uXPnKK+BlJHo/ZiMAcTvVfkjz5FHVPyMIr939MujfLMWquMSEwcaOn6CAc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMgzhZVs; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMgzhZVs"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13807d2f898so1616272c88.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780758330; x=1781363130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDvvIEJ397Z9hz/fjkFik69Td5t/Laz7R7T1FL6xIOQ=;
        b=IMgzhZVsmse/rKO+/jmbUK6hsIqLyIefjhObsNDHWQIWAntOhG23iKWC4vBNtEYBQE
         FSgmziwlWYv2o39Zn2w5jvB2KeIK6SyBLhQniJavJO+G1uKJLESfgU2L5q6XbHznsYkS
         utFEr3DT5ZVRxEVLAeSD3QO/DH22UIWvSwxU/bSisnEkGjumfUR1R6GJGYqnYbAh53CR
         FZ5dxWtQMDrwfOnRbH1fkpofpTiIdhen5K91def5CmdKuLqNfNWX4n2+biMnl4ND1w0J
         ETGGCynrT3pkj+HyV5VjAHj2nv2s0ZTbJcJn7ExAEm3acC9sJ059vKxQiAcHZ67CDq0U
         a/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758330; x=1781363130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDvvIEJ397Z9hz/fjkFik69Td5t/Laz7R7T1FL6xIOQ=;
        b=Q0bB1siJAGSUxx9Uir2Pk2u/hN+SbDda3iW2qciQq1ihR1VXzokZoTLCugVjWzdlzE
         YuuHZ3vYW70mvO6TE+xgPSXenYP6vat5WXrYjN7ur7vt57h9Datn5VheIB2JhTfzBhXk
         XuChuePLySJPy1b9iV6NZwwemU5slslfTy5Jfp7UxaWp1ayOO9/hxwS2adFu4uNewntM
         kXoIQ3c+i2p5XNXJNa5iad9EnnV7n0JvSVBBb5lhyTYgiNhkua5fivCyGPDc6cGuaY/H
         qQCttMdB5vnApINC7sNLOOtykrdRJ68qcoSR3/EVPYSEzGmjxHFqAA8g17iX5ruySm9j
         k1nQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MQ5zKqUwj1pvG9UTzyfcCPyDAfQFTBQX7mQb4zL1amTNhyG7aPbXzVgz1Daqj7bJc/azz/fNqeX8n/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YztiPLKd4SV9TGiTXygNHLMu/8+LRgKfldSqt4am871HpCilaZ5
	T2Wnu6I0Rd67hSCTh4XqLsstHLjdF1tFl44y4KpDT5i4crv3InMOu2MS
X-Gm-Gg: Acq92OGcLt2C6/5AbHvTq1dQH/B1wZuCwC23DfYaTGkGvOCJdMinOV4PXilKaX9RUba
	+l/dNgzCS+Qa2X5vGd4zVAMo3b7MkyobYg1UaQ7t6wtNX/diUuDh+V4u42EekqNkXUdFE/Aim3t
	xCrO24Gtrf5MZQ/ZT2xKiCm38+2tWFv8J+iGPTn6/l/Cmy65xwbkZGuGqlGe9cI6hQJf6ITxpGV
	5psAKQxaubeuuHTGydQSGsyedSQK3bpLp/P9JQzDrfQuxz10mWOudD3j8BGPeZKjEyYRiWdmr0g
	Tno3fUZVV9vu0DQgkZoMZgbfhllW64vG/Zy2qz/LlpY7jbDHAh/7Lf/XSQuoGi+GD3pm6VhW1Yx
	AP+x+qtlTUjPbpdP2kOTMh3GvsbazNtCqZFx9XJg/ttEXx1nTXXeJjb9Rv5xrUXvBmMAaMPnFhH
	aplBNNFuwPLoDE4WUsJlRaxhEUVIXjHw56hzH5kfGNB6TgdVii+A==
X-Received: by 2002:a05:7022:221e:b0:137:fe07:8a2c with SMTP id a92af1059eb24-1380671fdfamr4297594c88.22.1780758329731;
        Sat, 06 Jun 2026 08:05:29 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm8415607c88.11.2026.06.06.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:05:29 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] Input: cap11xx - clean up duplicate log and add probe error logs
Date: Sat,  6 Jun 2026 23:03:54 +0800
Message-ID: <20260606150458.250606-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606150458.250606-1-jerrysteve1101@gmail.com>
References: <20260606150458.250606-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicated device detection log exists at line 537 and line 542,
which brings redundant repeated kernel print messages. Drop one
redundant log entry to clean up dmesg output.

Meanwhile add missing error logs when I2C communication fails
during driver probe(), helping capture abnormal hardware access
for debug.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 2447c1ae2166..485d8ba97723 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -512,7 +512,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 
 	error = regmap_read(priv->regmap, CAP11XX_REG_PRODUCT_ID, &val);
 	if (error)
-		return error;
+		return dev_err_probe(dev, error, "Failed to read product ID\n");
 
 	if (val != cap->product_id) {
 		dev_err(dev, "Product ID: Got 0x%02x, expected 0x%02x\n",
@@ -522,7 +522,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 
 	error = regmap_read(priv->regmap, CAP11XX_REG_MANUFACTURER_ID, &val);
 	if (error)
-		return error;
+		return dev_err_probe(dev, error, "Failed to read manufacturer ID\n");
 
 	if (val != CAP11XX_MANUFACTURER_ID) {
 		dev_err(dev, "Manufacturer ID: Got 0x%02x, expected 0x%02x\n",
@@ -531,11 +531,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	}
 
 	error = regmap_read(priv->regmap, CAP11XX_REG_REVISION, &rev);
-	if (error < 0)
-		return error;
-
-	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
-			 id->name, rev);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to read revision\n");
 
 	priv->model = cap;
 
-- 
2.54.0

