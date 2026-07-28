Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE73093B5
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207915; cv=none; b=hp+/M58t+vnTH6jRa32gyQJAyhy93zbISYFC9gQhmfwsEi4uV6onLYAaCyDrVOZ2M2QeOgv2P9GAHxCWklFudhM7bh1ghVTUOUMcF+jfocFHGzOTlnsR0/nCeFxOgKnNlLQ1C2J+Lyr/8HwXktxZg335MfR+2CNthF+DnzuPG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207915; c=relaxed/simple;
	bh=SCCTEDGlVy5ccydnK+6iO+saremtsQyjpBxO9yXo8no=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4Ik7oEppWEZQ2JlqMB30Krdka/dS9PjoI+5BM8k/VLLo2YAZHNNl3BcmwevpOV3S1wXYGG9cioKhxI9OnZvH0WevJf/GPPtBhOlUVsV9DnKq24U41Yjh7qwCMxcGIMlDE9KfkZRDVNZ3sqoefUxSJCHDiDDONZXRRj6iuBsEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Me6WN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Me6WN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFD31F000E9;
	Tue, 28 Jul 2026 03:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785207913;
	bh=dZjA/raWSUXkM8QLRHUkXsx07vp+/b99mzWBpVhR89g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0Me6WN3cShDbZv01hG0+emxaOBRqH5F0ktO+BU3H+MbGY2+mmja1sxQRxqeD1qNi
	 ppRYvTLTpoo8eetm14K73eBiNNnpQoTBy6rvUEtuCK/461tfu+fTpMGku2hJ3xoinj
	 yqLYRrIXXbynpubxrFf6I9X+f98bh85e+dE4M9caCyzp26Q+4ARug4kOH7rFesHS8M
	 QAZBHXC8esxfWcch146Q9k04tDGcGw9+AkNxsRjsysXy3mKSMoAxXBtHR33FuXKuA3
	 q7UHhElqf4DioP9n81yYh0mg5GjLiQAY7zohpHtCi9+RUgoKglk9v3NjM7bEN5b6Bx
	 KyMWBMzoGZJ9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: intel-quicki2c: Use min() macro to simplify
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728025750.48249-2-chenchangcheng@kylinos.cn>
References: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
 <20260728025750.48249-2-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:05:12 +0000
Message-Id: <20260728030513.4CFD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the helper funct=
ion `quicki2c_acpi_get_dsd_property()` fails to validate the ACPI object ty=
pe, performs an unbounded memory copy, and leaks the dynamically allocated =
ACPI buffer.
--

--- Patch [1]: [PATCH 1/4] HID: intel-quicki2c: Use min() macro to simplify=
 code ---
commit 232da0a8d999e7cca061120fe2a92fd5ce93fd4e
Author: Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: HID: intel-quicki2c: Use min() macro to simplify code

This patch replaces open-coded min() logic with the standard min() macro in
pci-quicki2c.c. This is used for setting i2c_max_frame_size and i2c_int_del=
ay
to improve code readability and maintain consistency with kernel style.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..bd099600bb9f2 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -210,15 +210,8 @@ static int quicki2c_get_acpi_resources(struct quicki=
2c_device *qcdev)
>  		qcdev->i2c_max_frame_size_enable =3D i2c_config.FSEN;
>  		qcdev->i2c_int_delay_enable =3D i2c_config.INDE;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but since this code relies on=20
i2c_config populated earlier by quicki2c_acpi_get_dsd_property(), does the=
=20
helper function validate the ACPI object type before copying it?

Looking at quicki2c_acpi_get_dsd_property():

quicki2c_acpi_get_dsd_property(...)
{
        ...
        memcpy(prop_buf, ret_obj->buffer.pointer, ret_obj->buffer.length);
        ...
        return 0;
}

Does this memcpy blindly use the length from the ACPI object without
ensuring it fits into the destination buffer (such as the stack-allocated
i2c_config)? If firmware provides a larger buffer, could this overflow the
stack frame in quicki2c_get_acpi_resources()?

Also, if ret_obj->type is not verified as a buffer, could this cause an
invalid pointer dereference since the buffer pointer might overlap with
an integer value?

Additionally, does the success path in quicki2c_acpi_get_dsd_property()
leak the dynamically allocated ACPI buffer by returning without calling
ACPI_FREE(buffer.pointer)?

> -		if (i2c_config.FSVL <=3D qcdev->ddata->max_detect_size)
> -			qcdev->i2c_max_frame_size =3D i2c_config.FSVL;
> -		else
> -			qcdev->i2c_max_frame_size =3D qcdev->ddata->max_detect_size;
> -
> -		if (i2c_config.INDV <=3D qcdev->ddata->max_interrupt_delay)
> -			qcdev->i2c_int_delay =3D i2c_config.INDV;
> -		else
> -			qcdev->i2c_int_delay =3D qcdev->ddata->max_interrupt_delay;
> +		qcdev->i2c_max_frame_size =3D min(i2c_config.FSVL, qcdev->ddata->max_d=
etect_size);
> +		qcdev->i2c_int_delay =3D min(i2c_config.INDV, qcdev->ddata->max_interr=
upt_delay);
>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728025750.4824=
9-1-chenchangcheng@kylinos.cn?part=3D1
