From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
Date: Mon, 5 Oct 2015 22:57:52 +0200
Message-ID: <20151005205752.GA10479@xo-6d-61-c0.localdomain>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
 <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
 <20151004194632.GA27633@xo-6d-61-c0.localdomain>
 <1F3AC3675D538145B1661F571FE1805F2F0EE716@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0EE716-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi!

> > Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
> > 
> > On Mon 2015-09-07 17:36:15, Irina Tirdea wrote:
> > > Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/input/touchscreen/goodix.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > Don't.
> > 
> > Yes, we sometimes sort includes... to avoid patch rejects.
> > 
> > This is guaranteed to cause rejects.
> > 
> > If we do sort them, we use "longest-first" usually.
> > 
> 
> When using random order, I've been told by reviewers that my ordering
> is wrong [1], but I could not figure out what the "right" ordering is in order to apply.
> I did not find any mention of how to sort includes in  Documentation/CodingStyle,
> but I've seen patches in the kernel that fix random ordering by sorting them
> alphabetically [2].

Ok, I have seen this more often:

https://lkml.org/lkml/2009/3/28/99
 
> However, I do not feel strongly about this so I can drop this patch.

Well, its really nit picking.

										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
