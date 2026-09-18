Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D04AA574;
	Fri, 18 Sep 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730113; cv=none; b=B/T+PV4JojZkoPF6e9njbLDvcWkibd31HenNqj1cF3gC9gAcnD4eINJESQQEhFow/iKs29K9os+QsmQrDNSEVvtLRF5Kb820Dk+BwiQE57zeg9wMyi+SBMXKWXS0TYU/MiSO9yzlrDYLRAlxdwiuJlFvGDlfWJDVqUG/vPDfoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730113; c=relaxed/simple;
	bh=GaFLWzbzzqHn2jpMrsnfsH69Z3hdXBFKaw821MHywkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G73R2emd3xMau8OLbdlbBF6wEY99zi8/+EpcKSbIHIS+Y6neTnd0zmnaB9/SAydGSRa7MEGhW+ospAAZo9SPS1H4mx7IhocROvG2v4ESQOgNfiUG0xw4Gr3mrs07ujxnJEp36/CSRGFTxmEIbvoxC3lc8kAadsCVkzE1D3yzbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltYBR35J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltYBR35J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF41F00893;
	Fri, 18 Sep 2026 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789730111;
	bh=0Del7XIJZWKDZLTWU5zXsLsQ7pPAg9L1B0B5kXSNbAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltYBR35JQT0COzl59jtBxXKrDAM6UPEcRC0B1HbFaFoStnrJytRkNA0QfzEf5S/Te
	 COCHUSXaHFH5MICHaASaOklAgqiDh9qDCzE67CyiAXFcPOrFyndYN5Fw2kfOgniz0j
	 c779tNRFg2ms8mG2Fihw/DyoMoCwZ/lwSYXiM90B9+iTy7+u5Iywe3X6oSICMH8U5G
	 j0vdGcRCgXn1Ds9dT7YohJyZMNNBYdZ1BrN9SJx1tJfbdHav10MwOhDF53SV06nY+k
	 LsuvPs3jYBidGYtsHq9bzBe3C6y3kxqREyBhS7pEFwTmNmJP8KPqCbesYU8YLiN28/
	 tDKh2JWc9Xz4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260918-apple-mtp-keyboard-final-v2-4-a5c685e50b60@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
 <20260918-apple-mtp-keyboard-final-v2-4-a5c685e50b60@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 11:15:11 +0000
Message-Id: <20260918111511.7BAF41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: custom property hid-country-code lacks vendor prefix
--

commit 2849d54fecdf9f3ef276d3d92e80cfd4525ca96e
Author: Michael Reeves <michael.reeves077@gmail.com>

dt-bindings: input: apple: Add DockChannel HID transport

This commit adds the device tree binding for the Apple DockChannel HID
transport used by internal keyboards and trackpads on Apple Silicon. It
describes the required RTKit ASC mailbox, DockChannel mailbox, and MTP DART,
along with optional STM and keyboard child nodes.

> diff --git a/Documentation/devicetree/bindings/input/apple,t8112-dockchan=
nel-hid.yaml b/Documentation/devicetree/bindings/input/apple,t8112-dockchan=
nel-hid.yaml
> new file mode 100644
> index 0000000000000..c25e072b68687
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid=
.yaml

[ ... ]

> +  keyboard:
> +    type: object
> +    properties:
> +      hid-country-code:
> +        $ref: /schemas/types.yaml#/definitions/uint32

[Severity: Low]
Since this is a custom hardware-specific property inside the keyboard node,
shouldn't it include a vendor prefix to avoid namespace collisions?

Device tree guidelines mandate that hardware-specific or driver-specific
properties that are not part of a standard generic schema must be prefixed
with the vendor name, such as apple,hid-country-code.

> +        description:
> +          HID country code for the keyboard layout variant.
> +
> +    additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-apple-mtp-=
keyboard-final-v2-0-a5c685e50b60@gmail.com?part=3D4
