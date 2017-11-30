From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] gpio: pca953x: Name the gpiochip after the I2C address
Date: Thu, 30 Nov 2017 15:45:22 +0100
Message-ID: <CACRpkdY8MRAQ_c+mf5R_mbveuKPaJu4_d2gxTCsRraLCRPqi1A@mail.gmail.com>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
 <20171124093045.5961-3-linus.walleij@linaro.org> <20171124142627.GG30167@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:45475 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdK3OpY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Nov 2017 09:45:24 -0500
Received: by mail-io0-f174.google.com with SMTP id e204so7728886iof.12
        for <linux-input@vger.kernel.org>; Thu, 30 Nov 2017 06:45:23 -0800 (PST)
In-Reply-To: <20171124142627.GG30167@lunn.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 24, 2017 at 3:26 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Nov 24, 2017 at 10:30:42AM +0100, Linus Walleij wrote:
>> Just putting the name of the I2C device as name for the
>> GPIO chip (label) is ambigous, and makes it hard for us
>> to use GPIO descriptor tables on systems such as DaVinci
>> DA850EVM which has two chips but on I2C address 0x20 and 0x21.
>>
>> Instead, append "-XX" to the GPIOchip name using the I2C
>> address so we get a unique chip name that can be used
>> in descriptor tables, such as "tca6416-20" and
>> "tca6416-21" on the DaVinci DA850EVM.
>
> Hi Linus
>
> Are you making the assumption that there are not two devices at the
> same address but on different I2C busses?

Yes.

> How safe is that assumption? Can you include the adapter ID in the
> string?

Sure, I just had to come up with something.

The universe of board files is not very big, so the number of
potentially clashing things is not eternal. This is just a transient
"contain and deprecate" thing so I think it's unlikely that they
clash but usually when I say something like that the next day
it happens...

So I can add the adapter number :)

I am waiting for more feedback on the series before resending.

Yours,
Linus Walleij
