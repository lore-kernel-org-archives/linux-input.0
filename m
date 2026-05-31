Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7D33F5B4;
	Sun, 31 May 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780218645; cv=none; b=k9Wqph0+6hfiQMYybbndOWF90yYs7pAfDSIUSslF4KL8umgp/CVyWlGrNNLWWY/jyv/uO81vp5opqTIJcSVxtpiEzio4lKc5Gj5fQJiOZp9U6f3P/XDe1unnf2pBxbl8Dk+ScJ+JXJh1fzoRh2PLExVPLl1qOZnF7fajWxt+T2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780218645; c=relaxed/simple;
	bh=fl0iUdi5y/WRY0Tl1PLawS93frhYjgaC429L2//ta2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sm4bq4SGe6Tnr/T5LUM/TQMQY5VawwEYH78jXJgkNnlSvJGfvE67hl9HsYT20mAj+gBjglE6KtA1LnnnsqDK7At60Wus1tWYSqAPyNWmjmbyciaLbLjMVRqeOb2orQ5JC+3p4mGhBAKZ0/uDEb9Ha92FwYOpUSMJ2lVvlbx+zaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vea4tJa6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vea4tJa6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2330C2BCC4;
	Sun, 31 May 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780218645;
	bh=fl0iUdi5y/WRY0Tl1PLawS93frhYjgaC429L2//ta2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vea4tJa6nDmbCYqrfAXD+hOgB1RtiooRwmw05Az9Xgx/6ESpQ0ym5iKQ8/EpIUh8r
	 8dsnqjyk/q6V5YvqKrbvnni166jSXi5mL2fZ5A8iIysD4/0MVdJ7Yvrzo+69pPUCKA
	 iIqdm1TGDbnvsjTWo8//nUlZ8UINgUvOJ7+B++rKzVhk5uHVpV+D1vl/mnkOvfILQZ
	 VzIoRdftWpIcVNNHRrZzIBNVIwEANABBlDpsORaTABq16piTcJyIAKQ2iGe5NJtMcg
	 ymv2zfnO8nD8vN30SP0SP5m98BCe79/yFQPlPBBsgtepMNF17CJfOXZEajIIUndG6a
	 w5dvDX5mxG/4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC6DCD5BD1;
	Sun, 31 May 2026 09:10:44 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Date: Sun, 31 May 2026 11:10:42 +0200
Subject: [PATCH v2 1/4] dt-bindings: mediatek: pwrap: Add MT6735 compatible
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-mt6735-pwrap-mt6328-pmic-v2-1-dac37bf92894@protonmail.com>
References: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
In-Reply-To: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780218643; l=978;
 i=y.oudjana@protonmail.com; s=20260531; h=from:subject:message-id;
 bh=m78Bi8O6FvM9feF/O3ItPJ/iTAy8mD+DaEC7H/m00nc=;
 b=GHskc8UWok3K7CWbObkaLMAe27510F7dQRsRfHaOcFA8ar+qNdXa+Z49m9YRPxOHT2fKv3KCA
 aeM8he7n6ZdA91JPIj0D4ccd0iemNy8Zl39+H42lJVXnk/8NH/Xysnw
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=sr7uwnyVqGKAIhvwnIwormkDM3d2VNc3VOTEU1GmsEM=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20260531 with
 auth_id=802
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a compatible string for MT6735 PMIC wrapper.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index e7c4a3984c60..3a5fd46ce282 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -31,6 +31,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2701-pwrap
+              - mediatek,mt6735-pwrap
               - mediatek,mt6765-pwrap
               - mediatek,mt6779-pwrap
               - mediatek,mt6795-pwrap

-- 
2.54.0


