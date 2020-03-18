Return-Path: <SRS0=NBds=5D=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBBC10DCE
	for <linux-input@archiver.kernel.org>; Wed, 18 Mar 2020 04:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A7C20768
	for <linux-input@archiver.kernel.org>; Wed, 18 Mar 2020 04:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNWQuYS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgCREM6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 18 Mar 2020 00:12:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39821 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgCREM5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Mar 2020 00:12:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id f10so25425295ljn.6
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2020 21:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5RQy3c2offPt/+uCMqQvbRmg044IUDq91T7c4twuiQ=;
        b=PNWQuYS3DuEgG1TiRWX8q+/naX/RHcP4pfdCBEVHg5cGKkSz3CJsNMUQvZs1XqISn7
         MMjOoD2ESJw7hs7Sp6ETaNXJypXRC2brDHv1phlLM/rhN5u0NTDTWDk2jGgSkkDkfcVz
         rvJFwuZFUah0S2YbC9OhKBtqV2s/QWF5R7kjgIyAX5sMJmAiqw6xMF6GFLqp/6/OJC2Q
         7LzylG3jBo3r0UAmlCSTTPgv+Kx+F6NuCfrs+xiXLgP1nEhCM1xL+rxP9twLHrsiz8dw
         78FAEJpYdl59tv3vp9mSwv2txpYXconQ1LT4Ri9fx6yzegtHIm6YsGVwo8G3Dbu3FR53
         OnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5RQy3c2offPt/+uCMqQvbRmg044IUDq91T7c4twuiQ=;
        b=krbLBAyR1APl4o2cNyye/Bxm1YYdonoMZ3RBK7ztDmKoyZvxbTuqCwwTaX1MbD2dEA
         xZmWdUtYvkqcXAp+DXrXdOPlyhtBxhzwmdlGavAm6swXrLXl5xHpkjo6nCsOTQ8Ad61/
         38pNvIs+YHPuybZ9lkmfNW16XJ3p9WILjjoF2QwtoCwXeBGsMcnf37ioOeaDGo6GIrX/
         i4x+5STe26nquObQ3N+L1MbrAW3woVs4fgO5enSusXJVvuknt0GYjEpNTwnw+CgUcqHy
         QRmyWFnvzM61T+QtPuCKg9J5p1WePBxKmuZbwnjkBqThhM9+njOeDh6HtKZcHUgvmboh
         Iohw==
X-Gm-Message-State: ANhLgQ0EZqR2z5mUCf9HpcFqWUGZpK3AO8KUZZ27AyveyIRQ8EH7n8LE
        x5gp6jWMICuIJvEr96rsjgFYz2+N00ILaW0AA7k48A==
X-Google-Smtp-Source: ADFU+vshXsd069bcjh1DLJuN1A/iA9e1k3ypyxTcYsCayU/zyxOdXvq0TOmOvunUbxQpqQcl6WbQZ0tk2O56M3OLf54=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr1092986ljk.107.1584504775380;
 Tue, 17 Mar 2020 21:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200313180333.75011-1-rajatja@google.com> <20200318035618.GG192640@dtor-ws>
In-Reply-To: <20200318035618.GG192640@dtor-ws>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 17 Mar 2020 21:12:19 -0700
Message-ID: <CACK8Z6HXTDWteq1iVAHqw4irsWHGvAaS3apwNCicxGNreMncHg@mail.gmail.com>
Subject: Re: [PATCH v3] Input: Allocate keycode for "Selective Screenshot" key
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Harry Cutts <hcutts@chromium.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Mar 17, 2020 at 8:56 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Mar 13, 2020 at 11:03:33AM -0700, Rajat Jain wrote:
> > New chromeos keyboards have a "snip" key that is basically a selective
> > screenshot (allows a user to select an area of screen to be copied).
> > Allocate a keycode for it.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Applied, thank you.

I just noticed that I had by mistake used KEY_SELECTIVE_SNAPSHOT
instead of intended KEY_SELECTIVE_SCREENSHOT in the commit message. My
apologies. Can you please fix the commit message if not already
pushed. Otherwise I can send a follow up patch if you'd like.

Thanks & Best Regards,

Rajat

>
> > ---
> > v3: Rename KEY_SNIP to KEY_SELECTIVE_SNAPSHOT
> > V2: Drop patch [1/2] and instead rebase this on top of Linus' tree.
> >
> >  include/uapi/linux/input-event-codes.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > index 0f1db1cccc3fd..c4dbe2ee9c098 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -652,6 +652,8 @@
> >  /* Electronic privacy screen control */
> >  #define KEY_PRIVACY_SCREEN_TOGGLE    0x279
> >
> > +#define KEY_SELECTIVE_SCREENSHOT     0x280
> > +
> >  /*
> >   * Some keyboards have keys which do not have a defined meaning, these keys
> >   * are intended to be programmed / bound to macros by the user. For most
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >
>
> --
> Dmitry
