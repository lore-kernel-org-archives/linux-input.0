Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68C5013CA
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859467; cv=none; b=uqFgN2g/iw3IT5Dv9OImj8cwsqSaMN/BogwRMrtgi8CAyOF3cAmgfJn6NLe8mNnvd4qi6cXOMRwfj3Vghz/j94fItVFNywHaGRgBhqyeA89wqoUmOlmzGmnrZxQexbEG29HnVLRAWQDb2+aWgCB2OEm0Jp20qBkUhP4c5ddxbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859467; c=relaxed/simple;
	bh=yS08YpPoRp4JOXCnDB4PAiAN3u9JS4MJWnOUdmJEZS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RjRHTYQADEMHdVHKyRyQYEyjYW9gGkawnL0IJWru1qcuq7Bmo9g2YxpENpgLkR0j7m5dqpZ1N5Vxh2gJ7ltL1FjVmALS+QrU1XMQCKV3gNpcmhxGu2HB8YzpL9Rfc/ZIK7GM1vr+WNwh4RLFS1bsifG7tfLpN/FLDtng14jVBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNSmdc0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNSmdc0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155B11F00A3A;
	Tue,  8 Sep 2026 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859466;
	bh=eVrunKHwp7N9TMC5IY7axn4RxzO8iXYO5+8xBBUrnXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNSmdc0GR+qjDhkOcQdB03MDGYphpSSo7wMW+TgK+ZnjO9tDALBAzw8grD7J2VFS/
	 nuMhIexYliUANOR8ZZ6gFwyH2wUeaZZ5KiITGc1RiVYsh/ULcHkKsrjVzmvO6OiOOk
	 IX4doD0dEIoVY1qnuGse7v2OVEUA5mMzp931KkQJUVaHSPBM33bCWiATYHGXXLc9xO
	 iGAeSYZkYk/ZJrd4apKRHqYm0vW4mtPEz9Aq2h0odmbgmZuAx60GjwDpflg1f0eqAO
	 9GDVpAYTFlDFDTB8ICBvEw8xNKtNHQlEhKy1y564nMI8PM90QeTvBUfSo7mhrNr6g2
	 SmLmyTa5eNmxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] HID: hid-google-hammer: use named initializers for
 acpi_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawel Zalewski" <pzalewski@thegoodpenguin.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908-acpi-hid-v1-1-08df24c4b139@thegoodpenguin.co.uk>
References: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
 <20260908-acpi-hid-v1-1-08df24c4b139@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:24:25 +0000
Message-Id: <20260908092426.155B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of `field->maxusage` before accessing `field->u=
sage->hid`.
--

commit f7c0a66497368221036f024200ddbda2e9fb80a9
Author: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

HID: hid-google-hammer: use named initializers for acpi_device_id

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-ham=
mer.c
> index c99c3c0d442e1..847b1ddefeeca 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -268,7 +268,7 @@ static void cbas_ec_remove(struct platform_device *pd=
ev)
> =20
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cbas_ec_acpi_ids[] =3D {
> -	{ "GOOG000B", 0 },
> +	{ .id =3D "GOOG000B" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);

[Severity: High]
This is a pre-existing issue, but does hammer_get_folded_state() lack valid=
ation
for the number of usages before accessing the usage array?

Looking at drivers/hid/hid-google-hammer.c:hammer_get_folded_state():

	for (a =3D 0; a < report->maxfield; a++) {
		struct hid_field *field =3D report->field[a];

		if (field->usage->hid =3D=3D HID_USAGE_KBD_FOLDED) {
			u32 value =3D hid_field_extract(hdev, buf+1,
					field->report_offset, field->report_size);

			hammer_folded_event(hdev, value);
			break;
		}
	}

If a maliciously crafted HID descriptor declares a field with 0 usages
(where field->maxusage =3D=3D 0), will accessing field->usage->hid
(equivalent to field->usage[0].hid) cause an out-of-bounds memory read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-acpi-hid-v=
1-0-08df24c4b139@thegoodpenguin.co.uk?part=3D1
