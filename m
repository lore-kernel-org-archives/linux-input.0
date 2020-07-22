Return-Path: <SRS0=K8d0=BB=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4702C433EA
	for <linux-input@archiver.kernel.org>; Wed, 22 Jul 2020 20:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18A522B43
	for <linux-input@archiver.kernel.org>; Wed, 22 Jul 2020 20:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfciZa/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbgGVUDg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732555AbgGVUDf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Jul 2020 16:03:35 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C5C0619DC
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2020 13:03:35 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n4so1057795uae.5
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2020 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7aSWKdtvta1yHh+KlfXMiOO0rXZkSWXTEG5K9jCAsw=;
        b=lfciZa/fv9ElYFFHFuqCne/4U//jsFkfKPzLRT3rBEqsWXu0eglAUqGTPRJ243x04F
         lSmGFnsTG3OnRwNoL7487Zj8TlewVd2kNNLeO/YV4i/C1bLwpmcUc+kZdsi5CC9pI3yj
         sJL/B4gCAMYSNAbLsYaX3ieVnOtkX0jRIYE3uaULGy745ry9bwz4BeQdA5/0JxbqBQAG
         TMH7ny+WoN4aXcPlHMwyUL6o4Z/nrnJ+SrWHBHSCRoUgnzBWzVp4OFnXbeE+U0J0sr9x
         OiUpciwEBjx3MJeUfqhgeAzKcrVh4NoTBbthM8J8NgiZcfpaA+0i4KXvp2Ql6YegsB+R
         b9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7aSWKdtvta1yHh+KlfXMiOO0rXZkSWXTEG5K9jCAsw=;
        b=XBM1QdV1KP2EH1nOguhY03hs+lK8toMzw2Stm0GK5GWVM0ug02F4QOO1vZZGd24pRC
         /Jzc35bX+TaI4kR+RfmxGIQkGSPS8HReEqaZoYLcNFqbj52r66ftVBzhW5jug6grFbce
         iLQxLtreQCPMhEtjrnxAIBX/Kqml0OLPwJfYtBthQJVrT7aBfVw7btGBP5mWJ9iH0zLF
         eFfqT7X+1eDUkCk8jKw9RI72Vt6fwVZs2iS9OKw5KqS+hu2+yCZdiwFmlN9OMLI5CjUD
         GOTVmS+xl7I6+gYYH9uQ2AWY/Cr2wvEUZSzpM38s0mp21qzbzW3OvEabqAUBrr6tCv/n
         r2JQ==
X-Gm-Message-State: AOAM531vxtD4nGyioTxXzGa0+9HukWtU3/QzKuRDviD/QV54NUK0K2WO
        WHsuc5tB3Ap7nvWnBJv/cNxDi1+STrz0w5N5VTY=
X-Google-Smtp-Source: ABdhPJz08GM5iL6ocVtp1qChld4QW/wd9c7gzMs8BMOABnZmuNNxqD8YpwbdiGm9X8oLweJ7cFWGdVUyDn+LU7q2Zf4=
X-Received: by 2002:ab0:4d4d:: with SMTP id k13mr1422265uag.113.1595448214719;
 Wed, 22 Jul 2020 13:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200317032928.546172-1-djogorchock@gmail.com>
 <64ed771ebdd6c47c11a94f4e0ae365c6106b93f6.camel@hadess.net>
 <CAEc3jaACUvyrP=9=JZeUZEC16zDJ2NByJzaPHVO24024jwKJoA@mail.gmail.com>
 <59a550594ac3824532a667c668bf1dcb80747599.camel@hadess.net>
 <CAEc3jaDsSmCB0-AQDrh4_Cw3WjAavfXSy6G_A+bEtBF0U5ydkQ@mail.gmail.com>
 <703dfd7eeeb0839a34f8668c3a0d79c1ffd3ed59.camel@hadess.net>
 <CAEVj2tnXNF0BCSdH46DmNRtxPRO7oHkjdmvJuCmiRz4t4pFWuA@mail.gmail.com>
 <292d45aa-cd32-3348-ce32-965281a52b20@valvesoftware.com> <CAEVj2t=Az1G6X9Kj050aXVetW+PX==LgoEM9C3ES886NsYygcw@mail.gmail.com>
 <08812dc28896e5be07cfc40dda790f0d62171f7b.camel@hadess.net>
In-Reply-To: <08812dc28896e5be07cfc40dda790f0d62171f7b.camel@hadess.net>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Wed, 22 Jul 2020 15:03:23 -0500
Message-ID: <CAEVj2t=Uce_GPPfzVAzuETFpYeGaNkCdtBF41+GqC5AUzV77GA@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] HID: nintendo
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Roderick Colenbrander <thunderbird2k@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Billy Laws <blaws05@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>,
        Siarhei Vishniakou <svv@google.com>, s.jegen@gmail.com,
        Carl Mueller <carmueller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Bastien,

On Wed, Jul 22, 2020 at 2:47 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2020-07-22 at 14:22 -0500, Daniel Ogorchock wrote:
> >
> > <snip>
> > I will probably hold off on submitting that until we
> > figure out the right
> > solution to the hidraw issue.
>
> Any chance you could make your work available as a stand-alone driver?
> Something like this:
> https://github.com/hadess/retrode
> would make it easy to test in-development versions of the driver until
> it lands (I might want to give a try to the optional features for the
> GBros adapter as we discussed a couple of months ago).
>
> Cheers
>

I've been keeping my latest patches in this tree:
https://github.com/DanielOgorchock/linux/commits/ogorchock
nicman23 has been maintaining a dkms module for it here:
https://github.com/nicman23/dkms-hid-nintendo
as well as an aur package here:
https://aur.archlinux.org/packages/hid-nintendo-dkms/
if either of those are helpful.

Thanks,
Daniel
