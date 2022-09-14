Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CAAC6FA8E
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 10:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiINKVT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiINKVR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 06:21:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835F79EFB;
        Wed, 14 Sep 2022 03:21:16 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9212660201C;
        Wed, 14 Sep 2022 11:21:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663150874;
        bh=+t+eS5uIq7be1EAHToZiBnClNaJKjeBU4Ul3SPxFOAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8xUsm4llePZLK4+gmK9cVOZa6u5GdXx0q9y+xXYW7TEL8roG9249T7pQ7JKw/dth
         aYI8FMx0mzU7dXn9er5jfyxsuef0HFjgEtRGAUqHLevq5MiAuiZt5tOSpvqqeuSOra
         WLTuT2GAY6ngDengo2Ru4/uNr6jLALaTEGp3jIVxWZ51v7poOribtsURx90/5vJ/oo
         125VMs0ilxUxlVkgiP9RcxCHTg+bSBsfwvqD08rsbzWo+VLiJIHarnd05rFIGZ6ZKd
         ffp3ezY7Q/bWgTstgtFYwSh8f7+PmlxJqXkG2qNOvYfyfmeXu4G5OrwEylbYvC0tZ+
         mrTGQLAUHdz1w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] dt-bindings: input: mediatek,pmic-keys: Add compatible for MT6331 keys
Date:   Wed, 14 Sep 2022 12:20:59 +0200
Message-Id: <20220914102059.41757-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914102059.41757-1-angelogioacchino.delregno@collabora.com>
References: <20220914102059.41757-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add a compatible for the keys found on MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index e33fdca50b16..358d027e3e81 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt6323-keys
+      - mediatek,mt6331-keys
       - mediatek,mt6358-keys
       - mediatek,mt6397-keys
 
-- 
2.37.2

