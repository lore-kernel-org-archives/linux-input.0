From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] input: usb: hid: Bump maximum global item tag report size to 128 bytes
Date: Wed, 15 Aug 2012 13:56:42 +0200
Message-ID: <201208151356.42323.marex@denx.de>
References: <1344203835-8308-1-git-send-email-marex@denx.de> <alpine.LNX.2.00.1208151032340.7026@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41068 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab2HOL4v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 07:56:51 -0400
In-Reply-To: <alpine.LNX.2.00.1208151032340.7026@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>

Dear Jiri Kosina,

> On Sun, 5 Aug 2012, Marek Vasut wrote:
> > The Freescale i.MX28 BootROM USB recovery mode implements the USB HID
> > protocol, yet the global item tag report size is 128. Linux checks if
> > this is 96 as of now, see [1]. This causes Linux to refuse to communicate
> > with this device, making it impossible to use the recovery mode.
> > 
> > This is not a standard HID device per se, but rather a software emulation
> > implemented within the BootROM code and realized through USB OTG-capable
> > port switched to device mode present on the device.
> > 
> > Previous attempt to discuss this issue dates back to 2011, see [2]. There
> > has been not much response. Also noteworthy is the [3], where there seems
> > to be a pointing device that has issue similar to this one.
> > 
> > The tool making use of the USB recovery mode is available at [4].
> > 
> > [1] http://comments.gmane.org/gmane.linux.kernel.input/22328
> > [2] http://www.spinics.net/lists/linux-usb/msg43463.html
> > [3] https://bbs.archlinux.org/viewtopic.php?pid=1141340
> > [4] http://git.bfuser.eu/?p=marex/mxsldr.git;a=summary
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Chen Peter <B29397@freescale.com>
> > Cc: Greg KH <greg@kroah.com>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> 
> I have not admit I don't remember where the original limit came from --
> the spec doesn't mandate it as far as I can tell.
> 
> I am queueing this patch now for next merge window. Thanks.
[...]

Thanks!

Best regards,
Marek Vasut
