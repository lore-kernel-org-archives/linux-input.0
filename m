From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 6/8] Input: goodix - add support for ESD
Date: Fri, 27 Nov 2015 09:28:27 -0800
Message-ID: <20151127172827.GA27040@dtor-ws>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
 <1447936001-21420-7-git-send-email-irina.tirdea@intel.com>
 <20151120154458.GA12090@rob-hp-laptop>
 <1F3AC3675D538145B1661F571FE1805F2F1265D3@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F1265D3-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 27, 2015 at 05:24:21PM +0000, Tirdea, Irina wrote:
> 
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> > Sent: 20 November, 2015 17:45
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mark Rutland; Purdila, Octavian;
> > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH v11 6/8] Input: goodix - add support for ESD
> > 
> > On Thu, Nov 19, 2015 at 02:26:39PM +0200, Irina Tirdea wrote:
> > > Add ESD (Electrostatic Discharge) protection mechanism.
> > 
> > [...]
> > 
> > > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > > driver gt9xx.c for Android (publicly available in Android kernel
> > > trees for various devices).
> > >
> > > Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > For the binding: Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > 
> > You should not have the "For the binding:" part here. It was just a note
> > so it was clear what part I looked at.
> > 
> 
> I saw it done like that in another patch already merged, so I thought it's
> the right way [1]. Dmitry, could you fix this at merge or you need me to
> send another patchset?

No, I can fix it up locally. Let me sort through the latest submission
and I'll let you know if I need any changes.

Thanks!

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
