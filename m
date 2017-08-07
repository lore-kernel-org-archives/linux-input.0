From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] serio: PS/2 gpio bit banging driver for serio bus
Date: Mon, 7 Aug 2017 14:21:30 +0200
Message-ID: <CACRpkdZN27i6QZ6jGWqSt4zLMtozS3YHTUvqtN9UZHt+6NhPaQ@mail.gmail.com>
References: <20170802121222.30457-1-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:32871 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbdHGMVb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Aug 2017 08:21:31 -0400
Received: by mail-it0-f44.google.com with SMTP id f16so624568itb.0
        for <linux-input@vger.kernel.org>; Mon, 07 Aug 2017 05:21:31 -0700 (PDT)
In-Reply-To: <20170802121222.30457-1-danilokrummrich@dk-develop.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@infradead.org>

On Wed, Aug 2, 2017 at 2:12 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:

> This driver provides PS/2 serio bus support by implementing bit banging
> with the GPIO API. The GPIO pins, data and clock, can be configured with
> a node in the device tree or by generic device properties (GDP).
>
> Writing to a device is supported as well, though it is not recommended as
> the timings to be halt given by libps2 are very tough and difficult to
> reach with bit banging. Therefore it can be configured (also in DT and
> GDP) whether the serio write function should be available for clients.
>
> This driver is for development purposes and not for productive use.
> However, this driver can be useful e.g. when no USB port is available or
> using old peripherals is desired as PS/2 controller chips getting rare.
>
> This driver was tested on RPI1 and on Hikey960 and it worked well together
> with the atkbd driver.
>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
> v2: Removed one verbose print statement, changed another one to dev_dbg.
> v3: - fixed compiler warning on blackfin
>     - depends on GPIOLIB
>     - clarify documentation
> v4: - fixed concurrent calls to ps2_gpio_write (serio->write)
>     - use gpiod API
>     - use generic device properties
>     - request irq separately, do not use gpiod_to_irq
>     - abort when gpio is connected via slow bus
>     - Fixed a bug where PS2_CMD_RESEND is always send after tx failed once.
>       The makes the write functionallity work better, tough timing is still
>       critical.
>     - disable irq initially until ps2_gpip_open (serio->open) is called

Oh there is a new version of this patch.

This is better, some review comments from my old review still
holds.

Yours,
Linus Walleij
