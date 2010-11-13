From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 09/18] input: add input driver for polled GPIO buttons
Date: Fri, 12 Nov 2010 22:04:01 -0800
Message-ID: <20101113060401.GA1919@core.coreip.homeip.net>
References: <1289591445-28842-1-git-send-email-juhosg@openwrt.org>
 <1289591445-28842-10-git-send-email-juhosg@openwrt.org>
 <201011122015.01709.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43372 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab0KMGEK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Nov 2010 01:04:10 -0500
Received: by gyh4 with SMTP id 4so2262049gyh.19
        for <linux-input@vger.kernel.org>; Fri, 12 Nov 2010 22:04:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201011122015.01709.vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Gabor Juhos <juhosg@openwrt.org>, Ralf Baechle <ralf@linux-mips.org>, kaloz@openwrt.org, linux-input@vger.kernel.org, michael.hennerich@analog.com, vapier.adi@gmail.com

On Fri, Nov 12, 2010 at 08:14:59PM -0500, Mike Frysinger wrote:
> On Friday, November 12, 2010 14:50:36 Gabor Juhos wrote:
> > The existing gpio-keys driver can be usable only for GPIO lines with
> > interrupt support. Several devices have buttons connected to a GPIO
> > line which is not capable to generate interrupts. This patch adds a
> > new input driver using the generic GPIO layer and the input-polldev
> > to support such buttons.
> 
> i havent looked at the two drivers to compare, but my gut reaction is "do we 
> really need two drivers" ?  cant the existing one be extended to support both 
> types ? 

I actually like it being separate. All previous attempts to combine
interrupt-driven and polled devices complicated the drivers and had
driver picking in the guts of the polled device implementation.

> conceivably, you could have a device with both sources and a sep 
> driver would mean user space needs to watch two different devices.

This is unlikely, however userspace usually watches a few devices
anyway, nothing new here.

>  and it 
> implicitly means userspace needs to be aware of interrupt vs polled 
> limitations of the hardware instead of it simply caring about GPIOs.

No, as long as userspace simply listens to all devices whose
capabilities they are interested in they will be fine.

-- 
Dmitry
