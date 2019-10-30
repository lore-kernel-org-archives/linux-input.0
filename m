Return-Path: <SRS0=aG2u=YX=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A98CA9EC7
	for <linux-input@archiver.kernel.org>; Wed, 30 Oct 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D10F208C0
	for <linux-input@archiver.kernel.org>; Wed, 30 Oct 2019 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572444307;
	bh=1wJeIZRTGBvYQK67ll1QuK+8QXEEfDG/Z64iY5sRAb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ESeVEzV8u3TasaHrbOiKYnSNG0fUjGhY9zDsimQ1xPc4uAmGyuCB7SIs2+lugB0hH
	 uQAKW5FsrjBUhfKRYozMP7YquSFKAxx0TuczaBsROvAH7XHbEujPc9PXNJhno5Gbwl
	 5hNC/K/kpcPEZQbWHmC7YGDdJOW1tWYxJpS7EdC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfJ3OFD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:05:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43468 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OFC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Oct 2019 10:05:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id s5so2033493oie.10;
        Wed, 30 Oct 2019 07:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjUbeXseZNfZ1pV6P1oZr6TvD5+K3+0WHvnHgaOVfyc=;
        b=kQuUH+S6Fmh6UCsKAzyP9jg1N2QniL1UreLbqAQnyAMdedXbSbkaS3TxNdHzV2uloL
         8xjYRjqIFa0AtW2q7h6qolAgTniAHFQfFZgwSYqBveeqwW/lj0WKMogIDkHXW6nEDvtl
         rn6JXZztgnbo2szYMUV3ULE8DyqpsFFbFkk9c0h4E38QUJ2kLELMdyCpOqU+XdMoPNk8
         ptXLd29LEO4TfbNUwJpTuCSzgG3leMYB0pH60GXt5xSO1rYTQkauG+34ObjJSzBst8wy
         x7X0YjpKDCoM4U2JfmUlE/PvbkKzFuGRhBouWBoUvdLjgcUXGNwRlgryh10pOLhdDo99
         /KMQ==
X-Gm-Message-State: APjAAAVhJrpFYXvr0x1LBeyFFxZVrIdPjsSiC1KONflkSoCZU4jUsmTM
        tsgsqvki1p7aBPx71yZucQ==
X-Google-Smtp-Source: APXvYqxh7UaJbqXooxPymSVpV2Dkk9RFHomlOl61v/922QK11EtyGIdV7wMcJTOi1B5ho34SClF9Fw==
X-Received: by 2002:aca:5d8a:: with SMTP id r132mr8536367oib.119.1572444301779;
        Wed, 30 Oct 2019 07:05:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm55049otl.71.2019.10.30.07.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:04:56 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:04:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-imx@nxp.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] dt-bindings: input: tochscreen: ad7879: generic
 node names in example
Message-ID: <20191030140455.GA4544@bogus>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191026090403.3057-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-3-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, Oct 26, 2019 at 11:04:01AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

There's a typo in the subject.

> 
> Update example in ad7879 devicetree documentation to use generic touch
> controller node names.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2: New patch.
> 
>  .../devicetree/bindings/input/touchscreen/ad7879.txt          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
