From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Wed, 10 Jun 2009 09:25:24 +0100
Message-ID: <1244622324.5973.2499.camel@cookie.hadess.net>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244589738.5973.1954.camel@cookie.hadess.net>
	 <78f5d6bf0906100014r5b7f5c14p4544ef13442c8f0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <78f5d6bf0906100014r5b7f5c14p4544ef13442c8f0b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitriy Geels <dmitriy.geels-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2009-06-10 at 11:14 +0400, Dmitriy Geels wrote:
> Hi!
> 
> Kernel rebuilding is pretty easy, for ubuntu/debian it would be:
<snip>

FWIW, I contributed drivers to those two lists, so I do know how to
build my own kernels...

> 2009/6/10 Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>:
> > I found that for pretty much all the input problems, I'd need to do
> > something like that. Problem is:
> > - enabling CONFIG_HID_DEBUG requires rebuilding the kernel
> > - most distributions build hid into the kernel
> >
> > Wouldn't there be a way to enable the debug at run-time without
> > impacting too much on performance or binary size?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
