From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: disable touchpad?
Date: Fri, 24 Feb 2012 14:55:35 -0800
Message-ID: <1475573.qi4MNDPiM5@dtor-d630.eng.vmware.com>
References: <4F47ED34.1070406@xenotime.net> <1396991.aDtuZKT2u4@dtor-d630.eng.vmware.com> <4F480EBA.7020509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43749 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab2BXWzn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 17:55:43 -0500
Received: by pbcun15 with SMTP id un15so3141695pbc.19
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2012 14:55:42 -0800 (PST)
In-Reply-To: <4F480EBA.7020509@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-input@vger.kernel.org

On Friday, February 24, 2012 02:27:06 PM Chase Douglas wrote:
> On 02/24/2012 01:31 PM, Dmitry Torokhov wrote:
> > On Friday, February 24, 2012 12:04:04 PM Randy Dunlap wrote:
> >> (b) My Toshiba Portege laptop has a touchpad on/off button.  Is that
> >> supported?
> > 
> > Kernel probably emits one of KEY_TOUCHPAD_* for it; whether it is
> > handled
> > in userspace I do not know.
> 
> I have heard from some of our engineers who have looked into this that
> the interface for these buttons is not standardized. Sometimes the
> buttons turn off the touchpad in hardware. Sometimes they emit events
> that tell the OS to turn it off, and the OS needs to know how to handle it.
> 
> On top of that, LEDs are sometimes there to tell you if the trackpad is
> on or off. These are also not standardized. Sometimes they are hooked up
> to the hardware, and when the hardware is off they go off. Sometimes
> they are just a plain old LED and the OS needs to turn it on and off.
> 
> Fun...

That's because hardware designers were so delighted in beauty that
is rfkill buttons, they just had to do the same with touchpads...

-- 
Dmitry
