From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] input: adc-keys: add DT binding documentation
Date: Tue, 5 Jul 2016 09:53:03 -0500
Message-ID: <20160705145303.GA4302@rob-hp-laptop>
References: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34762 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbcGEOxH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2016 10:53:07 -0400
Content-Disposition: inline
In-Reply-To: <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Sun, Jul 03, 2016 at 02:43:56PM +0100, Jonathan Cameron wrote:
> On 01/07/16 22:30, Alexandre Belloni wrote:
> > Add documentation for ADC keys
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Clean looking binding to me - one comment inline.
> 
> Jonathan
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > 
> >  .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> > new file mode 100644
> > index 000000000000..873476bb4eab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> > @@ -0,0 +1,45 @@
> > +Allwinner sun4i low res adc attached tablet keys
> What is allwinner specific in here?  Looks pretty general purpose to me!
> > +------------------------------------------------
> > +
> > +Required properties:
> > + - compatible: "adc-keys"
> > + - io-channels: Phandle to an ADC channel
> > + - io-channel-names = "buttons";
> > + - voltage-keyup-mvolt: Voltage at which all the keys are considered up.
> > +
> > +Each key is represented as a sub-node of "adc-keys":
> > +
> > +Required subnode-properties:
> > +	- label: Descriptive name of the key.
> > +	- linux,code: Keycode to emit.
> > +	- voltage-mvolt: Voltage adc input when this key is pressed.

voltage-mcvoltface?

"voltage" is redundant and use standard units. How about 
{press,up}-threshold-microvolt?

Rob
