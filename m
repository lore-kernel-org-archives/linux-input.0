Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432748;
	b=SVf67jQ/SewALf/H9TzBoWsIhCXVrRnwpAShERetC/SqeM0SwknA1T3BL3PUH8gq8IVP
	 VLWR5OYWbZknh2ocn5TsONm7efgWC4El6srrPobQTd76OYKQ+K4oC1Gt0EaH4ZRinOnO+
	 ahLN0hK96pxgmpLu/00oJp9xL2iOyd8yRW5GkWyCriOFR+bDMuHgLTj1rgjTUZFs1zuF2
	 9SxATalCUFN9ImGo2QtGOjWS8NUOAn4QU213keJPzJv4/9IGM01O8JS2bvYbtXUqbpCb7
	 tgfjKH6Tvq6mLqiIqKYjksDVvzcUjfshy8Ehgbj2E5S9tZmsiMjLWHtGCpwvcGfLtnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=fhdQyf6FbFbh0WyyBUC7EygAiye6PpyKpdmvafidO2U=;
	b=ZAVi9kvrGjCE7gUil0HvTstofRE2hw4Zm4MRgjOW++49ELoUtko2FRJrXtZAIjKHpGf8
	 nxu/jF9Nh9GtpH778EUhssqM3ASQmyiugh+LJa6vgfPG6pnhRHHqC5xzWc91Raf2HzC3F
	 ZDLRfcmT+BxMvQL3NWHqno/F4QD6qgDqm982k1+K5hxQGC/fmFgbeiPzRNpg3WmH5nI8N
	 dYT34mesZojlVAjHm91XYRbnL70XoxE5NUesZhlicjcUdjoq9Dq3C6123uvu+79zw0ecH
	 tqmR10ieoPoi+jrUw0NPtQFSuwV/lp0jjhUzbl9RyYW407gNxxdoQ9ENyysSQ9UKHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTqjUcY9;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307460A2619
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 11:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9307460A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTqjUcY9
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so514308766b.2
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 03:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432747; x=1796037547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhdQyf6FbFbh0WyyBUC7EygAiye6PpyKpdmvafidO2U=;
        b=HTqjUcY9hLartbQ+wDqUUWh+DYA5uBQlIQNY8L8c0PwQFxlYvRUmqcKq9vBHjiWlIQ
         ZEUY4IVw5jmJePNOlSkdFejLPzyC/gnES/8A9mJHHXOsB8T5NCrWqcjznvksBUyFj8fX
         Gdoirno0KXw/7rEQXjyZtluV4Rd+3+z/PNlUakMZEHUQWIAO721PWX1/mvJ6P8xawItb
         ysROTquAqd3jS2dFl+6sDSphM2xYXtslTN97/hpIFiJOGhGv7AuWUlk/hK1ubkcgPaD+
         nmyLdRZ7rePh/oqb+a8G6vq0onwln8KbWQTA7ew4HWiVbD2Xc6bis5BHikU2+BPy7iLp
         b87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432747; x=1796037547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhdQyf6FbFbh0WyyBUC7EygAiye6PpyKpdmvafidO2U=;
        b=BcPDMm1MWhv/BDms4CjKLOcJ/PMaTPvHMlEZU9qeaw7qYi8GvK3FPUMS+5GEoOqQ/N
         /3AWoOhovel7BJDC683NJQocQkZWLVWQ8GtVVNrgtqMSH2qE1t/2IAT1Q5HayeRzFeYE
         HoFt+5Pg6Dx1fnYkpE7kSLeb0sjJQGZyEYbqv5T/w9Lp6gf+G482EeWEc4cWUEA+xsaN
         Flz4MUSlTmCQJkrszVWiXfDsJ/VMar1AnPwp3XYqHlBP1gNJzJKmkJpEIGufWaXyI3Uv
         aiPOXc2RbN94cx3I3K4Y+ekQz/5X9LnY6UlA5r0OpAzYX9hHlNCIqHADuIMw+m4RSGYm
         cNIw==
X-Forwarded-Encrypted: i=1; AL+hErEWvXVfuFdSl5/thM2/m7qqA/N5h13XHiLVxO4j1LMd3VmWf5xzLkCYIfJ/AOk6whb0/juas7d+fQY8Qw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9wcV6u0RA5Lqy69+Y2pPgfjiqIm1fVX0BQDVxTbkAl98WcTLI
	2Z3itLuJCxprqLuZJheMd9tBWwsY/K7MZZw0O2cEmPnq/ERuSvqgz3zQ
X-Gm-Gg: AZFdTZeRcRaO5oR1p6cC/pjWd1heIaGy5jn5BUR+6V3T1GfAUq/oTM0IV0Vu395I9id
	qp0eWvmc4fwuq53+imlHp3p5O7wTfutXjiUFU1G6zmm/lkFV74I3S79ekb520u0G4LXQOOxN83T
	HxfHUA9MeF5gRts9Z7aeJ1BqH9rXQIxFJadox+S6UmLZL7ltM5xTmRrQ+FNNZYAuM+F3d89LPh1
	6LJU35IR3xYDWo24gRcdMkQymsjeiGPd6S6ExCXIcFoqFM1b+jHE+kzrAaZoXvS+OOsAsCBtyWr
	RndKV2rgR63TNpEcCroUOJpDnzxuRTRzFWtSH2XFNmCuddG+v3qPxsCE8tK2F7dXhpNzFY3dChy
	lNp2eM7fsnzi5OyqisrZzupDywnJaA0qIhMlW+g74EFjbyaV0Dkb4VGQdQEvIMqxKsY9BPAXKri
	OOLINkAoJxiCi6kfNrZRVDUXOkp5RXkkusA8sEuXN9OH4Xe+IQqsAzQHNzLjyvleDprbIpfmMC7
	ZyHNOv6fI9S4n5mwn7M2gKPWDZgZv9m/f/Qm+yZpzQJjM0H4hMv52GcHyjVJkncZunufWGzraF5
	LK3+TFlHWJuijQVICVR7LgAdSpMSE7xtE0lcOoWusQsp6hHKHeqIM2u2QsGfOx5YCQ==
X-Received: by 2002:a17:907:1b1a:b0:c46:7ec3:fde2 with SMTP id a640c23a62f3a-c513a5ea1b5mr863152766b.11.1795432746902;
        Mon, 23 Nov 2026 03:19:06 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:06 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:36 +0300
Subject: [PATCH v3 3/7] dt-bindings: timer: mediatek,timer: Add compatible
 for MT6895
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-initial-mt6895-v3-3-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the system timer (SYST) of the MediaTek
MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
through the mediatek,mt6765-timer fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..ee4af54c29b5 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -40,6 +40,7 @@ properties:
       # SYST Timers
       - items:
           - enum:
+              - mediatek,mt6895-timer
               - mediatek,mt7629-timer
               - mediatek,mt8183-timer
               - mediatek,mt8186-timer

-- 
2.56.0

