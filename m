Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC441CCA47B
	for <linux-input@archiver.kernel.org>; Thu, 30 Jun 2022 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiF3XOr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiF3XOp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Jun 2022 19:14:45 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D287641F;
        Thu, 30 Jun 2022 16:14:43 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id u20so674846iob.8;
        Thu, 30 Jun 2022 16:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GS4VqtaJdqJSvRiDmjqKEuDBsco5w/MSERegvSlNYo=;
        b=MVsJjthYZa5Ax2q1nNnfJuEloOywNzTPG1CI66S4SR2xBnkfo+2lbq2oXdEjclYAPt
         nYweabcuR+v2HACQ/RKcUwsL8C31/ds67yAx7ofaAq/69dD0MIqDoCRmJQVKHMMeyXxl
         cngltVxr7u7Vjf9ky25mXQVDuR4vLju9qcrEPRPAI82zz+LR88OO1H8By3irQ7Dils23
         fL5G+8md5MK966uDcVFsrmv1mi07QrMlEYWf3oRHebSF1AYhT/JLRrlqEXfl+m77y5cY
         qzS/mfa9okg97aQ69tKhD3nibRjYt1TMXtvzIXBfU1fZLki2uDx8GKzpicIlSz61IBUx
         Z5/A==
X-Gm-Message-State: AJIora8Jw8+tjRGCpBe4Yzn94uuKydLhDCiAufEAn3jI0QKvrqvFdA9M
        uLSpWrHiW9raIx58JVQbqA==
X-Google-Smtp-Source: AGRyM1sJUPYBAoDl3kH4LmZNrZzwvpPud88QJXBsdw546xQxeoqVi/3TPmeC2oC5hXyxlJjn9x30Rg==
X-Received: by 2002:a05:6638:339b:b0:33e:98e7:152e with SMTP id h27-20020a056638339b00b0033e98e7152emr1194416jav.93.1656630882498;
        Thu, 30 Jun 2022 16:14:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e0208b100b002d955fab9dbsm8570417ilt.23.2022.06.30.16.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:14:42 -0700 (PDT)
Received: (nullmailer pid 3510734 invoked by uid 1000);
        Thu, 30 Jun 2022 23:14:40 -0000
Date:   Thu, 30 Jun 2022 17:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 18/20] dt-bindings: mfd: update dlg,da9063.yaml
 reference
Message-ID: <20220630231440.GA3510679-robh@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
 <da459164d166d994b06f9ce8bf3a2108ccd0abd5.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da459164d166d994b06f9ce8bf3a2108ccd0abd5.1656234456.git.mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 26 Jun 2022 10:11:04 +0100, Mauro Carvalho Chehab wrote:
> Changeset 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml")
> renamed: Documentation/devicetree/bindings/mfd/da9063.txt
> to: Documentation/devicetree/bindings/mfd/dlg,da9063.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
> 
>  Documentation/devicetree/bindings/input/da9062-onkey.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
