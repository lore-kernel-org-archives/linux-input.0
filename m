From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Thu, 13 Nov 2014 11:35:42 +0100
Message-ID: <5340312.bOFF4aoNWW@ws-stein>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com> <8280855.M123yTnXfy@ws-stein> <2197757.1V0yxO5sLr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:44673 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932241AbaKMKds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2014 05:33:48 -0500
In-Reply-To: <2197757.1V0yxO5sLr@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Wednesday 12 November 2014 20:16:06, Arnd Bergmann wrote:
> On Wednesday 12 November 2014 17:38:31 Alexander Stein wrote:
> > On Wednesday 12 November 2014 17:04:57, Arnd Bergmann wrote:
> > > On Wednesday 12 November 2014 17:02:56 Alexander Stein wrote:
> > > > This features already exists for board config setups. Add support for
> > > > device tree based systems.
> > > > 
> > > > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > > > ---
> > > > Please note: Due to current lack of hardware I could not test it yet. V2
> > > > includes the changes proposed by Dmitry.
> > > > 
> > > > Changes in v2:
> > > > * Added device tree bindings
> > > > * IRQ is only parsed and mapped when there is no "gpios" property
> > > > 
> > > 
> > > Can you list one or more examples in the patch description?
> > > Are these systems that don't expose the GPIO controller with a
> > > standalone driver, or systems that really actually connect the
> > > buttons to an interrupt pin?
> > 
> > You mean a use case? I came to this situation to test interrupt polarity on a microcontroller, thus a simple /IRQ pin, no GPIO at all. So in the end I have an input just connected to an interrupt line.
> > I noticed gpio_keys using platform data only can be used for this setup. So I added this support for device tree.
> > 
> 
> I meant a specific board file that uses this, which can't be converted
> to DT without your change.

I've searched (hopefully) the complete arch/ tree on v3.18-rc4 for struct gpio_keys_button and checked each occurrence. I didn't found any usage of IRQ based input keys.

Best regards,
Alexander

