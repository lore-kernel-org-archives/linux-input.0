From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 8 Sep 2010 08:46:01 -0700
Message-ID: <20100908154601.GF4190@core.coreip.homeip.net>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
 <4C8645CB.9070206@codeaurora.org>
 <33A307AF30D7BF4F811B1568FE7A9B181C8565B5@EXDCVYMBSTM006.EQ1STM.local>
 <4C87885C.70704@codeaurora.org>
 <AANLkTinYfUVGignRSA+GPWz4yHothgm6TTyt7ruMvmS9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37937 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0IHPqS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 11:46:18 -0400
Received: by pwi3 with SMTP id 3so102260pwi.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 08:46:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinYfUVGignRSA+GPWz4yHothgm6TTyt7ruMvmS9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, Sundar R IYER <sundar.iyer@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On Wed, Sep 08, 2010 at 04:19:45PM +0200, Linus Walleij wrote:
> 2010/9/8 Trilok Soni <tsoni@codeaurora.org>:
> > [Sundar]
> >> Yes it can. I am seeing increasing tendency to migrate to threaded_irq from the legacy irq recently
> >> and hence the threaded request.
> >
> > Use threaded_irq only when needed with different flags and not everywhere. In this case we don't
> > need threaded irq at all.
> 
> Look closer at the IRQ handler:
> 
> +static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
> (...)
> +       /*
> +        * if KPASON is not ready, we cannot read data registers
> +        * so wait for a debounce period; if still not settled,
> +        * we fire a timer and exit the IRQ
> +        */
> +       while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && timeout--)
> +               cpu_relax();
> 
> Active polling. Surely you want this to be preemptible? Thus ->
> threaded handler.
> 

Actually I'd like that form of active polling not be there at all.

-- 
Dmitry
