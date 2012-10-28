From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on keypad config
Date: Sun, 28 Oct 2012 18:55:37 +0100
Message-ID: <87vcduwkfa.fsf@free.fr>
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:38709 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499Ab2J1Rzy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Oct 2012 13:55:54 -0400
In-Reply-To: <1351439163-9575-1-git-send-email-anarsoul@gmail.com> (Vasily
	Khoruzhick's message of "Sun, 28 Oct 2012 18:46:03 +0300")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> Bootloader can leave interrupt bit pending, and it confuses driver.
OK, looks good to me.
One question though, just to make sure everything is covered :
  Suppose that the resume is the consequence of keypad press. If anybody relied
  previously on "reading the keypad" to know which key was pressed to wakeup the
  SoC, is it still working after your patch ?

And I suppose you can't "convince" your bootloader to behave correctly, can you ?

Cheers.

--
Robert
