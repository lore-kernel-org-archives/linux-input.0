Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C773DD51A
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249003; cv=none; b=faQ09L6Ltd77A7zHuT1dHKU5xMbZi2aAk11p6rFMJcILmGBSp+/cwgtskOJQeZ4t/nlpybOc8ua1Z/tYL1nxAN6XEZxLSCEBMLPytQBlm68AckLwnOP0NO9uYCySi6S0PlAohwitZ/cgQg0I0YaYmS/8WC2bkQUk/b/F3M9PcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249003; c=relaxed/simple;
	bh=L4IGNbM7y1d+TqDRCJgF9JoD/da1bj3QcNTtav1CsvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYfNWqqoBh/g0C1nRTnrr6FlLmmpgDgWYF3eMuZ+MJw0vGxxDbTD2puVr+/LlllJHYn0GUvkm85hrjfROWu6vdoBRzINK6iwZIsIrGdMZVvoqIbXQb/hJDrJsWrApcO+5kLFS/9+XpuK2nseLc5Yts/O9XYq5wDVyUUxHEQM8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBz4Tp75; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBz4Tp75"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so15986665e9.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249000; x=1781853800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xutruK5RfR43rmAYdiUjHl9bnTWIPbtUF5GMeFFCbOs=;
        b=bBz4Tp75X9vsRD/zUcOkpEb+HJHYOdgJutMZwCksCDWrXbc/6yj9Lr71IaYgwz74lc
         NmMFpvnuEE5SyVYmqGEJwcxl3Ol5lACPi7I6J8Uk20XyL0SmMj7VQh30T0IZzVDuxG3k
         p/nE/7r0WXUapFDJYm0fXQfn+bTASi4Fo4ece8aCig+neeC2js2lcTld5PPkGI63f6AJ
         VYrx7fBlsqGO0sOUDCV2gTp3rOaLqv8RFDPULcH1TzZmVWMFHV2Vx0hQPDB3USgDd/hR
         /j513fr3STQrF/kJcynm6V3VBs6mCGqHxSikoy/rpp1QtVxrou8rJsIW755AZku+XFmG
         g5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249000; x=1781853800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xutruK5RfR43rmAYdiUjHl9bnTWIPbtUF5GMeFFCbOs=;
        b=PEm8OuJuepQy/m6OEP8mY+Ik1kzxzOJNZvycwfX9ES+qitK7fZL21yYq1R3JHbgt4c
         lslZgN4hHh5EnRzilP+qwwjrTFA+p82ZSMtldH0MT0cPeum/Uay4qmll6hU/ZqzCxOU7
         ZowjeifwJ5yQoSFuwrehLLUHXvDQXOhT5Hm0YcFk3wi/xIehDtUFxA5LdRD6DJVgLswi
         BFCkQCTDenZ9s3h+3q33KySU7slht52QO+4wIQ8fJ92fyQkYuwzxSH9hT7S/791JlVG2
         /wq4CZKfeUUko5t/5D6o/jWyPVPK/Lcs0XD0r2KAtzzwYO7VrNZQQMaA5F2cyACP+/AO
         o8Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/cxt/GmmmaejzXg9W3BrEFTWJMBupXOb4NVe6TFRoLKLvRHZ2rwKpMMkfkvhvxeOgYufShMxXKhDGGCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6licMn7C/71JsebIGJk186sOlgWuAS1tx4//uIRXbXpQwkfC
	dN4BbBMQ3AqRFsq936YG3rKx8a5VH3az7b4WiWFa47dAlbRltDhZoc3M
X-Gm-Gg: Acq92OFy3RtfxbR/GMdf6/MgyvSb5NUnqz4CIUu8OI9WhoAcpntec0+ZjE6b1uV5Fxt
	PBwngYTyZgoGs22fGrSWPnF2F5Hy1XflvujZHdfV8jR4jh3IFDa1vooz5QyZXPZ3qxJg4qAdD1B
	icSfD8VXtEzbIbKvNad075ep2oGZcmSc/ZRDoAdQZOmasmWMudhFGysXQ7P4oJdbzRyakFOAk6u
	zvC9Km+Bz4mpVVTQF8pyYswu5t8eDiqb5Bo2hHampi0nIR7/xa9bJsovseNjyJdcW5cMAOoF+eJ
	FVz4spkwEg/TtKKRCeMcckx59FETlACqZaSeVoI3LLQiRm/mHLBtSWDVv41Ofjmjp4MjPQs2WFo
	s1Ecp8aWxMxud90AYo+L1j+GSn51YND/UVm8MmsohdBijaK6Bip4dbgX3a9WMcELmwbp0BBkoAi
	sxuTqMyfUa6LZrtctndyWYlBx3m6fKjocIClurF7E=
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-490ec480e65mr14320715e9.4.1781249000081;
        Fri, 12 Jun 2026 00:23:20 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:23:19 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] Input: cap11xx - clean up duplicate log and add probe error logs
Date: Fri, 12 Jun 2026 15:22:07 +0800
Message-ID: <20260612072237.1177304-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
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

