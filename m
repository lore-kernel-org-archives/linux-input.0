Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9D43F086
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228766; cv=none; b=jNhjpW8TT73ACSKeXQ5d9KfuGwmKIAd5O07W8tXJXL8RtLfW50aKJsHcz8FhLQFk9dxQLvhKpKCi+W9GGuCEcg8GdQvpTJGBa0gFCxH2kUHJnmNyOJgOXGMZtR4G65FXTtCEuMIBxI07K3Am6UykvfFvM+grijrfm19V4bpSXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228766; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCLBNxaGylRrysx+dnqvnsrrht2YZzqazgYwd1e/J6VyqCBvsBe9OsE27Bv+TxhKYBSVQ6O5bvdmVysRpECVQEImhBvnaYeaVS+IGVBtagkHQ7tyqpveo7Q6GV7gh7WekGFnbArGIPzFUpOsmgR2xChyNiUZCqQHw8T1btPBDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smH3jAQh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smH3jAQh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49954b88fffso22524755e9.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228762; x=1787833562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=smH3jAQh3vCdNjEeaF8UD3BHn5lWWVbhOwqm3FC8giSqd9hZwfYsZeeL4tdwGGs1Cu
         S3i0NEZd+bqjXPIAOuWVTA332n7IMUoZqGQaEvDtGTybVuCL74ADlT53Eoi8vRiJ9ub/
         4t1HZdFxl1kQoukgKuVTlctHv6Zo2XlXuzP3xb9eBt83EEtYcgmUCU2aGt3BwjPWZxi8
         PtRyJES5t5KSkshDSzmF7g2sA2rZfhP55t0MVXNOMGxij+bs7nqragOUvxfrn8akP4in
         mpBwd1m0X1BbFpraBDCseUUMe7DQB9xOr4WBTrQAs1QdlLlUo5OFPQTo9Jpc3sTSLXMt
         wMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228762; x=1787833562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=PCeuxb7pl1oVTNaLN7EAqIEwjhOcaQl9lodUqvtp9i4IBQvk7AwMLA0sZJY9/Bk+Im
         iY4RmWbWxzdPZwlKK0v4kFXcg3y3pfKaCVgRXWb7bJLo5vmL2dL/Y77Kfb4GaLAtHdBa
         zgULMgXztz44k2sAQYP9kCoqa0B4ZAU1snK/g68zkOUxO3YRx3p4SS5EyYc88ZSjgWSg
         0DBOwmibEGnkMnR38yKU0KYV0zFik7qS7jAbyt/j8zc7re1fOto2bcwvEA+7Vime1GGE
         f+ew+8NErg+hHSdpkvrXn08X0i/7/BhzqzUSvOQV+OTwb2uO87qc3YvAa1A5+y14SVYn
         1USg==
X-Forwarded-Encrypted: i=1; AHgh+Rrri+iGbMm3/fLHamoJ3IEdVC6OtdSD3/9Vz0eAbZVZfCnoFMV8LZfPkzPg5A1kCCUNtGnFSBu0m3PF6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcEOxE0GJVLlgnegfqKAk034ly4mtODoiYMFhQ0TgEW1feOZf
	jmo6QjFsikrtuFHxEqSxlDe+S1vUkznJIT5mh33qFvSl7kOHA3mXpD93
X-Gm-Gg: AR+sD12C++5gztr3Leiyup+Gt4G1/hiNC4hcR9TUmnTOtwETYuzOg5xCrbOEBb7vZl1
	3KgOXG4zfjsPnu+J1HLuibJmaA2zKfNwgbYqtMYCsHQ4Rtr2y6lIws0UBfJc18OtJTUBC96BckP
	nv7xfAMSESaG8wtbyumtcIk7w6y0gkCnRTlJhZW/3kG1DSwzLmf1EQL9eGfGqx09BzSeQk4PDJU
	CfXhiLsAm5FjyVnildaguc4gOy6id8eF93bt/Jfq4vvo77VE40LqLB07qv/bnXEf/BVNQWy8nEZ
	Pmdb1EOCUbzrH7HdGBezvYduNu7xX3KGcs3ZhxqRKM0IT8v4njAMs10ZhUXT0aq0uci+ovIqPij
	OxRcCV/Kb6XbsSNpmXRHvYgnKvDkUHyyoYeW/nwKLIIjCBeisGZq5WQhRjnTeOxj1B+T9f1tAWL
	HoNSqVOi3TokvGcCxhBokl7kXqRfUYOdCU5abmRfJxECrSokm8BGwSwg==
X-Received: by 2002:a05:600c:8b65:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-499aa1722f5mr231760135e9.6.1787228762272;
        Thu, 20 Aug 2026 05:26:02 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:26:01 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Julien Massot <julien.massot@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v9 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Thu, 20 Aug 2026 14:20:00 +0200
Message-ID: <20260820122242.120039-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 140a862ecfbe..ff720588128b 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt6357-keys
           - mediatek,mt6358-keys
           - mediatek,mt6359-keys
+          - mediatek,mt6392-keys
           - mediatek,mt6397-keys
       - items:
           - enum:
-- 
2.43.0

