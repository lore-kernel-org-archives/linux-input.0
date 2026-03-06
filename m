Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E3378D8B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798765; cv=none; b=hqt/6PdPnaui/Bn3ZCva0Oq7o8FbH2PTf1czqM+lkbc9r9ca+rpFgdlPKWnCuFo6anU4i5qimuVpDU8hZsnnlLwzdS/hyxSA1k69Z1iiZreA9o011XcV1FOJT4LO7sO7zXWgPFLt9qtVKapCQETtnvaxT0sukQu9cdU6IanK+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798765; c=relaxed/simple;
	bh=J83EIuQWnuvi57JW/hDPZJDW/A2HqSUqADqfDfUCqtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QanXhtJwUFlioyFyWNU0kR9T/RWRaTv7Co4E9YWYzAh8UZXjxfUC/AfON6QeWf/ESOqHiwIl4uX9mIu1DEN1mK89x3iCgE4AUUonyhd6mtpTZmTv/XcXhCaTE1ZcGvn2IODhC2sBkK0mr2USk9GsmYASSjKHLBzbkd0dOEmk5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deu9DuPs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deu9DuPs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48375f1defeso69104025e9.0
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798762; x=1773403562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1Te5dWKyFtHCAsQSaH2ONpVBfHilH2WjO8uBzqlY+c=;
        b=deu9DuPsomq4gkRyPCtlT9+w00KPZN3fSf6cPUUbPTbQKNwLRvmo/YegdiNSmq2cgJ
         NA498QBzW2+K7IXUIW3n5fQ2TyNshyjVa6fcM0sQwWekUWnNBAgU5dnwMVYA0CMvgxiq
         RLp4t0HUThRig3e559GHHTmAA21HwHhVIKfJ1E+NiWxlgqEuFBXa6adMmsPSMpVSGQws
         VfFtht6UWWRHNUmH++3vyzaEekn4rEyeGFY22vYDzX+JgFgCqS/K+LqjYfxK2riYqyRR
         N/4CSmES3EJ6UzPBjJoC0jAy8bIgBZMXFv7aGEsSckXOuCOz0gopKxU84CT2/Ou66wYx
         G1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798762; x=1773403562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1Te5dWKyFtHCAsQSaH2ONpVBfHilH2WjO8uBzqlY+c=;
        b=Bul8vo6HIJydllQymXnlxx4Ul9QypiEU73nIvdaoXKZMbeGSE/K+f0pb/QoOK9nXhq
         0UFfW8ROk5KTpHXzSfIpaA+0vimbxd19nWdoinQeycpZaI537uDv264R3dku7kuw4z4J
         0JlFkR0jZSl4AKnzSkrFfhQeUsUBSeSY0f3Yx6PwHuzRJJ7vvZRpN7rLoskaLH/fNhMp
         M6IvQjAziKpj5W61hLDGfhtF5lSj0B5ApjXMsvsPhetVjgtNLjSW51OA6fNuuqRxgG3S
         kZwVwTUqiexiE56rMOXiTFJd+ORgHXP2F8tY4rWb+poSF2BV1WFEE3GCEwSU0mfZlq0r
         Sfvw==
X-Forwarded-Encrypted: i=1; AJvYcCUqjnlU1z0ajUgwXWOCY87P0snaUwVEtUhpL/Y9PgWQ2GDOz4hH+aye1h96xOGmreh1ExB0oEMKmTppBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRFd/s4dS61aQ52Ffn91vgFWWWsfqvGXwGhnJ9WzUxCwQfyli
	WoBCcbSNMsQdu/R6ivK0Y6a3CXNt0js2NbUmoAaXjKe6O3g2me+BoT1w
X-Gm-Gg: ATEYQzwDTnSgEppOp9fNXicqcT1HXgX53NCX/i0ns1J77ylbmF4b0u97gfDU0JkP05H
	OC6A42jq6C3E7Fh+h5b1eNUYN8XO6qM1k+bKeuTO/Ce9yPg8cz/Y4A4nHUp4e7YW9XkI6Ij6Wvs
	JlpwXLgs0BASYqzK8ZxSDPLugrqORIWZyj/GDQo0386Eoq26bwu4A9gUR1/NoNI5Pm6EkyJXmz3
	ZifCxZ1zXLlXdwpTD6f+aZUuJ4zFSDObvWCSCEJETqMDDH3oEunccWI0qWnfOWA332pPUjri5zl
	ddXG2L6QtKWD1fivvmS9MaJNdXcd92YkReWLE6w3+3VAlnKz/uTMMpmkJHvqHQejCpBamwDJCVJ
	njTBSflcXmtXh/Lc87/0GyAKMPyqCx5HyWZhszXAj4tOTV8Jxl3WPpxtEyL0muMFpv7cyHLx127
	EeSYHvDOrV8cppSTlZHh0=
X-Received: by 2002:a05:600c:6386:b0:483:afbb:a064 with SMTP id 5b1f17b1804b1-48526918f7fmr31691795e9.1.1772798761805;
        Fri, 06 Mar 2026 04:06:01 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:01 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/7] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date: Fri,  6 Mar 2026 12:03:05 +0000
Message-ID: <20260306120521.163654-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10f..c358b2f8059c 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -72,6 +76,10 @@ properties:
               - enum:
                   - mediatek,mt6366-rtc
               - const: mediatek,mt6358-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6397-rtc
 
       start-year: true
 
-- 
2.43.0

