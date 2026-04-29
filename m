Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCD3D8108;
	Wed, 29 Apr 2026 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455923; cv=none; b=S9hgWRukH0xAMfQJz6MOkUBB8ZCp73utMLCIQcOX0JNl8r7w7WcMh4V4DFt2/Ce8+gDXYfLGpmhex98ULvPcVUfkcTFOZMRGNn3IBtc475s/j7Fiq/p7b13Of5DylIiuhlQJOitTD6iPSwHuoO33+G7DVMHfZeyWyJC8NugVtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455923; c=relaxed/simple;
	bh=LZSXpva6oG9AsEcsoWrDUJOYVDYzK7Fn+c63sWst9h8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxqB7wWYApm3PWOqnBdR7Hk1V/3c0OtGlbgJbSlsH0T/jezyrWxbMuqmbuxycHqUTzGnJuSWtyg72GIci3Or1XYThPX479/TRTrXC8K30V6Q4eVI7DFDRCmAeyw32w6jrz4tUQ3E8JnBowGOM8OJcD2n2KOA8O0u/XkKVR3ljQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yb7VlYqz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yb7VlYqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455920;
	bh=LZSXpva6oG9AsEcsoWrDUJOYVDYzK7Fn+c63sWst9h8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yb7VlYqzkY8wc9ZiMP2UgMZSeqTGRBU6WPJAZV8/bPbS0mH+meaLDWkg3ABDPS29/
	 QwY2C2ViVBqrJAjGqc4fZu3iAtRm3jtnKSWTXlxRKP06w8SneZsD+Apcn+lula8Y3S
	 bfLogmbk1NJ6j8BZOiqPze4qgxjgIVf+p5KtcbqF9cYwk8C7oxvb+3He0na8G5SG2l
	 SIYdKBfxQhXi0wq79rBnVJC30yBSzaRjxgSM+PkvYw6zCBR3ufGwqq6n6dm8ePg3c9
	 1TYSErcMS4THzJX3wkrEvKHmy5xoqO/FuGJXy5wZu26XuChYA4O4zGe8IXmtD+yUs4
	 4TRQJOZOHVLDA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF30E17E131F;
	Wed, 29 Apr 2026 11:45:18 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:22 +0200
Subject: [PATCH 9/9] arm64: dts: mediatek: mt8395-radxa-nio-12l: use MT6365
 PMIC definitions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-9-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1354;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=LZSXpva6oG9AsEcsoWrDUJOYVDYzK7Fn+c63sWst9h8=;
 b=PiLPTEDUjttvvITHiqe0IzMQ5Kj84Yl3Crww3pY7fvSDjC3aAVrBqpErDRIWSgvx1NBwz1mOs
 RZtAEl6k8KKDzZxn9QhmCKqe6G8Os4clkfk8CiFrLEbaIHeJw2gRyqE
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Radxa NIO-12L EVK board integrates a MT6365 PMIC, compatible with
MT6359, but its devicetree used mt6359.dtsi to enable its support since
the board support was introduced.

Now that mt6365.dtsi has been created, include it instead of mt6359.dtsi
and use MT6365 labels and pmic key compatible too.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index bf91305e8e4a..8bd3b3250b87 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -6,7 +6,7 @@
  */
 
 #include "mt8195.dtsi"
-#include "mt6359.dtsi"
+#include "mt6365.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -1034,8 +1034,8 @@ &pciephy {
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

