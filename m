From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Tue, 07 Jan 2014 09:38:07 +0900
Message-ID: <001001cf0b40$bbdd03b0$33970b10$%han@samsung.com>
References: <20140104090147.GA16680@core.coreip.homeip.net>
 <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
 <20140106023358.GA11575@earth.universe>
 <009301cf0a8a$1963cfd0$4c2b6f70$%han@samsung.com>
 <20140106221405.GA22325@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18069 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbaAGAiO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jan 2014 19:38:14 -0500
In-reply-to: <20140106221405.GA22325@earth.universe>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Sebastian Reichel' <sre@debian.org>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, January 07, 2014 7:14 AM, Sebastian Reichel wrote:
> On Mon, Jan 06, 2014 at 11:50:46AM +0900, Jingoo Han wrote:
> > If you repeat at least twice insmod & rmmod 'twl4030_keypad.ko',
> > it will be good. If there are some bugs, it will make the error
> > messages or kernel panic.
> 
> I tried load & unloading the twl4030_keypad module multiple times.
> I didn't get any error messages or kernel panics. Everything seems
> to behave correctly.

Thank you for your testing. :-)
I checked the sequence; it looks good.
See you later.

Best regards,
Jingoo Han


