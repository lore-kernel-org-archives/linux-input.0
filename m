Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFC3D16FC;
	Thu, 16 Jul 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239960; cv=none; b=G0NwgEnyWxsbkrx4SM1FJNryQZpAvccF4x4zw4kuFtTXi+RnBik7XSv+TDA9xN7VpKXNFeeH5XhGU6pUog1RPm9+16wb3Uzqz3fFnD9vmOtA9Ls3eF34kGDCbxoEkj6J76SbhFWADeBK9so4P5cH3knFjrbzfcT9rS6HSUlzLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239960; c=relaxed/simple;
	bh=eJzzq0+eI4rwVsvSmcEtmwZJhnaVhKwdMpipS+zcvSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqNSXXwpBxlB0FzkfQCNEaQn6VlV6GnplOsgSx6mFKOviuSTvYJAGH8kPmwwhazDuO9MMseW3dBxYT7Yb0bcWiZ1gzGIXIYWnFhqJSdjizqXP1qYQb855Q6kW9QF6v3etsChPm1B88j+bWbYqqFNZp1LkbBiUlZMXjvcw3GiP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohIkqRSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohIkqRSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11031F000E9;
	Thu, 16 Jul 2026 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784239959;
	bh=wqHcuPVvvxXWxaysAf9SzeGo2yhyLZDJBTeRKU8ATfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ohIkqRSaZ1F+eaXNAQmZkOjwuLDD8rkHwHrJ0rJj+tzNRibmdoaXMrPWqfwS0LKrQ
	 +QSML5WqXq6l1m4Z5sVZcy7iDeGzrtBCHIpPu5H3E7EsyekTazlLCl+SviOEVEGtBK
	 1zvzerPAKXFTvHqWjI3eRPc2E5OPPzRgrMuxVfMHwHBfkgKf9+xYGX9CUuZ7IK3DMg
	 hLYcyGG2SEjpdC+qt30X4g5vU9H9S12UwaYTl/begEvFeS2ygWX1y7eU6Ahv97pfM1
	 kB5Dvi92clrMZZAs7b5RiE+3O4MeeV8As0ngac03dxd0LSsXhkse5R4/mdxoq6MgBL
	 VFv2UVcNHFhZA==
Date: Thu, 16 Jul 2026 17:12:38 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Eduard Bostina <egbostina@gmail.com>, dmitry.torokhov@gmail.com,
	conor+dt@kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: Convert TI Keypad Controller to DT
 schema
Message-ID: <20260716221238.GA1523257-robh@kernel.org>
References: <20260708123252.1768355-1-egbostina@gmail.com>
 <20260708124112.1DC541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708124112.1DC541F00A3A@smtp.kernel.org>

On Wed, Jul 08, 2026 at 12:41:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Properties strictly required by the hardware and driver ('keypad,num-rows', 'keypad,num-columns', 'interrupts', and 'linux,keymap') are omitted from the 'required:' list, allowing non-functional device trees to silently pass validation.
> --
> 
> --- Patch [1]: [PATCH] dt-bindings: input: Convert TI Keypad Controller to DT schema ---
> commit 31e1662350e854e7b96beb7e7de83fc2b0d265e2
> Author: Eduard Bostina <egbostina@gmail.com>
> 
> dt-bindings: input: Convert TI Keypad Controller to DT schema
> 
> This commit converts the Texas Instruments Keypad Controller bindings to DT
> schema format. It updates the autorepeat property name, adds the reg-names
> property, and omits the keypad row and column properties from the required
> list to prevent validation failures.
> 
> > diff --git a/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml b/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
> [ ... ]
> > +required:
> > +  - compatible
> > +  - reg
> 
> [Severity: Medium]
> The commit message mentions that keypad,num-rows and keypad,num-columns were
> omitted from this required list because enforcing them causes validation
> failures. Should these properties, along with interrupts and linux,keymap,
> be included here to accurately reflect the driver's probing requirements?
> 
> Omitting them allows non-functional device tree nodes to silently pass
> schema validation. At runtime, the omap4-keypad driver will unconditionally
> fail to probe via platform_get_irq(), matrix_keypad_parse_properties(), and
> matrix_keypad_build_keymap() when these properties are missing.
> 
> Would it be better to enforce the strict hardware and driver requirements in
> the schema, and instead fix the incomplete device tree nodes that are
> failing validation?

Yes. sashiko is right.

Rob
