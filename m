Return-Path: <SRS0=9oVF=YD=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35099C4360C
	for <linux-input@archiver.kernel.org>; Thu, 10 Oct 2019 03:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A00F2086D
	for <linux-input@archiver.kernel.org>; Thu, 10 Oct 2019 03:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewnLhhbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfJJDTm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:19:42 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44065 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbfJJDTm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2019 23:19:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id v1so1455836ybo.11;
        Wed, 09 Oct 2019 20:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yapqKKHmksWpjKK9kDJuZQP0a3cvdgyZZKcG0PlCzF4=;
        b=ewnLhhbT+VP2SFCwBTjZJW2lR9IIIXym/4r6Fe+sB9K0RME8A3ZhGhnSiIq80RhR+S
         jki15CfIIPOmaNbd++Diis39U6kRYnT/95rva/Ktfancm7G9ErgepZltJL2R8q+WyXOa
         5dXBA5TZiK1WZ8PurUMuaeTstggwbN0ovEz4a1ITGfZYMFBxjP3Xom/bF7IGQfZaAxYY
         l8+CAVJPD8mmbKllihYvqSBRjnqXXthrAJ8hkUhKCPQn2+AoWTbPT44/mfsLSLv5FXVl
         AIIz4DvHDc1HDsJzEARcCv6B4elcPPNB5Tr3ViQG7oYPMQuGdT6fvHIjrovf5jooxmPt
         ZcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yapqKKHmksWpjKK9kDJuZQP0a3cvdgyZZKcG0PlCzF4=;
        b=mXuJwZF/WaBznJcnARPy8efDESrfZFN5GGCXtrUFHHMaKyHRxPjAADYNXmTYTZbygP
         E99CVySTJEFkpctniXp6wVHF7Re8KOlBLGSjq7ik/8q3pznVSMtcoVylfypVAEGEAxUQ
         sOewvFOAvQssw1zDU5oNnnZMB1VhRVjLeeHiplIihKsJn1UU+0Ksrcmd4prrtOfgrg26
         eVsmLOZ2OwK9SxuLYfNyYdCpGpBLtdVBJO22nzzN5bvNzu7MzF++2gviCEc+c5cO8Afl
         PVWzDVtbPvUci2iDStEsrPInPOekxAeUU2mNyZHITP6p3lgZZP9LalstQ9YAN71utWPU
         Kdow==
X-Gm-Message-State: APjAAAVwwqqZSmiwTW9I5AIw2/9OE1sIbLR8vMSPCEZCPVzxEcPHFGDO
        kiFsXDSVpJgmVRsTS+mN4QPLRzybv6SvAmiJmoU=
X-Google-Smtp-Source: APXvYqw6gupd/j7IiSMTNcxmWDOPkIQSNBNpIbuVfbdMQVc6gpdPJLQ0ZszgaDR9Qe62lAzCUqJrtBkHTpv4R81AZBI=
X-Received: by 2002:a25:5386:: with SMTP id h128mr4364699ybb.362.1570677579901;
 Wed, 09 Oct 2019 20:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <1570625609-11083-1-git-send-email-candlesea@gmail.com>
 <d739f691b677fb3ed88a23476d221527a87c363d.camel@suse.de> <nycvar.YFH.7.76.1910091958120.13160@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1910091958120.13160@cbobk.fhfr.pm>
From:   Candle Sun <candlesea@gmail.com>
Date:   Thu, 10 Oct 2019 11:19:28 +0800
Message-ID:
 <CAPnx3XNGBw+SKSFA3DhhHFZZ17f54DMfYjKOcqYTb3N-PWGKpw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: core: check whether usage page item is after
 usage id item
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        orson.zhai@unisoc.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191010031928.O5o9V0M41JTYQVLCc-f8fe2o0irQdCpaceyXlF6MUoc@z>

On Thu, Oct 10, 2019 at 2:00 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 9 Oct 2019, Nicolas Saenz Julienne wrote:
>
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 3eaee2c..3394222 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -35,6 +35,8 @@
> > >
> > >  #include "hid-ids.h"
> > >
> > > +#define GET_COMPLETE_USAGE(page, id) (((page) << 16) + ((id) & 0xffff))
> >
> > Not sure I like the macro. I'd rather have the explicit code. That said, lets
> > see what Benjamin has to say.
>
> Not sure about Benjamin :) but I personally would ask for putting it
> somewhere into hid.h as static inline.
>
> And even if it's for some reason insisted on this staying macro, please at
> least put it as close to the place(s) it's being used as possible, in
> order to maintain some code sanity.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Thanks Nicolas and Jiri,
If macro is not good, I will change it to static function. But the
funciton is only used in hid-core.c,
maybe placing it into hid.h is not good?

Regards,
Candle
