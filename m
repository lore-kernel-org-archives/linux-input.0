Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC643F4AF;
	Thu,  1 Oct 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852560; cv=none; b=IWwMi09FuXoRweJq9loznNX3ZzAve7BscqtCamBR/ZBdNBoI7m9PvwIw+hFYufiNoCVg5MN/meWRgKK1z66YYM7g8aFcgAmgc+/88JR8kPn+xKxVi1BA/F/dglpCBf1f/Nl3MHsXzWcUjPuOD3TnwpZt4kndBPVdtJKhfrMDxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852560; c=relaxed/simple;
	bh=6jqhue7Pr1raul2URy4Rmi+yWvGbQ5FeFqOFT1WVFSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U2AFFxhrDHZvlDej3CzQazZsHAG7BpK+6NK56kKqVkiPh8/k/kIc++373dX/off6p7BD+Uv7PxkGk4kDrNwxFZnsE7kLjx4MDsOAnPm1PFJ7NirBUhdQg/DZKlP7mmSzl9Gwr9H9vx2FHS3hNHGAWpHhZ5keRKe7ZiSlHD8StxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZcASYTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZcASYTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FB61F000FF;
	Thu,  1 Oct 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852555;
	bh=/hUKXWkLFn4ibUCquv1pSNwugRZJ/gX7PSj9h4lioig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZcASYTYdqdjLutSonii9y9SUOPtW6ZSSkygW/cqeoKW4vdOnVKUSpmf8eJUNfruC
	 EhBWLnmiH/453BQohL50yfm8wHYOtTmC88iVYvfHpnMcQd2yQkU0y7knqYDcDmF9Cv
	 8t5k9jliDZVslK/yA02OHHd3QiPNewqExxJLnrGtCzv3hnl6EUoDa+Qd0+ZZSwO3Tw
	 wN21RtgFtfk0e+H6DjtkHdQM/CbHjfczkIOkKGO5XDRtdhugy2bxYTzrTlq1tHtnEL
	 yCZhxq+P/u8C06elGmEzgcVLr/nHdF1cE+5oc3Yh+2Q4elRU0BdvoHS8PUSEIYj3dB
	 PKRfT8tAOD20A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: input: touchscreen: hynitron,cst816x:
 configure axes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <d18629ede3f2fd5a08d0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org>
References: <cover.1790851590.git.daniel@makrotopia.org>
 <d18629ede3f2fd5a08d0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:02:35 +0000
Message-Id: <20261001110235.63FB61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: incorrect use of additionalProperties with $ref
--

commit 0f12b787d0fbdb216a571a789ed3dfa0d0a368db
Author: Daniel Golle <daniel@makrotopia.org>

dt-bindings: input: touchscreen: hynitron,cst816x: configure axes

This commit references touchscreen.yaml and allows the properties
touchscreen-inverted-x, touchscreen-inverted-y, and touchscreen-swapped-x-y.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron=
,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitro=
n,cst816x.yaml
> --- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816=
x.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816=
x.yaml
> @@ -36,6 +36,10 @@ properties:
>        - description: Slide right gesture
>        - description: Long press gesture
> =20
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-swapped-x-y: true

[Severity: Low]
Looking at the properties block in
Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml, =
are
these redundant definitions a direct workaround for the improperly configur=
ed
additionalProperties keyword below?

> +
>  required:
>    - compatible
>    - reg
> @@ -43,6 +47,9 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - $ref: touchscreen.yaml#

[Severity: Low]
Looking at the allOf block in the same file, does the combination of
additionalProperties: false and a $ref create a constraint collision that
restricts validation exclusively to locally defined properties, breaking pr=
oper
schema inheritance?

If a valid generic touchscreen property (e.g., touchscreen-size-x) not
explicitly listed in the local schema is defined, running make dtbs_check
will incorrectly reject it. Would changing additionalProperties: false to
unevaluatedProperties: false address this when inheriting from another sche=
ma?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d18629ede3f2fd5a08d=
0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org?part=3D1
