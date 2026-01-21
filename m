Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9E436367
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031729; cv=none; b=oJSG6YIC5ipnfUC67aCYzZJ8lxPQ1DSiPdiBpif1Ze5OintRz2xm2AswO/dTMwBi5Rqq0uUToA4Jkn64YP6JFyu0DVyBllxdQfk4kDYEetZhB3fc388jOWNxTEWtnCdiIIPEs7DPv4sJ8Z+PaXO0bMMm3po4Gfu4fHbTpdHdYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031729; c=relaxed/simple;
	bh=GZnPKOTa1HqnzuYZeMPLeyCydNQCmNfziboE4iAektc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itHYe0B8mQxnZuHu4ersHiY4qj6fgjl62fTTIB7fh4hzVZM11uF6vuq3pgmA4yGMpeva3TPlXn9iYkULV2FJRGvtcfrDc9djGuyjNPIVff8tydEaY7f/s2NwJFsJ+lyJjSHyYR6pzPB4gHNerQZCRIiHz0MeUmVwQDW6RxvYtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuSAm1U6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuSAm1U6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso1467245e9.2
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 13:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031725; x=1769636525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOzxOEsKJTSa9ITustjB7WD7pn8Z4/rVt4c+7xkqZK8=;
        b=VuSAm1U64NJQdNfMnHDMY18uTDhX/c5JryF0ORORbCXHjQUs5qkw6EZW4SWUSXeDcA
         +08SY90/Q4MtxqZPL9eZTKCuzlAUZ7aZXBUG+4GfM9Tl3fBJ6R4YAkuQ4W0DNf3v9fvN
         lKX5QUkDdXUvPIV4EGy26xu6CoB7jXUD1NYy2bwNeCB6X/OIpsJUNeL7AO59SCHUY0Jk
         GAdPkMgJWoLbWzJxzmEb1Kihc/Um8A3W2n/gUmGiBfT0jGgrx9uiUqTAZLjz8R1lKW5o
         bz1Sk24k6OOmp9dY/k8CbfUrmgJRHhXNyG93E2EETRKHtO4QPFWc+9MVjLhzbjACc8YN
         Bflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031725; x=1769636525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sOzxOEsKJTSa9ITustjB7WD7pn8Z4/rVt4c+7xkqZK8=;
        b=B07tQwIJMZ9yVLjSXm+l6g+vSu6IFh09uC2pb3j5iPwof0q/azDuBx3lWPviZPGUpM
         w+zfgwdebaK+9vJQQlzvSNcO1UxGNQ54kPNnqHuZutMFcjjxl03P6uzRSkCMNionSMKJ
         wEVz/sjdrvw8S4VIQ1+wWcvKjCuah+GeO06WW9U33P8G1WSCUT3jjl0A09VvaSXjBD+e
         LSXBZCDaxeNJeIhidJI0wT6Jq9VWnGLcrlz3Qmuag2AEMoTq4pBg3HfsJQZH5c9NeRsT
         QmPg4omiuCdIQ30sxBQVabQlAAqAeP+cBS6r1dp9hNjXFEaQrhqdnatvkKjQVvJMGCa7
         k0wA==
X-Gm-Message-State: AOJu0Yw2JNX8h+O2ksjLlFJ+vEdN0D4wOU2lVANaCDB8EtzT5AAbDGey
	DVHGZvHNwJ7exjsInQNAKciYhDvH2lhN6Yo7gmWrKLZgCdn0FUwNQPRNobfOyj4Q
X-Gm-Gg: AZuq6aJAorXYtFbY1STCrqWa/uFT1N2JQl0JIXjuu/xBoBd71ezipzVPqE6xG5KRrtJ
	/SB6B6Yvh82m0xDeFwfi5f5Rl/sF8EpA4gnm8fXbD8eHnagniUgVuAAynNfMJZKCfDsk5FReNxq
	mMT6mL7ZzuzXEajZPbAALoHwyS4FtitWcw/xQLd+qdW37ecqXBe2Dw8LI5DmmiLaV7g6//7w7sr
	Bd55LvXngTYtiF6krxxP7P0coC+NCsQ7dhPcVzKtCrnFps6oBZQf25qxgEnh06ut4VJmF51uyAb
	i3UId5BGGAZ9TjekEBY5tTH6shh1UUJY9tKIG3DZVWsJqsBOCgtvqImQMsoaISQxo9tf30D0Akm
	iwKyh28yffRv7iC5CYpBpEPUVwtCvnqzMI2d2+5zTSxO4jAKAo4rDjOUV7Sy2lgVuQV8gLujn+C
	gm2gusJTsCYlJPOg2fBw7ultl7
X-Received: by 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr225401275e9.13.1769031725266;
        Wed, 21 Jan 2026 13:42:05 -0800 (PST)
Received: from unknown.tail46804.ts.net ([78.209.83.30])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm38351929f8f.18.2026.01.21.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:42:04 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	krzk@kernel.org,
	dmitry.torokhov@gmail.com,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: input: novatek,nvt-ts: Add nt36672a-e7t-ts compatible
Date: Wed, 21 Jan 2026 22:41:39 +0100
Message-ID: <20260121214141.36858-2-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121214141.36858-1-morf3089@gmail.com>
References: <20260120193600.1089458-1-morf3089@gmail.com>
 <20260121214141.36858-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for the Novatek NT36672A e7t touchscreen variant
found on the Xiaomi Redmi Note 6 Pro (tulip).

This variant uses different chip parameters compared to the standard
NT36672A, specifically a different wake_type value.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
index bd6a60486d1f..aaa9976bd65e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - novatek,nt11205-ts
       - novatek,nt36672a-ts
+      - novatek,nt36672a-e7t-ts
 
   reg:
     maxItems: 1
-- 
2.52.0

