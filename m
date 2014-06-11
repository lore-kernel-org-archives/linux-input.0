From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [RFC PATCH] input, touch, atmel_mxt_ts: use atmel driver
Date: Wed, 11 Jun 2014 13:06:51 +0100
Message-ID: <5398465B.7060101@itdev.co.uk>
References: <1402468526-9165-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:17901 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754021AbaFKMG4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jun 2014 08:06:56 -0400
In-Reply-To: <1402468526-9165-1-git-send-email-hs@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Heiko Schocher wrote:
> try to bring the driver from
> https://github.com/ndyer/linux for-next
> 
> to mainline. Post this as a RFC, to see if this is possible...
> 
> based on:
> commit dda0a5570574cfe467c1c794cf7a17e1d742ec02 ("Input:
> atmel_mxt_ts - implement improved debug message interface")
> 
> from Nick Dyer <nick.dyer@itdev.co.uk>
> 
> added:
> - remove some (not all) checkpatch warnings
> - Add support for voltage regulator
> - Add support for Device Tree support

My thinking has been that the maintainers will more likely accept a series
of small patches than to make such a huge change to the entire driver, my
for-next tree is where I'm working on this, and I plan to post another set
of 15 patches soon, when I've fixed up some issues to do with probe/remove
cycles.

You should note that my for-next branch has moved on slightly since you
have taken this, because I have implemented device tree support and changed
the config download to use the request_firmware_async() function.

Your device tree stuff for mach-goni.c looks really useful, however - if
you can send me a patch for that against my current for-next branch I can
include it with my version of the device tree support.

all the best

Nick
