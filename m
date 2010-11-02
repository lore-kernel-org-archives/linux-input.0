From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv1] staging: Synaptics RMI4 touchpad driver support
Date: Tue, 2 Nov 2010 08:40:30 -0700
Message-ID: <20101102154029.GH11778@core.coreip.homeip.net>
References: <1288699725-14405-1-git-send-email-naveen.gaddipati@stericsson.com>
 <20101102140337.GC9387@kroah.com>
 <4CD01CD8.3090206@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62897 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0KBPkq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Nov 2010 11:40:46 -0400
Content-Disposition: inline
In-Reply-To: <4CD01CD8.3090206@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg KH <greg@kroah.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, linux-input@vger.kernel.org

On Tue, Nov 02, 2010 at 03:14:48PM +0100, Linus Walleij wrote:
> Greg KH wrote:
> 
> >> +Wait for the official upstream synaptics rmi4 clearpad drivers as promised over the past few months
> >> +Merge any device support needed from this driver into it
> >> +Delete this driver
> > 
> > Huh?
> > 
> > Why not just add this driver to the kernel tree instead?  When the
> > "promised" driver then eventually shows up (who is promising it?) then
> > delete the thing.

The same reason as there were several wireless drivers in staging?

> 
> Well, Alan (on behalf of Ramesh Agarwal) sent out a very similar
> patch (Titled "Synaptics TM1217 Touchscreen Controller driver")
> the other day, and OTOMH that was after discussions with Synaptics
> where they said they were working on a "real" driver (a rather
> complex RMI4 bus driver) and we believe they will fix that sooner
> or later.
> 
> So, until sooner or later happens we thought we'd keep it in staging.
> 
> If you prefer both Alan and we can probably submit our patches for
> inclusion in the proper place.
> 
> A side effect may be that the Synaptics RMI4 people may have trouble
> to merge their driver into input/ since they may be requested to
> refactor the existing drivers to use it rather than merging new stuff,
> putting some burden on their shoulders.
> 

No, they have not been requested to change any existing [in tree]
drivers. They however been asked to convert to the driver core
primitives instead of rolling their own infprastructure to implement
devices and drivers binding.

Thanks.

-- 
Dmitry
