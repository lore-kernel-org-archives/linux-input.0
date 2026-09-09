Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B9582B8D;
	Wed,  9 Sep 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971220; cv=none; b=YHE2ccoOIi91nbKcN7qUbyg4r3tAux1y2NxT0qSrJdykbK4xLc9px7DIrEo3e7Lxw19YdC6mIGjMdOFOfO+bQWnkRckFDaByCmUrTpXJgT7aXbq6U0VcP6dAAXDehAoIQ4oKd3T9U6fnkKcmzHTOb89ENxMlp29ge8jBGd6xSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971220; c=relaxed/simple;
	bh=HcHgkL6TW1RqFn1pt9hSCxEEiyTt0+09c7FhbHWlUHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbCLPeL/UJ9MjcO3uBfOALsvhXDKJgFgdLrEmOeFO16f+2j5JvdVAsQuA49aLcscmtshsQqRe2yljlLWJc3x/r5x6xlNq9s+/fCmgSvownghYwhPFRXaecZ586A8xaOSgclVFoEVEk/WXn1xI/m5n+3REjpHAID6Uihi4DrVA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSq8nbn+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSq8nbn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126531F00893;
	Wed,  9 Sep 2026 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971219;
	bh=VtRki6K8hhXlfgH6SoziLswf1SwueIo5V1mQDr3Mdcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSq8nbn+DHrIH3dMX6o7UU5SJ1ue8FqZrzv62MAp3NF8qreZRw+Lr2GxCGiCf9IIt
	 O5XKbPu6/OA94XiTR8gtCUVYOBH7eoX1dEYPCuXejCDQ9MzqpNmvzLm9Xc+Pgedhw/
	 ujgL56imtp/dFjQYSOf2XzYW2KoH12ukbr3Noki+BXm+ddi5Oq5YwmRs8VoBy31QH7
	 6/wROFj42btByJmg5RuHwfJephgX0fSjx9qr6hLN2vvqzSr4zi005ffwvt2siSxKCx
	 wvxX3qj8muOXrylBYW914PBKXXYKXY2nyUSft5bxwcP9hZdnG1EUq5hWxPxmG1/f2I
	 /FUaQvtDJL60w==
Date: Wed, 9 Sep 2026 17:26:54 +0100
From: Lee Jones <lee@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Pavel Machek <pavel@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert to DT
 schema
Message-ID: <20260909162654.GK2133376@google.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-2-clamor95@gmail.com>
 <178463529533.2776661.17291216407355479584.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178463529533.2776661.17291216407355479584.robh@kernel.org>

On Tue, 21 Jul 2026, Rob Herring (Arm) wrote:

> 
> On Tue, 21 Jul 2026 12:56:48 +0300, Svyatoslav Ryhel wrote:
> > Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
> > YAML format. This patch does not change any functionality; the bindings
> > remain the same.
> > 
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
> >  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
> >  2 files changed, 42 insertions(+), 29 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/leds/leds-cpcap.txt
> Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/leds/leds-cpcap.txt
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260721095654.429346-2-clamor95@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

This one.

-- 
Lee Jones
