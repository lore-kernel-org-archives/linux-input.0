From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv2 3/3] ARM:dts:sunxi:ps2 dt nodes for
 A10/A20 PS2 controller.
Date: Thu, 11 Dec 2014 22:15:50 +0100
Message-ID: <20141211211550.GJ8739@lukather>
References: <CAEzqOZu49Z99B4DWvuD=E2BKs7ihSVAunshheUn=Z-VAqivUxA@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6AFz5yWxU/FsGPwt"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBE4VVCSAKGQEBXKWIKQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEzqOZu49Z99B4DWvuD=E2BKs7ihSVAunshheUn=Z-VAqivUxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vishnupatekar <VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--6AFz5yWxU/FsGPwt
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

Please keep the Cc list.

On Wed, Dec 10, 2014 at 01:39:52AM +0530, Vishnu Patekar wrote:
> > > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > @@ -112,6 +112,19 @@
> > >                       pinctrl-0 = <&uart0_pins_a>;
> > >                       status = "okay";
> > >               };
> > > +             /* PS2 0 and PS2 1 are disabled by default
> > > +             To enable PS2 0 and PS2 1 uncomment below ps20 and ps21
> > nodes
> > > +             Please note that ps20 pins conflict with HDMI on Lime2
> > Board*/
> > > +             /*ps20: ps2@0x01c2a000 {
> > > +                     pinctrl-names = "default";
> > > +                     pinctrl-0 = <&ps2_0_pins>;
> > > +                     status = "okay";
> > > +             };
> > > +             ps21: ps2@0x01c2a400 {
> > > +                     pinctrl-names = "default";
> > > +                     pinctrl-0 = <&ps2_1_pins>;
> > > +                     status = "okay";
> > > +             };*/
> >
> > Hmmm, no, no comments in the DTS.
> >
> > Especially when it's that trivial to enable.
>
> Okie, I'll just keep ps20 and ps21 nodes commented.

No, the comments themselves were great. But the nodes themselves
shouldn't be there in the first place.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--6AFz5yWxU/FsGPwt--
