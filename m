From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Thu, 02 Jan 2014 12:59:28 +0100
Message-ID: <1700375.GaI3zFl6RI@phil>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com> <20140101205603.GA1141@core.coreip.homeip.net> <52C5336B.9010903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:45015 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbaABL7s (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jan 2014 06:59:48 -0500
In-Reply-To: <52C5336B.9010903@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>

Hi Hans, Dmitry,

Am Donnerstag, 2. Januar 2014, 10:37:47 schrieb Hans de Goede:
> Hi,
> 
> On 01/01/2014 09:56 PM, Dmitry Torokhov wrote:
> > Hi Hans,
> > 
> > On Wed, Jan 01, 2014 at 08:30:07PM +0100, Hans de Goede wrote:
> >> +Required properties:
> >> + - compatible: "allwinner,sun4i-lradc-keys"
> >> + - reg: mmio address range of the chip
> >> + - interrupts: interrupt to which the chip is connected
> >> + - allwinner,chan0-step: step in mV between keys must be 150 or 200
> >> + - allwinner,chan0-keycodes: array of include/uapi/linux/input.h KEY_
> >> codes> 
> > I think this should be "linux,chan0-keycodes".
> 
> Right, because the codes are Linux specific, will fix in v2.

but the property with its "chan0-" thingy would be allwinner-specific if I'm 
not mistaken.

Also, instead of inventing yet another vendor-specific property, why not re-use 
a button binding similar to gpio-keys like:

       lradc: lradc@01c22800 {
               compatible = "allwinner,sun4i-lradc-keys";
               reg = <0x01c22800 0x100>;
               interrupts = <31>;
               allwinner,chan0-step = <200>;

		#address-cells = <1>;
		#size-cells = <0>;

		button@0 {
			reg = <0>; /* your channel index from above */
			linux,code = <115>; /* already used as dt-property */
		};

		button@1 {
			reg = <1>;
			linux,code = <114>;
		};

...

       };

But I may be on the wrong track here, so I've included the devicetree-people 
for help, which I guess should've been included from the beginning.


Heiko

