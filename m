From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 5/5] ARM: sunxi: dts: Add PS2 nodes for
 A20 lime2 board
Date: Wed, 21 Jan 2015 16:34:45 +0530
Message-ID: <CAEzqOZsWYQ+Aep6HBZXVtKGEJgKYAKJU2b0=nGvP0jPKECxn7g@mail.gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-6-git-send-email-vishnupatekar0510@gmail.com>
 <54BE8A0E.30604@gmail.com> <20150120200740.GY4367@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD64TFVR3YIBBY4P72SQKGQEFD7ITEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150120200740.GY4367@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Iain Paton <ipaton0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello,

On Wed, Jan 21, 2015 at 1:37 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>
> On Tue, Jan 20, 2015 at 05:02:06PM +0000, Iain Paton wrote:
> > On 16/01/15 14:03, Vishnu Patekar wrote:
> > > Signed-off-by: VishnuPatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > index ed364d5..3365f12 100644
> > > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > @@ -113,6 +113,18 @@
> > >                     status = "okay";
> > >             };
> > >
> > > +           ps20: ps2@01c2a000 {
> > > +                   pinctrl-names = "default";
> > > +                   pinctrl-0 = <&ps20_pins_a>;
> > > +                   status = "okay";
> > > +           };
> > > +
> > > +           ps21: ps2@01c2a400 {
> > > +                   pinctrl-names = "default";
> > > +                   pinctrl-0 = <&ps21_pins_a>;
> > > +                   status = "okay";
> > > +           };
> > > +
> > >             i2c0: i2c@01c2ac00 {
> > >                     pinctrl-names = "default";
> > >                     pinctrl-0 = <&i2c0_pins_a>;
> > >
> >
> > As the Lime2 doesn't actually have any PS2 connectors on the board,
> > I'd prefer that these are not enabled unconditionally. Doing so
> > only makes it more difficult for people who want to use these pins
> > for other functions.
> >
> > Device tree overlays seem to be close to being merged, perhaps we
> > could leave enabling this to an overlay?
>
> I already had the exact same reasoning, and this was even removed at
> some point. For some reason, it was added back, and I don't really
> know why.
This was removed in consideration that these pins conflict with HDMI,
however, these is not conflict.

It was kept there as an example. But, as there is no ps2 connector on
board, I've no problem to remove these nodes from Lime2 dts file.

>
> Maxime
>
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
