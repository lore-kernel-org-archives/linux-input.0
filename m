Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49441ECAAD3
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 10:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiINKah (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiINKah (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 06:30:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D57B1DB;
        Wed, 14 Sep 2022 03:30:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 542386601FAD;
        Wed, 14 Sep 2022 11:30:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663151434;
        bh=JeaIcKOvl1wCsTf8RWNpKTL2k0i/vhElw9DGJuWnWB8=;
        h=From:To:Cc:Subject:Date:From;
        b=GJgaqKXVMCcyQl1PHfEDZG+HdO0Cy9Ce2T6XkfNE/R2T5xNg7AWPX4FEm/X7xL0MI
         yizc4tdi5AnE76uneoh1TJjAXImUxpcP5bSq9GeZcf2z3fCL//zOzi6vRv3AJUvJyT
         pi+xhAe5Hmr4oII4wKNgaxhOyHqqo/f6IiP9zVUQ4vKn/UbvQ86yOpk9ot7iSeIYdc
         Tt/KiLxvjrxybZwankLAYo/RD4KNehFgaa4WxD7tcP7YY6iJpo3eDblqjnm0Piuq9j
         cJdsE7XcXGoVVq3JjF2dmF6EI0MEx8MOynH92XbPjQyT3eBM/OUmtoccCP42u5wCLZ
         1bhynkmiZ2jDw==
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
Subject: [PATCH v2 0/2] MediaTek PMIC Keys - DT schema conversion
Date:   Wed, 14 Sep 2022 12:30:19 +0200
Message-Id: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This series converts the old mtk-pmic-keys.txt binding to DT schema,
documents the missing support for key press/release interrupts and
adds a compatible for the newly introduced MT6331 keys.

Changes in v2:
 - Removed tests leftover interrupts/interrupt-names from examples

AngeloGioacchino Del Regno (2):
  dt-bindings: input: Convert mtk-pmic-keys to DT schema
  dt-bindings: input: mediatek,pmic-keys: Add compatible for MT6331 keys

 .../bindings/input/mediatek,pmic-keys.yaml    | 114 ++++++++++++++++++
 .../bindings/input/mtk-pmic-keys.txt          |  46 -------
 2 files changed, 114 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

-- 
2.37.2

