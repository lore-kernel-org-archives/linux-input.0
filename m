From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: event devices not released
Date: Mon, 11 Feb 2008 11:58:27 -0500
Message-ID: <20080211115631.ZZRA012@mailhub.coreip.homeip.net>
References: <47B043ED.3020309@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:50813 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758773AbYBKQ6b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2008 11:58:31 -0500
Received: by py-out-1112.google.com with SMTP id u52so6904871pyb.10
        for <linux-input@vger.kernel.org>; Mon, 11 Feb 2008 08:58:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47B043ED.3020309@slagter.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-input@vger.kernel.org

Hi Erik,

On Mon, Feb 11, 2008 at 01:47:41PM +0100, Erik Slagter wrote:
> Hi,
>
> I think I've found a bug :-/
>
> Symptoms: when I remove (unplug) a USB keyboard or mouse, the corresponding 
> event device seems to be closed but not released; when I plug the device 
> back in, it gets a new input device handle. This means that after several 
> suspend/resume cycles (in which it seems all usb devices are virtually 
> unplugged and replugged) the kernel is out of event devices and complains 
> likewise. My nice little program that catches specific keystrokes also 
> stops to get any interesting events from that moment on. After reboot 
> everything works again as expected.
>
> I've seen a similar bug report on linux-kernel but it wasn't followed up 
> on. Also this only mentioned problems through suspend cycles while I also 
> have the problem simply plugging in and out.
>
> Environment: linux kernel 2.6.24 vanilla on i386. The event files are held 
> open by one or more processes when the devices are unplugged. Unfortunatly 
> my program is not the only one that has them open, but hald and Xorg also 
> have some of the devices open, so I cannot prevent this situation. Upon 
> POLLERR | POLLHUP my app closes all event devices and rescans the 
> /dev/input directory, this should be enough imho? I don't know how the 
> other apps handle unplugging.
>

What happens if you kill HAL and X and leave only your application
running? Do event devices get released/reused in this case? Do you
see POLLERR or POLLHUP signals devlievered to your app?

-- 
Dmitry
