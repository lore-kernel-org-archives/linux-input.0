Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30233A1DB;
	Sun, 12 Jul 2026 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822969; cv=none; b=PYrF5nliZ3nZ78rNg3n0qm16NwAVws1c4Y6TFJs8HVxtqK89ksJhV0qRmO0tRBHOj6zBKVnvPCZ4PpI9UwTDJ8mxJRLEX1fqNZgYU8utu8JR/TIEnxdg9g9HowvTaOnqS0yL+2uNVXBcuA3IBf/rsh0e71nvyLCRkVycS3do7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822969; c=relaxed/simple;
	bh=ZqWo44/y9Qk+5e/k5HclItbq9ForOE/Xa+oz5RaUYX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJNMq0DX7GxxozYVsvsl15XNMTeaoC7TWw3KBamXq7NA8QddmWk7hcB7qwtXum1ZyIuk3/cT3VdhhPTQIL/96LptEPriZ+dptoMEJ3MDjZcgFTd6+MlKAp8tZraHwjdml6uou6VMggc4xoVVnHj2Plfuj7QO0YiytJPSNvX76HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKeKP8Ew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKeKP8Ew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA181F000E9;
	Sun, 12 Jul 2026 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822968;
	bh=WTvEAKzWwHA0I2PJQcZmdh9HqtSPk1S28+IWFyG9fEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cKeKP8EwvB97s4yXBnKVwa7pSPveuPyfV9yWhADZqJPF009ZYr+1l03inWQm2wLQm
	 8Ww442ZzmAfI3fZ9IPFAUw0hul7H2S8ZVfk08wh8x3ISDN5e1GuquteskhHRZ79yOO
	 us2pjN1RnyeElQCavJ8L1PerzzmY9u3eCy6SL2moXhAF5ant2p9/LnO5UUL0Q5z1LA
	 vmGdrdnzD0RTHdhOmEO9CFa//S8Ot0xP5Ym6UmoqXRZJrqrE8zJ6UYYgWJYlURhrmC
	 /NjQ5QeXnCjEckKUxLkJgy8kDXpl1JnlkqJD+508dxuPIHDt4egCJ89OA1ByAquFSy
	 axMoMuiE2TwUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: input: samsung,s3c6410-keypad:
 introduce compact binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260711-samsung-kp-v3-1-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-1-b2fcaba77aff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 02:22:47 +0000
Message-Id: <20260712022248.0FA181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced compact DT binding is completely unsupporte=
d by the driver, leading to guaranteed probe failure.
--

--- Patch [1]: [PATCH v3 01/10] dt-bindings: input: samsung,s3c6410-keypad:=
 introduce compact binding ---
commit c3ae19e70e1090e5ebc5290a0659633378fd46d7
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

dt-bindings: input: samsung,s3c6410-keypad: introduce compact binding

This commit updates the samsung,s3c6410-keypad devicetree binding to support
the standard matrix keymap binding. It makes the legacy
samsung,keypad-num-columns and samsung,keypad-num-rows properties mutually
exclusive with the standard linux,keymap property.

> diff --git a/Documentation/devicetree/bindings/input/samsung,s3c6410-keyp=
ad.yaml b/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.ya=
ml
> --- a/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
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

[Severity: Medium]
Will device trees using this new compact binding fail to probe?

The new binding explicitly forbids the samsung,keypad-num-columns and=20
samsung,keypad-num-rows properties when linux,keymap is used. However, the
current driver code in drivers/input/keyboard/samsung-keypad.c unconditiona=
lly
requires them:

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_parse_dt() {
    ...
    of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
    of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);
    if (!num_rows || !num_cols) {
        dev_err(dev, "number of keypad rows/columns not specified\n");
        return ERR_PTR(-EINVAL);
    }
    ...
}

This means a device tree written with the new compact binding format will
cause the keypad hardware probe to fail immediately with -EINVAL.

Additionally, if that check were bypassed, does the driver's current keymap
initialization conflict with the standard matrix keypad parsing?=20

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_probe() {
    ...
    error =3D matrix_keypad_build_keymap(keymap_data, NULL,
                                       pdata->rows, pdata->cols,
                                       keypad->keycodes, input_dev);
    ...
}

Because samsung_keypad_parse_dt() currently unconditionally allocates an
empty keymap_data structure, passing a non-null pointer here prevents
matrix_keypad_build_keymap() from falling back to parsing the linux,keymap
property directly from the device tree.

Are there corresponding driver updates planned to support these new
properties alongside this binding change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-samsung-kp=
-v3-0-b2fcaba77aff@gmail.com?part=3D1
