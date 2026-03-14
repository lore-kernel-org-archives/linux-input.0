Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DD309EFF
	for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507831; cv=none; b=UmbNNkBpQsv/50iXcnre1MU4EGIY41ZhEVkYl62mlk9J0t3wM8Ke/wH/9DrpfF6U0ZCVy0GlVOifv36rtv69wvdbFad3qB8a9UpVyXsuCTa4zLQohOLCz/r4GDBXstTzSE5SkWOLFL8L+1R0ToD75ZL2kSSFZO3LoTDoR983zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507831; c=relaxed/simple;
	bh=BECZ2kWUv9/sN/1vY2tcda5a7XzLvGpcZP8UN42zdk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKNkt+nCha8pcqpgVcywHcFMET7psSeYQiaoGizfr5yiLC0KXCdhbbnttKUFzWrEJ1WkJYUD64Ht99JL5KhHchQrvJXGwmzNAI3+4j8gHKKUWuxl6ePIJR5+knktvYCr37gDZ/v2flodKWeiud2VL0NR3CZ316F8M3hPczoqxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfnd3g7Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfnd3g7Y"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so37018165e9.2
        for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773507828; x=1774112628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVES9EBO2t19jyDyTJ/K+Tu3EVOBdgA74w8xUim9e9E=;
        b=jfnd3g7Y+QiaVtJOna+E/eiNUpOkEVyEphKKNlKn+T76b2oU+OMk2hUMOPsZN4P7V2
         aXufnB0E3blnAnBi/VfEp53m1a5eg2PtCOMckDOmg4U7Wc+eoGKXsSq+Z9NeTwpb022T
         1YeKfZzfaQ9Q6PYjeA75ptDpiCQA1dzwHIGAZADT4GwaYESwwhpN1EyRaSdSfYkMwIFA
         S9HA2w54UN7nf14vjJdiy7FKL+JVjge5ifMXNErjvadxQoMl6nydXuU+QLjsaJiE5vdH
         YMo5P1xmOxbgb7Jpe9Di/Zsc0t5+QtP/7MWAWtyRh5kVNTqZUg7ZFwt/lAjH7wqIJ2bQ
         XDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507828; x=1774112628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVES9EBO2t19jyDyTJ/K+Tu3EVOBdgA74w8xUim9e9E=;
        b=QtF7ihG4V/aRXiXDUUAVnP26cn9DPMou965BhqO1jG5JcIWVoQh7dj9tmVqsmFoYyB
         6X/Jv/qNbIikiky0ECCzUDcFFUCn0eWsxxKq33xxe+3B0yG6VB5Gk3hwCyAOQqyvwD2M
         9KNqhbADsIszVtT/HWJmBnujQLzMFaNuaMSW6UUDY34HMuznLkmzPueFm0rs5m4d4bBZ
         AnmNuv1dRqtkNwDQp+MXXvhm7/cqIF1iNaxV+BmPj4GxJnt4r55VdS8y3/DaD5L3UvUb
         nGTGmEpHcD8t9ujNGXqsn8Sz96S5y9XuLj3sS23TsQ/I93khX+0KFblZPByXNjQrIB9Z
         btuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgTtuGmDtnfsY6tFLssIDelMLCTC041Hc6CNp0dhKPrVg20IakMjKC0NCCmwG+xWAb127Aqrw8oB0vzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA3mwm1CnTq7gyd3AipSlHR4ks69Bs3XT5emMV4PvMo6azqFV
	tl6TSkfYeH94c6QIwgmwUgxGIqd+pOXIXjLXJv5nwtKgxPlNYK1CRpmj
X-Gm-Gg: ATEYQzzRKHWVrqq68Pynif0/3tHLHFZKQfwh+fTnA2SNAtzOrAu67YeMx5gc1djZRmB
	lTY0CxfxcZGjPeJuIJSbTi4S6lZWkvTspAmxlf1TrZ6ho1+crGXNPYuG6D+fC3KF+o02KsHU6xY
	yT4yQLvotsuVL7SABuu/Rd1ZlAd/EijZ4cfgcCJCjf19UPdyGZrBCX/V6SMxe62dcg8vPHYrz7w
	CU8agYKwI5IPE3LfPkxveBlay//o4VZJ/bzbnvkr70wfXXLZKNJtN54oHxps69UkBmz/51eyZVO
	xZ7eQFJw7Sa1nLA9Teo6IcM8MFckjkEc+RwqGwOOrLJFwlRMBYdi8ya6RfGMhVyiV1y2MaCGAF/
	R3HRPx71PCg5v7jgRDp376NFVPoRPtyLcXOzrH0nZQWQ/b8W551LLBF2nna0skcvwD4xWopch1Y
	lKnxJuILpzX/cYYQ7dxNJkaQ==
X-Received: by 2002:a05:600c:3550:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4855670c971mr130625545e9.29.1773507828313;
        Sat, 14 Mar 2026 10:03:48 -0700 (PDT)
Received: from localhost ([87.254.0.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm288880245e9.0.2026.03.14.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:03:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: mcp2221: Fix spelling mistake "Enfore" -> "Enforce"
Date: Sat, 14 Mar 2026 17:02:25 +0000
Message-ID: <20260314170225.1260440-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a module description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ea9f7ddd93a2..be80970ab48e 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -26,7 +26,7 @@ static bool gpio_mode_enforce;
 
 module_param(gpio_mode_enforce, bool, 0644);
 MODULE_PARM_DESC(gpio_mode_enforce,
-	 "Enfore GPIO mode for GP0 thru GP3 (default: false, will be used for IIO)");
+	 "Enforce GPIO mode for GP0 thru GP3 (default: false, will be used for IIO)");
 
 /* Commands codes in a raw output report */
 enum {
-- 
2.53.0

