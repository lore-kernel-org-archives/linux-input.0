Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A26EE49AB
	for <linux-input@archiver.kernel.org>; Tue, 22 Aug 2023 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHVVJF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 22 Aug 2023 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHVVJF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2023 17:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D56CEE;
        Tue, 22 Aug 2023 14:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C5AA6367E;
        Tue, 22 Aug 2023 21:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9F8C433C8;
        Tue, 22 Aug 2023 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738542;
        bh=rJboaYR03KRMt/MeagTdTKSfTmzcXaNzAAeQ4JLigds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNNTiz8XGNT+mvmhkY+g5ti+c4mWmtncgld3BScSpGVmeD5l/TCYv24J28CHERBpS
         XOB7LRkIH/Onf3pk65eGTiPv8nnDk3MqlpBct2fjIrDN9iTZQe4/5XiI6Kb4oYxHux
         o0wMPgSt4O9fltWpClfc3Q5fyAc2rWUyycI8uJGF/9IPkvf1lhIbjcrcUZdNIkVRVR
         pBnEEAn5ymImeJVvuuJlgnv0OvwxFYBIpFV1Z66nwEv8EqFHYol52Y8rUrZt3QMHXb
         6YCSImR6Y62Khk92VoYlB7axsVOcsuhARjrElOa53zGvF/ME7DJrdycQvfDfGzi4UU
         Zx1lE9bV9pgDQ==
Received: (nullmailer pid 791383 invoked by uid 1000);
        Tue, 22 Aug 2023 21:09:00 -0000
Date:   Tue, 22 Aug 2023 16:09:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Vincent Huang <vincent.huang@tw.synaptics.com>
Subject: Re: [PATCH v2] dt-bindings: input: convert syna,rmi4 to DT schema
Message-ID: <169273821521.784605.11692367268126300929.robh@kernel.org>
References: <20230728165054.88678-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728165054.88678-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


On Fri, 28 Jul 2023 18:50:54 +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Synaptics RMI4 bus and devices to DT schema.
> Changes during conversion:
> 1. Add reset-gpios already used in DTS and mentioned by RMI4
>    specification.
> 2. Do not require address/size cells, because without functions
>    (children) they aren't really needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Correct [0-9a-z] to [0-9a-f] (Rob).
> 
> Jason, Matthias, Vincent,
> I put your names as maintainers, because moderately recently you were
> changing the driver. Let me know if this is okay or you prefer not to
> maintain the hardware.
> ---
>  .../bindings/input/rmi4/rmi_2d_sensor.txt     |  56 ----
>  .../bindings/input/rmi4/rmi_f01.txt           |  39 ---
>  .../bindings/input/rmi4/rmi_i2c.txt           |  61 ----
>  .../bindings/input/rmi4/rmi_spi.txt           |  56 ----
>  .../devicetree/bindings/input/syna,rmi4.yaml  | 271 ++++++++++++++++++
>  5 files changed, 271 insertions(+), 212 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/input/syna,rmi4.yaml
> 

Since this hasn't been applied yet, I applied it, thanks!

