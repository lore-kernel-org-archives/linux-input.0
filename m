Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CD1F4CA9
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178267; cv=none; b=Nkw3BIvaq2EElqoO0iMB8JUw40r2UzR47b2W/FbriS15pFpWMXMXbOtOyl2JeboQgHSeeBblAMKiRDyliynT4cXfwx1LFkXb+bAdGlEYnwOqR1Nlmdclhq0398phw0yNuTtl3SKJ/D+Dc7IJrqXksWRRgidzSetv9op6eG7D+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178267; c=relaxed/simple;
	bh=xfZuXEx8LXTYCKhefmAsyovx5efrPKC9PF6wH9YToCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq+GVblmv3u0XhLmh22/qOUUMZRDMaGr3on8d5C9jw1YHU7dc1ZiE0kL5DLHUvHuSp4fO4SdpDoYLjSmmp82qUlcKyaBkZ9lx7mNp3XBhoZKXNE0Hr5tKnUppHCxpSZNCBXr6RniMr7oeh1bcUPOjgBTqlubdDIfWPdGao8wurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vjI5H-0003kl-65; Fri, 23 Jan 2026 15:24:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vjI5H-0026hm-1B;
	Fri, 23 Jan 2026 15:24:22 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vjI5G-00AwGI-1p;
	Fri, 23 Jan 2026 15:24:22 +0100
Date: Fri, 23 Jan 2026 15:24:22 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: AThomas63 <andrew.thomas@touchnetix.com>, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark.satterthwaite@touchnetix.com, kamel.bouhara@bootlin.com
Subject: Re: [PATCH v1] dt-bindings: input: Add TouchNetix aXiom touchscreen
 driver
Message-ID: <20260123142422.pd4x3wu5wk63pppe@pengutronix.de>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
 <20260122144052.358956-1-andrew.thomas@touchnetix.com>
 <c6fabbcc-4a18-446c-b97e-944cfd23b87e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fabbcc-4a18-446c-b97e-944cfd23b87e@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi Krzysztof,

On 26-01-23, Krzysztof Kozlowski wrote:
> On 22/01/2026 15:40, AThomas63 wrote:
> > Add extra changes referenced in the previous patch:

...

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - tnx,axiom-i2c
> > +      - tnx,axiom-spi
> 
> No, these are the same. Use only one describing the device.
> 
> No device model? Really?

That beeing said, you already provided your review for a device which is
part of this family here:
 - https://lore.kernel.org/all/20260111-v6-10-topic-touchscreen-axiom-v5-3-f94e0ae266cb@pengutronix.de/

Regards,
  Marco

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  axiom,poll-enable:
> 
> There is no such company as axiom. You just said it is tnx.
> > +    type: boolean
> > +    description: Enable aXiom polling mode instead of interrupt-driven 
> > +      reporting.
> 
> Anyway, drop entire property. Not a DT suitable, not hardware.
> 
> > +
> > +  axiom,poll-period:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 10
> > +    description: Set the polling period in milliseconds.
> 
> Drop entire property.
> 
> > +
> > +  # Required for SPI
> > +  spi-max-frequency: true
> 
> Drop. Not needed.
> 
> > +
> > +  # Common touchscreen properties
> > +  touchscreen-size-x: true
> > +  touchscreen-size-y: true
> > +  touchscreen-inverted-x: true
> > +  touchscreen-inverted-y: true
> > +  touchscreen-swapped-x-y: true
> 
> Drop all.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: touchscreen.yaml#
> 
> Missing ref to spi-periph.
> 
> Look at other bindings instead of inventing your own.
> 
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        touchscreen@66 {
> > +            compatible = "touchnetix,axiom-i2c";
> > +            reg = <0x66>;
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> > +            axiom,poll-enable;
> > +            axiom,poll-period = <15>;
> > +        };
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        touchscreen@0 {
> > +            compatible = "touchnetix,axiom-spi";
> > +            reg = <0>;
> > +            spi-max-frequency = <4000000>;
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index f1d1882009ba..dadfc7036ed7 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1636,6 +1636,8 @@ patternProperties:
> >      description: Trusted Logic Mobility
> >    "^tmt,.*":
> >      description: Tecon Microprocessor Technologies, LLC.
> > +  "^tnx,.*":
> 
> Domain is touchnetix, so that's your prefix.
> 
> > +    description: TouchNetix
> >    "^topeet,.*":
> >      description: Topeet
> >    "^topic,.*":
> 
> 
> Best regards,
> Krzysztof
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
