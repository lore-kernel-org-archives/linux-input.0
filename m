From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Wakeup for PNP
Date: Mon, 8 Mar 2010 23:45:30 -0800
Message-ID: <20100309074530.GB17288@core.coreip.homeip.net>
References: <20100302213105.GB13499@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1003031019040.2821-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61211 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0CIHpi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 02:45:38 -0500
Received: by gwb15 with SMTP id 15so3406673gwb.19
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 23:45:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003031019040.2821-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Li Shaohua <shaohua.li@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org

Hi Alan,

On Wed, Mar 03, 2010 at 10:29:09AM -0500, Alan Stern wrote:
> On Tue, 2 Mar 2010, Dmitry Torokhov wrote:
> 
> > > @@ -656,7 +658,7 @@ static struct pnp_device_id pnp_kbd_devi
> > >  };
> > >  
> > >  static struct pnp_driver i8042_pnp_kbd_driver = {
> > > -	.name           = "i8042 kbd",
> > > +	.name           = "i8042-kbd",
> > 
> > Why is this needed? I don't think spaces are more dangerous than a colon
> > which we do use...
> 
> This string becomes the name of a directory in sysfs.  Having a ' '
> character in a directory name just doesn't seem like a good idea; at
> the very least it's likely to confuse shell scripts.  (A ':' character
> is a lot less subject to misinterpretation.)  I could change the '-' to 
> ':' if you prefer.
> 

We have not heard complains about this causing trouble ever since PNP
support was added (so what 5 years at least?). At this point I'd be more
worried about breaking existing users...

Thanks.

-- 
Dmitry
