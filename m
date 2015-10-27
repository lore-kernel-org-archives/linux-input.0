From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 0/9] Goodix touchscreen enhancements
Date: Tue, 27 Oct 2015 09:13:03 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F105F1F@irsmsx105.ger.corp.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1445871989.31107.4.camel@hadess.net>
 <20151026182112.GA1800@excalibur.cnev.de> <20151026233248.GB26171@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151026233248.GB26171@dtor-pixel>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: 27 October, 2015 1:33
> To: Karsten Merker
> Cc: Bastien Nocera; Tirdea, Irina; Aleksei Mamlin; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mark Rutland; Purdila, Octavian; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v9 0/9] Goodix touchscreen enhancements
> 
> On Mon, Oct 26, 2015 at 07:21:12PM +0100, Karsten Merker wrote:
> > On Mon, Oct 26, 2015 at 04:06:29PM +0100, Bastien Nocera wrote:
> > > On Mon, 2015-10-12 at 18:24 +0300, Irina Tirdea wrote:
> >
> > > > v9 only adds GPIOLIB dependency in Kconfig for patch 2:
> > > > "Input: goodix - reset device at init". There are no other code
> > > > changes from v8.
> > > >
> > > > Thanks for testing these changes, Bastien and Aleksei!
> > > >
> > > > Karsten, there is no need to rebase your series on top of v9.
> > >
> > > Are we waiting on anything else before merging this? I'd like it to be
> > > scheduled to be merged so I can start focusing on the subsequent and
> > > dependent patches for that same driver.
> >
> > Hello,
> >
> > AFAICS there is one open point (cf.
> > http://www.spinics.net/lists/linux-input/msg41567.html) which
> > Irina wanted to address in a v10 of the patchset (cf.
> > http://www.spinics.net/lists/linux-input/msg41642.html).
> 
> There is also the whole thing about insane handling of named gpios in
> ACPI layer, which stops me from merging the reset code since these gpios
> should be marked as optional and we should stop ignoring errors coming
> from gpiolib.

The ACPI layer change is quite complex, since it includes changing the drivers
that use the gpio API before removing the fallback to indexed ACPI.
Not sure that will not also break current drivers that already count on this
fallback. Unfortunately, I do not have the time right now to get involved in
fixing the ACPI core myself.

Dmitry, is there anything I can do in the driver to get these patches merged?
I could go back to using indexed gpios and add an additional property
to specify if irq can be used as output or not (as suggested in one of the
previous reviews).

Thanks,
Irina

> 
> Thanks.
> 
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
