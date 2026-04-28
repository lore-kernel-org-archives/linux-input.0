Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11733947B0;
	Tue, 28 Apr 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396551; cv=none; b=crxfjioenMMKyPf2u51pgfhyekH3mG0GXuumSI3/rF93vWtUvRXSGzhMiarB0NMbz9k2J41gr1/aVBrtw+Ej0KK1Wy6vwVopTOw54nl8lHzTCirbwBKymlLwZGbx64zXo0MbdO/M+vZt5Cv5LF1C0wv1+y32ms2eHb/P/W8WY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396551; c=relaxed/simple;
	bh=QWfEq6gUlnAeK6XQ6Qanv4z6/M5X52A4bB2elgt2z4w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=M1M3oZt0KYKIP7O7QGXAZniZvDdOeOlykCtOoOBsqBSoGHsjHsyXWeCGuKEdapQ6j+1l5WQm6oh7sBQGZ/faT0+eF3tg1QwZNHnjlwVpCh252xc6ZxxsW8Bocw4t6P4ZSw5NJ3B6EDr4UXMVos3H7w4zLF4wvVFyJ11+X9PXMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1xtkjv3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1xtkjv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B99C2BCAF;
	Tue, 28 Apr 2026 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777396550;
	bh=QWfEq6gUlnAeK6XQ6Qanv4z6/M5X52A4bB2elgt2z4w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=I1xtkjv3s2UMpQSKJiMlo/BpkRkkOuE0sudgr/xnfXf6C4Ccyn5msPuZ2A8aq6mSE
	 PpfbDElRewlLf0NXAL5E2+DJnKlzJX2Em3MhjGdtB2dieqA4zdR8cTm8hVJPPrTjAp
	 AHkrYg0q1K8N6cc6aFUjjHmZ6NS2ZBGhYc619kFNCwCBwrwBCCLXGQ8y2AtfRNAAHR
	 OXLiGeAk20Wk1nUXxw/N2EB+jGeXoqQP763nWe1YU7pQiuWgW1ILnN0NXw3z3PRa39
	 3pfL29V7esdUOfutEMLDZXcv5cE9zbzOxd5JckG/3b0q92o/wlAqBqT1Y1stIqIexV
	 XtcnpqNDDz90Q==
Date: Tue, 28 Apr 2026 12:15:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
 Pavel Machek <pavel@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260428153611.142816-3-clamor95@gmail.com>
References: <20260428153611.142816-1-clamor95@gmail.com>
 <20260428153611.142816-3-clamor95@gmail.com>
Message-Id: <177739654665.2299307.14959755210536638419.robh@kernel.org>
Subject: Re: [PATCH v4 2/6 RESEND] dt-bindings: input: cpcap-pwrbutton:
 convert to DT schema


On Tue, 28 Apr 2026 18:36:07 +0300, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
>  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260428153611.142816-3-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

