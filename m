Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333E3C2792;
	Wed, 29 Apr 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455911; cv=none; b=d4pK1myy+SwsIDUyQqTCJfmHvc7+eq06+V1YlhXgnOhAEWbpmvT4OgnAj7ZQOPNIIoCfakGgkCW7wz3Dvk2/SI0l5lxUIti2tvCK9xw/fgwCigcXYKIMkJ395RK4l7jC6l8lzhkvKlG9IaDnwrJRGw0J2X2aonI7H8k/8GOanzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455911; c=relaxed/simple;
	bh=7OjqtC5nux3H7Fom9W3SHcIbBLK9+ElLhz5UxcD6yRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bu4tke80hVSXjxA3oecyQxDviVeENjY/Qr2zdA9zeu7n3QNUUfmr/UFkhj9XtlG0Skbkd3zZ0z5GNsHfwxRJoriJBgF7Imt/I5Ba6BEFnHbNDUtLFegCZRDu9HgecrziBkQ+XxLx6fBgtsanMafXW4YVNaWq+/WTKDM2iXqyrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QO5CM+6k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QO5CM+6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455908;
	bh=7OjqtC5nux3H7Fom9W3SHcIbBLK9+ElLhz5UxcD6yRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QO5CM+6k04Xc8Hh2wXASoRvgLKfjb21/fj92l0kkr9htMzpnjKE0JRhmRvJSUvM3l
	 n3iHLvRcf9UUbOK+0Hh3dmZ/atpw/LOXDPflxYi7XrTGl4heJHhLY+z8yF10yPBJuV
	 BVC6CfpmsVN7TBDDQzkjIsWgZSOP5KOrFa+IK5HqLUxN7tUJM5qquis7pFQR/oiHL2
	 qQ+1fc6/LucoaI/qeC/Hew5+ADn1DZdoJT864va5nE8PT7Y88K0vjhDCydChHFot2U
	 5P5LRjDSmfY7BIfV+JRyHfi/xaCys7QpRIj0sZTuvlo8WFFy4j0XEtrPPKTxfZUWk/
	 mVJ0dmIWAanPQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 78D7217E0610;
	Wed, 29 Apr 2026 11:45:06 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:15 +0200
Subject: [PATCH 2/9] dt-bindings: mfd: mediatek: mt6397: Add MT6365 PMIC
 support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1831;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=7OjqtC5nux3H7Fom9W3SHcIbBLK9+ElLhz5UxcD6yRc=;
 b=QHE3sDIoeLErxc6ns18g57+AuXPkUD82A7HUQsFDM3G8GezjcRt/4/tsatgB5ul2G04y0PsMa
 6Zs7Qqak6oMCTxd6gY+8x8gvI6ji63FqiawT2RmMSSbtd0LqB64DTKA
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

MT6365 PMIC is compatible with MT6359, so add the compatible strings
for the main and sub devices (regulator, rtc, audio codec).

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index dc2b38cf285d..122aba7a54f8 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -44,6 +44,10 @@ properties:
           - enum:
               - mediatek,mt6366
           - const: mediatek,mt6358
+      - items:
+          - enum:
+              - mediatek,mt6365
+          - const: mediatek,mt6359
 
   interrupts:
     maxItems: 1
@@ -71,6 +75,7 @@ properties:
           - items:
               - enum:
                   - mediatek,mt6359-rtc
+                  - mediatek,mt6365-rtc
                   - mediatek,mt6366-rtc
               - const: mediatek,mt6358-rtc
 
@@ -99,6 +104,10 @@ properties:
               - enum:
                   - mediatek,mt6366-regulator
               - const: mediatek,mt6358-regulator
+          - items:
+              - enum:
+                  - mediatek,mt6365-regulator
+              - const: mediatek,mt6359-regulator
 
     required:
       - compatible
@@ -125,6 +134,10 @@ properties:
               - enum:
                   - mediatek,mt6366-sound
               - const: mediatek,mt6358-sound
+          - items:
+              - enum:
+                  - mediatek,mt6365-codec
+              - const: mediatek,mt6359-codec
 
     required:
       - compatible

-- 
2.54.0

