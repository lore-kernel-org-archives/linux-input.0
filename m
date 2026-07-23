Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911473382F4;
	Thu, 23 Jul 2026 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806550; cv=none; b=pQw0sQRFfk8agQDUEK9ySSl9E58xVvDoYrRjxu4arTkHrtgbXRd6V3/hW5Fgyij8lAceI8Kux1wGIC6rUeJwb0FiStvSmUNn0fw3CENEjrt0z57k+LWnpt88ZzC3OR2QUufIKaNi+LG5laRMkL3LlnfQF5EuD25Z+ZOmKitpRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806550; c=relaxed/simple;
	bh=8f6wnLMUYHFrqWWHOq8wsF2bpBxkDPNUZTYscEDGTyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ANMi9ZfyJXvKPA1eV2p365rjroF0HmwKDb4nWwKxywZ4R+h04s5VJNl+DsP1eQbIXwKFjykx26vJdZTqDVlGZ5xXHVkbPZvAeIOh2v+8t8Rd1BLRgnlrLelMUT7ocpTyMeYOK72PUHckPOJCk2NcXDPHMpnMFWxYON1dOefwkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCNWw046; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCNWw046"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349311F000E9;
	Thu, 23 Jul 2026 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806549;
	bh=kyHhr5axBzTjkO/BP6fs+fvrLgi1Urm1wj70MxPO2dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCNWw046vX7Z9G3f/xW2YInPhBBNMHrpmCBbGZ0f2pfW3MPYD69K9XKEOsnqbz/dc
	 fmtNBqXLklDjbzxerjFr36Z2kGkcsYqq5c/RAFw9+dzHG85sXTLiqDwJro+ABHUy/k
	 B7+veKn2gRapDvt2skEIzilTs2+Nem9AA2/Jhp/+3mpAw1PAvjl854zaNr645r7L7S
	 GSiGPIS1gWDdzblanmD+PEt80X4qUoPMuYaWQQFzzvUAzuaOYq6H9kXC1h9KXMvKgj
	 WCkTYiuD+DNvnmpWbHmLxqGvARzn4ScTs+u/GunePYuWjgb0qZ1X23k3ZrEqIl79+u
	 vueuojPvpQClQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: input: edt-ft5x06 - add
 no-regmap-bulk-read property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandre Hamamdjian" <azkali.limited@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260723-b4-ft5426-v1-2-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
 <20260723-b4-ft5426-v1-2-d4b4e32be042@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:35:48 +0000
Message-Id: <20260723113549.349311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `no-regmap-bulk-read` property violates OS-agnostic Device T=
ree design principles by embedding Linux-specific software terminology and =
misplacing parent bus limitations into a child node.
--

--- Patch [2]: [PATCH 2/4] dt-bindings: input: edt-ft5x06 - add no-regmap-b=
ulk-read property ---
commit adbbdf0f113c3cd899e582907d5e795b5a3a7cc7
Author: Alexandre Hamamdjian <azkali.limited@gmail.com>

dt-bindings: input: edt-ft5x06 - add no-regmap-bulk-read property

This commit documents an optional boolean property, no-regmap-bulk-read, for
boards where the I2C controller cannot reliably sustain multi-byte block re=
ads.
It instructs the driver to read the touch frame one register at a time inst=
ead
of using a bulk transfer.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x=
06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.ya=
ml
> index 68b2f16016543..0d8310a290ea5 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -111,6 +111,14 @@ properties:
> =20
>    interrupt-controller: true
> =20
> +  no-regmap-bulk-read:
> +    type: boolean
> +    description:
> +      Set this when the i2c controller the touch controller is attached =
to
> +      cannot reliably sustain the multi-byte block read of a full touch
> +      frame and aborts long transfers. The driver then reads the touch
> +      frame one register at a time instead of in a single bulk transfer.

[Severity: Medium]
Does this property violate OS-agnostic Device Tree design principles? The
property name uses Linux-specific internal software terminology ("regmap")
and the description explicitly dictates driver implementation behavior rath=
er
than describing the hardware layout.

Additionally, is it appropriate to model a limitation of the parent I2C
controller inside the child touch controller's device node? This appears to
misplace parent bus limitations into a child node. Should this quirk perhaps
be handled at the I2C controller level or expressed in a more hardware-cent=
ric,
OS-agnostic way?

> +
>  unevaluatedProperties: false
> =20
>  required:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-ft5426-=
v1-0-d4b4e32be042@gmail.com?part=3D2
