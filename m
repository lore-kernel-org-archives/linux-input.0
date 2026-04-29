Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C23D0936;
	Wed, 29 Apr 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455919; cv=none; b=B1MaT3mWt0TVd7RtdrKrKGOOAXykcXLMnFPhRZ8WlPGFE3izgsklucBI/s0Dx59c5NIw2g975tzv4OeY1/P+wq+ppprgjbbiX1/u72FLi3/QlzYStjz+/LY2v7h1XxD2zZ9mMiCZFI2v/+aWsB8UA9C5ajNUUwlQn4Gr7tttORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455919; c=relaxed/simple;
	bh=YuHpf07kf4Uild2asVXBk4zqPo/qFzS4X/u93cN8vB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfBUMRf73Zi2ENekU+DzcRMKBkiYL0mNftBrVpQ0spGaIvo10HEplwosP1YpRgfFkyv+C5cfQCk0o9lgbSbzu0Cnz69VEdaWGpi+5hcM/ttdu8OYlvARTWuOvLADRT/8bPTUG5KSQzGRvXULEj4CC43tTI0v7rbxr0BKyeX/E88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vu6mnNZo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vu6mnNZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455916;
	bh=YuHpf07kf4Uild2asVXBk4zqPo/qFzS4X/u93cN8vB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vu6mnNZoSmzzxVa17f/idLnZUvmamt5+q3xdXwhqyA2fVGbyYhN4QBRY5SGzy32z0
	 mPEVTHtjdvMAeJ0elKiB2LQmnofVOKn/NAs4qQ5K1AsMrLXxjZEGrHkaHRhzAjaY7r
	 FkSlC2mBI5Di3lZcZotPXYZrEP4oB56GxioD5Z1Y4MH/0i/yHQl5CGYjgASz9gPp/X
	 SHCLhCyojt964uez61CYm7o6pkCZpE1unJi+SKnTZ5rtjt41gDmMfX/rmf+kQnGbko
	 +ijDLz6J4MZi7lEg7CIgOU3nZJg565+b7yRbIHzVsg2rrC+vQPlZ1N9mYx0frPh0BL
	 uq7IfPGI2TiPA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E8B417E1513;
	Wed, 29 Apr 2026 11:45:15 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:20 +0200
Subject: [PATCH 7/9] arm64: dts: mediatek: mt8390-genio-common: use MT6365
 PMIC definitions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-7-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1671;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=YuHpf07kf4Uild2asVXBk4zqPo/qFzS4X/u93cN8vB8=;
 b=lccIymyIWB3mM0xwUsTTgcmQHl+tFqmI89WYeoWyV6Zrkmr1u93/VOmHGSvZ9fnL0YfTNfZ0h
 cpRi2u/bCmVDLnl4qP5D6GZw2xQVYQKXjLCmEYhA0BWOCd4TjNbqDq1
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Mediatek Genio 510 and 700 EVK boards integrate a MT6365 PMIC,
compatible with MT6359, but the board common definition include file
used the mt6359.dtsi to enable its support since the board support was
introduced.

Now that mt6365.dtsi has been created, include it instead of mt6359.dtsi
and use MT6365 labels and pmic key compatible too.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index 2062506f6cc5..5303add717bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -10,7 +10,7 @@
  *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>   
  */
 
-#include "mt6359.dtsi"
+#include "mt6365.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -695,7 +695,7 @@ &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
 
-&mt6359codec {
+&mt6365codec {
 	mediatek,mic-type-0 = <1>; /* ACC */
 	mediatek,mic-type-1 = <3>; /* DCC */
 };
@@ -1281,8 +1281,8 @@ &pmic {
 	interrupt-parent = <&pio>;
 	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
 
-	mt6359keys: keys {
-		compatible = "mediatek,mt6359-keys";
+	mt6365keys: keys {
+		compatible = "mediatek,mt6365-keys", "mediatek,mt6359-keys";
 		mediatek,long-press-mode = <1>;
 		power-off-time-sec = <0>;
 

-- 
2.54.0

