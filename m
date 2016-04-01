From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Fri, 1 Apr 2016 07:04:49 -0700
Message-ID: <20160401140449.GA16014@roeck-us.net>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
 <1766024.riJEdmHPZI@ws-stein>
 <CACRpkdaynNEFGhCSkd7qAgxtNoRT=pRWbB0dJmjM89UM4NG_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44148 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759174AbcDAOEs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2016 10:04:48 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdaynNEFGhCSkd7qAgxtNoRT=pRWbB0dJmjM89UM4NG_xQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Linux Input <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On Fri, Apr 01, 2016 at 03:03:40PM +0200, Linus Walleij wrote:
> On Fri, Apr 1, 2016 at 2:16 PM, Alexander Stein
> <alexander.stein@systec-electronic.com> wrote:
> 
> > I noticed you fiddle with late_initcall_sync. Sorry, I did not mention it:
> > gpio_mcp23s08 as well as gpio_keys are loaded as modules, so late_initcall_*
> > should not affect it.
> 
> I don't get this. I think probe deferral is only used to defer
> initcalls used for built-in drivers.
> 

Maybe late_initcall() and driver_probe_done() are not synchronous ?

In other words, is it guaranteed that driver_probe_done() returns
true when late_initcall() is executed ?

Thanks,
Guenter

> If there are dependencies among things compiled as modules,
> doesn't depmod/modprobe make sure that they are probed in
> the right order? Could it be that some module alias thingofabob
> is missing?
> 
> Or is modprobe failing because it (correctly) see that there is
> no symbol dependencies between the gpio_mcp23s08 and
> gpio-keys modules? (Not that I know how depmod works...)
> 
> If nothing else works, I guess marking mcp23s08 as bool
> and building it into the kernel will work, right?
> 
> Yours,
> Linus Walleij
