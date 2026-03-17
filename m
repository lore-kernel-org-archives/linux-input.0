Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81C3368AA
	for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773141; cv=none; b=XLIbNk7AvRH5fDHp528tOKKai3JtvG8dCO+JWS2bu1KCwQJjeZQtvEeaAJ/t1a863W2Ny3YEVD2Z2M5zwplNgo6aoS7n9u1Gdn9O0mzXpVdMgPkqvZCYflnckhDNf/6K14OR8mVkKgiOgjb5H0yq4EemMhi9kTkPgvI27lIJzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773141; c=relaxed/simple;
	bh=ZfqOUDFz7v7R+mSXLBEeMIVnBZ09sWfkQvpiVD+GjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK+AbLUdRl1p6NALH4AvwZj2/KE5VMFznp+8Foc6pPRSExIPaU1GOXuuAF4atdAWwmdVAB49ddP0foOxTEsL3Mxlthy9O+V2PqgfbkaIsZrgEGlR+fMMZDO2pbJq7uCUqUhDxUy7R5qF3wL7ulKVti64c+RgSoPNuyfAoBdnV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwjY8TFH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwjY8TFH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso69479905e9.0
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773138; x=1774377938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTAXSeu6BtwHvgdghXlLX79R1MN9WAcZ3+G+4vaYWf4=;
        b=mwjY8TFHlZGYD59OayPabt2eM2tZ05M/gG4uikPVwIyJqeVqF+DaH1urznwWZldGNx
         uBNXk6pi0lVHbqPWpRC9lUFgRMGIsIzd0HD9XFpKtj6sbaRs5T8AcvqEfhI6TTyrW5Ho
         nrmSW6wXX8tZyNZVeL/HOwjlq6AddXFUCBNduMDHYUxH9zSbZlD1lqRJiZLCotswr5v0
         mwRABOwf8i3wCztsyrddsxy0w3FhXJG4WyviXAJb/7eIb1bKNx74jyApzwq85y/RukZI
         By+aGX0W3Qxmwmt8ndSeG4H6u71sBPcE+VONWc70MbKAZZmdtDOTttoYWYJ3yN6tlP40
         sWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773138; x=1774377938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTAXSeu6BtwHvgdghXlLX79R1MN9WAcZ3+G+4vaYWf4=;
        b=AnSBKuPTyexTUZMJe4Ged1uXw63zd3dWGbaKcAd1aCy5tEzTSQedvxv6lRUC9umC5x
         XBZ+lPN29E4KcUShJeXy+Sb/vg66YYifA8JvoFDdBd0BNgUA+/JS5k1sik/iQJsTMF0H
         tcpNJwJpHj0M47SYttC8rOnvUmqfn9SRxzmj92nxyipWcn5wQLwlbd4nz1GkC/rI45oe
         LrbKmRigAqFKp0BwPpHFXE4iIPtG/cY8V1f5AyRtg01r6E1cZHsNdg7FD6XIeSAasIrC
         II/wHIEvk4sWm/vejzHNHRyPMxHVEZxKosoihwazeHNv8XyUZWs/lc9Y6FrS50HaQw/5
         JTNA==
X-Forwarded-Encrypted: i=1; AJvYcCV/x6yTX3xZkaMMdRNDNFsUlEt5ibtT57MlWu3nn/2NZjvbP0NfnVittQYtIpGImFRzWMfPMkgbWkmOuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7DmbLEEqweXKq2I28i3wjNTtyFj1rl6hPRyH9xpfQmFvbBcu
	LjPAk74HTz5n5LfKH+GQLsZzOlhYFgiTWYrV9BbqpDmIhQ2yFL3uyqEc
X-Gm-Gg: ATEYQzyf0kJwZVAWPJDhzK2i9kL3X5iUCfQPXvK1KeflEftY44VCNJgcIzG5HSnY8Wb
	I+Y9pkEfRvKv1sgLfvmtvVOJKz20PRfK55wbz8nruud/hNL13dXeYl3Ndwt8Tcs6K4NHbRvP1Fy
	ZedakoMGTQh6OjDzx/m3balmIdxZ3ZGYrw4YjX0Ib1//seJCWksjpa1oJUk1SQLByb0ahw/QAGe
	cgvg0SDYMFhtCwGmUN5sWLjXubDeH5hsWzj14eAdtPIGKzkocIe8zwp+aTzRJO4xXItfZdD5Rmp
	DSedRKX0UM2WT4Q/lERWSVyNs8b2y/x0a3oTNvY6I9aUhVGK1NpX4lsMqPMeU6Ad0EYxwQdXNXz
	G+3q0JB7eNxsf51oz9+Q0DXlGYZLg23tJaYdPMCJ8HECT/Ikx9bwaFWryzORyqwUaoDWK6poYLd
	rwFjyT4/mfhgHC3qr/7q0=
X-Received: by 2002:a05:600c:1d0c:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-486f442df4bmr10381735e9.7.1773773138294;
        Tue, 17 Mar 2026 11:45:38 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:45:37 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date: Tue, 17 Mar 2026 18:43:04 +0000
Message-ID: <20260317184507.523060-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317184507.523060-1-l.scorcia@gmail.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
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
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10f..22b09e148d7c 100644
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
@@ -68,6 +72,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6366-rtc
@@ -92,6 +100,7 @@ properties:
               - mediatek,mt6328-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

