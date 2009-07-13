From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: usb mouse not responding after resume
Date: Mon, 13 Jul 2009 07:47:07 +0200
Message-ID: <E1MQENX-0008Up-N8@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0907101052500.2906-100000@iolanthe.rowland.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <Pine.LNX.4.44L0.0907101052500.2906-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
	(message from Alan Stern on Fri, 10 Jul 2009 10:56:42 -0400 (EDT))
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 10 Jul 2009, Alan Stern wrote:
> On Fri, 10 Jul 2009, Miklos Szeredi wrote:
> 
> > Sometimes after resume the usb mouse plugged into my T60 notebook
> > isn't working.  Unplugging and replugging it fixes the problem.  A
> > keyboard is also plugged in, which works normally every time.
> > 
> > This has been happening on and off from about 2.6.30-rc* but in
> > 2.6.31-rc* seems to be getting more frequent.
> 
> Looks like something is wrong with the mouse itself.

Hmm, could well be, this is not a young mouse and had some problems
(fits of random movements) all of its life.

> > Here's the suspend-resume-replug part of the dmesg.  Not sure if it is
> > enough, I'd be happy to provide more info.
> 
> The log showed that the mouse disconnected itself during the suspend.  
> But then after the resume it reconnected -- presumably this log shows a
> cycle where the mouse _was_ working afterward.

No it wasn't, if you look at the timestamps it reconnected only after
some time after resume.  That is because when it wasn't working I
unplugged it and then plugged it back.

> 
> Can you provide a similar log for a cycle where the mouse _didn't_ 
> respond afterward?  It might not help much, however; most likely it 
> will show that the mouse disconnects itself during the suspend and then 
> doesn't reconnect.
> 
> Have you tried plugging the mouse into a different USB port?  It might 
> help.

Okay, will try that and see if it helps.  Maybe I should get a new
mouse too... :)

Thanks,
Miklos
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
