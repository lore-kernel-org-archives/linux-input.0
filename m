From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Mon, 06 Jan 2014 11:50:46 +0900
Message-ID: <009301cf0a8a$1963cfd0$4c2b6f70$%han@samsung.com>
References: <20140104090147.GA16680@core.coreip.homeip.net>
 <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
 <20140106023358.GA11575@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34211 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbaAFCus (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Jan 2014 21:50:48 -0500
In-reply-to: <20140106023358.GA11575@earth.universe>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Sebastian Reichel' <sre@debian.org>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, January 06, 2014 11:34 AM, Sebastian Reichel wrote:
> On Mon, Jan 06, 2014 at 11:25:54AM +0900, Jingoo Han wrote:
> > IMHO, input_unregister_device() seems to be necessary,
> > because input_register_device() is still used.
> > If I am wrong, please let me know kindly.
> >
> > Sebastian Reichel,
> > Would you repeat insmod & rmmod 'twl4030_keypad.ko'?
> 
> mh. I only tested with twl4030-keypad compiled into the kernel.
> I will try building the driver as module and reloading it on
> the device when I find some time.

OK, I see. :-)

If you repeat at least twice insmod & rmmod 'twl4030_keypad.ko',
it will be good. If there are some bugs, it will make the error
messages or kernel panic.

In my case, Samsung Exynos SPI driver made kernel panic when
Repeating insmod & rmmod twice, after the patch to covert to
devm_* functions was applied. This was because there was a bug
of devm_spi_register_master().

Thank you.

Best regards,
Jingoo Han

