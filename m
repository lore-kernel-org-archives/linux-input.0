Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631C196C7C;
	Thu, 28 May 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947061; cv=none; b=l5uCUXG5+DZ9QcH4opTp2Jh8ked/tgbmqtpv+UmoiEuhaD+yk4HV2+mPzxL8GxILyjsrB7DW57xHnpn0Tn7SxfssNIlcwMZ5te08v/ubeL1fY6CFAIobr5fqEEsZbI8MeiXv4z4tIp8qfUyQWtGye8CmNDOCTUydGq2LH0WQV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947061; c=relaxed/simple;
	bh=ZKMcHvRvxWihPBYk1Iqx9lY0jP3ojmEzKrO53ZTZ1DQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dYgxdA2pvSoa/YKjPoKJ4KwX86VpSvc95beY/ihFAhtsFlT4J60Hqhl5c5oQbu6wuYqlFMGgiP++mqtsxLvoJOHl573Q5qj7SpT1ODebONyzxuZWRB03JRAjR7/W6t+6fPjZDNgXxtAJLZxiq8NYU914yMIGbdykkLi4sWYq6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDn7yLNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDn7yLNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7298E1F00A3A;
	Thu, 28 May 2026 05:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779947059;
	bh=0aj9R+k6BlIEExCpdMy1Jqx+NcDKiSyaqtZT4Sj4zjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDn7yLNl0UNkHy7KfZoRhF0bL32yRWJ9Wr0gOH4Mz1z3eHaZb05Sgh3Q633sNJoQM
	 2Kfo+rqBRtsUCAGJqzyS4+M3/E6aHvtN0paP2er18RXOAoDkeUL7I6J3Q1dQcWnxkr
	 S/s3596btYyYb3JkouV1EHj87Y+asI4rGE8eAOEGHj73D5yJ8/FWHeV1LPgZMgq8D0
	 nkdCgKt/PoH4W1nCUMzo7oxWgrqrfTNduOf/mUdI+TIny3FvimWWRNHN0NjUKv3PTN
	 QPZywPDPtoCbYcZlL6SWUcF/0/wB+D+VYHC9yvHmPwUAxKUYAn+bXUzMsJE1eLJ6jz
	 40CmMfAQ4aYYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260528053203.9339-2-clamor95@gmail.com>
References: <20260528053203.9339-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 05:44:19 +0000
Message-Id: <20260528054419.7298E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The 'reg' property array lacks an explicit upper bound ('maxItems' =
or 'items' list).
--

commit 51056b233d45625f7f08ea91a021eae296836600
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: embedded-controller: document ASUS Transformer EC

This commit documents the embedded controllers used in the ASUS Transformer
device series, adding a new YAML binding for the Nuvoton-based controllers
found in these tablets and docks.

> diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,t=
f201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/as=
us,tf201-ec-pad.yaml
> new file mode 100644
> index 0000000000000..60b6375864aaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec=
-pad.yaml
[ ... ]
> +  reg:
> +    description:
> +      The ASUS Transformer EC has a main I2C address and an associated
> +      DockRAM device, which provides power-related functions for the
> +      embedded controller. Both addresses are required for operation.
> +    minItems: 2

[Severity: Low]
Should this reg property also specify maxItems: 2 or an explicit items arra=
y?

While reg-names restricts the size indirectly, standard dt-schema meta-sche=
ma
rules generally require array properties like reg to define strict upper bo=
unds
explicitly to pass make dt_binding_check without warnings.

> +
> +  reg-names:
> +    items:
> +      - const: ec
> +      - const: dockram
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528053203.9339=
-1-clamor95@gmail.com?part=3D1
