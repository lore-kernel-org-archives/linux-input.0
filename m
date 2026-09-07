Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A2472F84;
	Mon,  7 Sep 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778824; cv=none; b=C0YDaWbJom/Bf4zm+CQ65u5q4xxj/EI6m6xqBHA54o1hgK1t8MGMjmjewAs55PG15K+ZPhJchLrT5Fvh12L/KywM37rI3wLZ9ooq8SfBTpVb1+rc9c+Sz45XjNnvfldTekYfo8FaBMRQHCjxs0uK0Nql+KumGBJ6i2IGUQ+tSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778824; c=relaxed/simple;
	bh=44uqOGoPp18Zxz/PSOh8dGSa2bWQrq0Caz6jn18paSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsOCDcsV9Ozc7+2Ip7ohTawbTL1QUNl3etGiW4ArAHXNMgVYHJ11VAdzMCXYPQ0Wv2FMNRho1wzJTgC6oUowXFCynSbUfa23QXsbLs8/xVQakitKOWDiAz366RE+3T7C7LeiQ6cJj+mccR/twuVXUFAXkBns/6MkmcuNLQSxBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCczSf4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCczSf4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCF1F00A3A;
	Mon,  7 Sep 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778823;
	bh=y7O4hYXmpu+NFuaRFLgi0plLjb11oJlDC8LH3F5UP8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCczSf4pUBzhEY9cs5ZeSTR8725uNb7eHRLGecbxt00nCkEr9P+OfdzmDQ5v4ukz+
	 kLfknO3q5XF85wsl4wx4OOFYtxv3lkFQ10lKkniZv8QwUPzJ8vh0InOFElapLdQeDj
	 xqr/U2HKJqZQghuVLtXZ7+1kfywngZDv0G25pWwyQXA1TWEhleTdY0pcQSkxcxsXBQ
	 O98HROvSz37xPsrlIi3W2RvOIhro9tyXtQeA0ddwzsWznkEGDR+ic3VzNM4mEDbZZB
	 UDmrrwx6PYXdfvDZV/5UCAaCsKGV7Wuzt/cTleXcpitAFzLL6fMESkYYp3pizlV53h
	 Sa93Pt+TzM5NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260907-stmfts5-v7-2-4a53381cd038@ixit.cz>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
 <20260907-stmfts5-v7-2-4a53381cd038@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:00:22 +0000
Message-Id: <20260907110023.03CCF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The conditional block restricting 'mode-switch-gpios' is missing=
 the 'contains' keyword under 'compatible', which will cause it to erroneou=
sly evaluate to false for all devices and block the use of 'mode-switch-gpi=
os' entirely.
--

commit 30e556decedf2eedf468c2bb05ec4af06f53437e
Author: David Heidelberg <david@ixit.cz>

dt-bindings: input: touchscreen: st,stmfts: Introduce STM FTS5

This commit introduces support for the STM FTS5 touchscreen variant to the
existing st,stmfts device tree binding. It adds the new compatible string
and introduces an optional mode-switch-gpios property specific to the FTS5
variant.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmft=
s.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> index 64c4f24ea3dd0..3de4bc5cd3f78 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
[ ... ]
> @@ -51,6 +54,17 @@ required:
>    - interrupts
>    - vdd-supply
> =20
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            const: st,stmfts5

[Severity: Medium]
Does this compatible string check need a contains directive? Because the
compatible property is globally evaluated as an array of strings in DT
schemas, using a strict const match here will always fail.

As a result, the not wrapper will always evaluate to true, unconditionally
applying the mode-switch-gpios: false restriction to all nodes, including
st,stmfts5. Valid device trees using st,stmfts5 with mode-switch-gpios
will likely fail dt_binding_check.

Should this be written as contains: const: st,stmfts5 instead?

> +    then:
> +      properties:
> +        mode-switch-gpios: false
> +
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-stmfts5-v7=
-0-4a53381cd038@ixit.cz?part=3D2
