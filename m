Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55249552D
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708677; cv=none; b=UO/sdOtrWuPqYy3hS94GaYK1QC1BMgHVOGlyMImpp6whlkEDvov/SFSPez6Aijch/zamlQrmZPtGEWAkc8u5dRyFQRW49wIaxKAQ7DlIA7JRthe74aidh+NVsUxgYiwknKbq6XYFL61ox9JFHGdAjDE3kleB7NjZrz1Zv0DiDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708677; c=relaxed/simple;
	bh=L4IGNbM7y1d+TqDRCJgF9JoD/da1bj3QcNTtav1CsvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv9TrAsT6os1e+fOSRO5r1VwrrerE6tpZt2g9gocwyso0i9EGVhsGF3ozHKyetRbP5nOItFbNEP/TmzMvdSNc4g2X2f2ZBAVzs8a7F4qKqjfWnoYG1NvqmoNG+L//EKe3e+13VfPJm+2PnaSHwkAip8k/6W7SzpW2j6EICV2yC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrQzabwD; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrQzabwD"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6607048fa62so5759273d50.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708675; x=1782313475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xutruK5RfR43rmAYdiUjHl9bnTWIPbtUF5GMeFFCbOs=;
        b=IrQzabwDdjP/XSrF1UzgLR98QrrXIk6QOn/E4saD/PKeIOnfwG5m8jAUp1duu9GG9k
         hE1fkc86Ci47h47pan6WmKcg1umiteAThOtfJbAYU+EnVXSAgFXyVS5gYz7R3qs97P+i
         nD9lVeqxHQetZ02L04ijWv32GVU2e9cYkq/55awdrxwmJ64+yh7NrkOPJihgEHUqSj+d
         e4u7zJfRiQETa6Xedf6VUcJvmxI5Dp0CqjzuKymTb67NWxnCT2e1/5zjPc4Cmx9vFvX0
         tcRyo6paPocm8/y9/n5GQIIgWmvy78Jt8/CS3cOwWNpdsnNJeE14H99Nazuya7FzLUYG
         rjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708675; x=1782313475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xutruK5RfR43rmAYdiUjHl9bnTWIPbtUF5GMeFFCbOs=;
        b=gCgOoHeaSskbLlfkbt3C6QB8CqdWc0KwwIBrzSYwyAW+93I7WZwzZ6GLw3TTh+3N6k
         JBWADVXr4gb1Uq8x7RpBrw4jZ/Fxz05KPE0CtuEToIV9UPV9vuyF2BRcd6+VBRAoNJ8n
         GiVk0qaVhdQTCc/RicKeiGbLP4CBGfoDgLZEFqShK6qDT7XzlwwyDhP0GiwVXKY5Mqck
         PAepEtaVfM8kfUk5IF0nVsFkgosfIp99kVwkJ+AyOcUTkUNMS1Ct+fI2g4BZ3LwaC8vT
         e011hWd35QOxtqRkEYQ9mE9E/TTWL0B0K0mM8qdwrrnLt0zceNtEVoTj1A2Gylyv5op8
         QQUA==
X-Forwarded-Encrypted: i=1; AFNElJ9dw51giSfMVMrY7CIfi5eGPp4Y2FOfqKf8kOs2jDFAN0rmHn/IiSfPlRg4Kfy1ncGT492z5wtARicpIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzrqWravO58JiqGE0ovS0IWoVwO6fmZAUr70Pu0PImcriPkip
	ePSdFarzSxe1xjUHkzWgPZN3g5rhx+sY05TBjHU/tK9iMpjekDDFP2iy
X-Gm-Gg: AfdE7ckScavWqKhenOMnGlC+dy1w7jwFzUEYjaESZ1KVjI5ZWrIWHwQOWGJ42BP8yzV
	iUYazz296PFBMghstLvUCGsVVNheO25m3ZsG4lMlYue8YzAbJBcbpg72Uz2+3BRrythhVF+D5qk
	sXObYquJOvnsz1JlVMEiZCn/ah0mNVmmu9pX4q5H4x6u8VAfs6VDARqp9k1QVaF/CjaP6ObUErQ
	y89RSgjRPz9N1FiXKZAw03GrSt+1IEMCLmgrBqbuf+fv7lsb394KyREBpBp3S2bdJ6AI8hTjhb9
	VZld2xDXzr/vUdpawHAegQIH7ACvhMkBcFpYQz5oJ1lPzgJ85ArlrPqg96iXO5+sT1cIN6DS5YD
	WWQJ3UWaGko4JogGXltgnPPk9pqAqsHFIorrynUgQKw8GUgiRKm641cOwpnweYNtYPJJGE+U9iO
	o050lT4hvhIg==
X-Received: by 2002:a53:a94a:0:b0:660:eaa4:5c17 with SMTP id 956f58d0204a3-662cb8494d9mr2924093d50.2.1781708613613;
        Wed, 17 Jun 2026 08:03:33 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:03:33 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] Input: cap11xx - clean up duplicate log and add probe error logs
Date: Wed, 17 Jun 2026 23:02:40 +0800
Message-ID: <20260617150318.753148-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150318.753148-1-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicated device detection log exists at line 537 and line 542,
which brings redundant kernel print messages. Drop one redundant
log entry to clean up dmesg output.

Meanwhile add missing error logs when I2C communication fails
during driver probe(), helping debug.

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

