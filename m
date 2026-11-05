Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907908;
	b=VXyX0lMFPJNs+BOgFPHKNhj41yGCVCKmUzG5s/rkT5HBGx+tTAhvcO4eFw7QFGoT9ZAn
	 xa4d12Lt4jERosu4Ci8URCyWNLWjOsH3+L3SBkBsZYKy2jwPRFgHRKBhec5FbvkEOu7zy
	 BzVnFOGY+zy70YAOmBz4uH8E/tFFCGa8GapCR2bh/8QupTdqpq3v0k8xS212ViGQaoxs5
	 zHcgDWJbPlGq0LtYj7ZEh7+NexAOysOHruOsrQNViw7GYDnineMDAXANe/7DNr0fa9zY2
	 +U8SoWJaWuMtlbGmP97c9NqGyAy7x1006b/hW3ZTU6Qknc2NQbDn65DZI/SdziXr3jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fdpjdk832N9BwoCOr6cdI+ScZVBChe7jU8b/pMSH0Po=;
	b=ThO48YNckUBIIGjQrkkPQx+70CEvUX4lzkMczTGNtbD6sn+CKT3RQwVxKm3lm9DBUaxG
	 ijAIHEVLGS/brsSFJKERJMKzZDSMbp9i8W+pNwd7pX/VhA5KjU3WUzaTJVIcmfyyPhdBg
	 FCutnOPfIaKTwKrh08ud85yIStmc19xEyVIo9+degAYCxKtrta1BEeNpagx3zsJk+yCJY
	 3rPl9OiL3WRF6/eH4bAsfCCIytrpnCaIChJcPuL0pXwUq0Whb1cuS7IbWdO5O94nREB5i
	 JgHsCkYeSD6afRGdNOZlIwzLGlmN1AeGqq95GxJ1cWndZ+Vvlq6K95X9ZUJvtCFKnBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXvGOO6H;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2A606EEB3
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B2A606EEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXvGOO6H
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so14591325e9.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907906; x=1794512706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdpjdk832N9BwoCOr6cdI+ScZVBChe7jU8b/pMSH0Po=;
        b=fXvGOO6HFchZghMJ/v5+oavqAdwYE0FUczZPmVcjMiUsOmN8ET9E9lp0Bx2YdISBDs
         roUj3howt7B+J0uMVmcDh6WdKyZyp3SC7N31jGFtIHav/6hKW82Df2Kt02OjQ+slaZy2
         GsF6YUn4Nc+2weRAUGWJUtnPQRyrdkU9S7C2rLRJdWPNsTqni48qtxvlr7wYLCedQJk4
         F/MlCN9qRxnIQrLA3yXNoiZi1rzI8EdYyyZK1q5aoId91yTE6UJOx83RTNIJz04jkpuh
         6wq+U+O0kEL0B+qvjVs8yunDGqJ4RV+w38VGakbcBHiGjBXWu2u4+misUTWgqfRtJyn+
         8iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907906; x=1794512706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdpjdk832N9BwoCOr6cdI+ScZVBChe7jU8b/pMSH0Po=;
        b=tsuSO3eZ2U/Un02317gbIpnBmP+qR4bpxT02G1Uujy0jmWt5WBmcST7TOZWR2gjmyr
         7g+5zKSEpcotJ+5ldVQBmRMzbqQd+BFBh3hoAffpIOfNc8zHlW3HQiHrZvvQZH9Z2/VF
         AzXwTcyD4Ax24bP4AQEJI6z65xb0lVJXq0peiMh4fEKz+odKh02jDcpEoD8pCZU7pACM
         p3lCJ8WOH3JtvezJ7amOI6lyg1j3gSTomxSZ3Y7no6oA82loFUbqopxfN6633wAJdakQ
         u4PWOEirL3DdF6yBDECcwJUK1mxiVDQi3EnbuGA0Xswu4vU6J7OBH9TxHJjib87N1y4E
         C7HA==
X-Forwarded-Encrypted: i=1; AKwUvBznif7CuMXzHZOR4qPnMJ+Ug13doqhr2Rj3qKpuVEwC8YKfkkFaL2p2HI4PYb3JBTj6koaYprWWdHmUyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9m9GAKXIxsIS8UTLr9thm0LLjvG0wMxUl+FxT7E98P5A6qc5yq
	vOeGxuEFoxT0ps7+uNwTzORlih5Bc8urE79uRzH5TFbWnZLo6L9uGhxs
X-Gm-Gg: AYBFou2EMC4SJkFDz0jg6XyjGeiT65mjwQxe4P0Mf1qdJcHZh8+aqf/kReryqHxsVgn
	hAQuch1FBxIttwyXwJER+Z+mksHl63sVhvRCzyqA8rgOGF17MhGug+fr7cnDRaLtkkdO5dtbgl9
	WZIyOS7FGMjaiCG3KgxN0xuqgU5tArBlOOjeWnYHEihc3ZZOzBy3H2cyhC8lG5ZPH0ZrjZSczQA
	KbgMkqBMVjdYo1HGGvQgB+0JCyz0/OyUg/yF22hADOldckcbJT1blB3D+E8Jsq4U6Y8Sjnag499
	mxzVwIWVDVawwB1yK9giALYNELG+GOksZS0t3JPEsCsjkDDtZ87o+7b4/fiOm6GEcGa5q0Aj8cv
	wYtTGI3p+avSinLlOMa7pRmhdTGANvEXnOPfEOnfGHITBp85x7aTYQn8Oq/UilxmVXnchBmoVJS
	nKLgkTBEdDWoAP4LexCgo4z/hOfogOBmihShOBCIY0ABI4NDq6Ev7wykLDngNvUDVvkdSQLhkEb
	Y8R0eTgbOFVCMy2I07XzcPmGcAPeI9mbY6PpZe1eeGgitBdgiqfj+jKmiTmFjRS5spMkpsZO8Ge
	+Pf0D1AJblmG9dnQNZhsx9g3
X-Received: by 2002:a05:600c:34d5:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4b6db1c5e0emr3268735e9.2.1793907906381;
        Thu, 05 Nov 2026 11:45:06 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6df5eaabbsm4204265e9.2.2026.11.05.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:45:05 -0800 (PST)
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
Subject: [PATCH v12 1/8] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Thu,  5 Nov 2026 20:41:32 +0100
Message-ID: <20261105194426.1113050-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105194426.1113050-1-l.scorcia@gmail.com>
References: <20261105194426.1113050-1-l.scorcia@gmail.com>
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
index 055625362951..8ecc44a88a14 100644
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
@@ -75,6 +76,10 @@ properties:
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
@@ -111,6 +116,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

