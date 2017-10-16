From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5 v2] input: mouse: Kill off platform data for GPIO mouse
Date: Mon, 16 Oct 2017 10:17:53 +0200
Message-ID: <CACRpkdaiNZXPcJPGH+-dU-1-dDLnDw18AyaMHTgRR5z5NwOx2A@mail.gmail.com>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:49204 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdJPIRy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Oct 2017 04:17:54 -0400
Received: by mail-it0-f44.google.com with SMTP id y15so177566ita.4
        for <linux-input@vger.kernel.org>; Mon, 16 Oct 2017 01:17:54 -0700 (PDT)
In-Reply-To: <20170925163430.22397-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>
Cc: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Linus Walleij <linus.walleij@linaro.org>

On Mon, Sep 25, 2017 at 6:34 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This is not used much: git grep  gpio_mouse_platform_data shows
> that absolutely nothing in the kernel defines this platform
> data.
>
> It could be argued that the driver should be deleted. But that
> is a bit harsh I think since it seems generally useful. So
> this patch starts a series which repurposes it to be used with
> hardware nodes from device tree or ACPI.
>
> This first patch simply localize the platform data header and
> allocates a dummy platform data.
>
> Yes: this patch leaves the driver in a pretty useless state,
> but since nothing is instantiating this driver, it doesn't
> make it more useless than it already is. Later patches makes
> use of the driver.
>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Collect Hand-Christian's ACK

Dmitry: with Rob's ACK arrvied on the DT bindings, can this series
be applied?

Yours,
Linus Walleij
