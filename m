Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F916329E6F
	for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814091; cv=none; b=gNw3bmYialGklXJqpNfqkVtRy187tn4qrRTc3l1zJy2LKhxLJJKH6na3ASH6YqoCHlQ1Tu/fn6f3t2QW9PZypj/3NIHwkvxtEuORntDlELHxGslHX0z4PJjif/QOJ6LmpWL+jNLdZxtEzjdTcc5d+aCabgq0P9Yib8qM5yd6SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814091; c=relaxed/simple;
	bh=eJX1yP3ycMOp+GPfJFr/Kg0BrgivZYOEuF4zUzf1F8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4yVQOfv9qNvfUYF6SgufOchY2QttOEpOM8FUeTTZBxItLelw4kEw7WlfKqMWKMPOo3x4q7X4txge+ks/yffF4gZTetAX7pSAgsOPgWliKcubF9R8GOeV7FEbMpRulKKvhz8Mqb8ewtQYoyC/F8QL9AMCpsthG4cyu6jBvqT/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKismof+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKismof+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so19933495e9.2
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775814089; x=1776418889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMDf5kG47sSh3LquTWW3lJq958x7ZFKaEtVYrO12TpQ=;
        b=aKismof+eqTr2porbxa1qlFO/qfy6vxpyckEJTsZBHd2xo3GlfaoLm0Owjo5hhmhAA
         0Ki7SDvPX3VL9FyXLRkEbxRrD73HkuZY31Tib1BuHrlBm1gcooHeDFtIj19+R/JrNuh+
         VfUSMhDD1xZxSA+LUwn5PHjIxi9Om/3iUlx11dtO3YgJ0DhkpPLDAWkkQDyh2M+eWLMw
         1FPc66ZYpEfhZ76kILn3360no+rfTgHukCnmH2wCj3zDKMSFMxDM1/4ewiZR7rMct2Cw
         ZXBC/qjax54a5+gdlES/51UOAmwQcNLyrSGb3ea6ac2e5x6v1wL/khGyx8trEDYYGdLF
         BlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775814089; x=1776418889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMDf5kG47sSh3LquTWW3lJq958x7ZFKaEtVYrO12TpQ=;
        b=L8Gt7iQA/cXagrH79gKtN3HY05R4fK8+lYZYknuzNnNCy7AFzocPuA5U9QC/bi8BdI
         PNYUddaFd/s6DgDW6wXQN94NIUuKNhz7ARS/1+RhF69z63BJCENZI3yUiSwiM3T4gF8G
         T/Z2pRM6dryQ8dW4OBX539hGwI8XLiOx3M+N1Qjf/NSropGZZwLTuwqPZ4dSRigJZwih
         mYepzXN21OZEzfKn+vtuiypgUjoyVkROVdoVLT9AyzM8jtAraLa7O3yufdBQilWkpqsG
         0f/aILTvxIUSNvrXkJUkkc2sZ85oQvVe3XNFtd+9zGrvXFhAy6RitU3RuKs7V8msCHUS
         UMNA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ojcAGRV+7rSMcSFc63Lmn7CIX4Jb8jZ3VBwyp/HVwjznghrxa7l49dK+5Frp/TxLVs3woMlzvBiMAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwgKqMCr4g6VVBo6GHU0LB0UDWrExKxunBV1/NhD7Ycs5eIeY
	Ui1HS/7krWsly7M7FT/agyeZnTN3caBrRwLUDdQj/sCAzpZ5Z0OzPzn1
X-Gm-Gg: AeBDievNMtRU2xgbDzMgrtuqCePXXEW5dZTuaHIP0avVr0g59h15pjVXvW9E7atYgH6
	Rc6uB8KBysFqaTsFAWot+QENv9Ym+1XjCkhtQYL3IXRYbxx3cKmAl1QsxRhDDaEJ2EYCsZWJo5a
	8B9+PzBoE1SkRKghfIPQSKjKHyII+CxPCKXJ7dyE6K+evE5csEn7TTMJ9b7xjYHkLXuogw1o9jz
	8Q6F+solIcHr1aQqvhRgWWRgLwbZPM4zjxoY5D6WmA21F3dQ9yxbNvrRn1ZIICzTIheCVuZ5AfW
	BbN/tPiqrKgVnuSVZsfxW8dGDtp8Jd864dFgNVxLjvXGDLUVZPzr+m7+vXqIRwhnX239CSg2xA7
	ilGFPPc784XP6Gk8d+28TKTdD9rqLMEwqxkcWbO+3ssYzAiQtwimakOP0Q/YgRgbQCg480scK2x
	Pub3Ujl8bJKmadf1xIM8YIdewvxbBzrQAndY90mUFZHc2MEQ/S0i6Yk2IdLjl5a55dW0Vj
X-Received: by 2002:a05:600c:8b6b:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488d67ce792mr29808725e9.8.1775814088482;
        Fri, 10 Apr 2026 02:41:28 -0700 (PDT)
Received: from x2-evb57.xsight.ent (genie03-172-158.inter.net.il. [213.8.172.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5df2062sm18102255e9.12.2026.04.10.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:41:28 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Sebasti=C3=A1n=20Josu=C3=A9=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH] HID: ft260: validate i2c input report length
Date: Fri, 10 Apr 2026 12:41:15 +0300
Message-Id: <20260410094115.229188-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
References: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate xfer->length against the actual HID report size in
ft260_raw_event() before using it as the memcpy length. A malicious
or malfunctioning device could send a report with xfer->length
exceeding the data actually present in the HID report, causing an
out-of-bounds read.

Each I2C data report ID (0xD0 through 0xDE) defines a different
report size in the HID descriptor, so the available payload varies
per report. Validate against the actual received report size rather
than a fixed maximum to avoid breaking valid short transfers.

Reported-by: Sebastián Josué Alba Vives <sebasjosue84@gmail.com>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
Tested on FT260 with I2C-attached EEPROM (24c02) behind PCA9548
mux switches. Verified short reads (1-4 bytes, report ID 0xD0)
and multi-report reads with debug tracing enabled, confirming
xfer->length is correctly validated against the HID report size
for each report ID.
---
 drivers/hid/hid-ft260.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80b0e..b31c43353249 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1070,8 +1070,15 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-			  xfer->length);
+		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
+			  xfer->report, xfer->length, size);
+
+		if (xfer->length > size -
+		    offsetof(struct ft260_i2c_input_report, data)) {
+			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
 
 		if ((dev->read_buf == NULL) ||
 		    (xfer->length > dev->read_len - dev->read_idx)) {
-- 
2.25.1

