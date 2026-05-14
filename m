Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157F425CC9;
	Thu, 14 May 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770545; cv=none; b=kDwbzpxM54aCHKxOeCFYHrr1O7j6Tc8TQFFnu7xFdHtrTtroGwtOWbW8cIrCU30W1+Q4QIwCVbkMer7I1qnqUMCADSoliJm068Gv5OX3cFKBwEEbXBQa9oPq9Y6kHnFPgTUwd2SZRRhy/89/ULD12wnfcGOpM2WMJtatZAnh48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770545; c=relaxed/simple;
	bh=herRRBiOpH8A7gjlck6qVNwEdXMOZMlvMsZVWeDnj0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2AWoRNJiKNHNR59mJjqcqFlZNr6lFgjufdwCfUfXdGss3+db8K/aENHr/dWN/j69TzAxzf27ZlT3l6Wy7ZcTwGPoFqzA61daUfciQ0n/V7ddlOOB13G6hXeEaEHCvrwz6S3FkdNFNAGKgRTLcxgsL7j7oWgk1/jTXEf/REKh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ70mEW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ70mEW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3537BC2BCB8;
	Thu, 14 May 2026 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770544;
	bh=herRRBiOpH8A7gjlck6qVNwEdXMOZMlvMsZVWeDnj0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQ70mEW+sC4jHtZY8e6qk/1x9sidnKcDCTuI1EcaNgovNmGUZQHUKUhCF8sb7NXiS
	 qf02zPLo1S2nRQUk8g9G7Gxy4uGrEnWzsegSkCztb1kYtmtSlEeA48q6RprGNR+a+n
	 FCeGtzyDK15GFIB/nDn8576c8w2DBcEHxWslx9cwnpzFpgoiCBWG+c4UCC24DQg/d0
	 ErKnzJBgDh/6oBBI5FiVghvbVq8FeZYypCYiAtLepZz4AnZ8Z/CnuEfCz8yk91/Jkk
	 1nxLjOwrbrXHFFeVksizGMQq+rwUPCftA5KResoGN+iv6lTdik45/A85si8rv28J3G
	 lmmYuSiqOg0Hw==
Date: Thu, 14 May 2026 09:55:41 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: input: Document Imagis ISA1200
 haptic motor driver
Message-ID: <20260514145541.GB472306-robh@kernel.org>
References: <20260512102445.55372-1-clamor95@gmail.com>
 <20260512102445.55372-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512102445.55372-2-clamor95@gmail.com>

On Tue, May 12, 2026 at 01:24:44PM +0300, Svyatoslav Ryhel wrote:
> Document the Imagis ISA1200 haptic motor driver, used primarily in mobile
> handheld devices and capable of supporting up to two motors.
> 
> The exact datasheet for the ISA1200 is not available; all data was modeled
> based on available downstream kernel sources for various devices and
> fragments of information scattered across the internet.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/input/imagis,isa1200.yaml        | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yaml b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> new file mode 100644
> index 000000000000..bbe6f99d39c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/imagis,isa1200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagis ISA1200 haptic motor driver
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description:
> +  The ISA1200 is a high-performance enhanced haptic motor driver designed
> +  for mobile hand-held devices. It supports various voltages for both ERM
> +  (Eccentric Rotating Mass) and LRA (Linear Resonant Actuator) type
> +  actuators. Thanks to an embedded LDO, battery power can be used directly
> +  in handheld applications.
> +
> +properties:
> +  compatible:
> +    const: imagis,isa1200
> +
> +  reg:
> +    maxItems: 1
> +
> +  control-gpios:
> +    description:
> +      One or two GPIOs flagged as active high linked to HEN and LEN pins

       minItems: 1

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +    maxItems: 2
