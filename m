Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54A2253EB;
	Mon, 10 Aug 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375842; cv=none; b=e85jk628qinggcaBUcPEBS3x15Q27XnjdSBQMhiMY+Hn6PP3OTgrmpjliPLbYGd1JALxrX/sYCfMWn8f9X0ddD5K2fVXUvS+E51aOVQdR0j6iQqbECv7hq8PKp9oIyuXNhIHGRYaXWjD8ogJma1bJqfOmiG8imo2wI6xcDz7ogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375842; c=relaxed/simple;
	bh=IFY0p7kt47Mm2uL5L96+uab5iS4HXf1VuTsWCKpj4fA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HP4LwsQVn13rgI7nfgFjiVukvIcKyphIQWtlje9uSWDh/Ovz0E9+EFrG9Up5b+Xl0c33njkSBzFWN9leHZZ5POaw0W92Jn8FFPrj1+iyAuFyE5V3W8rw8TI5ckiMLbDkCFM83iFEmvd1iCLbzSc2Na3ovS0vZGct9t/zFK5/YSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltVDYcYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltVDYcYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22421F000E9;
	Mon, 10 Aug 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786375841;
	bh=UQ+6OKffkYtv77bD6xX2cud9h+tG7NsHnR0sr9I4Nn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltVDYcYvdZOjqusez6aXkdqn0UD5PJGUfFB1WXxrlKIqTvfAdsSc5Ay0K6+e+8kvV
	 +cvyajpqu7ZgwLkIDVkP8CoBpASrXCSmSHPxqS/7t2FxWISAF9xOOk/CZLeCumxR5X
	 NEQpqwLE2hIFQaLoquic9xSEorNmZ9/teI/78zez+r+KF9t+DgDzFANrHKmWKx4NHx
	 /7DH9VGxfpBoYsGZTjyAcx2x5fAv6DUSpMSj54S8HQL36/kdEB05OcDVYXz75Tsx9D
	 nKVWxZyw27pekpQWANZjL7xG1hEtNHGm9a7TPNeIhqueMTbukN9DyJZiBu5bctWtfT
	 X9gL5/mTZMqOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260810-stmfts5-v5-1-0c737d929976@ixit.cz>
References: <20260810-stmfts5-v5-0-0c737d929976@ixit.cz>
 <20260810-stmfts5-v5-1-0c737d929976@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:30:40 +0000
Message-Id: <20260810153040.A22421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Schema validation logic incorrectly disables the `mode-switch-gpios=
` property for all compatible strings due to a missing `contains:` keyword.
--

--- Patch [1]: [PATCH v5 1/3] dt-bindings: input: touchscreen: st,stmfts: I=
ntroduce STM FTS5 ---
commit 38a7826302d5c029e7cdf3f5bbdf93b5ab26d21e
Author: David Heidelberg <david@ixit.cz>

dt-bindings: input: touchscreen: st,stmfts: Introduce STM FTS5

This commit introduces support for the more recent STM FTS5 touchscreen in
the device tree bindings. It adds the new compatible string and an optional
mode-switch-gpios property for the FTS5 variant.

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

[Severity: Low]
Does this conditional logic work as intended for a string array?

Since the compatible property evaluates as a JSON array of strings in
dt-schema, comparing it directly using const: st,stmfts5 will always
evaluate to false.=20

Because this is wrapped in a not: block, the overall condition becomes true
for all nodes, meaning mode-switch-gpios: false is applied unconditionally
even for the st,stmfts5 compatible.

Should this use contains: const: st,stmfts5 instead so that valid device
trees using this property are not erroneously rejected during schema checks?

> +    then:
> +      properties:
> +        mode-switch-gpios: false
> +
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-stmfts5-v5=
-0-0c737d929976@ixit.cz?part=3D1
