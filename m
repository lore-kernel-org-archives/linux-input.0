From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Dell Vostro 1520 and 1720 to the
	reset list
Date: Mon, 30 Nov 2009 01:35:44 -0800
Message-ID: <20091130093544.GH10295@core.coreip.homeip.net>
References: <20091124151250.03e185d1@destiny.ordissimo> <20091126110500.735461ac@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53970 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbZK3Jfl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 04:35:41 -0500
Content-Disposition: inline
In-Reply-To: <20091126110500.735461ac@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 26, 2009 at 11:05:00AM +0100, Anisse Astier wrote:
> Hi Dmitry,
> 
> Sorry for the badly threaded reply, I wasn't subscribed to the list and
> didn't ask explicitely to be Cc-ed.
> 
> >On Wed, 25 Nov 2009 12:17:37 -0800, Dmitry Torokhov wrote:
> >Could youplease explain in more detail what the "bad state" is.
> >And what exactly do you mean by "first boot"? Cold boot? The very
> >first boot after assembling? Something else?
> 
> By bad state I mean that neither touchpad nor keyboard are working. They
> are both unresponsive. You can fix this by adding i8042.reset on the
> kernel command line, or removing the battery and waiting long enough.
> By very first boot I mean when the laptops are received from Dell and
> booted in Linux.
> 
> If you cold boot with a working non-Dell power supply (with same
> electrical characteristics), you can reproduce the "first boot" bug as
> much as you want, and laptops won't work unless you remove the battery
> and wait long enough OR add i8042.reset on the cmdline.
> 

Ok, I see... what about 1320? I did a quick round of googling and it
seem to have the similar issue...

-- 
Dmitry
