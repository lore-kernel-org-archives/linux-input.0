Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346EA43DEA4;
	Wed, 16 Sep 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543061; cv=none; b=jAvsG3kxmcLjX+jmO/J7HN+5Kb7wO6mFAyMxGIF0ruI03eozsyJg5GaCDajWqWnRTKJWFTUg5WvYOrDP1QaIGodJeASUTMOoZ/28Aj1rybzLWdmCFHyossKIAhpq1mglEqRUiD5rwFuYAa2sVpFwJGlu4c7KhrXwDaKdfTThpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543061; c=relaxed/simple;
	bh=TQScnIW64PYSTPMRBWQYz0P422qGpCMWapcTGy9MRUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUmR+oZvH6m0qp0Pypz1tL6sKfunYaImsgyBzIcQzheamj5HjfIMMAECira3uUtT0OBXA7D0PauHUefVIxEP4DJQONkokpQbdKeuclJNw43NVR3kN+2E2Tt9nMtzes3opSGOCa1b88QkjZIMKOVUCmObcRLOZdFvkLtQcbydQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN4Ej6+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN4Ej6+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4407D1F000FF;
	Wed, 16 Sep 2026 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543055;
	bh=Q0y577wAh41kaq34lv6/ls7nb8OYGlN0LYNbndS0JPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JN4Ej6+RR/wVhUNUe1kT4SmVWrJns2s6cQ6moA0yeLD9Z1ZUgtIn2vcjZ2b1yoahy
	 Ddin0SQBxk32wt2xNs9VSNEC8xMtOz3VEpslI6cPhc7JSsLEWABndE97+K72RTWktb
	 bddB76A5hYEJThTic/65VkZmOH2xEJhmqlJWCY0KIPKZGOa6hccBCx6pNS8i5KWO7g
	 H8mB1piI97QK2wfy1g3ALoxvXXONleiJZrb5nIlltHwwHxnqHmVcRufaEiYlyfUiQ4
	 NXSvnSnyfwwNFY5GOXfRVRMXs1B+K9SE0jUVnpPgQab3msu4Mb9+fHgyCRZy9jshGg
	 GlW5/8RBPaPQA==
Date: Wed, 16 Sep 2026 09:17:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, msp@baylibre.com, s-kochidanadu@ti.com, a-kaur@ti.com, 
	s-tripathi1@ti.com, vishalm@ti.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <20260916-dancing-loud-guan-fbb1eb@quoll>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
 <dec4f6e1-115e-46dd-8fb9-a3c67f1a8811@kernel.org>
 <da881fb0-93da-4d75-88da-8898b2c734eb@kernel.org>
 <20260915174103.ad6tjy6w6s24h2yc@uda0506412>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915174103.ad6tjy6w6s24h2yc@uda0506412>

On Tue, Sep 15, 2026 at 12:41:03PM -0500, Kendall Willis wrote:
> On 19:07-20260915, Krzysztof Kozlowski wrote:
> > On 15/09/2026 19:05, Krzysztof Kozlowski wrote:
> > > On 15/09/2026 18:48, Kendall Willis wrote:
> > >> On 12:13-20260914, Krzysztof Kozlowski wrote:
> > >>> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
> > >>>> Document pinctrl properties on the gpio-keys device node. By using the
> > >>>> wakeup pinctrl state, the pins are able to wakeup the system from a
> > >>>> low-power state. The default pinctrl state describes the default pin
> > >>>> configuration.
> > >>>>
> > >>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
> > >>>> ---
> > >>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
> > >>>>  1 file changed, 16 insertions(+)
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > >>>> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
> > >>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > >>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > >>>> @@ -22,6 +22,22 @@ properties:
> > >>>>  
> > >>>>    poll-interval: true
> > >>>>  
> > >>>> +  pinctrl-0:
> > >>>> +    description: Default pinctrl state
> > >>>> +
> > >>>> +  pinctrl-1:
> > >>>> +    description: Wakeup pinctrl state
> > >>>> +
> > >>>> +  pinctrl-names:
> > >>>> +    description:
> > >>>> +      When present should contain at least "default" describing the default pin
> > >>>> +      states. The second state called "wakeup" describes the pins in their
> > >>>> +      wakeup configuration required to exit sleep states.
> > >>>> +    minItems: 1
> > >>>> +    items:
> > >>>> +      - const: default
> > >>>> +      - const: wakeup
> > >>>
> > >>> This will introduce new warnings, which should be being fixed in this
> > >>> patchset (e.g. at91-kizbox3-hs.dts).
> > >>>
> > >>
> > >> Will fix the binding to work with current device trees.
> > >>
> > >>> But nevertheless, isn't second state the sleep state? How can you
> > >>> configure pins for the wakeup state - like being in the wakeup? You
> > >>> configure the pins for given state, which will be a system suspend, so
> > >>> sleep?
> > >>>
> > >>
> > >> The sleep state usually refers to putting the pins in a state to save
> > >> power. The wakeup pinctrl state is for putting the pins in a state to
> > >> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
> > >> are for system suspend, but they fill different functions. The CAN
> > >> subsystem also uses the 'wakeup' state in addition to the 'sleep' state
> > >> [1].
> > > 
> > > So you mean sleep would be a separate state? But then aren't both
> > > exactly the same states? IOW, if device is wakeup-source, it will have
> > > for "sleep" state pin configuration allowing to wakeup.
> 
> The 'sleep' and 'wakeup' pin states are both used for suspend. They
> would just be used separately since only one could be used at a time.
> The reason 'wakeup' is separated out is because it is more specific for
> allowing wakeup from the device.

If they cannot be used together, then it is the same state.

We do not define pinctrl states as XOR of "active-high-drive-str" or
"active-no-pull-up" or "active-whatever-other-mode", because these are
defined by the actual values of pincfg of one, single "active" config.

> 
> > 
> > And about CAN, I see no use of both sleep and wakeup:
> > git grep pinctrl-names | grep wakeup
> > 
> > So if you use existing code as reason for this change, then existing
> > code tells they are the same.
> > 
> 
> Yes, as of now both are not being used at the same time. I was more

Then it is simply sleep.

Best regards,
Krzysztof

