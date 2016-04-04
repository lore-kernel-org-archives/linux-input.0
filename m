From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [LINUX PATCH v2] gpio_keys: Added support to read the IRQ_FLAGS
 from devicetree
Date: Mon, 4 Apr 2016 13:08:15 +0200
Message-ID: <CACRpkdZ9pqgScTV_z9TLyBgB39vuj6SGCSpz2pYj89O6XDnFrA@mail.gmail.com>
References: <1459763770-2296-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34075 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbcDDLIP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2016 07:08:15 -0400
Received: by mail-ob0-f179.google.com with SMTP id bg3so30663316obb.1
        for <linux-input@vger.kernel.org>; Mon, 04 Apr 2016 04:08:15 -0700 (PDT)
In-Reply-To: <1459763770-2296-1-git-send-email-navam@xilinx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Andersson=2C_Bj=C3=B6rn?= <bjorn.andersson@sonymobile.com>, navam@xilinx.com, Peng Fan <van.freenix@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 4, 2016 at 11:56 AM, Nava kishore Manne
<nava.manne@xilinx.com> wrote:

> This patch adds the support to read the IRQ_FLAGS from the device
> instead of hard code the flags in gpio_keys_setup_key().

NACK

>                 sw14 {
>                         label = "sw14";
>                         gpios = <&gpio0 12 1>;
>                         /*
>                          * Triggering Type:
>                          *
>                          * 1 - edge rising
>                          * 2 - edge falling
>                          * 4 - level active high
>                          * 8 - level active low
>                          *
>                          */

You are completely violating the existing GPIO flags from
include/dt-bindings/gpio/gpio.h

As you will see, for a twocell GPIO flags are already
clearly defined for 0,1,2 and 3. (Bit 0 & 1).

Further, these IRQ edge/level flags already exist in
include/dt-bindings/interrupt-controller/irq.h
but you should not be using those either, because they
do not mix with a GPIO specifier, it's a bit like oil and water.

The standard GPIO bindings already has
GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW
which makes it pretty clear that a GPIO line marked
as GPIO_ACTIVE_HIGH should trigger either on
rising edge or level active high and vice versa.

The only information you could *possibly* lack is
whether the IRQ should be edge or level triggered.

But level triggered GPIO buttons *does* *not* *make*
*sense* *at* *all*.

Think about it:

The IRQ line goes level high or low because a user
pressed a button with his/her thumb. Then that is wired
in as a level IRQ. So what are we going to do? Wait in
the interrupt handler until the user removes his/her
thumb?

Level IRQs on GPIOs only makes sense for devices
off-chip where you can talk to the device and ACK the
interrupt, and in this case "talk" does not mean wire
up a speaker telling the user to remove the thumb from
the button because we have recieved the interrupt, albeit
that would be the real-world analogy.

Please tell us what you are actually trying to solve.

Yours,
Linus Walleij
