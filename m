From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on
 keypad config
Date: Thu, 1 Nov 2012 10:35:43 +0100
Message-ID: <CAN1soZyq6F0G8F-eiA-zX2n8AAzp68URUWdf_4HsJ_OW++8u_g@mail.gmail.com>
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
	<87vcduwkfa.fsf@free.fr>
	<CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
	<87r4oiwin8.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50396 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab2KAJfo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Nov 2012 05:35:44 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1170280eek.19
        for <linux-input@vger.kernel.org>; Thu, 01 Nov 2012 02:35:43 -0700 (PDT)
In-Reply-To: <87r4oiwin8.fsf@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 29, 2012 at 2:34 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Vasily Khoruzhick <anarsoul@gmail.com> writes:
>
>> It behaves correctly, it just can't handle last keypress (because it's
>> booting Linux).
>> Even if it would be possible to fix this issue in bootloader it's
>> always nice to keep driver
>> failure-proof, so it does not fail even if bootloader left something
>> in non-consistent state.
> True.
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> --
> Robert

Applied

Thanks
Haojian
