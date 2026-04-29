Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326263D47DB;
	Wed, 29 Apr 2026 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455921; cv=none; b=oXJExuCwVINIHpHlFQC2GoPb+QuPAwHCsseQPHuCN6ka4iOzY8auw9pk4PPd7Q7nd+6pylEeoJxw7LYDp2D4LLM4b8nm0zYO1Cp8mB/AonuDQ93mkieLs1e9IHJxtT5t8zLoNOj5B4E0DyIcFCuIib4Flz9ltiZtMycvF4dLXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455921; c=relaxed/simple;
	bh=SAHaTTN0o8iSHVoz4k1Wj+QoNXNDXkB6el3hzjXShiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMlgGx/uNUANzUM9qif31jm5rnddd/P8hBFeM7l/TP2eA5iO1JCdGHVSiTC3nFZIAlQiYPwJC720DZFuTMtzGfymJPH9YTmA9KX5jn4yoB6sxBEGtFzlD02B3/lCTsUQUR9kB6vLWbVAgnGNldeqX1RMqmU2rCdY6yj+MROuTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RwUA7zhm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RwUA7zhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455918;
	bh=SAHaTTN0o8iSHVoz4k1Wj+QoNXNDXkB6el3hzjXShiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RwUA7zhmGWrujBV3Ks2QMSYQCwgMBX3XSb0gyhqfKluPF8qp1tGUCU30pRHa/i4dx
	 wJTKZB1kWEEct4950wrozu9DrdSztcM5Y7CwEhsMavk+6r7gPYaStlxS3V/63aRjMp
	 mwxCv+5q1uWWYyyrZQk5t8sSOsWwVhNgde4ZXnA6vO10iOWnC/XPOfLh5TFgxGzLGM
	 4z40dPVNae4VDndrX4GEwl06klEQEB0jYR4zEQTJI+0wRImQ+VUsxKRdLIMP3HQYRR
	 WrkGusjbFIkzA/xlwu5/EZMFMao+OS4WyYmaXKpWWq7rHQx3+NOHaASE4LQ9AG6ik1
	 u0fgNRcYpB3dw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF87617E12E5;
	Wed, 29 Apr 2026 11:45:16 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:21 +0200
Subject: [PATCH 8/9] arm64: dts: mediatek: mt8395-genio-common: use MT6365
 PMIC definitions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-8-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1686;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=SAHaTTN0o8iSHVoz4k1Wj+QoNXNDXkB6el3hzjXShiY=;
 b=K8Jf6OjYx3bqGDaaGsaioQRvIxXwQ+xH0j9faGjPlJV1UoLf3/6NJramdtuPmoxX/n+rrAyaX
 1gi555dXuOgCQhv9V5dLvsaPNoHHXT6/ybwPuxe4sUave75hnDXLq0Q
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Mediatek Genio 1200 EVK board integrates a MT6365 PMIC, compatible
with MT6359, but the board common definition include file (for the eMMC
and UFS configurations) used the mt6359.dtsi to enable its support
since the board support was introduced.

Now that mt6365.dtsi has been created, include it instead of mt6359.dtsi
and use MT6365 labels and pmic key compatible too.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
index 62c336e21500..6df614c471fc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
@@ -7,7 +7,7 @@
 /dts-v1/;
 
 #include "mt8195.dtsi"
-#include "mt6359.dtsi"
+#include "mt6365.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -728,7 +728,7 @@ &mt6359_vsram_others_ldo_reg {
 	regulator-max-microvolt = <750000>;
 };
 
-&mt6359codec {
+&mt6365codec {
 	mediatek,mic-type-0 = <1>; /* ACC */
 	mediatek,mic-type-1 = <3>; /* DCC */
 	mediatek,mic-type-2 = <1>; /* ACC */
@@ -1151,8 +1151,8 @@ pins {
 &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 
-	mt6359keys: keys {
-		compatible = "mediatek,mt6359-keys";
+	mt6365keys: keys {
+		compatible = "mediatek,mt6365-keys", "mediatek,mt6359-keys";
 		mediatek,long-press-mode = <1>;
 		power-off-time-sec = <0>;
 

-- 
2.54.0

