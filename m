Return-Path: <SRS0=Maqc=YL=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E68ACA9EA9
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B22821925
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpxaFdev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfJRUjj (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:39:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38245 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJRUjj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Oct 2019 16:39:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so3397500plq.5;
        Fri, 18 Oct 2019 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yF7MutHrwkvSGB6U3XIdCr2BIBwvqm916Bsky0mGSyw=;
        b=jpxaFdev7vpkQkBEd6ufvN8+8Syuaax8emVkCAdb5pwQ08+Kx9HfaUAmG/dNO0LruH
         Ru0kVaNEtVe9TtUPNBK2HDfoNRda5QO7P3o/5lHaePEV6vpjkyLRnGWMWfpfNkOLwic4
         dD99vIdupsM6P3loEyJhDAG6j4eJzxkjjn3GzbzghzvuQGp9pzx4ygzylPs+RjDUDHiZ
         7S1C/WpfwV1W36dmHXS0Rl0SrBDOkRGXe+A3yaivtT3PLAWohYyWenjZBURub3C84fD4
         Y2JMkDGtadl07MZ+5Ewc/wwtOmdgYKepH691VkKehLXyc8PrvAZ5aF3mDaPp3Rh6DsJs
         qvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yF7MutHrwkvSGB6U3XIdCr2BIBwvqm916Bsky0mGSyw=;
        b=rH8WuIBiRV+8HU8nBg0sVYW2dbilrIlYKksccN8XgH0QQAHXsIJC7xMbDiXgfvRCBO
         Z4xB6CLcLiCDU/xx7u1dy/YMY7HvSxaiYDyE54hqeAH6Yv2+lBVpy4SgOAvk09/363S6
         UXqB/NgVzV+WwkjXtHh4XQCBhQIX7K17fCP/+GwwX56VM2YA1//n2rYNqx1rc3mwKn2Q
         QK4S8aJoBtK+WmoNVMEkj+4NDfiP9MkQwlqvZC25Zcwz9v/xMjTcCxIeg6I42nE+sUY+
         X8nJseGabKjETsEUAOBpwPy9nQcQEeHgDOnhogGC2rMKdasakhTx4xX53RnwcIeBtlXw
         E2jw==
X-Gm-Message-State: APjAAAXqC52uFzSgVl1m0wX3JfH0S6sLy4hXtxjskOcFgfsdXI8KaXuF
        Jim1ZB41O3hJiRfABnnAGpI=
X-Google-Smtp-Source: APXvYqwMMoMg/Sj3XuNx6NavhISCBWY4vd22WowubXqMjUc6xYCpcf344nB/pSVMbxAZVJeeJlF6GA==
X-Received: by 2002:a17:902:6acb:: with SMTP id i11mr12268939plt.16.1571431178249;
        Fri, 18 Oct 2019 13:39:38 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v3sm7071068pfn.18.2019.10.18.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 13:39:37 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:39:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [PATCH 25/46] ARM: pxa: mainstone-wm97xx: use gpio lookup table
Message-ID: <20191018203935.GR35946@dtor-ws>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-25-arnd@arndb.de>
 <20191018183940.GM35946@dtor-ws>
 <CAK8P3a1Fc=ogknDRGJ3Sn8bZ8tsR_ebE8_bDtF_kZ4AZ5YG_+g@mail.gmail.com>
 <CAK8P3a00s4=6YHS_2K1r6=i+artkjgxjHJGVHBLuCj1ft5sqFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a00s4=6YHS_2K1r6=i+artkjgxjHJGVHBLuCj1ft5sqFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Oct 18, 2019 at 09:37:28PM +0200, Arnd Bergmann wrote:
> On Fri, Oct 18, 2019 at 8:39 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 05:41:40PM +0200, Arnd Bergmann wrote:
> > > This driver hardcodes gpio numbers without a header file.
> > > Use lookup tables instead.
> > >
> > > Cc: Marek Vasut <marek.vasut@gmail.com>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> >
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > Arnd, do you have these devices by chance? I had stached patches
> > converting wm97xx core to use threaded ISR and it would be great if
> > someone could test them...
> 
> Unfortunately I don't, but I'm hoping that someone can test my series
> on any hardware they might have.
> 
> If you like, send me your patches and I'll add them to this series.

OK, I'll do that, thanks.

-- 
Dmitry
