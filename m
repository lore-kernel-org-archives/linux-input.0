Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7603BF69E
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681486; cv=none; b=rnyiOCtZ5z7Tr/FlERfmV1QJlfqoOz5eJnJl+UVKhet6LSO/kQNir69rvVWdefoak3+SfRNBSKqsdBbb+pLlnSjmxAsmfIX0YuYKNDJiTC3clEFlZ1L39N/YlbNgseSq8cQx17TUbCG3IMYcOIWKR9aR6Yr3Mlt7i8vU8BH1glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681486; c=relaxed/simple;
	bh=smk15FfcWWql7E5fWPgGUTDQuao3QrkcraU8CDm7S+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYYZclUExeofSslGT3qZOkZldNaoakvzlYfjSAUMLTb36tsmODt6SlL1CW0i8fZLCPmAnHJslZlIiuwE0x7zYwnIsjWZlRD9Njeulcr5M1DwVsctu3rLkUm+T9UL8Lobdg4j9QluHiAcDJ3XtuiPHTxlhz4CXz+FibWD7UmdUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7KdYiLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7KdYiLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADFE1F000E9;
	Wed, 17 Jun 2026 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781681483;
	bh=w29vM9ot0cyPh3mZsI/r8AU19GPk+9ZqRnwyKHa7q10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7KdYiLezD/NW9fudzXGmg8SZaHnAM0hFJS8u+evzXJ1bokXBXu1en+RwMTtBD4NZ
	 08hgQxy9/k/AhAP3V2NzBm6Wwuot/FIo3guIfKAHNv5t42LNcsCcLgpGjJ5AqsX+N6
	 EviJLuO+O90a3oOPTEdax9q0MWkBmoUU1sie94sXN364ZBmPxQjVVvyjJ99hDtcds/
	 0vvr/gsgOJC2mtKWJsex/u9ZfmZHd9wynDooxvVTxknA6T6dkKtW1/OADvb+2//BLi
	 yJa4ES6+7rrjTD1C418+JN4zYlbZss7VnYL/2L5MMIyV/JtAhK1p1YwbGQdMTRmHgb
	 ApU4htJHlbiUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: avoid copying Bluetooth input reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260617072035.3373487-1-ruoyuw560@gmail.com>
References: <20260606040344.4-1-ruoyuw560@gmail.com>
 <20260617072035.3373487-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:31:22 +0000
Message-Id: <20260617073123.5ADFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unaligned memory access when parsing Bluetooth input reports.
--

commit 3d01afcf428b29530738d10b1c36a61efcc9ab57
Author: Ruoyu Wang <ruoyuw560@gmail.com>

HID: wacom: avoid copying Bluetooth input reports

This commit avoids duplicating the Bluetooth report with kmemdup() by
temporarily pointing wacom->data at the 10-byte payload while the
common parser runs.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..a29bf051ada7c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1192,8 +1192,11 @@ static int int_dist(int x1, int y1, int x2, int y2)
>  static void wacom_intuos_bt_process_data(struct wacom_wac *wacom,
>  		unsigned char *data)
>  {
> -	memcpy(wacom->data, data, 10);
> +	u8 *saved_data =3D wacom->data;
> +
> +	wacom->data =3D data;

[Severity: High]
Can this lead to unaligned memory accesses on strict-alignment architecture=
s?

In wacom_intuos_bt_irq(), wacom_intuos_bt_process_data() is called with
data + 1 or data + 11. By pointing wacom->data directly to these unaligned
offsets, the common parsers will receive an odd-aligned base pointer.

When wacom_intuos_irq() then calls wacom_intuos_general() or
wacom_intuos_pad(), those functions assume wacom->data is aligned and cast
offsets from it to __be16 *:

drivers/hid/wacom_wac.c:wacom_intuos_general() {
        ...
        x =3D (be16_to_cpup((__be16 *)&data[2]) << 1) | ((data[9] >> 1) & 1=
);
        ...
}

If data is odd-aligned, &data[2] will also be unaligned. Calling
be16_to_cpup() on an unaligned pointer will trigger alignment faults on
architectures that do not support hardware unaligned accesses.

>  	wacom_intuos_irq(wacom);
> +	wacom->data =3D saved_data;
> =20
>  	input_sync(wacom->pen_input);
>  	if (wacom->pad_input)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617072035.3373=
487-1-ruoyuw560@gmail.com?part=3D1
