From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 4/4] Input: tsc2004 - Document ts2004 dt bindings
Date: Mon, 2 Nov 2015 14:50:29 -0600
Message-ID: <20151102205028.GA2571@deathstar>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
 <1446252086-24334-5-git-send-email-mwelling@ieee.org>
 <CAL_JsqKpbrWcHj4eubWMAjtVRHE8TTN_qC5S=J7qzcf8khpzng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34288 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbbKBUuk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 15:50:40 -0500
Content-Disposition: inline
In-Reply-To: <CAL_JsqKpbrWcHj4eubWMAjtVRHE8TTN_qC5S=J7qzcf8khpzng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Nov 02, 2015 at 09:19:50AM -0600, Rob Herring wrote:
> > +Required properties:
> > + - compatible                : "ti,tsc2004"
> > + - interrupts                : IRQ specifier
> > + - vio-supply                 : Regulator specifier
> 
> reg property?

Rob,

It appears that I missed this in the description.

Probably because I was following the lead of the ts2005 description.

How does this look:
- reg			: I2C address. 0x48 - 0x4b based on the voltage applied to
			  the AD1 and AD0 inputs on the IC.

Do I have to spin the whole series to update this patch?

Everyone,

Are there any other concerns with this patch series?

Regards,

Michael
