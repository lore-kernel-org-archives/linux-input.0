Return-Path: <SRS0=64J9=ED=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E3C388F7
	for <linux-input@archiver.kernel.org>; Wed, 28 Oct 2020 21:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ADF24724
	for <linux-input@archiver.kernel.org>; Wed, 28 Oct 2020 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603921617;
	bh=LiuBL+ajxgK/05zso7lW3tr1FQ9436dztCx5AnPxyeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2rizpjXYxX1tdPBqoViabAhKz3w3uFIF+5l7UP0s4gAFNIYx22pPoolLtt6BZ8j5C
	 xoHfa9Hc0f4ST7JzGXanNYh0luVgu4ip7uCJua3Qlt5NPZXFMZBwB4IpHMalYcy0Xe
	 w+ZSg/rhyi7Nvu/F1zjWeHbN/c72vFhTSxD/6lSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgJ1Vqx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:46:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40550 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgJ1Vqq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Oct 2020 17:46:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id f97so531107otb.7;
        Wed, 28 Oct 2020 14:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3/K5+XcED3p9NTK0JBEc3k0+bdVtoWznxcAQJyccp4=;
        b=j/txmiTx32e0b0AXuO83r4B03jcKtca/g5DjqoMsgphQJPjfyI40ZGHOWiCCofWW3f
         c1ntowPz1BJYGlzvGMzjK4v1uKyZxoDhUrlaaHoYXb/WaM9vqXC/sJKxO7inpQ0AfPtK
         32Zfu0u+whsFZuxquLP/l8JMXpjcfOlaTLlTzx05eh6P5rI4AlXuqY4TXoYZDQLsqKQG
         o0KR0hufvrXDnVFHZIOrI7ESEwh4v2VkqeXMSMhjpznx8B+7q3lJsRT+BsSpzhDE8O6+
         3/ZTmjocgM+o8jhF0tSugsJIMld/EXGQH/qKeTwBP/LLbD2DguPvvPq2Aeb9E+OfSLgX
         qmWQ==
X-Gm-Message-State: AOAM532ts8zZvTHPugm7um5Z0UQxRyhE5f2gk/Yk6pL2oo2FRJBHhfdD
        EmbIcclXPQ1SW8INT8IRgq48Gf6B/w==
X-Google-Smtp-Source: ABdhPJxwv/u+gGhkTQAd+a1VYtJctn3VyVn+NtJrI9T39kVYiX54LDZ5860k5i/giAZkP2pJYTXxPA==
X-Received: by 2002:a4a:d848:: with SMTP id g8mr6143739oov.35.1603897864482;
        Wed, 28 Oct 2020 08:11:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h15sm2182854ots.31.2020.10.28.08.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:11:03 -0700 (PDT)
Received: (nullmailer pid 4034187 invoked by uid 1000);
        Wed, 28 Oct 2020 15:11:02 -0000
Date:   Wed, 28 Oct 2020 10:11:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        priv.luk@gmail.com, robh+dt@kernel.org, marijns95@gmail.com,
        krzk@kernel.org, konradybcio@gmail.com,
        linux-input@vger.kernel.org, rydberg@bitmath.org,
        andy.shevchenko@gmail.com, martin.botka1@gmail.com,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v8 3/3] dt-bindings: touchscreen: Add binding for Novatek
 NT36xxx series driver
Message-ID: <20201028151102.GA4034049@bogus>
References: <20201026173045.165236-1-kholk11@gmail.com>
 <20201026173045.165236-4-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026173045.165236-4-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 26 Oct 2020 18:30:45 +0100, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add binding for the Novatek NT36xxx series touchscreen driver.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/input/touchscreen/nt36xxx.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nt36xxx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
