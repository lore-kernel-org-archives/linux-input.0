Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFEF3B6C1F;
	Wed, 29 Apr 2026 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455912; cv=none; b=jr2Q509HNiV51xxIJx1JF9aMPxccAGM62yGyWY4qQQDFp54gNHBbGzbB57/wQbjyHmZvo+wxRNbnaBU+4Lcq4up87sz7To5NbBaLEaP5Br9w7fSafRlJigvI4D1RgnwFZuqXJqgqduzvfKi8To1SE8YS4KbnYwJLJleXLiZtiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455912; c=relaxed/simple;
	bh=bh0uY2NrxRuSPR7bJjjP3NnW4WJYh4INGqbmgLPQ6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTk5msLxUyyqqnhFxgu4bkbhvHDvDNxagmtysC46kmsNysxiIkWDH6nXjCorJ78EWIJ9ugTxDCMTmB/vxjvCl9OdviYbFwx+pBT5ussS5g1gUelcjgYSuAn+0swSe43ZHBfCTEwi2JWFzKBY3Jj4N/y05OWfvUbcr7bVQWkNX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fHFA8Omt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fHFA8Omt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455909;
	bh=bh0uY2NrxRuSPR7bJjjP3NnW4WJYh4INGqbmgLPQ6JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fHFA8Omt7vbqDuLprpTF1JdYKuemipqgH3jAcgV/aK73g6KhdFhznbNEXObTIKX9q
	 Vdz92SKJ9ZRsV9zWGACUr+P+wdm3fviE6U89yG7m4mxPLMt2vANzigzGxIGAl8Uend
	 o2bwtkv/z1T2M6TDMZkMPX+bWkzROHRmtxrGDE7PptFpYl68OJELaVI+spLOD0hIJ0
	 ynLB5/C3oUsfVbWd3wQs9s6tgWOxGkJ/V/0Et0C9j9RXZk5BoucInxMntyf16TBtwK
	 T9xNHusPsDz3SO5EY81m6dUfgZnLIpkuJimA7VuhbDrGeaTTru+B3jUZGlNQFAa3z6
	 JuJx2JxWlJ1yg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 35C4417E1513;
	Wed, 29 Apr 2026 11:45:08 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:16 +0200
Subject: [PATCH 3/9] dt-bindings: input: mediatek,pmic-keys: Add MT6365
 support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-3-6f43838be92f@collabora.com>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Chen Zhong <chen.zhong@mediatek.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1402;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=bh0uY2NrxRuSPR7bJjjP3NnW4WJYh4INGqbmgLPQ6JI=;
 b=+JPMFfnaPFBWysGTvk1GTeK7AFS9wWrVKFQUF2Z5aaZggdcTGDcPaH5YlQNjkNQdVbgCONTo7
 9h7Qty+RGpCDwV9DU6G7SJuNPMpjs/2W8mn/F962wGajQ3ebMouiZpx
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible string for the pmic keys block found on the MT6365 PMIC,
that is compatible with the one found in MT6359.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/input/mediatek,pmic-keys.yaml          | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index b95435bd6a9b..140a862ecfbe 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -23,14 +23,19 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt6323-keys
-      - mediatek,mt6328-keys
-      - mediatek,mt6331-keys
-      - mediatek,mt6357-keys
-      - mediatek,mt6358-keys
-      - mediatek,mt6359-keys
-      - mediatek,mt6397-keys
+    oneOf:
+      - enum:
+          - mediatek,mt6323-keys
+          - mediatek,mt6328-keys
+          - mediatek,mt6331-keys
+          - mediatek,mt6357-keys
+          - mediatek,mt6358-keys
+          - mediatek,mt6359-keys
+          - mediatek,mt6397-keys
+      - items:
+          - enum:
+              - mediatek,mt6365-keys
+          - const: mediatek,mt6359-keys
 
   power-off-time-sec: true
 

-- 
2.54.0

