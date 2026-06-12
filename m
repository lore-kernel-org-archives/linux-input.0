Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FC33C187
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295990; cv=none; b=l8l1+INhcO4CV1xKB4SXyOl/82Lt57OeBy/FEjVOuRZuY04AtFjsOL+ADcRwV/r8RequQtiMBGHesrzy/R8hEp4ZixN/1e0ILvojzoOkMPJmW3/NNPuq7XLB4UtuFRZgg50A8ya9e81LgvNEt337X0seCAw2YSbnHYFuIKj+Vuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295990; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBT8hqzpBWL4isKTOP+W9ljQgJuNOyDhPf3CK2DzM6Lj6MylH5KgZjr+Scz2ZKj+n9fGgwfUxXuYs1jV2L+qOGumBU3fe/AV4l805k3Nv5qL4ELx3p5R0ek2nJNn7bXWRDJE1KTKKkiPj5J7xtcg+ZkASe/NNfwK2m40Np0DZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AedV3o6C; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AedV3o6C"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eeea039ebso803307f8f.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781295988; x=1781900788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=AedV3o6CKP9etrouAX2aI4TYbvR95xMnhT2ZI0vfhKmntM4pr3UgStPI6woybZbkPe
         KTtc4cqXC2pFmagPE9jIfvkpYkXnK0boVxn3oRKQlaED5uQL00pO3y+oNThpEr4eXgAP
         53FEf7G7fCkrxTkm1Gmq55s/HLCHxbysWTNn6XhF8lQ343pySfjmtgCm4F+/3ZGrs1r5
         LRSvlANumz6+t13Q/S3shQz8MOfgLDPx/7SxdC2emuTrKPiISpH84xWxTUWlgHrwK7Wm
         DBNn3GBG1BGkkSzForG4RF7/d2bY6yDrQ3bh9pZWZ68527o0WmvRGsAa3H1rVt91Yiyw
         Zq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295988; x=1781900788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=qRZrzNQDhZCxhcKJVuxupTDTBak+n187xq7Ja3WpeuvblrJq/v6WBeCA2tZI5QabpL
         vlzNSvHzCUQ1zfrE6o5JuKOOUm23Ne/QGpLeJCTl3eE/OP2smZSQGlg7HI0kbd//PJV5
         f3s+rLjSe7U7FgaFuMQ1TobeN4+Odn0ABEzWJi4rOGDEhed6m9Tu1hbVbVkes4D6lKcI
         AFsh3QXLWk+gJDkbIvQbD/fo0Zf6iW95piLEO5o6gdqfWhKDwWMJuyqdnvYQviU0vyKO
         NUQikA0UXhF1CsnkfNHlZ791N+R3mLOJNbFW5OILs8zlsSnJHShatBc7kO1zO0tDETmj
         l5Sg==
X-Forwarded-Encrypted: i=1; AFNElJ+Te3kyZz9WTZ96uoJOU8Mq6ZbU3w4u+RCdN3crG/zmHzIJQbJ6T5yF0K2mmTCEn9nhiH3S+GsPHRJhlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SV3YmKDDllC0OYK2TtSvbmcCQjMNI2BNqhw22VZQHa+KQt0W
	s0sLhmRot2xY8uZ/6dfBiao5u/a1sg5HPeeezNFz0kd51NG4sJ6qVKPV
X-Gm-Gg: Acq92OHppZ24S+HfjwUmfuqDlaKR4r5VvaQbhFpsT8sDPHq1/WjZHykkqhM4LEG6mtW
	d4UV8qQOYvf2fooflkfFUVpixuFDT/EnaK4n80vdK2iKnFvs+rBcQMjOT44gwEypCrFoWUgsOFB
	d1zTLs+KP6qVRjW1qGjiv12WiZYnnZe8dguJZo4xrNc0YRQ10NhEvkdK5m3NPGDY2qQDeSO6JTi
	6MtO96DCu+MUzQhmzpKmx5kwM7FiSRfw/RpVbv/iDYbp9O8sx+36TFhWaPScSQPzMn0BHxVvypk
	VxnfUxLTVsNQQzuv52iNbX/RZWJ6FiaaDrgwNaadO+HCHXM2buwmiCdeEmkqcgI5LS6mU2X1kOu
	Bg0p1TQ31j0aRy5RZhrm+7MZh0bIXW2SXAttafxIHPhOg+6Wg90pCVguATKTiHlRfPJlRsU7zRp
	kuuAWFindgfF6EpaL3
X-Received: by 2002:a5d:59aa:0:b0:460:6731:6165 with SMTP id ffacd0b85a97d-4607796858emr866095f8f.22.1781295987798;
        Fri, 12 Jun 2026 13:26:27 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:26:27 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 2/7] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Fri, 12 Jun 2026 22:04:07 +0200
Message-ID: <20260612200717.361018-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612200717.361018-1-l.scorcia@gmail.com>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
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

