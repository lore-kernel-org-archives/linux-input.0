Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B13C9EF4;
	Wed, 29 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455914; cv=none; b=jq1cTCw7+lZFxRD13bAaccVpaWReg/Wzx1kp6SaVJ8czmjCJRJwTuVZZuyXboRtGEVj1CoUUAiw7NmStdH91EU2+ioDk42BWMFiWa0Uii+6+46wFFJSukRcHMagR6YVrBeHy/89eE46BtK9M/RB7AtgtbodH+QCDv3BDv5+5YNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455914; c=relaxed/simple;
	bh=TSR8+FrWKPGQLmMRKvH66z/2gbF9VH8G/RaYA1rHxoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHSw8NaE58QWjgrT8xZ3336YRIbpqCczu3f/OXOmrYtPWV/gOjK15cc9571Ohas7II6V4ne50CCBYZYf3tiSTxztYDZTljp99ukZJkvYPOISf6Z4RYq53LSxjgXA1brR4HictEDmEPFO6lNnG0FEzTb2sHCzO/+7HoqSct/tRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DiicNPQt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DiicNPQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777455911;
	bh=TSR8+FrWKPGQLmMRKvH66z/2gbF9VH8G/RaYA1rHxoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DiicNPQtHG9DBBbkq2z1eJR5y0kr2p/OOFm8UFTlzMu3KLSJiQGEzbqShNZH2g3zw
	 MGCSl3Rne36XWF38bXFDUiZ2aLev2VmXXNQL2QRCaNfxh8JCjvrinA+CituHMU+mac
	 nrVn1T9PHmzTnZUYp9j41YYjWw+1iPvgDHshD0sHGA9PrhwuH6QU/8pHO8uju+lPX6
	 XsLMPunquWJXPc7WTZZch+YuwlfaLspSpN7MKFsfkXuTEvXr7hXEo+RR7kCE2AX2sa
	 mC9/q7zrDwMLytfnHFWWmhyHvGFQ/8nCa7P8mDX6IsfUriSAw80QGedou88/yNcDpb
	 BjQ0NsHwQD9tQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 04F1A17E12E5;
	Wed, 29 Apr 2026 11:45:09 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:44:17 +0200
Subject: [PATCH 4/9] dt-bindings: iio: adc: mt6359: Add MT6365 PMIC AuxADC
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-genio-mt6365-cleanup-v1-4-6f43838be92f@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455902; l=1321;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=TSR8+FrWKPGQLmMRKvH66z/2gbF9VH8G/RaYA1rHxoI=;
 b=9uy0SJ4P2FfSH2gveM/Zktxjbd+42yJvnuj7AGX6tn242abshLgb0m880+IMVpt8fP1axmbQv
 dFNUjPbeaEGD7nUmx5SApTaqTSH/EDPkuxehP+vmV5lmbYsrtL/CssE
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible string for the AuxADC block found on the MT6365 PMIC,
that is compatible with the one found in MT6359.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml        | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index 5d4ab701f51a..9936aa605c7b 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -18,12 +18,17 @@ description:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt6357-auxadc
-      - mediatek,mt6358-auxadc
-      - mediatek,mt6359-auxadc
-      - mediatek,mt6363-auxadc
-      - mediatek,mt6373-auxadc
+    oneOf:
+      - enum:
+          - mediatek,mt6357-auxadc
+          - mediatek,mt6358-auxadc
+          - mediatek,mt6359-auxadc
+          - mediatek,mt6363-auxadc
+          - mediatek,mt6373-auxadc
+      - items:
+          - enum:
+              - mediatek,mt6365-auxadc
+          - const: mediatek,mt6359-auxadc
 
   "#io-channel-cells":
     const: 1

-- 
2.54.0

