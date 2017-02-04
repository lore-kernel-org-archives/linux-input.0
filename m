From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/2] gpio: Add the devm_fwnode_get_index_gpiod_from_child()
 helper
Date: Sat, 4 Feb 2017 21:29:50 +0100
Message-ID: <CACRpkdYaLy8dNYEYKCocXf6jc0XPumQ6KoEnSkwaWvUs3m9Djw@mail.gmail.com>
References: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1486043591-6278-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34123 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdBDU3w (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Feb 2017 15:29:52 -0500
Received: by mail-io0-f175.google.com with SMTP id l66so41570346ioi.1
        for <linux-input@vger.kernel.org>; Sat, 04 Feb 2017 12:29:52 -0800 (PST)
In-Reply-To: <1486043591-6278-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thu, Feb 2, 2017 at 2:53 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:

> devm_fwnode_get_gpiod_from_child() currently allows GPIO users to
> request a GPIO that is defined in a child fwnode instead of directly in
> the device fwnode.
> Extend this API by adding the devm_fwnode_get_index_gpiod_from_child()
> helper which does the same except you can also specify an index in case
> the 'xx-gpios' property describe several GPIOs.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Patch applied.

Both are stacked on ib-gpiod-flags for now, going into test compile.

Yours,
Linus Walleij
