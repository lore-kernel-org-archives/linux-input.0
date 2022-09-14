Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D32C6FA89
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 16:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiINQ2X (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiINQ2F (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 12:28:05 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01E844F4;
        Wed, 14 Sep 2022 09:27:26 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1225219ee46so42432499fac.2;
        Wed, 14 Sep 2022 09:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zZD8tJ7NCtrHJsbCaNSP87Y3qe7OynbxFKCss/jxB3I=;
        b=bLDYu1JGbEvYJN7uMWfR1S0F9M66PQD3EL094y77Gs2LGAeM28pvRPEKVSzeCfjkvA
         YlIizg67ks5xulJq2zWSxRT05VMuflKI4KSYmb1KXyK0jLF4nSUjZLKKzb4Jew1libA8
         hDy5X+jAD50eUoLx80G4N0DZbwHGMcGDm/FkB10+snerpKeh2IaW5x0B2CpT1/pCOOGl
         +wisL5b3ak8iVW0BlOIJNpITi8P1K9t+7CRFtAd69HeIWoHfqNlsduP9s2tPaunFMTfp
         Vk3OQCSNL23znCqg9+aKrHPeBUqJMp8wmYzIkasdZ9WTbP5ZaC3gAHetucCYa8UItJWt
         gAJA==
X-Gm-Message-State: ACgBeo25sYwWWC0mWGi4vsqW00RJzJW/fPHiZqV9y328GNbd/WAB5kka
        74k8fvqQvwxGtqLl53BuJA==
X-Google-Smtp-Source: AA6agR508A59RRasBqGG0pg5H5/FqMmo9DiIAClotXDA1a4zQTOyhkP1kMxVLkm7CrmxQf7x66/I2A==
X-Received: by 2002:a05:6870:34d:b0:127:cb87:a169 with SMTP id n13-20020a056870034d00b00127cb87a169mr2787895oaf.87.1663172845636;
        Wed, 14 Sep 2022 09:27:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g9-20020a056830160900b00655d9ea896bsm5587940otr.47.2022.09.14.09.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:27:25 -0700 (PDT)
Received: (nullmailer pid 2501100 invoked by uid 1000);
        Wed, 14 Sep 2022 16:27:24 -0000
Date:   Wed, 14 Sep 2022 11:27:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        chen.zhong@mediatek.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Convert mtk-pmic-keys to DT
 schema
Message-ID: <20220914162724.GA2500989-robh@kernel.org>
References: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
 <20220914103021.43593-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914103021.43593-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 14 Sep 2022 12:30:20 +0200, AngeloGioacchino Del Regno wrote:
> Convert the mtk-pmic-keys to DT schema format.
> 
> The old binding was missing documentation for key press/release
> interrupts, even though it was supported in hardware and driver,
> so support for the same was added during the conversion.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/input/mediatek,pmic-keys.yaml    | 113 ++++++++++++++++++
>  .../bindings/input/mtk-pmic-keys.txt          |  46 -------
>  2 files changed, 113 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
