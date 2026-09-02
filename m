Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31EF4A0903
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357543; cv=none; b=jQe86mJUiDr+OmvT0rpCLh0NawVZQvX34TzijGv9PyLWt92a477S1BOzpTKglmCkxDYxLL01LVrV3lEjM/r7rzgWUShL15L/5fjqMVg0ns0ByP2hfSvArvZury5bJou5p5u4KUmq86AJI9r++98Irem9h60tuGujTIbBQBHLiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357543; c=relaxed/simple;
	bh=rb9Qg+qGlu5sTUWpiIWcbtxUlyPiBUZs9hZyLEbPRwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mq5WFdJVyl8uQvH7K74BaoNHu7rPqoH9oC6qV181hhmXWbGacIghrOU5ewzAjpXJMDGodekMpco7QlyMsJrCd1gnILuPAW0CAyLAMXlZsOaBzH/ozZxU1ucsp6Dnv1sD2Q+Nbpa9rAjlkX7JvkiVPgiEOT/MQ0TUNBlzc0l6nxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAGy4l9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAGy4l9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6AC1F000E9;
	Wed,  2 Sep 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357541;
	bh=hKTwtwOo49L527UMnYDbAopFiEIACvos94EFxYcWmnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAGy4l9bVntbCI0pop8dtM0jr4fLseO4JXX0ugnSxkzqrSYJEonRRmU+j/Cd1NwkB
	 1QU1NyoUE4c13fJVPC4o8C+McD5sw5XB1qjDc79mq6PMr7DhpecnzE+lMXiBIYz9lN
	 Ap2o7RQlTn6UypOdmGbgn5zZVpJRvEazRKjtPaLSCFZ+mD1C/mzU1FkxyQQPwnWbwm
	 co8LcM9hfhQEbSo7hgnLDIL+gWZG3aa7ZV6BlJm8CarmZ4qFX5e4jCMyjG/HAgDi65
	 n9nWkp/nyY46UscINTD91xbzTBD9hPcwMjPmLUCS4cBC+CAJ0ljFMqf+FSv3Fn3IyD
	 E5gZ6EdrS3S+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: amd_sfh: Add device mode support for latest
 AMD SOC.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902134431.3146117-5-Basavaraj.Natikar@amd.com>
References: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
 <20260902134431.3146117-5-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:59:00 +0000
Message-Id: <20260902135900.CD6AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack memory disclosure in `get_input_rep` (and `get_feature_rep`)=
 due to uninitialized struct fields.
--

commit ee34af1b468d9118272d016d00f5ca0dd24501d8
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Add device mode support for latest AMD SOC.

Use device mode data from DRAM instead of reading from the C2P
register in latest AMD SOC.

> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers=
/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
> index d2021f5cc6e59..711174184d2d9 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
[ ... ]
> @@ -132,7 +151,7 @@ static int amd_sfh_mode_info(u32 *platform_type, u32 =
*laptop_placement)
>  	if (!emp2 || !emp2->dev_en.is_sra_present)
>  		return -ENODEV;
> =20
> -	mode.val =3D readl(emp2->mmio + amd_get_c2p_val(emp2, 3));
> +	mode.val =3D amd_sfh_read_c2p3(emp2);
> =20
>  	*platform_type =3D mode.op_mode.devicemode;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
stack memory disclosure in this subsystem when constructing HID input
reports.

In drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c:get_input_rep():

	struct accel3_input_report acc_input;
	...
	case ACCEL_IDX: /* accelerometer */
		...
		get_common_inputs(&acc_input.common_property, report_id);
		acc_input.in_accel_x_value =3D amd_sfh_float_to_int(...) / 100;
		acc_input.in_accel_y_value =3D amd_sfh_float_to_int(...) / 100;
		acc_input.in_accel_z_value =3D amd_sfh_float_to_int(...) / 100;
		memcpy(input_report, &acc_input, sizeof(acc_input));

Since acc_input is allocated on the stack without being zero-initialized,
could uninitialized fields (like in_accel_shake_detection or compiler
padding bytes) retain old kernel stack data and be leaked to userspace
when the entire struct size is copied into the report buffer?

The same pattern appears in get_input_rep() for als_input, where some
fields are only conditionally initialized:

	struct als_input_report als_input;
	...
	case ALS_IDX:
		...
		als_input.illuminance_value =3D amd_sfh_float_to_int(als_data.lux);

		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2) {
			als_input.light_color_temp =3D als_data.light_color_temp;
			...
		}

		report_size =3D sizeof(als_input);
		memcpy(input_report, &als_input, sizeof(als_input));

If the if-condition is false, are the uninitialized light_color_temp and
chromaticity fields leaking kernel memory into the HID report?

Does this same issue also exist in get_feature_rep() where structs like
acc_feature and als_feature are allocated on the stack and copied
directly into feature_report?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134431.3146=
117-1-Basavaraj.Natikar@amd.com?part=3D4
