From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RESEND PATCH V4 1/1] input: misc: da9063: OnKey driver
Date: Mon, 8 Jun 2015 11:38:47 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22F122@SW-EX-MBX02.diasemi.com>
References: <cover.1433415752.git.stwiss.opensource@diasemi.com>
 <c84964549832af45f56362e0f6c0cb8b76b2878f.1433415752.git.stwiss.opensource@diasemi.com>
 <20150605174931.GH26708@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150605174931.GH26708@dtor-ws>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, "Opensource [Adam Ward]" <Adam.Ward.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05 June 2015 18:50 Dmitry Torokhov wrote:

> Subject: Re: [RESEND PATCH V4 1/1] input: misc: da9063: OnKey driver
> On Thu, Jun 04, 2015 at 12:02:32PM +0100, S Twiss wrote:
> > From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> >
> > Add OnKey driver support for DA9063
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> >
> > ---
> > The changes made in PATCH V3 have been taken from the DA9062 OnKey review
> > thread. Please see https://lkml.org/lkml/2015/4/29/406 for more information
> > on this.
> >
> > Version History
> >
> > Changes in V4
> >  - No change, just a resend.
> 
> Sorry for the delay.
> 
> I took the liberty of rearranging the code a bit and converting it to
> devm* fully, does the version below still work for you?
> 

Hi Dmitry,

No problem. Thank you for getting back to me and for taking the time to work
through this code.

Everything looks fine for me thank you.

Tested-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

I see now: in future I will make use of the devm_add_action() and use the devm*
properly & your changes have simplified the error handling and negated the need
for a .remove function. The devm release cleans up in reverse -- preserving
the free_irq() and cancel_delayed_work_sync() ordering ...

Regards,
Steve.

CC: Adam Ward <adam.ward.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

[...]

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
