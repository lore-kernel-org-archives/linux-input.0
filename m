From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: keyboard doesn't work with acpi on lenovo s10-3c
Date: Sat, 27 Nov 2010 16:06:48 -0800
Message-ID: <20101128000648.GC29981@core.coreip.homeip.net>
References: <AANLkTimZxNOuuK2+uEUF_RbHus1dgFRA6usMuYzrGjoD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39712 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0K1AGz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 19:06:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimZxNOuuK2+uEUF_RbHus1dgFRA6usMuYzrGjoD@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Boris Savelev <boris.savelev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Boris,

On Sat, Nov 27, 2010 at 08:28:51PM +0300, Boris Savelev wrote:
> Hello!
> 
> When I run linux on my netbook lenovo s10-3c -- keyboard doesn't work!
> keyboard works perfectly in bios, in grub (or lilo), in windows, but
> not in linux.
> I try linux kernel 2.6.35, 2.6.36, 2.6.37-rc2 -- no way. keyboard doesn't work
> I upgrade BIOS up to 3CCN13WW. keyboard doesn't work
> All keys are disabled, numlock, capslock... It's seems like keyboard
> haven't power.
> with Google I find topic [1] where solution is add to kernel opts
> 'noapic acpi=off' -- Viola! keyboard work. But battery state,
> powersaving, powerbutton and other usefull things doesn't work.
> So this is not a workaround...

The keyboard seems to get detected but is silent afterwards...  Does the
touchpad work by default?

Could you try a few kernel options: acpi=noirq, pci=noacpi, i8042.reset
and i8042.nomux please?

-- 
Dmitry
