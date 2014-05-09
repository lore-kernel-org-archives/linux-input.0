From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] input: fix ps2/serio module dependency
Date: Fri, 09 May 2014 09:34:26 +0200
Message-ID: <4385062.1bvKsSrGCq@wuerfel>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de> <1399560990-1402858-15-git-send-email-arnd@arndb.de> <20140508155931.GA11672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56849 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaEIHe3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 May 2014 03:34:29 -0400
In-Reply-To: <20140508155931.GA11672@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thursday 08 May 2014 08:59:31 Dmitry Torokhov wrote:
> Hi Arnd,
> 
> On Thu, May 08, 2014 at 04:56:26PM +0200, Arnd Bergmann wrote:
> > @@ -71,7 +71,7 @@ config KEYBOARD_ATKBD
> >       default y
> >       select SERIO
> >       select SERIO_LIBPS2
> > -     select SERIO_I8042 if X86
> > +     select SERIO_I8042 if X86 || ARCH_MIGHT_HAVE_PC_SERIO
> 
> x86 also selects ARCH_MIGHT_HAVE_PC_SERIO so shouldn't this be
> 
>         select SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO
> 
> ?
> 
> I can fix it up on my side if you agree.

Yes, sounds good, thanks!

	Arnd
