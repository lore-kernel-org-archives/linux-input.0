From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: psmouse: fix input_dev leak in lifebook driver
Date: Wed, 16 Jan 2008 14:15:26 -0500
Message-ID: <20080116141353.ZZRA012@mailhub.coreip.homeip.net>
References: <20080112151252.193d6b52@ephemeral> <20080115170323.ZZRA012@mailhub.coreip.homeip.net> <20080116125801.199224f3@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:23890 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbYAPTPb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 14:15:31 -0500
Received: by ag-out-0708.google.com with SMTP id 23so2123863agd.10
        for <linux-input@vger.kernel.org>; Wed, 16 Jan 2008 11:15:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080116125801.199224f3@ephemeral>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 16, 2008 at 12:58:01PM -0500, Andres Salomon wrote:
> On Tue, 15 Jan 2008 17:04:01 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Sat, Jan 12, 2008 at 03:12:52PM -0500, Andres Salomon wrote:
> > > 
> > > The lifebook driver may register a second input device, but it never
> > > unregisters it.  This fixes that.
> > > 
> > > Signed-off-by: Andres Salomon <dilinger@debian.org>
> > 
> > Applied, thank you Andres.
> >
> 
> Hi Dmitry,
>  
> There's one additional patch, I don't know if you saw it; the subject
> was "check return value of input_register_device() in hil_ptr.c's init".
> 

I have seen it but postponed for later. Right now I am trying to get though
2.6.24 material.

> 
> Also, I've found myself needing to provide my own device_attribute for
> the OLPC psmouse driver; I couldn't use PSMOUSE_DEFINE_ATTR(), as its
> set_helper callback calls psmouse_disable.
> 
> static DEVICE_ATTR(powered, S_IWUSR | S_IRUGO, hgpk_show_powered,
>                 hgpk_set_powered);
> 
> Unfortunately, in order to not be racy, hgpk_set_powered needs to
> deal with psmouse_mutex.  Which method of dealing with this would
> you prefer?  I could either make psmouse_mutex no longer static,
> provide psmouse_mutex locking functions (declared in psmouse.h), or
> put psmouse_mutex into 'struct psmouse'.  Or, if you have any other
> ideas..

Could you just send me the code? I tend to think better when I see it...

Thanks!

-- 
Dmitry
