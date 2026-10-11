Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A644A3F3;
	Sun, 11 Oct 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723219; cv=none; b=FeJCpGnSpOPu9AcURBjBeegavuHorr0mW13dFiYgtsesi1xkgkRjYqJH3dq6nrxSgzi4+8jBagb9Q898Yy496h9rlEQmokbx9VKk9T5H+61tjRcnRmljpvCBuCYHnAGD26z5R/mQ+CGMbGbBZNlwpIR+cjIzri5NrQtCPMTPA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723219; c=relaxed/simple;
	bh=eNhgn7/ENoI96xjYGD5lJxJWy2Q1q4hFzrUXfImRFVo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DLLQmLoJ2gcWztatU7ZzljywK0TPPXCtOxYPo5PAuB7WFNZZ1Tm9jARWXeEFEehRawMXp+OInNL8RRa/bWhcn39Mr+4EOFf0KiITsXku1qzfkCkM7jGvyEPA389mrfwceMBA0SMXB/fz0Bg/TrgQYIFslgGge8sXbuNjnIk0UKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYgG1hpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYgG1hpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D50E1F0089B;
	Sun, 11 Oct 2026 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723217;
	bh=Mr85LdfHSYtOyRLpsIzxq5zWTiQfhtBgCzmso2uO/io=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WYgG1hpoKb0bK+to1y8sy/z5BDdUCPajALZReuQoG3YteP97vyTWGBtkZDNKEKU/N
	 1H2aiYp0nvSmtEUnjZJMdaoj5Qz6CpEbhfIUkkSHAttorAaSUJwSxeGRv0YNe9bFKF
	 mkAEBPP3WaZiZ4etI91CrtoRGiqZerpXPcBfFVwATYgnhdNbnFhNAdjyZHIqS/tceR
	 gHGl2YmFfzDpdBB3EP5tZJUggNC2uwsDGMujWacM/6d+nwJXDNFSh4992jqgw/qrJX
	 C+OsaGg27jCcT7faNzyHOV9HNs7A+ANRXRxaNJsvPhHyKEgOfYmq0OqgZ3dXLNtPJu
	 cQitjbFEhW+9w==
Message-ID: <sashiko-outbox-167228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: input: touchscreen: samsung,s6sy761:
 Add S6SY791 and reset GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Timmermann" <foss@timmermann.space>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-1-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-1-2a9f55159b9e@timmermann.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:53:36 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: unconditional SPI properties allow I2C variant to pass=
 with invalid properties
--

commit ea887456e038f98ac0c943c8af10e4e502dc0827
Author: Lukas Timmermann <foss@timmermann.space>

dt-bindings: input: touchscreen: samsung,s6sy761: Add S6SY791 and reset GPIO

This patch adds the S6SY791 SPI-based touchscreen controller as a variant
alongside the existing I2C-based S6SY761. It also adds support for an optio=
nal
reset GPIO and references spi-peripheral-props for the SPI bus properties.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,=
s6sy761.yaml b/Documentation/devicetree/bindings/input/touchscreen/samsung,=
s6sy761.yaml
> index 1ffd17af3c53f..d24f35038934a 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761=
.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761=
.yaml
> @@ -8,13 +8,17 @@ title: Samsung S6SY761 touchscreen controller
> =20
>  maintainers:
>    - Andi Shyti <andi.shyti@kernel.org>
> +  - Lukas Timmermann <foss@timmermann.space>
> =20
>  allOf:
>    - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

[Severity: Low]
Does this allow the I2C variant to pass validation with invalid properties?

By unconditionally referencing spi-peripheral-props.yaml in the global allOf
list, device trees for the I2C variant (samsung,s6sy761) can now include SPI
properties and silently pass schema validation.

Should this $ref be moved to an if-then block that matches only the
samsung,s6sy791 compatible string?

[ ... ]

>    avdd-supply: true
>    vdd-supply: true
> =20
> +  spi-max-frequency: true
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +

[Severity: Low]
Similarly, these SPI properties are added at the top-level. Does this globa=
lly
permit them for both interfaces, defeating the unevaluatedProperties: false
check for the I2C variant?

Could these properties be restricted to the samsung,s6sy791 variant using an
if-then block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-lat3st-goo=
gle-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space?part=3D1
