From: mwilder <mwilder-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH] Input: add mmio xi driver
Date: Mon, 24 Nov 2008 21:19:35 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0811242028360.15284@gremlin.cs.nmsu.edu>
References: <20080925232237.GA22938@suse.de> <20080925182055.f12f5d0b.randy.dunlap@oracle.com>
 <20080926031918.GA10083@suse.de> <48DCBEC3.2020904@hannent.co.uk>
 <20080926174607.GA700@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080926174607.GA700-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Phil Hannent <phil-+6o+yPtToBIqdlJmJB21zg@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello.  I am the original developer of the mimio Xi driver for 2.4 
kernel linux. I have been observing this particular thread of emails for 
quite some time. I haven't been able to devote much attention to the 
developments in this thread because my primary research emphasis lies 
elsewhere.  Recent events, however, have provoked me to pay close 
attention to this thread.

I would like to thank gregkh-l3A5Bk7waGM@public.gmane.org for his work folding in the 
2.6-specific mods to the driver.  This is something that I do not have the 
time to do, and I am glad to see that he has taken up the slack so 
that others may benefit from this work.

I would like to discuss the following dialog:

> On Fri, Sep 26, 2008 at 11:51:47AM +0100, Phil Hannent wrote:
> > Greg KH wrote:
> > > On Thu, Sep 25, 2008 at 06:20:55PM -0700, Randy Dunlap wrote:
> > >> On Thu, 25 Sep 2008 16:22:37 -0700 Greg KH wrote:
> > >>
> > >>> From: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> > >>>
> > >>> This patch adds the Mimio Xi interactive whiteboard driver to the tree.
> > >>>
> > >>> It was originally written by mwilder-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org, but cleaned up and
> > >>> forward ported by me to the latest kernel version.
> > I have been given the protocol document for the whiteboards, I am not allowed to
> > share it with anybody unfortunately.
> 
> That's great news, and not that big of a deal about the "no share" issue
> as long as you are allowed to contribute.
> 
> > I am just waiting for approval of funds for me to start development of this
> > driver and an X11 library to make the ink capture work.
> 
> Um, what's wrong with the driver that I just posted?  Does it not work
> properly?  I'll gladly accept patches for things that are wrong, but
> don't start over from scratch please.
> 

> > I expect to start work at the end of October, I could do with a mentor to help
> > me with this.
> 
> If you need help on the kernel side, feel free to contact me off-list.
> 
>

What _is_ wrong with the driver?  I am guessing that phil-U4DcaGvlwG/QXOPxS62xeg@public.gmane.org is 
just struggling with creating X bindings for the module, but I would like 
to hear some elaboration on what is actually happening here.  Enlighten 
me.



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
