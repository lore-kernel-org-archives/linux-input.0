From: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: input: Add the Goodix GTx5 series
 Touchscreen devicetree bindings
Date: Tue, 20 Jun 2017 21:29:26 +0800
Message-ID: <20170620132926.GA29186@andrew-dell>
References: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
 <1497911109.2559.2.camel@hadess.net>
 <20170620085346.GA9345@andrew-dell>
 <1497950270.2559.12.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497950270.2559.12.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andrew-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org, mouse-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 20, 2017 at 11:17:50AM +0200, Bastien Nocera wrote:
> On Tue, 2017-06-20 at 16:53 +0800, Wang Yafei wrote:
> > On Tue, Jun 20, 2017 at 12:25:09AM +0200, Bastien Nocera wrote:
> > > On Mon, 2017-06-19 at 18:40 +0800, Wang Yafei wrote:
> > > > Signed-off-by: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > >  .../bindings/input/touchscreen/goodix-gtx5.txt     | 75
> > > > ++++++++++++++++++++++
> > > 
> > > Where was the driver sent? I didn't see it on linux-input. Why
> > > wasn't
> > > this support added to the goodix driver instead?
> > 
> > Hi, Bastien,
> > I'm sorry for confused you. I have posted two patches one is
> > touchscreen
> > driver another is this dt-bindings. The driver is under reviewing and
> > hasn't
> > been applied to linux-input.
> 
> But where's the driver? It should have been posted to the linux-input
> mailing-list, and I cannot see it there.

Forgive my carelessness, This is my first time posted patches to kernel,
I'm not sure which mailbox to send my patches, so I Cc the
linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org and linux-kernel-u79uwXL29TaiAVqoAR/hOA@public.gmane.org And as a
result you can find the maillist only in "LKML".

> >  Finally thanks for you advice I'll try add a
> > patch in ./bindings/input/touchscreen/goodix.txt rather than add a
> > new file.
> 
> That's not what I meant. I wonder about the reason why the existing
> driver wasn't extended rather than writing a new one.

Goodix driver that the kernel already have, is for our gt9xx series
touchscreen controllers. This new driver is for out new generation
touchscreen controllers, consider this two generations are very
different with each other. We wrote a new driver instead of make
a patch on the old driver.

> Good to see that Goodix is finally upstreaming its drivers though, my
> attempts at contacting some of your colleagues fell on deaf ears a
> couple of years ago.

Thank you very mouch for your attention, And very sorry for the negligence.
I believe in the future we will pay more and more attention to keep the
the Goodix driver up to date.

Sincerely

> Cheers
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
