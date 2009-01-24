From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] input: add driver for S1 button of rb532
Date: Sat, 24 Jan 2009 09:34:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901240934040.13803@anakin>
References: <1232651528-19870-1-git-send-email-n0-1@freewrt.org>
 <1232651528-19870-2-git-send-email-n0-1@freewrt.org> <20090122191216.15285400E106@mail.nwl.cc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yorgi.telenet-ops.be ([195.130.133.69]:33212 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbZAXIfU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jan 2009 03:35:20 -0500
Received: from monty.telenet-ops.be (monty.telenet-ops.be [195.130.132.56])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id DD7C4588104
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2009 09:35:18 +0100 (CET)
In-Reply-To: <20090122191216.15285400E106@mail.nwl.cc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>

On Thu, 22 Jan 2009, Phil Sutter wrote:
> Mikrotik's Routerboard 532 has two builtin buttons, from which one
> triggers a hardware reset. The other one is accessible through GPIO pin
> 1. Sadly, this pin is being multiplexed with UART0 input, so enabling it
> as interrupt source (as implied by the gpio-keys driver) is not possible
> unless UART0 has been turned off. The later one though is a rather bad
> idea as the Routerboard is an embedded device with only a single serial
> port, so it's almost always used as serial console device.
> 
> This patch adds a driver based on INPUT_POLLDEV, which disables the UART
> and reconfigures GPIO pin 1 temporarily while reading the button state.
> This procedure works fine and has been tested as part of another,
> unpublished driver for this device.

What happens when you receive UART input while the UART is disabled? Is it
lost?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
