From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: keyboard: constify attribute_group structures.
Date: Mon, 31 Jul 2017 15:42:00 +0200
Message-ID: <CACRpkdbv+8_U8Xhdwo2Ry4p+128pe5ChkvwsfGJgqab2Ri2NZQ@mail.gmail.com>
References: <5c9063817d021c487f3429a4fee60fa84e0e93d6.1499251467.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34056 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaNmC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Jul 2017 09:42:02 -0400
Received: by mail-io0-f174.google.com with SMTP id o9so3431625iod.1
        for <linux-input@vger.kernel.org>; Mon, 31 Jul 2017 06:42:02 -0700 (PDT)
In-Reply-To: <5c9063817d021c487f3429a4fee60fa84e0e93d6.1499251467.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 5, 2017 at 12:46 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
>
> File size before:
>    text    data     bss     dec     hex filename
>    5693     464       0    6157    180d drivers/input/keyboard/gpio_keys.o
>
> File size After adding 'const':
>    text    data     bss     dec     hex filename
>    5749     400       0    6149    1805 drivers/input/keyboard/gpio_keys.o
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
