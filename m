From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Mon, 06 Jan 2014 11:04:34 +0100
Message-ID: <7852278.jiSUdg0kdd@phil>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com> <20140103173605.GN3144@lukather> <20140103182349.GA13489@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDHPTCWTXEHRBRH7VGLAKGQE2LI4GJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140103182349.GA13489-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Freitag, 3. Januar 2014, 10:23:50 schrieb Dmitry Torokhov:
> On Fri, Jan 03, 2014 at 06:36:05PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 02, 2014 at 11:36:33PM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> > > >On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > > >>>Also, instead of inventing yet another vendor-specific property, why
> > > >>>not re-use> > >>>
> > > >>>a button binding similar to gpio-keys like:
> > > >>>        lradc: lradc@01c22800 {
> > > >>>        
> > > >>>                compatible = "allwinner,sun4i-lradc-keys";
> > > >>>                reg = <0x01c22800 0x100>;
> > > >>>                interrupts = <31>;
> > > >>>                allwinner,chan0-step = <200>;
> > > >>>		
> > > >>>		#address-cells = <1>;
> > > >>>		#size-cells = <0>;
> > > >>>		
> > > >>>		button@0 {
> > > >>>		
> > > >>>			reg = <0>; /* your channel index from above */
> > > >>>			linux,code = <115>; /* already used as dt-property */
> > > >>>		
> > > >>>		};
> > > >>>		
> > > >>>		button@1 {
> > > >>>		
> > > >>>			reg = <1>;
> > > >>>			linux,code = <114>;
> > > >>>		
> > > >>>		};
> > > >>
> > > >>Ugh no. Having a vendor specific property which is KISS certainly
> > > >>beats this, both wrt ease of writing dts files as well as wrt the
> > > >>dts parsing code in the driver.
> > > >
> > > >I'd agree with Heiko here. This is pretty much the same construct
> > > >that's already in use in other input drivers, like gpio-keys.
> > > 
> > > In the gpio case there is a 1 on 1 relation between a single hw
> > > entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
> > > which maps to an array of key-codes, certainly using an array rather
> > > then a much more complicated construct is the correct data-structure
> > > to represent this.
> > 
> > You can build an array in your driver out of this very easily, it's 10
> > lines in your probe. And you gain from this something that is more
> > generic, can be shared by other similar drivers and is consistent with
> > what is already in use.
> 
> How will it be shared? Surely not code-wise, but basically in spirit
> only. It seems to me that the originally proposed binding is simple and
> concise and works well for the driver.

I don't think "binding [...] works well for the driver" is the correct 
direction. From my understanding the binding should describe the hardware in 
an os-agnostic way (so "linux,foo" properties should stay the exception) and 
not the data structures used in the driver. The driver itself then implements 
the binding to convert the binding-data into a structure it wants to use.

The sharing would, as you suggested, be in spirit and in the use of already 
established dt-properties without introducing more non-standard ones.


Heiko
