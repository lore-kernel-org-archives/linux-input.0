From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 0/5] Input: make the GPIO mouse useful
Date: Sun, 17 Sep 2017 14:44:20 +0200
Message-ID: <20170917124419.y2vlxykkjmp3isg3@samfundet.no>
References: <20170917111445.30880-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:33505 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdIQNPB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Sep 2017 09:15:01 -0400
Content-Disposition: inline
In-Reply-To: <20170917111445.30880-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Around Sun 17 Sep 2017 13:14:40 +0200 or thereabout, Linus Walleij wrote:
> The GPIO mouse device does not have any in-kernel users.
> 
> This series converts it to use descriptors, adds device tree
> bindings and adds device tree probing so it can be used for
> embedded target etc without proper mouse ports.
> 
> An alternative is to simply delete the driver. But I took
> pity in it and I am also worried that the number of out-of-tree
> users could be pretty large.
> 
> Hans-Christian: can you express your idea for the future of
> this driver? Does this look all right to you? Do you want to
> add some users in some device trees maybe?

I had completely forgotten about this driver. IIRC we used it quite a lot on
various stages of development for Atmel's AVR32 processors, an architecture
now removed from the kernel.

I have found it quite useful when needing a simple input mouse like device on
embedded systems, so hopefully it is of value for other users.

OTOH, I have not used this driver for years, but if somebody do occasionally
use it, I do not mind it staying around. If the majority of people want it
out, then I will not object that either.

> Linus Walleij (5):
>   input: mouse: Kill off platform data for GPIO mouse
>   input: mouse: Rename GPIO mouse variables
>   input: mouse: Add DT bindings for GPIO mice
>   input: mouse: Convert GPIO mouse to use descriptors
>   input: mouse: Add device tree probing to GPIO mouse
> 
>  .../devicetree/bindings/input/gpio-mouse.txt       |  32 ++++
>  drivers/input/mouse/gpio_mouse.c                   | 195 +++++++++++----------
>  include/linux/gpio_mouse.h                         |  61 -------
>  3 files changed, 130 insertions(+), 158 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
>  delete mode 100644 include/linux/gpio_mouse.h

Good work, this driver is a lot more usable rewritten to support device tree
instead of platform data. I would assume any 4.14++ kernel users is over on
device tree anyway.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> on these five
patches.

-- 
mvh
Hans-Christian Noren Egtvedt
