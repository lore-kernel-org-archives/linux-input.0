From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 4/4] Input: tsc2004 - Document ts2004 dt bindings
Date: Tue, 3 Nov 2015 17:11:56 -0600
Message-ID: <20151103231156.GA10138@deathstar>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
 <1446252086-24334-5-git-send-email-mwelling@ieee.org>
 <CAL_JsqKpbrWcHj4eubWMAjtVRHE8TTN_qC5S=J7qzcf8khpzng@mail.gmail.com>
 <20151102205028.GA2571@deathstar>
 <20151103072124.GA33601@dtor-ws>
 <CAL_JsqKb0ms5syf6oTkEw6BGt0nUeqg6=Sm4Zd-5pH9JPrqLiQ@mail.gmail.com>
 <20151103154117.GA13271@deathstar>
 <20151103225913.GA29032@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38034 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbbKCXMH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 18:12:07 -0500
Content-Disposition: inline
In-Reply-To: <20151103225913.GA29032@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Nov 03, 2015 at 02:59:13PM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 03, 2015 at 09:41:17AM -0600, Michael Welling wrote:
> > On Tue, Nov 03, 2015 at 09:31:10AM -0600, Rob Herring wrote:
> > > On Tue, Nov 3, 2015 at 1:21 AM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > On Mon, Nov 02, 2015 at 02:50:29PM -0600, Michael Welling wrote:
> > > >> On Mon, Nov 02, 2015 at 09:19:50AM -0600, Rob Herring wrote:
> > > >> > > +Required properties:
> > > >> > > + - compatible                : "ti,tsc2004"
> > > >> > > + - interrupts                : IRQ specifier
> > > >> > > + - vio-supply                 : Regulator specifier
> > > >> >
> > > >> > reg property?
> > > >>
> > > >> Rob,
> > > >>
> > > >> It appears that I missed this in the description.
> > > >>
> > > >> Probably because I was following the lead of the ts2005 description.
> > > >>
> > > >> How does this look:
> > > >> - reg                 : I2C address. 0x48 - 0x4b based on the voltage applied to
> > > >>                         the AD1 and AD0 inputs on the IC.
> > > >>
> > > >
> > > > How about the version below?
> > > >
> > > > Thanks.
> > > >
> > > > --
> > > > Dmitry
> > > >
> > > >
> > > > Input: tsc2004 - document ts2004 dt bindings
> > 
> > Just noticed that it says ts2004 instead of tsc2004 in the subject.
> > Otherwise, I am fine with it.
> > 
> > Thanks for the assistance.
> > 
> > Still no acks or reviews for the other patches in the series.
> > I would like for someone to test the tsc2005 support to see if it still works.
> > 
> > The tsc2004 works very well on the target that I have here.
> 
> I folded this patch into the patch #3 and applied everything.
>

Great.

Will this patch series conflict with the patch series to take out the .owner=THIS_MODULE
from spi_drivers?

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1004626.html
 
> Thanks!
> 
> -- 
> Dmitry
