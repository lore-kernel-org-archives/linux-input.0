Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18078416D17;
	Tue, 30 Jun 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825022; cv=none; b=PXXyec10Ie0oqntyqhPcI+gQ02OVwmCTbNSoLLE4UUoTu7u/h329z6RJwvQXkX9mX8BxKujW99I9XgBacuVaihPrVPwmkMGkPH+7VtybdAzw8FndnBuD3SCW2mUrs8aJ4R/dmD8xiD0clGRupg+oFY8o8ZXJwotSLH72g7RrTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825022; c=relaxed/simple;
	bh=2DwouDtvhu+LBQwnOw/5wk9oZdseE3IN96soFMzOsf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d4QQeP+MaTwHn9HpOatZBXZXsJy4SJlz4FSH7L7qQsntgSi+K5bbT3TB9QM0FsEUFviXeH/XVeVkXttzmR9Re6GIDOSjZKxoBRVb85uIoHCEiKAfVxtH6ttAENp0HvKK0QmJynENljsw7wIRQFGW3rqYKhtDhW9FNHNkKp6fpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPaPqu1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPaPqu1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D021F00A3A;
	Tue, 30 Jun 2026 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825019;
	bh=sqOiu5B9EF2puSGiP3TqHNAjCpWng7/BEsdp57dPPMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPaPqu1tB+QJA3VIQmmhGTxXPBnbtwnQYTZaFR7dtRABGo4lSOnw/PI37YjwumuCA
	 W2UVbNe1DmEPqBOCzJJE/4dox72gpXKxHLBWYR2kx1PIe0aBsex2qeMjhdIH/vW0IB
	 xZAKhkU+Gy6u5jp7iMguB/7Tns8DGdV+oYx6PEYnDr08sE2SaXyaKPn6Rk/tb7tpf9
	 uP0A5w11uZIaYp6Kl3SRKwiIWiZShiHMBbTjumO1UtgE4fecDgt2hRIU+1GwjPKqx0
	 zaYLLQkCVwxHFsyvWDxmRKOdDbCC4Z1wo0h15cHFzPpKXqUMq+lEjYjbBw3m2TX6tQ
	 BsZuqSX07L6tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves via B4 Relay" <devnull+michael.reeves077.gmail.com@kernel.org>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-4-506d936a1707@gmail.com>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-4-506d936a1707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:10:17 +0000
Message-Id: <20260630131018.90D021F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The custom property `hid-country-code` lacks a vendor prefix.
--

commit 0afec3dbb1ad0bf9e9d68a29699cf412f978e322
Author: Michael Reeves <michael.reeves077@gmail.com>

dt-bindings: input: apple: Add DockChannel HID transport

This commit adds the device tree binding schema for the Apple DockChannel H=
ID
transport. It defines the required properties including mailboxes, IOMMUs,
and an optional keyboard child node for layout variants.

> diff --git a/Documentation/devicetree/bindings/input/apple,dockchannel-hi=
d.yaml b/Documentation/devicetree/bindings/input/apple,dockchannel-hid.yaml
> new file mode 100644
> index 0000000000000..dbba4fc389710
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/apple,dockchannel-hid.yaml
[ ... ]
> +  keyboard:
> +    type: object
> +    properties:
> +      hid-country-code:

[Severity: Low]
Should this custom property include a vendor prefix? Hardware-specific
properties not defined in a generic schema generally require a vendor prefix
(like apple,hid-country-code) to prevent future namespace collisions.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          HID country code for the keyboard layout variant.
> +
> +    additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-apple-mtp-=
keyboard-final-v1-0-506d936a1707@gmail.com?part=3D4
