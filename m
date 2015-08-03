From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] MIPS: Remove all the uses of custom gpio.h
Date: Mon, 3 Aug 2015 13:25:36 +0200
Message-ID: <CACRpkdYk13TQXYVfG0cOvmz9RTZ717rFWax+fij7oPbaUoqpOA@mail.gmail.com>
References: <1438277338-7246-1-git-send-email-albeu@free.fr>
	<CACRpkdbUhYysC+mGuJY6Y8kd18LQLoWu+av81+ZD4UZo2nM-Yw@mail.gmail.com>
	<20150803072332.GC16650@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36457 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbHCLZh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 07:25:37 -0400
Received: by oibv126 with SMTP id v126so10833435oib.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 04:25:36 -0700 (PDT)
In-Reply-To: <20150803072332.GC16650@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Alban Bedel <albeu@free.fr>, Linux MIPS <linux-mips@linux-mips.org>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Fainelli <florian@openwrt.org>, Manuel Lauss <manuel.lauss@gmail.com>, Joe Perches <joe@perches.com>, Daniel Walter <dwalter@google.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Huacai Chen <chenhc@lemote.com>, Andrew Bresticker <abrestic@chromium.org>, James Hartley <james.hartley@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Bjorn Helgaas <bhelgaas@google.com>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Varka Bhadram <varkabhadram@gmail.com>, Masanari

On Mon, Aug 3, 2015 at 9:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Aug 03, 2015 at 09:13:27AM +0200, Linus Walleij wrote:
>
>> Very good job being done here.
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I guess this better go in through the MIPS tree.
>> Given all the OpenWRT ports using MIPS this is excellent
>> progress for a large hobbyist community.
>
> Alban has posted a v2 [1] already but I take it that your Reviewed-by: applies
> to the v2 patch as well?

Sure thing. Green light for this.

Yours,
Linus Walleij
