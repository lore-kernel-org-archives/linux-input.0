Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804463;
	b=oISQR8CmIk8NLzbzO0hILyEj1ypSpEZ6RaDONIVTv18LojRGPjwi95xEJs22UKrxt6gk
	 V6R/xgmkKnK1T8erRTyu2kDsTVL75rPcbW9SQvzXBMcNPO41tEo4v+KuUlM8tztEMZks6
	 ff9n4jhGGuVL1OT2wKtJJ4qWYn4U6P9KM1akt/U+i0MEI4ctN09cDBT7euXopQsESWf0p
	 YRt6vFKKTSdSP//+Gq0CjgO8AUFBA3miERyWPukfGTPmBwocp4QCIQpPYZjfbEuKKPCMv
	 imksi5VLrXl9NQ2TBjVDT9vmR5zPv29j5/YJDy90rQRhg8WllzA2yzrKC2KbreRIQfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e81tcatBHOQvCatTtne4Vl4ETpILuAB3x6t6D2nRZLk=;
	b=WdlquNnXuMzq17zZXF5+dwe4PcSEE/JlivU+X4FV7qi3j8vX5zcqgRwJV07e9Jmo96V3
	 ZC8jRbIs3NhVjiRv7IbxcLkayGXsrLs9ZcMqNRGhxBL5g6DHvyg7EqLP7r0B2D2PdDzhC
	 bW5rbbNgwjHeFpGvobEyeKYk/O25FahVPhBHtDLYP0wE0bRuuCzhpZa47NAos7LVKsXco
	 L8u27YzbY4j2aHe8F9LDM2em1kodPa4Y/7x04HToq7K9V3PMLOjMPCCPHwxh5kUOUa6Gr
	 1fQBQnoWWMdVXbAg8NspwgnHqBN/2BI0qrRtS7GzTYWH7uROmgUecmSr2EoaEABbOIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzZA7hIw;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89982606A334
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 15:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89982606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzZA7hIw
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1725379eec.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804463; x=1794409263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e81tcatBHOQvCatTtne4Vl4ETpILuAB3x6t6D2nRZLk=;
        b=fzZA7hIwTwFCLtV3HBfFHWeAd5CaDykpU2HEZkvxrySCFEBwVxlsb1eyI5C8dI0btQ
         y0mAt3u0EjX5CHg1SB0EcaMpBEHVM1+hd59xcC5gw5VscTJQklG7JgNAc2uW93pE04Aj
         tFGABa2fl93KkXxUt9jOCOU60LDZjJebHRINVV7F/saYmetX0EqsGlsr+pI7F0Zaguj1
         ZDjJ9bLhGzJBf3f9gDuG7EXWHOxGKhbAJha7X3U2zI4ZhuJzhO6OYL4VXmvVEf3D0fqE
         kNFnHBdaYDPm3O9Vjg3NdIKMsrknnXGY0TDErXA89YQTFYRYQSwwSLXwvEmBjy8g7L7g
         0P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804463; x=1794409263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e81tcatBHOQvCatTtne4Vl4ETpILuAB3x6t6D2nRZLk=;
        b=F+TKkd/KnNf6wBJYET63+TE5y6V5vJ/w8NP2Qa/RARrZeKvbmuxW7HMAp0b9+fRD8p
         1SZA+ZGAKSTOC1YoLEsuXz4g63CefPN2aPcYzOTKFHZMT3+/MTe8ZVhQTivwSUZDc5oL
         A0pZCG+cJSm4CN1/VvezxRYkmN38Y1pJVDuZEbUUrrIQ4L1U+Zr1HIWVin3l0sm2FMRP
         Xia/wiziKM64hYQsEFb7Gn5oPQH+/WqFg/wyvQi2OlE77u9+QJEC5AIkFyCgBKtC7om5
         vToG5pSQzQp5Oj9O7GvVlVQqTmdRF7KMxH9etHp/6VPVebCPpASawW/8CqEjIqiYQtqP
         2hxg==
X-Forwarded-Encrypted: i=1; AKwUvBw/0DuNMYdmOl0ls2tZ5FYl5sd03BrS/8XaC38aOJL2GLHzVX90aG9/+7A4T8ladjPcyo2RKo12Yihtyg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8OXFlu3BINgLBDwOIKaWS/A/mccY7V5sWhBGb8RX/tWjMz9aSQ
	ulzon5kz39A9ywUP+C1v9gik3xmKsFPJhggw1uL5r61lLa7bvO/InY+b
X-Gm-Gg: AYBFou28YlHuN52PnTVXiBDX/PlnKc/2ZnzWtmWD1H26fTiB8HPPIMXp7pk2MbO4/Cq
	SZXQLJB72EqdikGJZaIufsxNGLRoejsv63kYARPrQCuxButO9YFqs81uOf9xNReFIvNVikadrM2
	mMHuIFvdYD8PV7tr1FXp1ISL1auLHR2BjOsGgFzz6Zo2JsY+Clr7Tth4EyWX14HfdqdwW041kqb
	KDcNxrEBOefAiLBSah39CNOCqA/l5CsVHXBqUepQ+aIw7rM7zFqsRnPNguCCtrabE/LGcZi9AQR
	j3ikhjuaVMmOCjGqAO3Wr0jSj2Cc9BkYHaG6wdUgwdI+JDvbgEyAL3ui6hNGh+NDyPnZozf0pPq
	G+9bJbaDmBs5IfxAF8yHrjZiuDQgXXT4O5xuf6ypu/oHlsGlKR+Ua5UFVuZhOC0anQNNpha/sSk
	Lko9yCHn9gs2x/rb5lzv2YHlhFbq3pQRAAzFespgrAzmC9rQUokkIuRPThW99OPX4fSHvGXXq5H
	0n1DKr6kqZ2D5IBgtJuzQSXRQSVbaqdFazPuCLlp1PXGxz42KjTWKnzwkuySJxQBU/YOK8oAHMm
	sxnXBhga3Loo37W9UG9k6+oo6yHcyKxgxift8FCwJ53TiaeeUOd+H1tJM+Y3lJ0qW4N5jLqE1TR
	4L7ZV4u5lzFif1FylNjNfx9oQabE=
X-Received: by 2002:a05:693c:6092:b0:369:1084:8ee3 with SMTP id 5a478bee46e88-36a423e52c8mr28908255eec.23.1793804462315;
        Wed, 04 Nov 2026 07:01:02 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:5040:8550:f5e4:709a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fe477sm7347457eec.17.2026.11.04.07.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 07:01:01 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] HID: pulsar: print the battery error with %pe
Date: Wed,  4 Nov 2026 20:30:52 +0530
Message-ID: <20261104150055.33028-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
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

%pe prints the symbolic errno, which is easier to read than the raw
number from the PTR_ERR().

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/hid/hid-pulsar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index b0b34849f..ba7cc9f65 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -615,8 +615,8 @@ static void pulsar_init_work(struct work_struct *work)
 	    devm_power_supply_register(&hdev->dev, &drvdata->battery.desc,
 				       &psy_cfg);
 	if (IS_ERR(drvdata->battery.ps)) {
-		hid_err(hdev, "failed to register battery: %ld\n",
-			PTR_ERR(drvdata->battery.ps));
+		hid_err(hdev, "failed to register battery: %pe\n",
+			drvdata->battery.ps);
 		drvdata->battery.ps = NULL;
 		return;
 	}
-- 
2.46.0

