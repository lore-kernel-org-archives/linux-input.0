From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND: PATCH 1/2] mfd: tc3589x: Add device tree bindings
Date: Wed, 13 Aug 2014 09:03:01 +0100
Message-ID: <20140813080301.GA18712@lee--X1>
References: <1397028480-15413-1-git-send-email-linus.walleij@linaro.org>
 <20140617202340.GW29841@lee--X1>
 <CACRpkdY2xjp9=muE5WFoN3smzgC+cqR0ijgD306nXi7owEGyyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY2xjp9=muE5WFoN3smzgC+cqR0ijgD306nXi7owEGyyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 12 Aug 2014, Linus Walleij wrote:

> On Tue, Jun 17, 2014 at 10:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wr=
ote:
> > On Wed, 09 Apr 2014, Linus Walleij wrote:
> >
> >> This defines the device tree bindings for the Toshiba TC3589x
> >> series of multi-purpose expanders. Only the stuff I can test
> >> is defined: GPIO and keypad. Others may implement more
> >> subdevices further down the road.
> >>
> >> This is to complement
> >> commit a435ae1d51e2f18414f2a87219fdbe068231e692
> >> "mfd: Enable the tc3589x for Device Tree" which left off
> >> the definition of the device tree bindings.
> >>
> >> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> ---
> >> ChangeLog v2->v3:
> >> - Fix the keys/rows bindings to be u32 rather than
> >>   /bits/ 8, inconsistency noted by Mark Rutland.
> >> ChangeLog v1->v2:
> >> - Include a verbose example in the DT bindings.
> >> - Explain why this is a stand-alone bindings patch.
> >> ---
> >>  Documentation/devicetree/bindings/mfd/tc3589x.txt | 107 +++++++++=
+++++++++++++
> >>  1 file changed, 107 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/tc3589x.=
txt
> >
> > Looks about right, been on the list for ages and doesn't add any ne=
w
> > properties.  Applied, thanks.
>=20
> This wasn't in the v3.17 pull request AFAICT :-(
>=20
> Did it get dropped to the floor accidentally?

It doesn't look like this was ever actually applied to the MFD tree
i.e I can't find it in my git history (reflog), sorry Linus.  I have a
-fixes branch and will attempt to send this patch as a part of that.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
