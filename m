From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Thu, 13 Nov 2014 11:47:13 +0100
Message-ID: <1763965.yCxTDubTPH@wuerfel>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com> <2197757.1V0yxO5sLr@wuerfel> <5340312.bOFF4aoNWW@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62394 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbaKMKrU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2014 05:47:20 -0500
In-Reply-To: <5340312.bOFF4aoNWW@ws-stein>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

On Thursday 13 November 2014 11:35:42 Alexander Stein wrote:
> On Wednesday 12 November 2014 20:16:06, Arnd Bergmann wrote:
> > On Wednesday 12 November 2014 17:38:31 Alexander Stein wrote:
> > > On Wednesday 12 November 2014 17:04:57, Arnd Bergmann wrote:
> > > > On Wednesday 12 November 2014 17:02:56 Alexander Stein wrote:
> > > > > This features already exists for board config setups. Add support for
> > > > > device tree based systems.
> > > > > 
> > > > > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > > > > ---
> > > > > Please note: Due to current lack of hardware I could not test it yet. V2
> > > > > includes the changes proposed by Dmitry.
> > > > > 
> > > > > Changes in v2:
> > > > > * Added device tree bindings
> > > > > * IRQ is only parsed and mapped when there is no "gpios" property
> > > > > 
> > > > 
> > > > Can you list one or more examples in the patch description?
> > > > Are these systems that don't expose the GPIO controller with a
> > > > standalone driver, or systems that really actually connect the
> > > > buttons to an interrupt pin?
> > > 
> > > You mean a use case? I came to this situation to test interrupt polarity on a microcontroller, thus a simple /IRQ pin, no GPIO at all. So in the end I have an input just connected to an interrupt line.
> > > I noticed gpio_keys using platform data only can be used for this setup. So I added this support for device tree.
> > > 
> > 
> > I meant a specific board file that uses this, which can't be converted
> > to DT without your change.
> 
> I've searched (hopefully) the complete arch/ tree on v3.18-rc4 for
> struct gpio_keys_button and checked each occurrence. I didn't found
> any usage of IRQ based input keys.

Ok, I see.

I notice that Laxman Dewangan initially added the feature as part of
(I assume) work on Tegra, but these days Tegra is DT-only so it can't
actually get used for that any more.

If we have a real usecase, I think we can still take your patch, but
my impression at the moment is that it may be better to instead
remove the feature entirely by reverting d8ee4a1c9052 ("Input:
gpio_keys - add support for interrupt only keys").

Regarding your initial use case of testing interrupt polarity, would
you have been able to do the same thing by looking at the interrupt
count in /proc/interrupts?

	Arnd
