From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on keypad config
Date: Sun, 28 Oct 2012 19:34:03 +0100
Message-ID: <87r4oiwin8.fsf@free.fr>
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
	<87vcduwkfa.fsf@free.fr>
	<CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:34780 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab2J1SeT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Oct 2012 14:34:19 -0400
In-Reply-To: <CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
	(Vasily Khoruzhick's message of "Sun, 28 Oct 2012 21:09:42 +0300")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> It behaves correctly, it just can't handle last keypress (because it's
> booting Linux).
> Even if it would be possible to fix this issue in bootloader it's
> always nice to keep driver
> failure-proof, so it does not fail even if bootloader left something
> in non-consistent state.
True.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
