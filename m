Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C63E024C;
	Thu, 14 May 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769736; cv=none; b=BLdbjayIw1rvRgh7J4nVHZPW3lGoNzg4/oQfmm3cFixfIia9z7+Ev96M9OS8ck3jKfWt1Y9XF18nuWl0tKm6XrT2ONYP27t7pyxoRbHXhM4lkAZ2A2SAd6RuxNdvbIJcvava/SOgqXGiimItedJsLbVXEOK+oSBtjfjzjsebi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769736; c=relaxed/simple;
	bh=q/Qpk81UwCbtSa4zrr4b89ohb7zLtbr21yyWHZFdP6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLAThn0S3HX3+WXxO9DIulsZISMWCfCUgQn60Rln6+f1H9hi5urMagAW3EFaQeEkvW0tFsja1Lf1NHsSD7QdGDwA+PZxmKqSL6oJKoqfYVM3b+MIJttwd3/C3IQryUVLCK0k+zJFjeQPEZ9tSpNyjfpDrwCyV6cNCNxQg1qJctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmstQxzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmstQxzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BF2C2BCB3;
	Thu, 14 May 2026 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769736;
	bh=q/Qpk81UwCbtSa4zrr4b89ohb7zLtbr21yyWHZFdP6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmstQxzDqmqhYGx/nWH3uhGfsGl41ssF2Sd91HLGQr7VEU1ltjE7bMS6L7d8TjO+X
	 igmPcyrIog/tb6jq908DjJKNqkE+au5pMZ8azaTmp4mxgbU1lDoqhSKAQrRQLrvkG7
	 1Njw1G1gc//+isavq+eeJ+BNzDgta6seGBtzxe+A1C2XBw/T3dMhjvskycGnmFyHSF
	 7IEkqItrnFAwjyXUlYWQ9v+7/EosNdT5Wgw1NcSyWiTehtkeOy79CEq4JUV3Qt9RgD
	 Ju8R+4m+btqiJYZF6NbsqL0XJY27RB5LBabMvg+LN/oRWjUbgZjapA/NhOuMYxFKtl
	 wZQqMrSIc85tA==
Date: Thu, 14 May 2026 09:42:14 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, linux-input@vger.kernel.org,
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: input: Document Imagis ISA1200
 haptic motor driver
Message-ID: <20260514144214.GA472306-robh@kernel.org>
References: <20260512102445.55372-2-clamor95@gmail.com>
 <20260513201558.808C4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513201558.808C4C19425@smtp.kernel.org>

On Wed, May 13, 2026 at 08:15:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing scalar type definitions for `imagis,period-ns` and `imagis,duty-cycle-ns` cause schema bounds validation to be silently bypassed.
> --
> 
> commit c2a7ef2ca3d62317c69bc5b6a450107172eeeac7
> Author: Svyatoslav Ryhel <clamor95@gmail.com>
> 
> dt-bindings: input: Document Imagis ISA1200 haptic motor driver
> 
> This commit documents the Imagis ISA1200 haptic motor driver. It introduces
> a new YAML binding schema for the driver, specifying properties like
> control-gpios, clocks, and internal PWM configurations.
> 
> > diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yaml b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> > new file mode 100644
> > index 0000000000000..bbe6f99d39c19
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> [ ... ]
> > @@ -0,0 +1,140 @@
> [ ... ]
> > +  imagis,mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Defines the motor type isa1200 drives
> > +      0 - LRA (Linear Resonant Actuator)
> > +      1 - ERM (Eccentric Rotating Mass)
> > +    enum: [0, 1]
> > +    default: 0
> > +
> > +  imagis,period-ns:
> > +    description:
> > +      Period of the internal PWM channel in nanoseconds.
> > +    minimum: 10000
> > +    maximum: 30000
> > +
> > +  imagis,duty-cycle-ns:
> > +    description:
> > +      Duty cycle of the external/internal PWM channel in nanoseconds,
> > +      defaults to 50% of the channel's period
> 
> Will the minimum and maximum bounds on imagis,period-ns be silently ignored
> during validation?
> 
> The core property-units.yaml schema automatically assigns an array type to
> properties ending in -ns. Without an explicit reference to
> /schemas/types.yaml#/definitions/uint32, these properties are evaluated as
> arrays rather than scalar integers. 
> 
> In standard JSON Schema, numeric constraints like minimum and maximum are
> ignored when applied to an array instance. Adding the uint32 type reference
> for both imagis,period-ns and imagis,duty-cycle-ns would ensure the
> constraints are properly enforced on a single scalar value.

Wrong.

While that's true for json-schema, the standard unit properties 
schemas will be fixed up to the right type.

Rob
