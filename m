Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D73B95E9;
	Wed, 29 Apr 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455909; cv=none; b=PDdZVy62SZ5rV0P8/sdcDwlkBv3Fz2/XcAZ+Tzt9yE5GDK9DNMYxzYD/+yCHq9vLSrSn/eal6u2N1SPIz3+qM/nz2cqcpCkh8NdovOrrQvO5145FsPlpGubZhXLWgp2TUCkLOcQn0a06Lccg0xyCdYFitS36C2KU6v1xmHp6pfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455909; c=relaxed/simple;
	bh=q+A0nPBQFvkrIuJrsyjnlh7ztGoUgI2vF8ZPdTgCh6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fX7Q1AXj329WVNLAkSL0ejDU+8gJT6rEhrCdOg25jPD7gP3btWa8hKru4EvyGxNDc3YfP7V6djYkk5zCLXySBTHx357kZzsdcOtWqfXPHrpu8xnhRJunW9lf/eD7SSt+hXaxARZsy3qFI+PqoOa3gHp/glzcCbj6CZ9GsoQzjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IffD0BE5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IffD0BE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455906;
	bh=q+A0nPBQFvkrIuJrsyjnlh7ztGoUgI2vF8ZPdTgCh6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IffD0BE5cdoKPv1N2T1S7/tVF+WxEfnag2ya3IpIUQF1psgubeBd0ute8rUA8GyQN
	 9Wv9qCy1mDFkWAohSU4CUj48WyBQX04ljloQPbW7EARGOv+vxvbpVEVPz4C5RLsF8Y
	 puJ2M8H7txDfLrk4jDZk1zpirr4z95JGUmGAYaZdaY8ARFwUWRHEpaKbPceVPy7XTv
	 PUeU1xVmLnaSDXZGYSGA3Qai9j020hBzFNy7uDjeNxfDk8HdASmHj3t/vgpY5g9rl3
	 dZm0im9/v+F6dmu36XVU9rOFthBOo0dgcwSOhApcc+OrOR6iKJkAecMV5rq7mkTP1+
	 PNVsBmjtTEYnw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B468317E131F;
	Wed, 29 Apr 2026 11:45:04 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:14 +0200
Subject: [PATCH 1/9] dt-bindings: mfd: mediatek: mt6397: Add rtc for MT6359
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-1-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=944;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=q+A0nPBQFvkrIuJrsyjnlh7ztGoUgI2vF8ZPdTgCh6M=;
 b=cH9zfo8/F+L9VyCuhm6yP4jQnsZTfb1o69JGpuvont2C9AHoiLy74ampVamrThGevdcY+sxbs
 6wRupzWS56mAas7GTpPJeQDpABzu/8ywoRCEYigUW9DZTkDQEmD2OFX
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The rtc block of MT6359 PMIC is compatible with the one found in MT6358
but this compatibility was never expressed in the dt-bindings, so add
the missing compatible string for the rtc subnode.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 05c121b0cb3d..dc2b38cf285d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -70,6 +70,7 @@ properties:
               - mediatek,mt6397-rtc
           - items:
               - enum:
+                  - mediatek,mt6359-rtc
                   - mediatek,mt6366-rtc
               - const: mediatek,mt6358-rtc
 

-- 
2.54.0

