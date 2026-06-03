Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A632A3E5
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514675; cv=none; b=fNV1ZXaWXkN2TgVU/EWsQftLoNfqbRiwqs8LJOQT6QxgNk0KUdTgX1s1NsU/oathhP0sATn7QfOfidGHJAawNm+f+AFZKf3xzPe8jaCKsGuisMttquC/+kzSJtNa4iqanvahc97KqSAJb6rGLJVpYbpvlxY30Bn3nVxxDMLn2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514675; c=relaxed/simple;
	bh=krNcY8aGkY0R9eiNm2+dNi/C+OFvcaJVgMnP4s96AgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L66vfYS3g1yzMpvHAdvdyXuLKEepdKQXCHBhi5fe7Zyq/OUszb2NYKYMz3DQZIHVW8MKsXAW65D1tftBV7OREk00NRIrezc/ckarBncch5jfgCI4w+zRiaD7KSZr/1Iy+llW6E3LYOz76pXuyhRPSu2qcBZDvbmwkPDLWLFYXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCtVb/xb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCtVb/xb"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36c68964315so2852729a91.2
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514673; x=1781119473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=og++R4ahc4AookV77c97mQ8F+3qsfkk1kwm9Se/wnb8=;
        b=BCtVb/xbsFuOepRbtYjKZpSnMpYa9CF9hkX7JZCRailLBxV/ZN/YMX0uiBY0lyobwB
         l1cxAN1/vsW2bAtsB1MakDE5s9y/5IZun9A+izR/Hfh88fvbe5ix/gFjd3BViRpqT2zK
         MgDFeSdb+UA4/vshXGBEXVrXkZTqbgHZohEfsydbb0Uog46pPZkmDqZLYG5WziO2L+JR
         DEHlFHpGPrFdZ3EJTB0BDkyCKwYFWuyz8K5pGdcG5MEA7R6lak6xmq21ZJLY3SCpviaL
         8pnsQ2K+DUL7cR6I5sZf0zHSFZkk2RpBPNMwdYWRsjONWP/Gvw8lVo2hfrdm+aNh/yZB
         XJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514673; x=1781119473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og++R4ahc4AookV77c97mQ8F+3qsfkk1kwm9Se/wnb8=;
        b=V30UsYuwvLobQQAS+RR69F7JwozRbACKxd2jLQBfkhdAK9W1f6q9cKQAujOlDMYoIX
         BgXGljj0I1nKCqm/5Rkgu3aLEYU5032ZgcfoPlJXGhLWuYYYtOMX3qZzvx/xgc25zzHe
         u4QD4mtQU4TPz6RCbVjd8ADQPtIVbyuTp2t1xnu1+O2vSUo8imrMyvZtkvSA1oiDuO86
         5V4RiCQBz4Rvj7vXrulGmEUS/0nTuWHkKylh3q4vuIoPzFZ7U6tuj2aWwWmVKf1msfzE
         QRQVuHB/3kScnI0hEJaSa6ruY9n0rZPpIvZvqtM2RbUF9ThbgVUc5vxaAuSGO3xNhguq
         QGNw==
X-Gm-Message-State: AOJu0YzkYTjreMVpfFEA6qWog5QKYfcq+g0bz2Jy+d6nAIdmsB4ZcMFQ
	Yy1KGDKszIwICmgtm3iHA3b8dZGbZ5liSv2ELdQG1GX/V6u8sogf1dQvIhtHd3Pq
X-Gm-Gg: Acq92OFcD9eOP1IB5Ki3uBtG4bJQWTuEOHKCZGEaMIuvHZoLdHQIykc6CZmOBdGoIun
	8/wmEfgACB6S4kp5U7BxS+o0IwsM0YNSiiip3RRs4+JK2ZUt58Sm0TK6Iq3c/TRTdG3OIgjuTkN
	wuATpavjW7XWp93xyiw0HLWsrKwjJjt6sdWsNrxes9gG5Ok09ZHW3Rzs4hkFkYlCzkE1ucAgqn0
	yPJJVLzuPHceD/BbQ/HzX1LFY1vh4RNAMcspn9Rq9TF1ebvvJA1CnVwcAUk423iQAzhgdD9NSdV
	cmJo+O8nA7gvzthx92Y9uIsD0MV2I96B74evk5T6wePZQF0DmYKgveSSFoXQNdgr1CMAqoFFNYQ
	nepPjKl+p4+pZVMKQY9kG9H5e7LTZXaKxcBqBcOsz30MvNyLU0IzlUDjlGH0UyogE0RuxHS6oa6
	OM+Kpz+krpUFJ3wxud+I00PzFznyqDMFjodT/st8SM6a9klh3+72sO8jY71fV8jr7G6b10fpf7K
	IZ4jK6gUFv993lvwqGR1BKOS3le0TK/xD8pfytKcW5epg==
X-Received: by 2002:a17:90b:268e:b0:369:e217:d110 with SMTP id 98e67ed59e1d1-36e3486bc55mr4626797a91.27.1780514673235;
        Wed, 03 Jun 2026 12:24:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d013c9dsm480326a91.8.2026.06.03.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:24:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Input: apbps2: Simplify resource mapping and IRQ retrieval
Date: Wed,  3 Jun 2026 12:24:15 -0700
Message-ID: <20260603192415.6679-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify resource mapping by using devm_platform_ioremap_resource()
instead of the longer devm_platform_get_and_ioremap_resource() helper
as the last argument is NULL.

Additionally, use platform_get_irq() to retrieve the interrupt
instead of irq_of_parse_and_map() and propagate its error code on
failure. irq_of_parse_and_map() requires irq_dispose_mapping, which is
missing.

Assisted-by: Antigravity:Gemini-3.5-Flash
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/serio/apbps2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 0aa4ab00af35..5f21acdd4113 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -140,7 +140,7 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	}
 
 	/* Find device address */
-	priv->regs = devm_platform_get_and_ioremap_resource(ofdev, 0, NULL);
+	priv->regs = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
@@ -148,7 +148,10 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	iowrite32be(0, &priv->regs->ctrl);
 
 	/* IRQ */
-	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0)
+		return irq;
+
 	err = devm_request_irq(&ofdev->dev, irq, apbps2_isr,
 				IRQF_SHARED, "apbps2", priv);
 	if (err) {
-- 
2.54.0

