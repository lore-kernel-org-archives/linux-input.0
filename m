From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] bcm5974-0.58: name changes, open/close and
	suspend/resume serialized
Date: Fri, 25 Jul 2008 14:37:56 -0400
Message-ID: <20080725143015.ZZRA012@mailhub.coreip.homeip.net>
References: <4888311E.9010005@euromail.se> <20080725154250.GA1861@anvil.corenet.prv> <488A1A99.2070609@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:62396 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbYGYSiC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 14:38:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so743239and.103
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2008 11:38:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <488A1A99.2070609@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net

On Fri, Jul 25, 2008 at 08:25:29PM +0200, Henrik Rydberg wrote:
> Hello Dmitry,
> > 
> > Thank you for the changes.  You don't have to track whether device is
> > manually suspended or not - usb_submit_urb will fail and that is it.
> > 
> 
> Perfect.
> 
> > Attached are 2 patches. First cleans suspend state tracking as it is not
> > really needed and does some formatting and other minor changes and 2nd
> > implements runtime pm for the device. Could you please try them and if
> > everything still works I will apply the driver.
> 
> Patch 1:
> 
>   Looking good, just a few comments:
> 
>   * I notice that clamp_val is new since 2.6.24.3

Probably, I am not sure...

>   * Regarding the open-fails comment: is EACCES correct?

We don't return EACCESS anymore, I don't think. We will return what
bcm5974_start_traffic returns which in turn returns result of
usb_submit_urb and the likes.

I don't think returning -EACCESS was proper - it usually indicates
permisison issues, not the fact that the hardware is unavailable.

> 
> Patch 2:
> 
>   Perfect.
> 
> Thank you so much, Dmitry - it's a GO!
> 

Great, thank you!

-- 
Dmitry
