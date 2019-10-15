Return-Path: <SRS0=Zd9i=YI=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA8C10F14
	for <linux-input@archiver.kernel.org>; Tue, 15 Oct 2019 17:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1752084B
	for <linux-input@archiver.kernel.org>; Tue, 15 Oct 2019 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159385;
	bh=Dfb+VbNuZRRlfRLnuBdbP9NAoaJRtcFvTHdTwBxA8Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XiBWVnd93kWO69dy/HjGFG2Q1e5XnaRzjNnrzVrBD1g7ynmt2jZuE4govExsahgfB
	 vuDsDAkL3Ohm9rcz1EGE/48RY7nReWHXR2xJrcU9l3LF284iWONBpR/CU71cb7wAK4
	 F9SI7gCgzBEy5TiC5XADOlOg0D9A90K2464MEN8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfJORJo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:09:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37913 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfJORJo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Oct 2019 13:09:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id e11so17584838otl.5;
        Tue, 15 Oct 2019 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4m4ztFRVJREZvvAzKgEyEDcwgtV2Rxd/pgAgtcgzCk=;
        b=RNPAPdO+Z+bT6TVIQ18Y977X2u8DX4HGWwC5Pm/ZGuxwQ2gxYigr2ua96oJiPF38fX
         Qvul3xhujQj5WuIOfX6j8wq0LQsPGfkhB8Oav0k738dJxmCiqXEVT6aaw0ZPnUWB3VhJ
         12NLqTfAcADH4/IZveaLXc0wlj0f2m5e0abPkNOcmGAzZavuEGtlf1gmEBjHcG2DUog5
         1uz1pNDkBEf+UUZCKF2rB+brwXQv/iqkmhE4eWcBOpIyV6yAjLBAtMuhhhjh0lS29KN9
         /MpigWryQxVI1qLRbwbLiLu9vYiAY2ptnhOEHowTuxRTdHzPtayMoDpgo1wFML0vszgd
         AbfQ==
X-Gm-Message-State: APjAAAUFApZKrTNkj509jIGNF76jIwGJumtXU3AT0e6l12MCd7tegZZt
        7Z8Tloj3wq02gDQzlV5F7NxPQ2k=
X-Google-Smtp-Source: APXvYqwhdx77gfk1a6QK5izjA81UZqxl6F9iGcwDONqsSdoALxs7FicmBNSHjrzOmaBQ30bjBdCMhg==
X-Received: by 2002:a9d:69c7:: with SMTP id v7mr4207160oto.357.1571159383555;
        Tue, 15 Oct 2019 10:09:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm6935799otj.21.2019.10.15.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:09:42 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:09:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dmitry.torokhov@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] dt-bindings: serio: Convert Allwinner PS2 controller to
 a schema
Message-ID: <20191015170941.GA8898@bogus>
References: <20191002120645.102805-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002120645.102805-1-mripard@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed,  2 Oct 2019 14:06:45 +0200, Maxime Ripard wrote:
> The older Allwinner SoCs have a PS2 controller that is supported in Linux,
> with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../serio/allwinner,sun4i-a10-ps2.yaml        | 51 +++++++++++++++++++
>  .../bindings/serio/allwinner,sun4i-ps2.txt    | 22 --------
>  2 files changed, 51 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-a10-ps2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
> 

Applied, thanks.

Rob
