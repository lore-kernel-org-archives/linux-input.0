Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B745C700;
	Tue,  6 Oct 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302451; cv=none; b=fcS0cm3pTHN5fiCvtXb5ME0SuQn+qZedIQ7/lYAYZHqJjFYZTeo5jTnymDVFE9N79uujt5YTmvv61TA3QN78SQ423RT9wXDqKsnLC5cNLVfLes7puARp1U15p5p224v5VUhKvz1eG28wsK9dL6SDx11dyv3oG7dWiLbhHyJ6xIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302451; c=relaxed/simple;
	bh=kusOD+0aQTMuKi/VhC33ZHvLnI/Amhx1DrqodrZNgoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Ywi2Jasc1XMugPaTYWf3xbXeM+vH7a9D9i9ZGKjl4ccT1MoQJJlZ+NoUjRecdAhzgLp8uPKWgNXjZUC225B/esx3yImJ25dn4lcT8GK8u8R2CLn6xz+lyWcHXvl+65w7u0AzgWxodacv+qJ9QUWXFvz7v+FF3otjmIvuPKdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZLgEdVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZLgEdVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C714C1F0089B;
	Tue,  6 Oct 2026 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302450;
	bh=/vu360YYcRwt3HSnHjol/3LXh7oyXMVKQzNSNfXoSt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZLgEdVic3fVHaSEl9FZAleOk4QaUceClRvW+wjX8lQldMmBdv4/V4DbacEvdcnL2
	 3xwzV8yUg0fMpoeOzwSXIJ+rmVSnwNr9PWrHQWofU/2AMR0yMepxsMYHwNfNcy9G6R
	 rHMoFa4KRWIY+iNvp7BhWHGKYemLyKiP40efhGMsEqrBphcj1tetg4lYU3hNmCbcKp
	 4linjbudBJEQ5alGa9qaAunmYDWrTUKQEos61hTPZOWhucMn1N6JFx9sXMneMS4yGh
	 7x1YMsCH67rXqJwDHjClW7AL1b57C3ZXbNvLYpafm/80c1vEltnA85UIdRJmDFibPP
	 AlGeqYTdLNoYw==
Date: Tue, 6 Oct 2026 11:00:49 -0500
From: Rob Herring <robh@kernel.org>
To: Michael Reeves <michael.reeves077@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-input@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>,
	Julian Braha <julianbraha@gmail.com>,
	Sasha Finkelstein <k@chaosmail.tech>
Subject: Re: [PATCH v4 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Message-ID: <20261006160049.GA2406717-robh@kernel.org>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
 <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>

On Fri, Sep 25, 2026 at 10:09:31PM +1000, Michael Reeves wrote:
> Apple internal keyboards and trackpads behind MTP are exposed through a
> DockChannel HID transport.
> 
> Describe the transport's mailboxes, DART and HID child interfaces. An
> optional STM child supplies shared device identifiers and serial numbers;
> the keyboard child can specify its HID country code for layout selection.
> 
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> 
> ---
> Conor's v1 Reviewed-by is not carried forward because v2 adds the STM binding.
> ---
>  .../input/apple,t8112-dockchannel-hid.yaml         | 104 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 105 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
> new file mode 100644
> index 000000000..c25e072b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/apple,t8112-dockchannel-hid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple DockChannel HID Transport
> +
> +maintainers:
> +  - Michael Reeves <michael.reeves077@gmail.com>
> +
> +description:
> +  HID transport for keyboard and trackpad devices connected via the
> +  DockChannel FIFO mailbox on Apple Silicon SoCs. The endpoint includes a
> +  small RTKit coprocessor called MTP which must be booted before the HID
> +  transport becomes available.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: apple,t8112-dockchannel-hid
> +      - items:
> +          - enum:
> +              - apple,t6020-dockchannel-hid
> +              - apple,t6030-dockchannel-hid
> +              - apple,t6031-dockchannel-hid
> +              - apple,t8122-dockchannel-hid
> +          - const: apple,t8112-dockchannel-hid
> +
> +  reg:
> +    items:
> +      - description: Coprocessor ASC registers
> +      - description: Coprocessor SRAM/mailbox registers
> +
> +  reg-names:
> +    items:
> +      - const: coproc-asc
> +      - const: coproc-sram

'coproc-' seems redundant?

> +
> +  mboxes:
> +    items:
> +      - description: ASC mailbox used for RTKit control
> +      - description: DockChannel FIFO mailbox used for HID packets
> +
> +  mbox-names:
> +    items:
> +      - const: asc
> +      - const: dockchannel
> +
> +  iommus:
> +    maxItems: 1
> +
> +  stm:
> +    type: object
> +    description:
> +      STM interface providing the vendor, product and version identifiers
> +      and serial number shared by the HID devices. When present, the host
> +      must query this interface before registering the keyboard.
> +    additionalProperties: false

An empty node is unusual. Why can't you just query the STM interface and 
treat it not existing or having those properties the same as no 'stm' 
node.

> +
> +  keyboard:
> +    type: object
> +    properties:
> +      hid-country-code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          HID country code for the keyboard layout variant.

Why does this need its own node?

And address sashiko's comment. Seems like it could be common? I'll defer 
to HID folks.

Rob
