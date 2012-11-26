From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] input: Drop TOUCHSCREEN_BITSY support
Date: Mon, 26 Nov 2012 10:58:26 -0800
Message-ID: <20121126185826.GA9425@kroah.com>
References: <1353852178-4920-1-git-send-email-shc_work@mail.ru>
 <20121126081312.GC21091@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57231 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab2KZS62 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 13:58:28 -0500
Content-Disposition: inline
In-Reply-To: <20121126081312.GC21091@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-input@vger.kernel.org, Jarod Wilson <jarod@wilsonet.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Nov 26, 2012 at 12:13:12AM -0800, Dmitry Torokhov wrote:
> Hi Alexander,
> 
> On Sun, Nov 25, 2012 at 06:02:57PM +0400, Alexander Shiyan wrote:
> > The kernel does not contain the symbol SA1100_BITSY so the driver
> > never compiled and can be removed safely.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/input/touchscreen/Kconfig          |   12 -
> >  drivers/input/touchscreen/Makefile         |    1 -
> >  drivers/input/touchscreen/h3600_ts_input.c |  479 ----------------------------
> 
> I applied the touchscreen part, thank you. The staging piece should go
> through Greg KH.

Ok, can someone please resend just that part for me to include it?

thanks,

greg k-h
