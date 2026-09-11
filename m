Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABA46982A;
	Fri, 11 Sep 2026 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117140; cv=none; b=Ftr1klFqnv5sQPuVdaFC7qwf9MD40ZNCnnEUsqNdMyPBQc87to/PoeeMyfneJ8gzGQK3tSA4eRrJpGD1In0H70em2I/mhkyxPW0dFfvg+FbB3GITAqMiYvxeQkBTBfMIJnPl78TDczZhj8BnEgoPALbeJuHwFUGvdAHsYWm3Hyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117140; c=relaxed/simple;
	bh=cr5bTeQSjnsO7cabtVXOtBWVrF9FyPu02Knfq5F4Qfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HKbZfAm/A2TL+LC4hpCJ+z6Fpc22jtAYdtV4VKmEVY/mKevQNKvKk0cOyF4b67x2AUpWj/AbCR3Wiaw1y1oGP+E25ACQQpPxzEyoC5kzUVcezTNJHU8XHLyscfabpUR/WONMTasZorC0aBXBFZ5SvG+yW9BJUBNaYqFAqaD0fAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8wQ1oKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8wQ1oKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E271F0089C;
	Fri, 11 Sep 2026 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117138;
	bh=5tPuc2ps1jfYPQ+gl4Rr4wTdILWDC3yJuAz3rA0C+O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8wQ1oKwbzjMG87pb/D10CiDYiDgDhy4qS6nEueP7KRvGC01krRSlmDY0U5enmD9B
	 CLSqoogXgNw1L7X5GNIOuC9ey8s7K/pzlZJyIUoIyEV9VV6+mYFfITLTy3WK9T9Kl+
	 Wqe1LX21eDZwy+rFE8lazzmgDHVVtSltS6q9pIyl3U/XaPARfJKxryIKy0Yl/GRCHF
	 bzmjbQbDx+/vbTlteORjqJ28+rGW9b+TLIBamhbi94sdBgtlZdbjOz9rfrdcwH3fv3
	 DELJNz27h1C5XhPDufcALtGd+Q03A/y2FbU5vlmN2eaONMFQTXUOyIPyf/wgSOti68
	 8xBtLllVWsmLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/10] dt-bindings: input: touchscreen: add Novatek
 NT36672A SPI touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-5-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-5-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:58:57 +0000
Message-Id: <20260911085857.F3E271F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Device tree schema conflict for the 'novatek,nt36672a-ts' compatibl=
e string causes `dtbs_check` validation failures.
--

commit d198703693d9ad88fe332afc5287a4b5bb64a630
Author: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

dt-bindings: input: touchscreen: add Novatek NT36672A SPI touchscreen

Add devicetree binding documentation for the Novatek NT36672A SPI
touchscreen controller.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/novatek,=
nt36672a-spi.yaml b/Documentation/devicetree/bindings/input/touchscreen/nov=
atek,nt36672a-spi.yaml
> index 0000000000000..0d89d60f2a93d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/novatek,nt36672=
a-spi.yaml
[ ... ]
> +properties:
> +  compatible:
> +    enum:
> +      - novatek,nt36672a-spi
> +      - novatek,nt36672a-ts

[Severity: Low]
Does adding "novatek,nt36672a-ts" here conflict with the existing I2C
binding in novatek,nvt-ts.yaml?

Since "novatek,nt36672a-ts" is already bound to the I2C schema, and both
schemas define unevaluatedProperties: false without a custom select rule
based on the parent bus, nodes with this compatible string will match both
schemas simultaneously.

Will this cause dtbs_check validation to fail for existing I2C touchscreens
(which lack SPI properties like spi-max-frequency) and new SPI touchscreens
(which lack I2C properties like vcc-supply)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D5
