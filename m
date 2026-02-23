Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433D329C60
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867052; cv=none; b=sJZQCi7EhkpN8AvsKrHUf/OsJ1A88nt/z7FRk7GPpkDBgC7BNuo8MNWYNxBuAKxUCWajC5K/o96RvFtfkN6dS5kLCQZzfQ1tOPRKDRBFwcQqWIfelYxZIjf/0CUEyFT/D5pKTr1aG6maKy+KO7YVXlF2+76lv0bsvZw2LYt4XTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867052; c=relaxed/simple;
	bh=OZfaPFSqbA2C31QZTHgklz9lyeFU0Jd8/jlpq+HGvJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVIdV7Gao8qntmYP4CRv4jvwfdv2L4xEcBF4Z7mTTr3h1JSRSqW20LxpvA8zvyr/fDP3PfvzUo1DV3DnozqAiKNEdRaEM1roOx7WSHYA6Tw6UFgANLbvDwZz6wJb2Runblzbh9fElLb7rd58v+NEao31LEaHohHw9YzPosHiBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPuSI1sc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPuSI1sc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43621bf67ceso3066701f8f.2
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867049; x=1772471849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfSw/YyZxtWdt6T+0h8WzqJ7g3THGU6LxAxLY8xoIzw=;
        b=gPuSI1scwCWzlR8FBeZxbwSrPM+9HXa9Pgv+N3SySO1xN4xE3RclTXWEPoKXdIuUGt
         c6tJwU3RdZ+hyeBO4b8J5be5POhh5wlMtmUGIgcIPW19bdabM0TfZGeOmbR21aDa+r+a
         DB9uAVjN7rOHQ8pfNFzRiPhCCyVyWhJJb0igFgYKzAFE7pPTMnrvvBmqla9sHo5fG4s7
         0OOpIexnPfbua2ARxQt20UtF/+wyqimd97WtszzGUPox+HfDxVRjr98j5SFL6h2q0HI7
         mByQM4T6sHDK7RtRv8DkROMYKsf22cIk/q62bSI5btAVLglwRzkf8t0HjxrLVPemgF5X
         yLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867049; x=1772471849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfSw/YyZxtWdt6T+0h8WzqJ7g3THGU6LxAxLY8xoIzw=;
        b=do0551tQjv9ieJQiDzSDoH4KMrm1AULix2H88elcRm46izlpA5CghMs/JUP/vSzpxT
         vJMwKO8lYxq1WYsVyzqYemrSZ3LcymsCaH/gCj/fkgf45YH7AjOXVdN0Tx7iN55LdyST
         zRrogmeffFYYDI/I/14kRKO4qO6yoLbJk25YLpWqBj3bgSmtDgEed+oKcJSHl+lkT4QQ
         Lw+dF0I3b/P65nM6a9UpIgjHdi8I4aVjYVsNVGxg+hAUs3TtQo82wOhHWvvc5upkVyl9
         +B8ohCUFMpKvyduacT9bRagUjdQN+BfYNyvg2cjFdd+VJc1r7y1LZZWGDOdXBJ6Fp//4
         NYng==
X-Forwarded-Encrypted: i=1; AJvYcCWvze+UHYfVB8YkvK6ziNpFJ878mbOcEyxRsju2UKob7p5kkgM6gKIDVy4lNe6edBJAYQPkS0cTLEx+fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAvF5g94QMHGbfMPf0uwtolcpg6M52rpfc7BJkoVa5I4x6RuF/
	YAMA34DffymZlOI5rDEoXFTUyW/WzAqw9nBwDKFBjmDTGlTZdbgUvAsl
X-Gm-Gg: ATEYQzwzQLnnqi1Bv63WqcapmZ3yRvB6noQzHk/P0KV/sIXOfwOphwuY8ZlBYt2Yqtu
	J/wBVGp3P/RDhcwXKvCQ6FNOr4kpNZ7TsFlYv3XvUSRnNYlQ2WhvPMgRngj8gdIB3NWSpSWDMGD
	9xB4ncFp+sYlYpJ0CeQalUe+phX2UMOP2iYYZX98cNr/W82aM0jGHA2MDocm9FXdIki3qWplhCN
	MG2SxzSFWaYHvJq1lpw5aA8yxvQLB1vS+dnuAG3FWK006qLZZI3HjaL7jczW8ZSfQQs2egv2qt7
	MHlbwKMhcgyuGTMehi9LqD6Q3GThUj0T3IB/Z6AKVhz4Fy4OPoTzpsJDspQs1Rs2jY1po4VIVOa
	T7Tp4/ya2U6M5VDIrS6bLXZKG8Ovib9KqJbZd/iJeyJoiX6WehHIVwvadcSm5v2FdZRkhNyMXIE
	iNqPoGIVDsHLXco55Lf2c=
X-Received: by 2002:a05:6000:188e:b0:437:9d2f:8bf1 with SMTP id ffacd0b85a97d-4396f17ce2cmr17527562f8f.38.1771867049261;
        Mon, 23 Feb 2026 09:17:29 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:28 -0800 (PST)
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
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: regulator: add support for MT6392
Date: Mon, 23 Feb 2026 17:12:41 +0000
Message-ID: <b7664f4d9a7b038b0603b6bba79cfab4e18cbdd6.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add binding documentation of the regulator for MT6392 SoCs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 5f422d311d4d..b61fce8f09c0 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -94,6 +94,7 @@ properties:
               - mediatek,mt6328-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

