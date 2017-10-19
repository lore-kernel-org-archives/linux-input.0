From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5 v2] input: mouse: Kill off platform data for GPIO
 mouse
Date: Thu, 19 Oct 2017 16:29:41 -0700
Message-ID: <20171019232941.dzxwj5jtzpmh3btq@dtor-ws>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
 <CACRpkdaiNZXPcJPGH+-dU-1-dDLnDw18AyaMHTgRR5z5NwOx2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:52236 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdJSX3p (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Oct 2017 19:29:45 -0400
Received: by mail-it0-f68.google.com with SMTP id j140so11659110itj.1
        for <linux-input@vger.kernel.org>; Thu, 19 Oct 2017 16:29:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdaiNZXPcJPGH+-dU-1-dDLnDw18AyaMHTgRR5z5NwOx2A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

On Mon, Oct 16, 2017 at 10:17:53AM +0200, Linus Walleij wrote:
> On Mon, Sep 25, 2017 at 6:34 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This is not used much: git grep  gpio_mouse_platform_data shows
> > that absolutely nothing in the kernel defines this platform
> > data.
> >
> > It could be argued that the driver should be deleted. But that
> > is a bit harsh I think since it seems generally useful. So
> > this patch starts a series which repurposes it to be used with
> > hardware nodes from device tree or ACPI.
> >
> > This first patch simply localize the platform data header and
> > allocates a dummy platform data.
> >
> > Yes: this patch leaves the driver in a pretty useless state,
> > but since nothing is instantiating this driver, it doesn't
> > make it more useless than it already is. Later patches makes
> > use of the driver.
> >
> > Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Collect Hand-Christian's ACK
> 
> Dmitry: with Rob's ACK arrvied on the DT bindings, can this series
> be applied?

Queued for 4.15, thank you.

-- 
Dmitry
