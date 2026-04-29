Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD63CBE9E;
	Wed, 29 Apr 2026 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455916; cv=none; b=QRHjqffd03mzpNBMXr76yC31X+EkpbuwhGvOJ5oWmMzOS5kj6YkBzJ5KCDrOzoivXd5XJN0bJY38FGF8+No1xRUVbdD1Y2R8FlxbjYJr33qlL10U+xeySx/TmfjBNeM7PKc08OTVJYHt0a3O/8NvbUDuW5iLLB6kfshKHxv2AuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455916; c=relaxed/simple;
	bh=jzJGcawn7WHZFwkXKelyKyVTeaOuz1vareif1yRSiAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3+FkTEizguDtIIK7rSgateKWY+bgs43PguWUjThXTkfjW/n0ghLJZAZxoaeThYfhIVjHTpec8GeyyUwNlrSH3F0lnarIHly5WzXbdgakZsrl+0J5AzA4c+2/J7+7HTsFCdSA408rHFuNQxso00lv9tAUlXU3wrF7NqUT9ctY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fr1gJ1MA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fr1gJ1MA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455913;
	bh=jzJGcawn7WHZFwkXKelyKyVTeaOuz1vareif1yRSiAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fr1gJ1MA9rypeqmnbofOmd2TQUoCrdZNOylGWIuoC++Jzp7X1+Aw4VS6injl++gmm
	 XkifHntFPl46dDW0jhVQA6fp30zctAHmz2a7mzHU3/hemXlTX19Y0TtOhhkJn+NwP8
	 rXcgR3JS6k1ufixvboi+qBdIX3Zf6PcJMt4JYIG7GPpg2Qj8DquIYQR5LX4SA2ZAFh
	 dGX7WH7Epq1VJ5Vyza5W/7Dwcc1cWBzjHEVdgX2D0iSCLjcyWOU32/cFxRem4lDn0A
	 1itIFkQNnjcdse6toTE2/fa5cV0ZbnHXIP9gGW/0ujDN+uvTtZZxx8+1rraA5BfY3C
	 d1L5YiHMSFO+g==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD7A517E131F;
	Wed, 29 Apr 2026 11:45:11 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:18 +0200
Subject: [PATCH 5/9] arm64: dts: mediatek: mt6359: use proper compatible
 for rtc
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-5-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1179;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=jzJGcawn7WHZFwkXKelyKyVTeaOuz1vareif1yRSiAc=;
 b=OVRYr11w1c+IB9miFxIjILKSA0jYRDeSlAKcFoemhlh/gfXhToGlSSizQkKiEVgd49BoTa3BA
 KdrLg+Kv0aHCOAGELtYrC321yPEhkv2w2hDFpz6YcOp+uxIqYySJ+ad
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The MT6359 PMIC include file uses directly "mediatek,mt6358-rtc"
compatible string for the rtc subnode, but not its own compatible
string.
Now that the "mediatek,mt6359-rtc" compatible is properly declared in
the dt-bindings, use it with "mediatek,mt6358-rtc" as fallback.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 45ad69ee49ed..c279b3372eda 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -19,7 +19,7 @@ mt6359codec: audio-codec {
 			compatible = "mediatek,mt6359-codec";
 		};
 
-		regulators {
+		mt6359regulators: regulators {
 			compatible = "mediatek,mt6359-regulator";
 
 			mt6359_vs1_buck_reg: buck_vs1 {
@@ -301,7 +301,7 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 		};
 
 		mt6359rtc: rtc {
-			compatible = "mediatek,mt6358-rtc";
+			compatible = "mediatek,mt6359-rtc", "mediatek,mt6358-rtc";
 		};
 	};
 };

-- 
2.54.0

