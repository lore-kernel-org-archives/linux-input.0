Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02761E633C;
	Thu,  9 Jul 2026 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573562; cv=none; b=LErXZj01GEzJzjiN69aTx7vEsbONgQplDREiMvanuMXG6Fku1DISr6s+TKZrII7Y1Etqo0eHJjxWIuLhuxOaFdaSzh4rvF38rQGJuy+Bqk9jKDefEAfIBTauXeWsEVH/ltQLLZ8Ot4Rz5qAN7mhdrUlM0N4DxsWdSsJe0ZrWhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573562; c=relaxed/simple;
	bh=CSmc0xYxo9ylDGsqpjX0BDN8/YBaIQPk0QW+j4CNFHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RDXzMjjf2x/CfgktSMWL55aJZ43pmu6Ju62/laow3eeOvgtmfNoG7E4iVbeRiD2YXbtOAEGdTAuj11ygeMUey783VfquHYDU7e0hXeq1h8iJ6r1h2ws2wmv1uYl/Ub+HB7TIhYvPw9YSwhC3wyV4LBNw5vFDfX8yc3oitnvRXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm+mPUBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm+mPUBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EF31F000E9;
	Thu,  9 Jul 2026 05:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573561;
	bh=Q9Z4TE3ce9DcEfNk6etufiZcW3QfnfUe2Ho2iXRCbtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zm+mPUBCkUpiBGdbdY3ZIR3oNMJOBczV69TfSJB4tQIZh2yemXZKHvXK+K7ZAXQTZ
	 Ulxg2Rmpp/rb4JMuebF2+Q5nKx0FN2F209R8NUvICS1oyWU1j1AWhQyG4G/QWDddmv
	 b6Sr4C3bzHZeqsPeHsaKLSrHc7Q9T0TunXi9tFLqRXA3/ygkbTm5iGR5m3LT46v8uz
	 BAPz9+IYby+bOMuxwjTLtHO1uirbQH7hlZEcRg9XDzjP9qC43NY7N/iSU/hFeQJuAc
	 aKNsG862CLa5fL/LdvT9e3ARgA7WVUIOlp/Cw8W2kcboE78sr951c2poLnwsHt7D5h
	 fRkX4zn0qZIZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: input: samsung,s3c6410-keypad:
 introduce compact binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260708-samsung-kp-v2-1-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
 <20260708-samsung-kp-v2-1-3c6ed4c9b3b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:05:59 +0000
Message-Id: <20260709050601.18EF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Driver fails to probe and skips keymap parsing when using the newl=
y introduced compact device tree binding.
- [Low] Suboptimal workaround for schema validation when importing matrix-k=
eymap.yaml properties.
--

--- Patch [1]: [PATCH v2 01/11] dt-bindings: input: samsung,s3c6410-keypad:=
 introduce compact binding ---
commit b727e1653e0c43f9e2d755869527a44de705430f
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

dt-bindings: input: samsung,s3c6410-keypad: introduce compact binding
   =20
The binding with a sub-node per each key is very verbose and is hard to
use with static device properties. Allow standard matrix keymap binding
in addition to the verbose one.

> diff --git a/Documentation/devicetree/bindings/input/samsung,s3c6410-keyp=
ad.yaml b/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.ya=
ml
> --- a/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
> @@ -37,6 +37,10 @@ properties:
> =20
>    wakeup-source: true
> =20
> +  keypad,num-columns: true
> +  keypad,num-rows: true
> +  linux,keymap: true
> +

[Severity: Low]
Is it necessary to manually declare these properties?

Since they are already defined in matrix-keymap.yaml, using
unevaluatedProperties: false at the end of the schema instead of
additionalProperties: false should allow them to be evaluated
automatically without explicitly listing them here.

>    linux,input-no-autorepeat:
>      type: boolean
>      description:

[ ... ]

> @@ -81,12 +85,33 @@ patternProperties:
>        - keypad,row
>        - linux,code
> =20
> +dependencies:
> +  linux,keymap: [ "keypad,num-columns", "keypad,num-rows" ]
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> -  - samsung,keypad-num-columns
> -  - samsung,keypad-num-rows
> +
> +allOf:
> +  - $ref: input.yaml#
> +  - $ref: matrix-keymap.yaml#
> +  - if:
> +      required:
> +        - linux,keymap
> +    then:
> +      properties:
> +        samsung,keypad-num-columns: false
> +        samsung,keypad-num-rows: false

[Severity: High]
Will this cause the samsung-keypad driver to fail to probe when using
the new compact binding?

If a device tree drops the legacy properties as mandated here,
samsung_keypad_parse_dt() in drivers/input/keyboard/samsung-keypad.c
will fail to probe the device:

samsung_keypad_parse_dt() {
        ...
        of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
        of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);
        if (!num_rows || !num_cols) {
                dev_err(dev, "number of keypad rows/columns not specified\n=
");
                return ERR_PTR(-EINVAL);
        }
        ...
}

Additionally, will the driver skip parsing the linux,keymap property
entirely?

The driver currently sizes the keymap based on the child node count, which
is zero for the compact matrix binding:

samsung_keypad_parse_dt() {
        ...
        keymap_data =3D devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
        ...
        key_count =3D of_get_child_count(np);
        keymap_data->keymap_size =3D key_count;
        ...
}

This causes matrix_keypad_build_keymap() to bypass parsing the linux,keymap
property, resulting in an empty keymap.

Does the driver need a corresponding update to support this binding change?

> +      patternProperties:
> +        '^key-[0-9a-z]+$': false
> +    else:
> +      properties:
> +        keypad,num-columns: false
> +        keypad,num-rows: false

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-samsung-kp=
-v2-0-3c6ed4c9b3b6@gmail.com?part=3D1
