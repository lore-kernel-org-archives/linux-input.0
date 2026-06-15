Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDC3F88BE
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533292; cv=none; b=oQN93oE9MR0USKt4dL5eNMDWIqR+GgxGPOjxmqUORBXhmFlGYIDxFTBgQP9VhOzCAqNlsn178qmU5vG6Fc+sHnIOBjiNnzFIlLfIexcgYr49Ez7Iop1fKWZquRO39+8iRIEXWbbe2nStwvgKkT1xcBE5vVAFFDpQlBpDBgzLPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533292; c=relaxed/simple;
	bh=L4IGNbM7y1d+TqDRCJgF9JoD/da1bj3QcNTtav1CsvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF5dBRflnipeaHoZlhxQorInC12+CZ+2ACVrdSS72kE7uCmlvFU+HWN6x+G6oil/RlhB86hPHw80zmWO7qEQ/Rp0oBENu2SupREdGtEvtWDsPAWUqpJxOWQlcz8iM0TcQ34z/w/BGeSaCEAzfsWQ/LBfma8Npogyu2Iq+bz2diA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruPXGjEI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruPXGjEI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36da8439078so2892337a91.2
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533284; x=1782138084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xutruK5RfR43rmAYdiUjHl9bnTWIPbtUF5GMeFFCbOs=;
        b=ruPXGjEIbXyqSTqYMYJJpMA2xui/eu4d8fuPoG/5NX5JB6BIXyoDl34Uam91x3JJ0k
         DDa76ebc6FNkNlOZsqfDJrm/eE7M2+Sku/jm1xAQ66MAUxrwEECh4xmfFDpMkuDBMCH8
         Qif5lwZCvpLhweg7i2z6/TJXT6AoTB/DZyUvQiZMNvAD2FkE6y9eKR8RmBATiZQgPQQr
         HJst6+TZRx6sYcSDyk4+AkO/2lOpMA3S4Pge17x4BMfbwQ1I+u/hPFJzw79tHIVKT/VD
         3U40JZjfodnMzujU4WK7d70SjOEdWxeUnVLZsqinXGAlGYXFbzDssLYM/wxDm6qMSI/j
         p33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533284; x=1782138084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xutruK5RfR43rmAYdiUjHl9bnTWIPbtUF5GMeFFCbOs=;
        b=iRptxuDj6idk45141i6Q99uyT9ufivepg772x52UBBcySnew/BNwcCXQ2epoB7HG8G
         Lsy9PuFi3Yb71WijCDGTJzSYNkst6dpMTEAzeTGAaJdf8KveI/S3TiajWIrSts8ltAle
         raEgQT38KfDhp509cZd+C0zoP2N2492HPOYlPFWrqUMZXh/pNtuCHOU9/BBtiZ9PUUZp
         ISwnQbM+UjvHhU8iwRiOFy3/J4rF6wi+/TOeYjg/Tj0q5udsA+EAHqQySoxiQUsjQfrF
         nrC4mOar8b28SpKfVZBO+hCfFJVMFUu3aVK99IZXPYwomhIKhY0M96diiBzgd6nI2g8Q
         4QPw==
X-Forwarded-Encrypted: i=1; AFNElJ9BZdqqAAHUHJHvG/O0lSfWx2k21hEzNwevvcunSpi7mvArhh70DWP9P4/QKGxxTd43a/CYwVCGmq1BYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/EwohvALRN7IrfWydKnCeXu4jszissj1ufKxAw3vfj/UXlg5
	YSM3fCYnvSOwuA4Ho+qs1E5oKRIv3lv4p4dHzW2L/ZJd+Cmf8mykGixW
X-Gm-Gg: Acq92OFlxFXf6sJsS7Sq4RZ5tYRIMnsGODMxEve/BudEtowyeRU+qT71/VnyGhlC4w0
	3QOlamMWOjC91uV6SIfSEa4nE+s3XzYxhl8nrFW0nNXk/W08goDedkBHzNG7KtG9ahyvhAG5NkU
	qIcrD4z6Tmfn/Y6QIEYw1kzmIMewehTNvIeUTQ7TYr9BAZGw0ck4dOsUxaUxF0arp4UfIXmNkeE
	NQw1XCl0JJ6619nVHAK84esE8YUFHDn9efY0SxDcfW77k31bMQTqFqyCL3RQXgaTmPDHAF8tPGC
	SLpSkTBJM7HfLVOLCsrSMHYBZ+gHYxrG1sUOSyMid0YZ175lfmE6M6qPQ4quiJ/Xo/Uttgmdjg0
	ka8u2eXprLs3F43VSnU+FrlcVfZVqq6Spx2MoPUTkkBuW7RYLDoGcj3d1A26ybn6305KgdtHFmy
	zaW0IriPPCVbPYky/c5lZn
X-Received: by 2002:a17:90b:4ace:b0:377:4a58:fe0b with SMTP id 98e67ed59e1d1-37a01f335ddmr15548652a91.7.1781533284059;
        Mon, 15 Jun 2026 07:21:24 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:23 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] Input: cap11xx - clean up duplicate log and add probe error logs
Date: Mon, 15 Jun 2026 22:20:27 +0800
Message-ID: <20260615142103.352163-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615142103.352163-1-jerrysteve1101@gmail.com>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
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

