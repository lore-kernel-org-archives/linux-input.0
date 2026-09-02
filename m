Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5E40800D
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339712; cv=none; b=ubc0zY9hKTsYO1/RSolBxzRkYDNvRAtkEI9ttrSeYI8hZGWpdfs4yChbdYDIOd2JZ2dSTDh+6+369SoTguxkY3fA+GneE/P4M6EP+DX0GTsle20bZXcfHRAKamgknkuNRp/a3+uTHRQzKrfbt7FftSoOCLBYWIZLJ6XnpecTtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339712; c=relaxed/simple;
	bh=1MVPHl/mJHTZrbVF8lxu1bBOVy3m9YcWnx+ij+Ibk/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rlmxtc8VBdj9ToYCkzxA1ow0m8PrblhprIx6VZLhxHkh5bbNmQA2CfXfrfDyZqGZOQ/vuz7xDNLtC//p3iA3qnABryXpGQ5TkxwZZ4m4acB94ZKF8ym2mdAWH5kO80y4cO5uz0l2rEINFYO+wg1kqwdjiY0y1WiUDhq/mr+BCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4E7dfMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4E7dfMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972911F000E9;
	Wed,  2 Sep 2026 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788339710;
	bh=hcG3vt6LNYwp5OQLcO85eEXNCcbIqkAUGqEG7KMWscs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4E7dfMdqClTTzE/LLD6pt9FBncrDIqK9t+Lq+LDxjfJI7/Pddmrp9vdglvvSiNVQ
	 8l6cKYHZcD7zkJgsz3VodAKVRNhguvNm9yna3lFjLMZfSz71ysbRGFb1cHdStc1lhH
	 w9/EyQR2j3a8v/fSnvUq7NF0Vn8Xj6LP3WMaS+TKsIzL73SKGV0sJqkiIt2XGVDWB/
	 0+OipDqZtx7RL9dxGIT4TaCoVL4IaI1M8vl0tIcAY7PKWW9pTLSloJAHq3yncxfyEL
	 qmwFtDB9AtEaTnZLXJLQ/Xc/ahR32+5NRJy0+WAq12Oo5p7qT57nSyfiET1E5PzH2e
	 kRdFEDlDe0ddQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: hycon-hy46xx - bound the checksum length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902084842.1999180-1-gonglinkai@kylinos.cn>
References: <20260902084842.1999180-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:01:50 +0000
Message-Id: <20260902090150.972911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sysfs attribute handlers write to and read from `int` struct field=
s using a `u8 *` pointer, causing silent data corruption on Big Endian arch=
itectures.
- [High] Returning `IRQ_HANDLED` on I2C read failure without clearing the h=
ardware interrupt can cause an interrupt storm and a hard CPU lockup.
--

commit 3014acd85e249aca8ccbf7913330ea41bc0f1165
Author: Linkai Gong <gonglinkai@kylinos.cn>

Input: hycon-hy46xx - bound the checksum length
   =20
The checksum loop uses a length byte from the report as the upper bound.
The report buffer is only HY46XX_REPORT_PKT_LEN bytes.

Fixes: aa2f62cf211a ("Input: add driver for the Hycon HY46XX touchpanel ser=
ies")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

> diff --git a/drivers/input/touchscreen/hycon-hy46xx.c b/drivers/input/tou=
chscreen/hycon-hy46xx.c
> index 1513f20cbf51f..bb8b82b11301b 100644
> --- a/drivers/input/touchscreen/hycon-hy46xx.c
> +++ b/drivers/input/touchscreen/hycon-hy46xx.c
> @@ -84,7 +84,7 @@ static bool hycon_hy46xx_check_checksum(struct hycon_hy=
46xx_data *tsdata, u8 *bu
>  	u8 chksum =3D 0;
>  	int i;
> =20
> -	for (i =3D 2; i < buf[HY46XX_CHKSUM_LEN]; i++)
> +	for (i =3D 2; i < min_t(int, buf[HY46XX_CHKSUM_LEN], HY46XX_REPORT_PKT_=
LEN); i++)
>  		chksum +=3D buf[i];
> =20
>  	if (chksum =3D=3D buf[HY46XX_CHKSUM_CODE])

This isn't a bug introduced by this patch, but while reviewing this file I
noticed a few significant pre-existing issues.

[Severity: High]
Can this sysfs attribute handling corrupt data on big-endian architectures?

In hycon_hy46xx_setting_show() and hycon_hy46xx_setting_store(), sysfs
attributes are mapped to fields in the hycon_hy46xx_data struct. Many of th=
ese
fields, such as threshold and report_speed, are of type int.

drivers/input/touchscreen/hycon-hy46xx.c:hycon_hy46xx_setting_store() {
    ...
	u8 *field =3D (u8 *)tsdata + attr->field_offset;
    ...
	*field =3D val;
    ...
}

Because the pointer is cast to a u8 pointer, it will point to the Most
Significant Byte of the int field on big-endian architectures. Writing a sm=
all
value here (like 100) will shift it into the upper 24 bits, drastically
corrupting the driver's internal state. Reading it will typically return 0
unless the MSB happens to be set.

[Severity: High]
Does returning IRQ_HANDLED on failure in the ISR risk an interrupt storm?

drivers/input/touchscreen/hycon-hy46xx.c:hycon_hy46xx_isr() {
    ...
	error =3D regmap_bulk_read(tsdata->regmap, 0, rdbuf, sizeof(rdbuf));
	if (error) {
		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
				    error);
		goto out;
	}
    ...
out:
	return IRQ_HANDLED;
}

If the regmap_bulk_read() fails (e.g., due to an I2C bus error), the functi=
on
jumps to the out label and unconditionally returns IRQ_HANDLED.

Because the hardware was not successfully queried, the hardware interrupt l=
ine
may remain asserted. Since IRQ_HANDLED informs the kernel that the interrupt
was fully processed, the kernel unmasks the IRQ line again. This can cause =
the
interrupt to immediately fire again, creating an infinite loop that starves
the CPU.

Should this path return IRQ_NONE so the kernel's spurious interrupt detector
can safely disable the broken IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902084842.1999=
180-1-gonglinkai@kylinos.cn?part=3D1
