From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on
 keypad config
Date: Sun, 28 Oct 2012 21:09:42 +0300
Message-ID: <CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com> <87vcduwkfa.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42877 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab2J1SKD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Oct 2012 14:10:03 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4628857vbb.19
        for <linux-input@vger.kernel.org>; Sun, 28 Oct 2012 11:10:02 -0700 (PDT)
In-Reply-To: <87vcduwkfa.fsf@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Oct 28, 2012 at 8:55 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Vasily Khoruzhick <anarsoul@gmail.com> writes:
>
>> Bootloader can leave interrupt bit pending, and it confuses driver.
> OK, looks good to me.
> One question though, just to make sure everything is covered :
>   Suppose that the resume is the consequence of keypad press. If anybody relied
>   previously on "reading the keypad" to know which key was pressed to wakeup the
>   SoC, is it still working after your patch ?

Hi Robert,

Code from git master will not call pxa27x_keypad_config on resume if
device can cause wakeup,
so everything is OK (however it's another issue for pxa27x, because
device is not resuming correctly)

> And I suppose you can't "convince" your bootloader to behave correctly, can you ?

It behaves correctly, it just can't handle last keypress (because it's
booting Linux).
Even if it would be possible to fix this issue in bootloader it's
always nice to keep driver
failure-proof, so it does not fail even if bootloader left something
in non-consistent state.

Regards
Vasily
