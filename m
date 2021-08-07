Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA09DC4320A
	for <linux-input@archiver.kernel.org>; Sat,  7 Aug 2021 15:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B5260F5A
	for <linux-input@archiver.kernel.org>; Sat,  7 Aug 2021 15:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhHGPSE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 7 Aug 2021 11:18:04 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:38956 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231159AbhHGPSD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 7 Aug 2021 11:18:03 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 662FC18238842;
        Sat,  7 Aug 2021 15:17:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id EEE8B1D42FA;
        Sat,  7 Aug 2021 15:17:41 +0000 (UTC)
Message-ID: <0c1d7c01821f1f0891fd8f13c1e8f9a68bb21717.camel@perches.com>
Subject: Re: [PATCH] drivers/input: Remove all strcpy() uses in favor of
 strscpy()
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hardening@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 07 Aug 2021 08:17:39 -0700
In-Reply-To: <20210807140245.GA2688@titan>
References: <20210801144316.12841-1-len.baker@gmx.com>
         <20210801145959.GI22278@shell.armlinux.org.uk>
         <20210801155732.GA16547@titan> <202108010934.FA668DEB28@keescook>
         <20210807140245.GA2688@titan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EEE8B1D42FA
X-Stat-Signature: pwijksomz6gtkkoep9eeicnahht4ctew
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19wOvYjIgVqLuXn/xjQleZQQKop/qZhuMg=
X-HE-Tag: 1628349461-59007
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 2021-08-07 at 16:02 +0200, Len Baker wrote:
> On Sun, Aug 01, 2021 at 09:44:33AM -0700, Kees Cook wrote:
[]
> > One thing is clear: replacing strlcpy() with strscpy() is probably the
> > easiest and best first step to cleaning up the proliferation of str*()
> > functions.
> 
> Thanks for all this info. I will work on it (clean up the proliferation
> of str*() functions).

btw:

It's not possible to sed as the return value is different,
but here is a cocci script that converts strlcpy to strscpy
when the return value is unused.

    @@
    expression e1, e2, e3;
    @@
    
    -       strlcpy(
    +       strscpy(
            e1, e2, e3);

This cocci script was used on sound/ awhile back.
see commit 75b1a8f9d62e.


