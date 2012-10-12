From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 14:35:52 -0700
Message-ID: <2124185.0mAfDLSa7H@dtor-d630.eng.vmware.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com> <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:45668 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2JLVf6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:35:58 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1514721dak.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:35:57 -0700 (PDT)
In-Reply-To: <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, Jonas ABERG <jonas.aberg@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Friday, October 12, 2012 11:26:00 PM Linus Walleij wrote:
> On Fri, Oct 12, 2012 at 5:55 PM, Daniel Mack <zonque@gmail.com> wrote:
> > This allows DT driven boards to allocate and configure the pinmux once
> > the driver is probed.
> > 
> > Signed-off-by: Daniel Mack <zonque@gmail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> (...)
> 
> > +       /* request pin mux */
> > +       pinctrl = devm_pinctrl_get_select_default(dev);
> > +       if (IS_ERR(pinctrl))
> > +               dev_warn(dev, "pins are not configured from the
> > driver\n");
> 
> I think dev_warn() is rather nasty to throw in here, dev_info() is OK.
> 
> However I suspect this driver could actually handle default, idle and sleep
> states, especially after the runtime PM patches discussed elsewhere,
> but that can be patched later.

I take this as Acked-by then?

-- 
Dmitry
