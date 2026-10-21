Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579912;
	b=0U/bd9vOdSVCMoHDZ3cuLs8NpNQ7j5uASCi3JCqEIylXC8L1Q2O3m28UNj+jWLROwxFr
	 yhh7OZq3yTb4wi09OXNSP8163UzkY2QrB+S5/UxcdicnKIvzqrg9M9A+YT5h3Xh9AFevr
	 eBAjCJFysAeCDpRv4YzAHPJGKdfy9GRbmTO4Z/y1XL6A7l2ZqDQYJRDuFTZQHEcuZm9zl
	 jbhMuE/c+zb0oQhsMIZmeaOMS542jsgy6jcULKxUhCMylTQShKUj87HDE7w3qbBKExKC6
	 5AEqI02CFwWJX5rt3wpj54V7GYwFQd+sr4CcIReiW6SRH1q2sSO3aD4tXfpEJcutmcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LPY8vdhVi6Xj88wwWO8EGGblZmNfcIUJaJL4gRNaJy8=;
	b=oKqS2ijsolW92cq3ae57NEm3bUEZuos6+o7exE4wz9ENAu3FGt8ed/fyis8Eco1wHY5L
	 Wm04CP4atBfCzHTbUUuDH/1wNFrPbbvmDzhnLNDBOWBA2/nOUM4aFsGRnrIs7Pewxnypt
	 IataHK8veUgCrVT+/pubA0540yhuzM0nGpmN3mw/V04jwaa0XnZ74vdcD5JHTfVgdS/Is
	 g8EDQ+e4SJkUz1D63aptjaJ5DUE0qUzey7+dG7LvMPa6SYNfX+W7DX1tiahNlDyH/5V4e
	 8nyJRi8Yu5WfGfgH07y1bAiSiqbXFim+l8SdYZzl1uOeivXrwwdEncwGlxEAIvKHZBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YogfN1+C;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40E606A31E
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A40E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YogfN1+C
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so4083845e9.3
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579910; x=1793184710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPY8vdhVi6Xj88wwWO8EGGblZmNfcIUJaJL4gRNaJy8=;
        b=YogfN1+CAf8JdXWXwZ7r6WzUlJC6+9QrZ2QzvQ7egcgdx4YlcjZmr8Wkq9xMSirwrX
         TQ3akbrh2/vSRJO7DX6s/eGHPkvD7n3zkOkFJMTFj4IvhQAEpMrUQBJEPwa4oP+CzXuY
         vowBguEv9A5WkWSVU6lpkVFR6GWylkbKA1AmGL1KfURAgMOX9BIgeG+lJ0Q3YnvsVK6+
         bvInFcxanHjXF9lDsdu/eX5D4W9tKVUUSpJ90nfpnp2+oBi+QIGjPSVvqP0feb/LGVTU
         Bzte3AyM/xczq1BDIOsPD3Qf15Ssq55++QBt+U6CAhg6W54uPhdf5R+7R81UiF0BbWku
         jB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579910; x=1793184710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LPY8vdhVi6Xj88wwWO8EGGblZmNfcIUJaJL4gRNaJy8=;
        b=pUvn6yzMH76LMuTIz+URjy4pixCIp0TDGIOFqyJHC8kJblMbZ5GLVESzQiCXe5deV7
         ewCZESgj/9Onz5cuN2VM4CU8eXC/PWhF8sq+z/CtZCAip+mELCySRXf3Drpg/I35u6gc
         3py7fGWIyvgEFygR+3r0X/rzv9m9uCkgoUWWvrYlTT86Xr1/yHQFZamm3wF4UJEGtz7Y
         jvR+RqFPZ6fJ/csXFWSDoPbC0GrLql8Trqjw2kptoFZnkqh3KWkM0vY4vlTt57ndJ6ng
         i8wKAr7AeaSUgBGMljRSGHHBPyg10LjjTyUs2T8ZfWpO3u/nMTG4eOPfmOaTIHfEqGqc
         wD9w==
X-Forwarded-Encrypted: i=1; AKwUvBwI/X8WKo7QwMtp49LvNsP+vM6/mvE9YjxN46KOOLwzcS7vu3wM/AvwL5Tu8ps1o5Dn/J0posYIA17pHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK4comVUPXtqJI105ta4ThhspbjYR1w5MQG96GIrqsbVd/fF+ot
	JUVNxa8ipI0i1HWQ9EEhI2LYhGsUlyWaS56sU9pNYa/Uxd8m78/Jm9H3
X-Gm-Gg: AYBFou1R6hmQSjvL/bjXjjDkbc1lRy8ZW8yeG7XNhP1wiXSuTeI171JCUYkYfAI41DS
	hFH2zVBfNWb00yna3UMxV0Btv5AokG4fjrSiHMIiBVL2OWX6kF2IQ2Li8QrElJkkTi+Pm/RWYa0
	x7EpmstxQTxM79GCr8lSi2Et119YIDJIdqJxBpuUvKuRa2INrz6QNFnavjiLQJOcJ8uw97S4FN5
	nrNeBakAtnu++Q1r4Ohe3L8zj33vdGf092LYZElGo/+hxSoC+yHszBCH1zsNmvfNeFU76g2t+SI
	y52MBIRqVkEmebqrAQ34m7OUtVogugcu+7AiEtkt9ie0b/1gVlFJztqhS2I05sjiVV5GCP7UgMI
	oOFGJxsuDu/ig66oY2XuDeJXfhGOQvDuzwN3gfIQ3Jic62/qlPJXqzlExnAf9y686q4YNuPgjIE
	cf5xHfTEkUn5Vlo9p/xZr4wcvzLHLuMWvUxHC57A6EArSh+e7hm8xoSRGImBYo/C2m+oeu7BlCx
	irBczZtg22zQGFC4dgVQ8xYAu61NNBOQ9tGTmfN4USCLwREGS8=
X-Received: by 2002:a05:600d:4447:10b0:4a1:d1f7:bea with SMTP id 5b1f17b1804b1-4a1fdd1e568mr25614785e9.17.1792579909764;
        Wed, 21 Oct 2026 03:51:49 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:51:49 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v11 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Wed, 21 Oct 2026 12:47:19 +0200
Message-ID: <20261021105109.199886-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..da534fa324a8 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -72,6 +73,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6359-rtc
@@ -99,6 +104,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

