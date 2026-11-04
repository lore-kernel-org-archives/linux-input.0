Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812046;
	b=K84GiPwXhYieEgIKs0eNLBDG54q+Bv4QW+djraHGfC00dynrQHv1MHQCdvTIy2gzF4rp
	 rYqNvwAh2Pr587ewvi2fkyfGF1UnwK8Cj0VqtblAaCOgtTDH6POkNUpu8ljZUj6vOTews
	 CuuAy4AUf5cqH+5Gqj7dvNMFDKbfpbspYGttMzAHiDoX/w9XD4JSYI6XjkU41Pb25QKbO
	 ppOeqcYyNXPAFiEBaxcajNe+ETIEbqQpiBXtRJu3nYQ55DXLHBgLqBN9YAPPt1FZI4Oyi
	 IkimkTvmGucm+DEF8hZ8xIF4lQ6hunyNrkQQCV0XQFX/QRrmYM1wGrq6A8A9rimjRyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bMUeeyqXhx4pYCqyuQF7kp2eRMK2Urk3NMv18j7p/SE=;
	b=D0CSAbi0UW9m2VyMsNu9J3GAHm5Kw7PgAGNFHi9waxE+CH61FAxMyDnHhgI7y/dphrNk
	 U1iPT7chCZFPwTMDyFw93IYrXGCPoEi4VH9KKPGByaPhGlLim06+DxoUgo1XYo7AftA2b
	 +UNu+iU2R3LNw3HfEHmf3YZBS1kh994KqCL3oH3UyrgOpIzgxSVYoxxmlpsD8Tve70Ffy
	 IE1bU/+BFVRl3zwRU2FKjjN8X45ml9MiGZbxAe4BQ+A48KHmrexSDlbpTPP/pZmLwOf44
	 A/OoJF9Ck3TJSRXsZZsLtx+XXLEAGYwZDwVUbtgtMRm0cSEiNd2oIO6pEYRAlWeKFZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTqkyo69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DA606A328
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTqkyo69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174361F00919;
	Wed,  4 Nov 2026 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812045;
	bh=bMUeeyqXhx4pYCqyuQF7kp2eRMK2Urk3NMv18j7p/SE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTqkyo69ViCApLiyEilKq9axDhkWb86tYikv9KWMGT0vy0Khq/oaRdIEpMQNs4ay8
	 NYwl7i8F1FPG9JouTF2kHooaydnC+rmUiWU4JGsEsjHlwXoJZHOURjMPQU5sGCb2zL
	 yyTV62DpZNeqH070VIuZvNKbEdaKoIYBBha5FNioIFfP6kFBPG5976M4ZQ2KcljqGh
	 nn7Xzky5ro8DVpgZm7rZO2oZVau7Z3xouhNmguOIMX4XVkxc4SLwPKFLC7M6yDn7lE
	 gMwJrfZdDd6Nzs02N0olFBCZcxr2BXcr+SK3GFCIUQH4QTTL9ZFOaD+RzCiCyNJc/N
	 4efVUg6bFmH8Q==
Message-ID: <sashiko-outbox-197712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:07:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iio: hid-sensors: divide by zero in convert_to_vtf_format() for ex=
p < -6
--

commit e56afd4fc65e2d177add5e21d5704d17876c53ec
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

iio: hid-sensors: fix fractional part for unit exponents -7 and -8

This commit fixes split_micro_fraction() so that HID unit exponents of -7 a=
nd
-8 divide the remainder by 10^(exp - 6) instead of passing a negative expon=
ent
to int_pow().

> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 26f8554d18a57..22d33f8c25f14 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -98,9 +98,14 @@ static void simple_div(int dividend, int divisor, int =
*whole, int *micro_frac)
>  static void split_micro_fraction(unsigned int no, int exp, int *val1, in=
t *val2)
>  {
>  	int divisor =3D int_pow(10, exp);
> +	unsigned int rem;
> =20
>  	*val1 =3D no / divisor;
> -	*val2 =3D no % divisor * int_pow(10, 6 - exp);
> +	rem =3D no % divisor;
> +	if (exp > 6)
> +		*val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> +	else
> +		*val2 =3D rem * int_pow(10, 6 - exp);
>  }

[Severity: High]
As reported by Sashiko on v1 [1], the commit message notes that dividing by
10^(exp - 6) in split_micro_fraction() matches the reverse conversion in
convert_to_vtf_format(), but does convert_to_vtf_format() also need a simil=
ar
fix for unit exponents -7 and -8?

In drivers/iio/common/hid-sensors/hid-sensor-attributes.c:

static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
{
	...
	exp =3D hid_sensor_convert_exponent(exp);
	if (exp < 0) {
		divisor =3D int_pow(10, 6 + exp);
		value =3D abs(val1) * int_pow(10, -exp);
		value +=3D abs(val2) / divisor;
	}
	...
}

When hid_sensor_write_raw_hyst_value() or
hid_sensor_write_raw_hyst_rel_value() calls convert_to_vtf_format() with a
unit exponent of -7 or -8, 6 + exp is -1 or -2. Because the second parameter
of int_pow() is unsigned, int_pow(10, 6 + exp) overflows to 0 modulo 2^64,
causing abs(val2) / divisor to divide by zero in the kernel.

Should convert_to_vtf_format() multiply abs(val2) by int_pow(10, -6 - exp)
when exp < -6 instead of dividing?

[1] https://lore.kernel.org/r/20261102222309.439895-1-srinivas.pandruvada@l=
inux.intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104165319.1890=
851-1-srinivas.pandruvada@linux.intel.com?part=3D1
