Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7093054EF
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507943; cv=none; b=n3W+zINNlpG9EBIUwXWN0wX3ltXCvOkb+LLkmF5+47+kpAt7AEOCsLvr/dwQ6YoxgtO7mPwDCJTcpQ2icCk43HWD6ZWVZ0Px64RI4Ew49PTsMK0IoxjH5sGjGIOy6hMr+5n4UvvHuDlvbPYye7nBCn7FT8xnM09TNiLDsSAPxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507943; c=relaxed/simple;
	bh=39n206CmQ8BRbq71T9wut28oq9EZ1MOP8rFLirp5ceg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxSnqjksT0XwqLOyt+hbiygP/Bc+3bvoJwan38sBEfsjKE4enFzsp0RkPjQM5gkKNg+CMRTqqigQgS8hzTn6DCz4PxEFHLHg/Fn7+Rj4raiswmEN74Sk7er28UCUEzDOp4U5JU9uaffjvCoAEfQ8q4k/FKTmMdX9OkSR7dPCPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pznMkxxP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pznMkxxP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-460166910e6so1521916f8f.2
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507940; x=1782112740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l1g6CPnWeS0nbdTC0p6FeyNadxSnUc62NucgUQYfYI=;
        b=pznMkxxPsRm0Y0UeSTdzN+hU88kV+QNuSZ7Gt0SiRctaFEOtwQLd1snaMVfprEyasG
         KFwb7DA/ka/apKZB9+u+7a0pCujujWabndQI/IJlZ32zz0fgkugt1nZCtk3OwcY0sFXp
         gdXXZ6+ixiTGrHf+JHa+1pGdgyiqQEpVgoxzNy/6kU19CLSw3ipmNs+pCRrJpCodzQ7l
         t34l3A6a/CkJbdmuPr2NjeFGm3EYnzm6C3NE8mYjPdPNjWdY4Z9f/C02HXCGITDjfZpN
         okcK4hgachbsaqXxSChgcbcpztA4vuhBZQ8TVc1fYH89hsedBR8jxRH4sWGgvdWrv3al
         Bk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507940; x=1782112740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/l1g6CPnWeS0nbdTC0p6FeyNadxSnUc62NucgUQYfYI=;
        b=NiZO6qjYC97scvvfqU6IyYHMqGw3j0/vH0LCUWv8J95pnRQSOAEkHb37jdiWFh0WRv
         Zn6GpfPjyqlTRwGCTIOEw9B/DVhO+AQVfEd2MBMpCbbIkOO8BSfJuo0+aX7lMEe0+DsM
         kmCooxWPH0NgsG80dmyyA2cOoCG7bgB536zDbswv9ogXq+Vq9AwPTRUU2SlZUkcHbsif
         1nT857mE994trbSVIeOYbq9INMd5HYhzqvP4oYUxF+4AR1vaR+267TvaYjWF40pvSh3D
         uLpc+7CoNcAKa9ecgyS78so2KeNR7iABKA++fffdZOBH4PJgGNOI72HkOlrgK4I7tnr6
         KE7A==
X-Forwarded-Encrypted: i=1; AFNElJ+i/jEfsAtWChNVODBHdzlU1CSsEQ1MR4UZF+pazzRoE95d4FQT4mgPGsicHpO9FqIKwNepfoFxrZOveg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMffq1AsRC359gKKI+iZyPRHPNOEa04XsG2sMDHVnmE3ay2L5
	9jIxkz+BaeF6r+CDlS9WWXdqOvKsAi4cN5IA93bj1RYGc4MaY1QFRqhK
X-Gm-Gg: Acq92OH7Snr7PD0q/CB/YimPC9r2H8B8esClH4COghsAbdlBgS1FBbrPa53o/3jJuPF
	XAiN5UQxnR+UupzFiAmPLib/Jcox0OaRzPaHOor+uwqLkGIIEKansVGrs2uR37G+BLpJVb3k+h8
	l4oNvhlUdnVqSYVCmv7Ui4OogU2ncdNmh8HmVnVtjR5oMPkxwzgPsg2kEDWGlIm86sAwrIc0N2i
	8JoLd6RXNvIE9pZDe2hVodgqRR2ykHU0/5yzb/505pq3RZY6JR32jF8hz4WovGhmqz76Zy/BAYQ
	asKvBcPzcKRwk3LEbTgE9NsxRQDPiVONu5+Bv07R3BED/ZAFmkMPPC2DNiKJ0wDLe+CSGCE+CNu
	N9fnycgFp/YJ3e1LmUobnROXvrOTGE/c4v4P30z9E/2NTR6Yi3hf5+36A5EcFS186yDB8qqq8Wi
	UUW7yC8vuc7/NBACq6
X-Received: by 2002:a05:600c:5286:b0:492:1e36:85dd with SMTP id 5b1f17b1804b1-4922017bc4bmr108656645e9.37.1781507940110;
        Mon, 15 Jun 2026 00:19:00 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm200181015e9.10.2026.06.15.00.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:18:59 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v7 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Mon, 15 Jun 2026 09:16:07 +0200
Message-ID: <20260615071836.362883-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615071836.362883-1-l.scorcia@gmail.com>
References: <20260615071836.362883-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..8b14956af4fc 100644
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
@@ -99,6 +107,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

