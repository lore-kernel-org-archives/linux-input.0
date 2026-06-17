Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6418871F;
	Wed, 17 Jun 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730961; cv=none; b=AQi0DOtnvEADhsUHd1BhVNf/89RXAWCSOFd3VDA64rkRF4lbCUJ2p18N3IlyjyspHOVdDKiBHsSUvNlQ4u3xpq8U2+LAfdMLGdWXAfFK8bn6XPnOnb18KWX5bvLdB8AmyOSfZJL0KNVcREczFBbbvYw8Xs3tFrwV3xoPl6mky/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730961; c=relaxed/simple;
	bh=2DQnI8VkSK2INwYpF6SZ3hNw75WvItQc4mGHC0anI6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mZwkcDwedFvV1AJu5PcIODOe/kiNKqaPtni+EEaXyUT1nl9g6/MbYybZxJiYSJ1b62UP7fWRDSWuwYZp6KLOGgO7fWGKF4husFBLiQl75xUd3eM9e+uQvmdk7KqcoDfC2+Q+TaUg8SOrRJA8jRy/jhStxQOQMNfchbchqZAKL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+CEQ3N7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+CEQ3N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D01F000E9;
	Wed, 17 Jun 2026 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781730960;
	bh=iWTQ/zT0dJYJ8fm6ptf+v5jMyy5kp4RRE6dQB4qOtgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+CEQ3N7Aab/rObEqUYAX8b8iUlkhxuHCNCqsV2EtlYuSIOf2jJis1pDqSjWoj48B
	 BKKirS7ao2qKcJ3otoJvPcYmLDRlB/qcHbarbTOWQjRTkZz4bKczZtTaK0IUrLP/l5
	 rmBcK0uKwB3XiN+2UiD+N99mwGnfqmiXef+T0SVDuubsOuPqHpq0BZVnlEV+aYsC8U
	 tCufXtbmsyRwpzF+BAF7z20+3l1mI9ENWIJSZdA+rsa+x6h2Q6VFtDr6sJuuqu6C8S
	 4Oms35JBfikY0StLpEhiyD0iJR4dOrrtBWlt1/8pUDMRpJuT1oXxwCpuyZq46dinwi
	 8quVbk5OdCJdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] dt-bindings: input: microchip,cap11xx: Add
 CAP1114 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260617150318.753148-10-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
 <20260617150318.753148-10-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 21:15:59 +0000
Message-Id: <20260617211559.C15D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Schema Validation Regression (Incomplete Constraints Update)
--

commit 74e08f50d786114a66be01956a59aeb6b7083fbc
Author: Jun Yan <jerrysteve1101@gmail.com>

dt-bindings: input: cap11xx: Add CAP1114 support

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support. Add the compatible string for CAP1114, add
its datasheet URL, update the maximum of LED channel reg, and add
constraint for linux,keycodes.

> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index b97e5b2735f1..2a37ac252c37 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml

[ ... ]

> @@ -140,7 +144,7 @@ properties:
>        The number of entries must correspond to the number of channels.
> =20
>  patternProperties:
> -  "^led@[0-7]$":
> +  "^led@[0-9a]$":

[Severity: Medium]
Does this global regex update also require an update to the disablement blo=
ck
for hardware variants without LEDs?

The allOf block that disables LEDs for specific variants (like CAP1106,
CAP1203, etc.) still uses "^led@[0-7]$": false.

Because of this new global regex, wouldn't nodes like led@8, led@9,
and led@a now bypass the false constraint and be silently permitted on
devices that are supposed to have zero LEDs?

>      type: object
>      description: CAP11xx LEDs
>      $ref: /schemas/leds/common.yaml#
> @@ -149,7 +153,7 @@ patternProperties:
>        reg:
>          description: LED channel number
>          minimum: 0
> -        maximum: 7
> +        maximum: 10
> =20
>        label: true

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617150318.7531=
48-1-jerrysteve1101@gmail.com?part=3D9
