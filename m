Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381505;
	b=DwDMieOIqtYgAHRzIYaLXH+F6q1ywZSAGzhSIXk6LMmAC4AlCjWLkIcK/2fEzxUzKqKS
	 /1IhcR74encEgDmIBc3Ls53bNGgl6sLFmExENHTq6Z9oldIbiKtvZCJZW87gAWhy90Cbq
	 VnlMvzR9TyuA28x5B7bmDiISjYgT8LOssvnd9YvoQOQ0n6KBfCaNiUNXVD5RUG6Dd/hEW
	 8C2KXFz/4s0OxhsWzCzR5048boLwbOf8D+d5UJEyKJMZoS3VU9c1AqfCfBh4NE0tL65P5
	 kVP0Rx2DGu7g0RFR8re1uTxyIZa1cB01ocQasgtOcsw8LlDDIOvuWFz5XnLmwRCtDMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ubTkJ5xNAMqXDr5I2OlO8eBXHLgCkPpSg0BGTZDzc6c=;
	b=4K/DIAWQSc2+NRMiFRpvfMnPfWNERqVrMnLuwo1461yGrJhuPRZQger7RBXDVQyMuWki
	 iFS4P+5CoMVFXcviRJjQl99r/eP1U+SeH4LO2k0QJOqAWlwEtdTs7aUR4JBE4r2mWKQq8
	 rt/UAl6wvlgcjmXg41Mank0lV4fzGeRdjB7KtxbU/hDjv6g7MqKdsrMS9k0qoyOStn6+Q
	 Cj0YmCELya0d4TWvUb4RhsMVZ5F1NGa1P3QmHqAzMURNjbgJqJtSOOodkB4kpT8KJLntB
	 1Die0KWqR9mndfLI8DtCzOMyKAqHEpBgHYfVDzFmOtX/j/YRa+nvRQ9EzHl7csQKJFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPC9cOpq;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BE606A31A
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 17:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPC9cOpq
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so238578c88.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381504; x=1793986304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ubTkJ5xNAMqXDr5I2OlO8eBXHLgCkPpSg0BGTZDzc6c=;
        b=SPC9cOpq7Lah9VzIYCwPiKKmaHbVd7dWuCkvAhK7n19QzKJHfJxtPDO03GRncp+Amg
         l//qlsmSEm39OFAOJal8xPJmJtvBMIGFpdIMXpA9xqecukK0VbtV7GXgIl+LW0iCKiNN
         mPJWFwzYGelfpLYX6Vb5SwPIy4Fz6rc/gDwzG4TEmVFM0ZwVVBMs/M1vFSQ7xa3nz8nU
         qDUnY8i0Iz5eTxpzOxIRefJkEc95PiPYQknXcTDdowJPvNSrUyim10/Lur3qHT8OMNjv
         HWZeFU/zulWZnp+Xn1pp3bLzAvmIKq+pAcwUjM6ss/l/wblMvVZ+zOEdkJZLPQ7PScc2
         jHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381504; x=1793986304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ubTkJ5xNAMqXDr5I2OlO8eBXHLgCkPpSg0BGTZDzc6c=;
        b=BGIh+MZQ/T+Vwwn3LagMcfjYTyNg3AIV/5EFz1AvA1/wZxjRy+aS8mLHxnmsS1pJCt
         ihXhYhtFx804TjkfklVsO9rR7BXp00AM8Ok+S1DVCTVbOw9Xe0nMpBtdwWeDbaHzKiW0
         wLoswujdBYXnXWnQfq4G5Wai75fgjHCDdYrUbPlBTJQvSfXIV32eYbU4lpgrPdUfFJQR
         HbtiCFcGaEtsDZ23iNpEmxdess53Iy0xRJzdR0RQBtdxcSCKczWTqzF/zzKNmUdUlI0o
         0F4fkQbWaioQx5Bx2+ox40qm0+gKM+cC+iSxQ1T3/uNMH45LUdNh08k3YKe1UdBLOADb
         YSfw==
X-Gm-Message-State: AFq9FYKTD8BL/EUDSBVQqVYT7HRRWh50RXweHBeyuGbZgHlmywT3wtE1
	u8BJ4oRKOu/fyntwRr8uiLr6IJTSxcIF1aqjgd5kmSMTYJg+PmKh0mpV144+KH9VWQg=
X-Gm-Gg: AYBFou1T5yiAAt9zTK0Ntko17GsQge0E80ZyVF6MH+Wy1jA4lsd6L3VqEBBLRtl0483
	ZyVfU9Au1s6O+sWuAAmo2ZxQnYIQVxPCs6HAZ0SomMLpOTh92crmn1L6XY+itGJ/oD/ADHq15g4
	ZpQOiDliVp76XgNqgXQqNnFE2bS3M8qz7QxPRRhjUjeGPe2rE1x/UJfxjtxg3JnXymd02NHPtuU
	yQ+WCfcRV2XLTcIpe7++CgWH2UIQs5LJuF0zlvkc1ooNTFvY/GJ6ZJBl293cyiFeOdNbdGGH/up
	fv/RpoSJUfLFAp3lCp5nhMfm2aKrYnr86QSCJB4QYJ5xP79Nj1h+6L3Hsjpy/RjzHceWpdSoEPT
	pLC2rO+HHBuwomrKSxisoP3HKv65DaMNvN4mGgCqjYf+9u47HCN1JFSTiCxgbsmvl0NLKz3kzB1
	r7NCFTZ5U3nEeMK9CS+S7viRo0WB7dJ8zlF0S6wTw2mZocviQYpkcgkkttYydFEvVjfWDIu9woa
	1Qrzzx2OH9VcCN8FU9JsqRqvX8wJL46g2GXeOumY8wPukxJ1u7cy5+zeRKdcf3Ijy04kthfr0M7
	rC1NbqGXUGqbdUtXDhS4JpgYIstFk9WLMseDxYIBm+OrcaKVKic=
X-Received: by 2002:a05:701b:428a:20b0:17b:fed6:7449 with SMTP id a92af1059eb24-1ac5da7725fmr4282799c88.47.1793381503588;
        Fri, 30 Oct 2026 10:31:43 -0700 (PDT)
Received: from 1ndr4th.debian ([45.112.151.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm7844437c88.8.2026.10.30.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:31:42 -0700 (PDT)
From: Devarjya Purkayastha <unseentactician27062006@gmail.com>
To: linux-input@vger.kernel.org
Cc: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Devarjya Purkayastha <unseentactician27062006@gmail.com>,
	Indrath <indrathftw@gmail.com>
Subject: [PATCH] HID: wacom: Prevent NULL dereference in wireless work
Date: Fri, 30 Oct 2026 23:01:08 +0530
Message-ID: <20261030173108.45408-1-unseentactician27062006@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_wireless_work() assumes that the active USB configuration has
three interfaces and unconditionally accesses interface[1] and
interface[2].

A malformed configuration with fewer interfaces can therefore cause a
NULL pointer dereference in the wireless workqueue. Return early unless
the configuration has at least three interfaces.

Reported-by: Indrath <indrathftw@gmail.com>
Signed-off-by: Devarjya Purkayastha <unseentactician27062006@gmail.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 628372ab818a..dcf2811a5c48 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2619,7 +2619,7 @@ static void wacom_wireless_work(struct work_struct *work)
 
 	wacom_destroy_battery(wacom);
 
-	if (!usbdev)
+	if (!usbdev || usbdev->config->desc.bNumInterfaces < 3)
 		return;
 
 	/* Stylus interface */
-- 
2.53.0

