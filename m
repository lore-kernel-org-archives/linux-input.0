Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A03590A4
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854352; cv=none; b=rP2d5fe86mleYct6Knqs0UPSBcGmZVP64a87H6eyL7ysAVqKUSZF/AvJ7O4WtZXg8813L8hMx6ah53WorklmBv3YghzWFI6KqSSjr+0L1Wlk9yuYddWX3SJy2n2e5SCbulHVV3bdXLWD7v7QMvXfQwfMt1bm82B76vki791i+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854352; c=relaxed/simple;
	bh=3A3J3Qg1ugV7Cq0g+7Bq3RTcFtGsYQSv4rQ4QfVeSOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGPp0VAJuU/47l6DG+gvoWa7bKZUk4SPGub/d1qt4/hI4aIXyOoCev8SYoVB0qt7L7uvkh5AVgfqc1xydi8yODgczG0zopsqAHDXkKtIqkrb6iGUIIEAITMwA4PrPnOH1TDLxuRrKw7O6BK5+FZbQF4HFrjT1CWCts+VrpX+beY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwIt5eeK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwIt5eeK"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so1400490a12.3
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 15:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770854350; x=1771459150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtNU+CNiv7eB+4+SI68i2lfQ9T+GFhaj4UMZeMPALAs=;
        b=cwIt5eeKMNnj6zd+oEkH1owdptcaQjSeNQNvBYTpgBSLc4e4nuB6Nd9tZK+jq3WDzk
         Qbk7DQ5cO6o6XAIT5CkXxRiGLYNUrt9qdyxTIH6QPfrrqz79iz6YyeXJD0V1PI5MgtqN
         3SUEB3L/cM3gZiBe8XGbL3VdTR0UOrGaP0UcsQtwPEier81B3biz5niX4Z8z4FICGTyB
         Ii4KzMIqid+Y8j2cTYJllpuuSL6+rrJ7rPAyhgRVpSVP1ZjYF1qQY6qlTcn/9vD2ZpR6
         8p99UEgs6pChSkD9FM2iaDtQ7ijcXAELkyMmNWCyNhTW+Jev9RYyB+tTnyVYmUCUtace
         0twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770854350; x=1771459150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtNU+CNiv7eB+4+SI68i2lfQ9T+GFhaj4UMZeMPALAs=;
        b=dRiQj15EfQrJPYOr6Ue21jGetlyeFGclB+H5bxKtIBe51dtH2gb0hp9r5oBH6A8Gxn
         I6rX1vp0Zx/D22zbRvw6pPU26IrjNtg4hIX6H+gQxX08WKCqD2EOMEcvYWnBH8/DEXYF
         gdklLf/Gg7pUqSYF4Cu1pcHsUbghzejgAF1OODp0lWBPUoalfUwieNFMuKFTIDzOuIhp
         Ihrj9M8USbvmTuZXO5E/jfHAmsT+Cm3mEsdQRbNbiBhtGp+4yFTtzRPsgwAz0eQdQWPz
         D85LrhlFpG78S/a5SsvNLrwOmwEoF0E47KmqavC/Moka9vnqi+vVJ/RzvFAonKsr4ydn
         301w==
X-Forwarded-Encrypted: i=1; AJvYcCWXQV32Hr/HAWNUVAf0C0YXH7KUhRqKXwgu88FTZ7FZilY8xYdAyAlu5nbO60j1OMzuTgYPeAO9aS1aCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NE3XH+9/6iOPEhRQ++E3x2ao8RQF11nDpKWpNgOYzAR3lVKj
	DVtNrE0bVcj+2wA0oxdvyEeYVLLBXtMOeUbAS67/gNehoWUHUaX7t+G/
X-Gm-Gg: AZuq6aKHybVesAPIsT+E26Ldv/+CXJkQMEblxPc9r6Atdw51mDvPWTkda7Ic+HTUfZH
	DHUS6ZS/t6Eign+CH7Qily2ARL6lD+bCrTke9WKY3qGh6bhYAC++ZUmzgVx+65D/uxrAZuGiCic
	ymcX4/WgY/wc2mTpKIUZVNAklIV9dGjvnh6p++u5a6G0xYDibUCbxFZmVb/HWBycbGgnFy0Lz1U
	C9ciUJRdo70soXCHUiOQ3Mzw+I3EZDlfspDCpma30I6FjS9yoi4wS8g14DBsJDHm6yW+a7EnwJ4
	Sj0hcZ3/UFs2oUUbIBXFiLFb5BWfA2qsDOp/NSyrAHinsY3R/DQTVD08J6q6KlyXnsXR9hezRgM
	/5RjxVk1bdSpcgq3HfN+9bVu9js/h381gSqjD9gRU/K8Uv4VYaVqHOIGb0RwO5nno8frHqHuwBx
	Znr7AoXeieh4HLug==
X-Received: by 2002:a17:906:c141:b0:b87:6f58:a848 with SMTP id a640c23a62f3a-b8f92c6674emr16512466b.51.1770854349449;
        Wed, 11 Feb 2026 15:59:09 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9561f722sm1593466b.10.2026.02.11.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:59:09 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 3/5] input: drv260x: Check the device ID at initialization
Date: Thu, 12 Feb 2026 01:46:53 +0200
Message-ID: <20260211235902.4156624-4-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211235902.4156624-1-jekhor@gmail.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ensure that the device is accessible on the I2C bus, read the status
register and check the Device ID field in drv260x_init().

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index f613c81fa2ba..f08a3d6c3ed8 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -56,6 +56,13 @@
 #define DRV260X_LRA_RES_PERIOD	0x22
 #define DRV260X_MAX_REG			0x23
 
+#define DRV260X_STATUS_ID_MASK		0xe0
+#define DRV260X_STATUS_ID_SHIFT		5
+#define DRV260X_ID_DRV2605		3
+#define DRV260X_ID_DRV2604		4
+#define DRV260X_ID_DRV2604L		6
+#define DRV260X_ID_DRV2605L		7
+
 #define DRV260X_GO_BIT				0x01
 
 /* Library Selection */
@@ -305,10 +312,47 @@ static const struct reg_sequence drv260x_erm_cal_regs[] = {
 	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
 };
 
+struct drv260x_id_map {
+	u8 id;
+	char *name;
+};
+
+static const struct drv260x_id_map drv_260x_devids[] = {
+	{ DRV260X_ID_DRV2605, "DRV2605"},
+	{ DRV260X_ID_DRV2604, "DRV2604"},
+	{ DRV260X_ID_DRV2604L, "DRV2604L"},
+	{ DRV260X_ID_DRV2605L, "DRV2605L"},
+};
+
+static char *drv260x_get_model(u8 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(drv_260x_devids); i++)
+		if (id == drv_260x_devids[i].id)
+			return drv_260x_devids[i].name;
+
+	return NULL;
+}
+
 static int drv260x_init(struct drv260x_data *haptics)
 {
 	int error;
 	unsigned int cal_buf;
+	u8 id;
+
+	error = regmap_read(haptics->regmap, DRV260X_STATUS, &cal_buf);
+	if (error) {
+		dev_err(&haptics->client->dev,
+				"Failed to read DRV260X_status register: %d\n",
+				error);
+		return error;
+	}
+
+	id = (cal_buf & DRV260X_STATUS_ID_MASK) >> DRV260X_STATUS_ID_SHIFT;
+
+	dev_info(&haptics->client->dev, "ID: %u (%s)\n", id,
+		 drv260x_get_model(id));
 
 	error = regmap_write(haptics->regmap,
 			     DRV260X_RATED_VOLT, haptics->rated_voltage);
-- 
2.51.0

