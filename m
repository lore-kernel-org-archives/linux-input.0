From: Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH] usbtouchscreen: option to swap X and Y axes
Date: Sat, 20 Sep 2008 18:47:42 +0200
Message-ID: <200809201847.42939.technoboy85@gmail.com>
References: <40101cc30809181016l632de30en6ff56b1fe9fe36ff@mail.gmail.com> <Pine.LNX.4.64.0809200444570.27884@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:9293 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYITQrt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Sep 2008 12:47:49 -0400
Received: by ey-out-2122.google.com with SMTP id 6so268562eyi.37
        for <linux-input@vger.kernel.org>; Sat, 20 Sep 2008 09:47:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0809200444570.27884@twin.jikos.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Saturday 20 September 2008 04:45:48 Jiri Kosina wrote:
> On Thu, 18 Sep 2008, Matteo Croce wrote:
> > Here there is a patch to invert the X and Y axes, as my controller swaps
> > it:
> >
> > Signed-off-by: Matteo Croce <matteo@openwrt.org>
> >
> > --- a/drivers/input/touchscreen/usbtouchscreen.c	2008-09-18
> > 18:50:44.294868149 +0200
> > +++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-09-18
> > 18:50:44.226867816 +0200
> > @@ -56,8 +56,16 @@
> >  #define DRIVER_DESC		"USB Touchscreen Driver"
> >
> >  static int swap_xy;
> > +static int invert_x;
> > +static int invert_y;
> > +
> >  module_param(swap_xy, bool, 0644);
> > +module_param(invert_x, bool, 0644);
> > +module_param(invert_y, bool, 0644);
> > +
> >  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> > +MODULE_PARM_DESC(invert_x, "If set X axe is inverted.");
> > +MODULE_PARM_DESC(invert_y, "If set Y axe is inverted.");
>
> If this is done just by certain devices, maybe VID/PID-based autodetection
> might be much more user friendly than using module parameter?

no, sometimes you have to swap just because you attached it in the wrong 
direction,
this is what appened to me, I have 50 swapped touchscreens, and i decided to 
hack
the driver instead to redo all the work
