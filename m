Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B973A641F;
	Fri, 18 Sep 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717019; cv=none; b=a9vwbh4FnzM4SgXiHdsuuFItODk7MGtydurb6nr6phW9FyyQQzGYGpVDqOpLBfs3MRrwgpTElScmvgxuNYZVAZMnBo0xBHccz51QPQD923Qlg+bGoHoHSdwYiMXxFkQsdCyuI0J0wu0Ozfve1gTWLWhx44Mx8Fiv/mPGireaPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717019; c=relaxed/simple;
	bh=8ZQoph177gzc0XynIInF9rdWFQGY1RqAuoZwr7hb2P8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tGc/xF7ZRgvtGHP0J7lwM0+iBAaktEzpjT4qnhHvVcWtj4235h5PfkrFv+tX9Nq+DDoPvGW5rcCPpSwrCr0vzaNFJzs2L+xOHjDusccxz72zxenXgIsuVJxWnHWs91LxRCua34DfFrERwHE/aWD5ilsjfcQCs0WRfe2FpqXiiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM/hW2UO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM/hW2UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E75B1F000FF;
	Fri, 18 Sep 2026 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789717008;
	bh=Y1uLT8fbmqMuUX3tqd/YBdA25g7iFOWHtLjbyLuYv+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aM/hW2UOem6qslcAD5FieGz9nAxbTvVmusDN+EiCCTWu6w++fB8nsoxeh5QmyO66k
	 +/L6XpKNkq7mKH2ojH7tJbmfI1CGrB+oemkfSAG+pCPzTjYYE6C1bbB112UTSAEf2h
	 fTYin5HxECf1VawRNZYlRnWfZKJ37DTqo6tRBAcPHLd0LKHImXgrYhCi/VO7YY3zCq
	 s9c8+TAnnX6pPim/SYtv4vPGen0Q3TGLOrHw+nmzX07iz1aNy+SQqBYEwckIfLaOEn
	 959eiGg2z/gqXLIE/IuUu2hXTijgM1/e97ILM3bYtRNyivnQiSkNFqmUZKyV6tZnJz
	 1qfwYuwP3RHWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: input: touchscreen: document ESWIN
 EPH8621
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260918-eswin-eph8621-v3-1-514eb1f622c0@fairphone.com>
References: <20260918-eswin-eph8621-v3-0-514eb1f622c0@fairphone.com>
 <20260918-eswin-eph8621-v3-1-514eb1f622c0@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 07:36:47 +0000
Message-Id: <20260918073648.3E75B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: eswin,eph8621: redundant properties via additionalProp=
erties
--

commit 46b2080091d009fd58f47b811d02fd1ffe2a1da8
Author: Luca Weiss <luca.weiss@fairphone.com>

dt-bindings: input: touchscreen: document ESWIN EPH8621

Document the ESWIN EPH8621 touchscreen controller, which can operate in
SPI mode. Other touchscreen controllers from the EPH861X family (and
potentially also EPH8621) can also operate in I2C mode, this was not
added yet.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/eswin,ep=
h8621.yaml b/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8=
621.yaml
> new file mode 100644
> index 0000000000000..ac7fa58644ba6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8621.y=
aml
> @@ -0,0 +1,79 @@

[ ... ]

> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:

[ ... ]

> +  vddio-supply:
> +    description: Power supply regulator on VDDIO pin
> +
> +  spi-max-frequency: true
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-swapped-x-y: true

[Severity: Low]
Are these redundant property declarations necessary? Since the schema refer=
ences
touchscreen.yaml and spi-peripheral-props.yaml in its allOf block, these can
typically be omitted if unevaluatedProperties is used instead.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - avdd-supply
> +  - vddio-supply
> +  - touchscreen-size-x
> +  - touchscreen-size-y
> +
> +additionalProperties: false

[Severity: Low]
Would it be better to use unevaluatedProperties: false here?

By using additionalProperties: false, the schema explicitly prevents proper=
ties
defined in the referenced schemas from being implicitly allowed. This force=
s the
redundant declaration of properties like touchscreen-size-x and
spi-max-frequency above, and it inadvertently rejects other valid,
framework-supported touchscreen properties like touchscreen-fuzz-x.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-eswin-eph8=
621-v3-0-514eb1f622c0@fairphone.com?part=3D1
