From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Thu, 2 Jan 2014 12:38:31 -0800
Message-ID: <20140102203831.GA3239@core.coreip.homeip.net>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com>
 <20140102202022.GK3144@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBYX6S6LAKGQEI4ZGZYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140102202022.GK3144@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 02, 2014 at 09:20:22PM +0100, Maxime Ripard wrote:
> On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > >Also, instead of inventing yet another vendor-specific property, why not re-use
> > >a button binding similar to gpio-keys like:
> > >
> > >        lradc: lradc@01c22800 {
> > >                compatible = "allwinner,sun4i-lradc-keys";
> > >                reg = <0x01c22800 0x100>;
> > >                interrupts = <31>;
> > >                allwinner,chan0-step = <200>;
> > >
> > >		#address-cells = <1>;
> > >		#size-cells = <0>;
> > >
> > >		button@0 {
> > >			reg = <0>; /* your channel index from above */
> > >			linux,code = <115>; /* already used as dt-property */
> > >		};
> > >
> > >		button@1 {
> > >			reg = <1>;
> > >			linux,code = <114>;
> > >		};
> > 
> > Ugh no. Having a vendor specific property which is KISS certainly
> > beats this, both wrt ease of writing dts files as well as wrt the
> > dts parsing code in the driver.
> 
> I'd agree with Heiko here. This is pretty much the same construct
> that's already in use in other input drivers, like gpio-keys.
> 
> This is also something that can really easily be made generic, since
> this is something that is rather common.

Except that button definition from gpio-keys does not use 'reg' property
but rather gpio. I'd rather we did not cram non-applicable attributes
into that definition just to make it "reusable" like that.

I'd be OK with having similar (but not claiming to be the same) mappings
though.

Thanks.

-- 
Dmitry
