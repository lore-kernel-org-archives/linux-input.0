Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7040BCC2;
	Sun,  4 Oct 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099928; cv=none; b=KnYi/SuxwnW24m0KZHEC85x+7osDsQzrG2CCH2sJHM/biNGtND17T7bummNj4Pix0OMJqhK9u0U7MxauR/gN9KyCGnwN4hRw5KFBlt2LFB2StjIJZL2t+luU9AHhL3J5B0yMySog1ZNkOhe8MHrnkEf0qp9058Fw+pW9BVBmeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099928; c=relaxed/simple;
	bh=LgD0yIKkzGOrsy945NxWwlqtvLEejkyd28dk6ODFXSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5JOmTqxg/c6us+KUGvRsmPtP9WFj/jU8AGLP2s13Wk5NwFO1OTxsDr6i2ak1ZAR8GcXfl70mic+4QWg8EkSth6VshlVzlopmcBDPlhmF8di/uXvr7gHtDPS/f5w0cMdx+r01EX0QiqQfg37ZKoSjrFaM34qpOxO1Mp04Y0ApNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liiYdyZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liiYdyZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A591F000FF;
	Sun,  4 Oct 2026 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099927;
	bh=9Rmulx5tWtZwNZ4srP1UM6NrLE00b/t8K2ZAJDxpNCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liiYdyZc/+jysn1D8TPlEHk+jjZ5GSvFJM8qFJWTumsm72ri3c7XNO1KXJeK7WZJR
	 b/2b/HH+CGvOmSE9h/4OSBzlZTw5FRuo0ivZp7fD2Rk4wsRLDsdiJKLahR74/if2rD
	 Kzj5jSQNglKtffgsWLTGnvP6iIhDVsjsABQALJRQaQc2w4gfkZvFMn5UsSvbG9HaZ2
	 NrmW7d1toY0d4lg61EeYXxDlfTs6xNwZoZWHkq2FqXNQdnq/fT3nLX/ZLHuO4qBA3+
	 frFON9bcXmeoXrChDVD8vBH5wI0DMJ3zJiaS/9abplLgdjOv1/HIXApTSIXB5uc8xp
	 rtxGGBZdYl4OQ==
Date: Sun, 4 Oct 2026 09:45:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Lin <allencl_lin@hotmail.com>, 
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>, Felix Kaechele <felix@kaechele.ca>, 
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20261004-terrific-lemon-hamster-2ab5cf@quoll>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-2-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261003142741.48634-2-michal@nozomi.space>

On Sat, Oct 03, 2026 at 04:27:36PM +0200, Micha=C5=82 Kope=C4=87 wrote:
> From: Allen_Lin <allencl_lin@hotmail.com>
>=20
> Add the binding for the touch function of the Himax HX83102J, a touch
> and display driver integrated (TDDI) controller. The touch function is
> connected over SPI and shares the analog supplies and the reset of the
> display function, so it is powered and reset together with the panel
> and has to follow it.
>=20
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>

Please use full name, not login or nickname. I see original patchset had
the same issue, but full name was provided in the maintainers entry. If
the original author does not want to fix that, you can takeover the
patchset.


> [michal@nozomi.space: rename ddreset-gpios to display-reset-gpios,
>  describe the shared supplies and the display reset, take over
>  maintainership, drop Rob's Reviewed-by because of these changes]
> Signed-off-by: Micha=C5=82 Kope=C4=87 <michal@nozomi.space>
> ---
>  .../input/touchscreen/himax,hx83102j.yaml     | 98 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/h=
imax,hx83102j.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx=
83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx8=
3102j.yaml
> new file mode 100644
> index 0000000000000..c9f229bf9ca7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.=
yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83102j.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax hx83102j touchscreen
> +
> +maintainers:
> +  - Micha=C5=82 Kope=C4=87 <michal@nozomi.space>
> +
> +description:
> +  The Himax HX83102J is a touch and display driver integrated (TDDI)
> +  controller. Its touch function is connected over SPI and reports HID
> +  packets. The display and touch functions share the analog supplies and
> +  the display reset, so the touch function is powered and reset together
> +  with the panel it is part of.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: himax,hx83102j
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1

You need description to explain why this is different than
display-reset-gpios.

> +
> +  vccd-supply:
> +    description: Digital I/O supply of the touch function.
> +
> +  vsn-supply:
> +    description: Negative analog supply, shared with the display functio=
n.
> +
> +  vsp-supply:
> +    description: Positive analog supply, shared with the display functio=
n.

Best regards,
Krzysztof

