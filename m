Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3E3101C0
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512819; cv=none; b=ZZs1rgucPB545wFKFRzgDk301cOt5Rqitzp6p9vCj1piwRIosk9/JL4d5ZhHBjXCuiw+owPyMl0zAEeo0gx2XO1Do5ABW676+uFS1zwYM+vG8pAESAXIsEQ92JgB3si4hEUneZBDmDPq1S6XeVKr2CLI9ZAIHY7M8Kfkb5wd1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512819; c=relaxed/simple;
	bh=7msCFmmqPEC0bv111WI7CuSzpKcR42Z0vLrh7N3kgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JO1NDfNn5F4pNUyScEDyd6sP0mSdw91g15Xr2gW0DhEWgS0jCtf3F5y6RMjPuNRMdMTLp3K9nFteLXZoILeAGxeA0CCNwEImWZxuppUnJLMiBA3W+EcUIBPWmyhKWM2NNfGKxQF83ljzt488XMBCg7M4u5+1v3UTII0bGCga+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJsLc4NI; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJsLc4NI"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30455f77e0eso1069985eec.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512817; x=1780117617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH+nSqGuHupA2MghGAqtpGS/yixxkoX328NYlBs9gE4=;
        b=TJsLc4NIZmqN4acmwvNaaYMe/VNS+TI9Z/8z3Y3MXsWodD/BaBjxrd1/rW3zXelImN
         rTJpVbXlQ9hrWjW8eAiUdaYDJXkSUeRNHKQtD5/aR9Zi36XbFa/UhiliPwcEcSpU7Dxk
         c4YGuY7oZDa01uXZL3od4GZhrBnnCB5gh/af6WTraHyfG1Qo9CVP0qtutSkJyBDJeVrh
         y2pbDwjpC0uaRO5hwEA4bbpyDBMfi0rle4HIUeAdkv5apRcMKZZ+PzIy12P5zolzqkfp
         F69QmE4fxCBgRmsIKy0UJDauUsonQF39VB6R/YiBY/hQNskIREF1fl+IPPlOjDHNsOex
         iBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512817; x=1780117617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH+nSqGuHupA2MghGAqtpGS/yixxkoX328NYlBs9gE4=;
        b=KtM+93N8o2hrQrwomJkeG6QEzG2Ea1evLnLuC6e7MNnzrPaLZpkaJHLvBmQghIwCDe
         s3i87rA8O9hyDDVI5VdYUki6iVWeFNFU02SusBBC0RX5/5ndy63RF7HeZFkakZvlz7YD
         jFk0hBBP75Gv4suB6caFb35Uf/HN5YvZzmfK+wPovaF6G0oEBSOV2XKY73B9X+ZNvJoq
         MfQBjA3fKO0PiLGnlOJucslHz32xpFGFLjlfo+fc6qsN97wX9Cp5eOutuLevHKfRkRV0
         GC1K2c7RL9UY5ZgEPFPcBI+43PZ0B4QE4/aMbARDQhCh35k/SmMjz94O/40gk5O6oRC4
         BtPA==
X-Gm-Message-State: AOJu0YwTPXNcm94S2NKKhmjtQ6fUgCNLZ25BTK5VA5f8wDPMuYgsoI2p
	88D1zMRBPcPNuhFZgWcYXAWNn2QGOf5HVxvIjGTij7uF9B5rDOv1c8I9cN6n6w==
X-Gm-Gg: Acq92OEHa3s4P3cvNTQUM0bAuaUZ2o79CHLCvzfRNMdXhUuh9WjDzZo8Rvnd7YPtkB/
	BnhwHgj2bq6GwIV58v53IBExjLPkE1u4wvhg1DbpOwypiWOpG8W/3gHNcTnJzs0Rwy9zrOb4bZ/
	mQaJFZANKjpDK0xncexByoetMxcB0uwnXLwQhVmjqv/vmNPX/t62A8/jUwUhlWRGSWSB2ZS+7ZC
	YtKJwA01NgFbucvxxKq7+YKrG8skI5GqqbKw2IjsM0St1TJ2hRA8Wa7D1ejFc7YrjuAQ11F8our
	g0DrMSXbIMq4lxvlHBZgEkUgmDVgN/TPHsG+W/g/ZwT7lZGy1VEUK2V9NCzvbuGfl09I5bX/4vB
	GH8I2kuSWvyHazbVeeh8CG7hUxzdEvmIlVmoxZZL0PuEDwT+RoU/8duMEdkN/Y2YTWaSWmrQ1v0
	tj45RNqxIY762mGMr5JhBmnJr9pgoRQI+SQKuxcADLtE3Z2hgP1vJyVufbLOqX+tSEfjEMf0G8y
	kvzjBQHcw2wxA==
X-Received: by 2002:a05:7300:818a:b0:2ed:e12:376e with SMTP id 5a478bee46e88-304491f21femr3174647eec.30.1779512817548;
        Fri, 22 May 2026 22:06:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 10/11] Input: ims-pcu - add response length checks
Date: Fri, 22 May 2026 22:06:28 -0700
Message-ID: <20260523050634.501509-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver processes response data from device buffers without verifying
that the device actually sent enough data. This can lead to
out-of-bounds reads or processing stale data.

Add checks for the expected response length before accessing the
buffers.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 53 +++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 3b119bc81c85..422b1be62303 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -406,7 +406,16 @@ static void ims_pcu_destroy_gamepad(struct ims_pcu *pcu)
 
 static void ims_pcu_report_events(struct ims_pcu *pcu)
 {
-	u32 data = get_unaligned_be32(&pcu->read_buf[3]);
+	u32 data;
+
+	/* 6-axis setting (1 byte) + button data + checksum */
+	if (pcu->read_pos < IMS_PCU_DATA_OFFSET + 1 + sizeof(data) + 1) {
+		dev_warn(pcu->dev, "Short buttons report: %d bytes\n",
+			 pcu->read_pos);
+		return;
+	}
+
+	data = get_unaligned_be32(&pcu->read_buf[IMS_PCU_DATA_OFFSET + 1]);
 
 	ims_pcu_buttons_report(pcu, data & ~IMS_PCU_GAMEPAD_MASK);
 	if (pcu->gamepad)
@@ -718,6 +727,12 @@ static int ims_pcu_get_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + IMS_PCU_SET_INFO_SIZE + 1) {
+		dev_err(pcu->dev, "Short GET_INFO response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	memcpy(pcu->part_number,
 	       &pcu->cmd_buf[IMS_PCU_INFO_PART_OFFSET],
 	       sizeof(pcu->part_number));
@@ -1283,6 +1298,12 @@ static int ims_pcu_read_ofn_config(struct ims_pcu *pcu, u8 addr, u8 *data)
 	if (error)
 		return error;
 
+	if (pcu->cmd_buf_len < OFN_REG_RESULT_OFFSET + 2 + 1) {
+		dev_err(pcu->dev, "Short OFN_GET_CONFIG response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	result = (s16)get_unaligned_le16(pcu->cmd_buf + OFN_REG_RESULT_OFFSET);
 	if (result < 0)
 		return -EIO;
@@ -1843,6 +1864,12 @@ static int ims_pcu_get_device_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 6 + 1) {
+		dev_err(pcu->dev, "Short GET_FW_VERSION response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	snprintf(pcu->fw_version, sizeof(pcu->fw_version),
 		 "%02d%02d%02d%02d.%c%c",
 		 pcu->cmd_buf[2], pcu->cmd_buf[3], pcu->cmd_buf[4], pcu->cmd_buf[5],
@@ -1855,6 +1882,12 @@ static int ims_pcu_get_device_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 6 + 1) {
+		dev_err(pcu->dev, "Short GET_BL_VERSION response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	snprintf(pcu->bl_version, sizeof(pcu->bl_version),
 		 "%02d%02d%02d%02d.%c%c",
 		 pcu->cmd_buf[2], pcu->cmd_buf[3], pcu->cmd_buf[4], pcu->cmd_buf[5],
@@ -1867,6 +1900,12 @@ static int ims_pcu_get_device_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 1 + 1) {
+		dev_err(pcu->dev, "Short RESET_REASON response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	snprintf(pcu->reset_reason, sizeof(pcu->reset_reason),
 		 "%02x", pcu->cmd_buf[IMS_PCU_DATA_OFFSET]);
 
@@ -1893,6 +1932,12 @@ static int ims_pcu_identify_type(struct ims_pcu *pcu, u8 *device_id)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 1 + 1) {
+		dev_err(pcu->dev, "Short GET_DEVICE_ID response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	*device_id = pcu->cmd_buf[IMS_PCU_DATA_OFFSET];
 	dev_dbg(pcu->dev, "Detected device ID: %d\n", *device_id);
 
@@ -1984,6 +2029,12 @@ static int ims_pcu_init_bootloader_mode(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 15 + 4 + 1) {
+		dev_err(pcu->dev, "Short QUERY_DEVICE response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	pcu->fw_start_addr =
 		get_unaligned_le32(&pcu->cmd_buf[IMS_PCU_DATA_OFFSET + 11]);
 	pcu->fw_end_addr =
-- 
2.54.0.746.g67dd491aae-goog

