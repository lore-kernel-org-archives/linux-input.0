Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560D0EB64DD
	for <linux-input@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjFZQ0A (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFZQZY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:24 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1783C6;
        Mon, 26 Jun 2023 09:25:22 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7836e80b303so10257539f.0;
        Mon, 26 Jun 2023 09:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796722; x=1690388722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RYGciDOxC1iCdj+Wex+uvlKlLoz+9cyauVshjtzds8=;
        b=K9keNZbHiPFolgTaG+Au3EXgMyqn2A4GQKgcdZVhDy5VDgjn+dqL29PQdEbFV0qu5P
         m+P34n9GxqGqC0pFjVN8GskIq1w5EYqY4Sj8g0hyRoLrqNW43X/4Adv9wSP5tU3tduzd
         5dKinlZNs1SOz3DFn4Mcq5wooW7NWSj/75WATYg2/w2/uXsxPkVglMACDI/ywRoyjOqb
         2CdmCaOeZ52isXRuA7Ypnt3OXGh3ezGVcl1V1toM7v+7H4IndP3B0DQU6q1sRLSqfnjq
         OEqIl3wkwmT7Nq+HMEQjTrC9AQ6quLBPjfqg2zjHrg0un1VxNU4lndyBSWhL8hsr6wrY
         AYPQ==
X-Gm-Message-State: AC+VfDxohStZUQgIaERtDyQDla5hB4dgh80L8GJjpPAD2myfYjUF9R10
        CjSqPYVGAz/Y2sd3j8oApg==
X-Google-Smtp-Source: ACHHUZ6oRsBdvIsfJbfc9fDrIiqZXuor8/TLpAnQjwH50J4uh85t1dd9JDXyc0oQspUhreLDm/dNHw==
X-Received: by 2002:a05:6602:34c:b0:783:6bfb:8a52 with SMTP id w12-20020a056602034c00b007836bfb8a52mr1022181iou.9.1687796722041;
        Mon, 26 Jun 2023 09:25:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g18-20020a0566380c5200b00420c65ba4ebsm1958067jal.24.2023.06.26.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:21 -0700 (PDT)
Received: (nullmailer pid 3354816 invoked by uid 1000);
        Mon, 26 Jun 2023 16:25:19 -0000
Date:   Mon, 26 Jun 2023 10:25:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,pmic-keys: Fix typo in
 "linux,keycodes" property name
Message-ID: <168779671898.3354738.8151043856160262902.robh@kernel.org>
References: <20230613201040.2823802-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201040.2823802-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


On Tue, 13 Jun 2023 14:10:40 -0600, Rob Herring wrote:
> "linux-keycodes" is the wrong property name and is unused. It should be
> "linux,keycodes" instead.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

