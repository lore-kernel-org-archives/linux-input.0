Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD91A0BE0
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121898; cv=none; b=M9GzwXUY3jp1SD6Q6XwGaJjLqo73OGWfpSdQzVtzb9BkrquLmys8w1FXetV9PmSx4ws1S45QiTA/i+ETTPqtyYXMTp8eBZyOUyIaEbN8SW/4NNbDCT1lg51ZT+5XVh+waXGkDz8lj/cLB0kkR/0gv2Bg0Og9JqqZ7eQTO0LidRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121898; c=relaxed/simple;
	bh=w2C533kD8X9+WIT6uv0UNgirL5q3KfuX5FCS1C3rO/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tyVUCF6kmJtWYm/8kfNt4uD6qvZU3BrSRzAHax8pS/S7GQkl2gtzL/whOpB4TbtkrspYdfJvWm4OXVJ4EfF9qIF5omG5ShfYY8yLpRdlZ7oDeNTsVQv0g6NjdwLnXU0VN6j79+MyD0J9EHvW3AFG5Cha66M2HMy1uWnQXg0uPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNCGeCdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNCGeCdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336E51F000E9;
	Mon, 27 Jul 2026 03:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785121897;
	bh=BFxCk1BAsQlMjKJ7wiRrpWL/nC7t4WGv0uFvS5PgiyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNCGeCduJxbpG7xzzbvloXU4OcvWhMgUoIX4mG/Y2p4zxZQ6AcU7jegUntm6Kxe2s
	 h8dc2BkS2y/t/Wk0Dyzpp726/A5JDsQ81UIW5WvzuL5u5RGzeV+fo/ZS4f/bw3He/q
	 Vuz1xltWnG/Px3ATBhEsTOEh6Ot+5X5L6Yv16Fkskw/mBfn3tJBuqK1LbfFZnRRyft
	 NluPr9XuoT0dBm1iCgZZp+pTP7sVqw8qt/NpLWKli3d0stLd+ojfXjET+4zTAd6NJ8
	 tAZvmLb784enx4oPdlpW6Emu/iuO81k+R2lUVulaYkf2VszEcl1+TGt+LpdYnQ1mbz
	 aMDmNIUm1OImw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: Intel-thc-hid: Intel-quicki2c: Support full
 I2C BUS config parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727030310.3850984-3-even.xu@intel.com>
References: <20260727030310.3850984-1-even.xu@intel.com>
 <20260727030310.3850984-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 03:11:36 +0000
Message-Id: <20260727031137.336E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Multiple critical flaws in ACPI evaluation in `quicki2c_acpi_g=
et_dsd_property` lead to memory leaks, potential stack buffer overflows, an=
d type confusion.
- [High] Structs `i2c_config` and `i2c_param` are declared on the stack wit=
hout zero-initialization, leading to uninitialized kernel memory being used=
 for hardware configuration if the ACPI buffer is smaller than expected.
--

--- Patch [2]: [PATCH 2/2] HID: Intel-thc-hid: Intel-quicki2c: Support full=
 I2C BUS config parameters ---
commit 1910fa4a54d63973a7e0cc155b418558fa7c3450
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Support full I2C BUS config parameters

This patch reads complete I2C bus configuration parameters from ACPI and
passes them to thc_i2c_subip_init() to properly initialize the THC I2C
subip. This enhances hardware compatibility by allowing full
platform-specific I2C bus configurations.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..2ec52cb35a132 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -175,7 +175,9 @@ static int quicki2c_get_acpi_resources(struct quicki2=
c_device *qcdev)
>  	if (i2c_param.addressing_mode !=3D HIDI2C_ADDRESSING_MODE_7BIT)
>  		return -EOPNOTSUPP;
> =20
> -	qcdev->i2c_slave_addr =3D i2c_param.device_address;
> +	qcdev->i2c_config.addr_mode =3D HIDI2C_ADDRESSING_MODE_7BIT;
> +
> +	qcdev->i2c_config.target_addr =3D i2c_param.device_address;
> =20
>  	ret =3D quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_=
ISUB,
>  					     ACPI_TYPE_BUFFER, &i2c_config);

[Severity: Critical]
This is a pre-existing issue, but does quicki2c_acpi_get_dsd_property() have
multiple flaws when evaluating ACPI methods?

When called here, quicki2c_acpi_get_dsd_property() receives an acpi_buffer,=
 but
it ignores the passed type parameter and unconditionally assumes
ret_obj->type =3D=3D ACPI_TYPE_BUFFER. If the ACPI method returns a differe=
nt type,
does type confusion occur, causing ret_obj->buffer.pointer to resolve to
invalid memory and crash during memcpy()?

Additionally, there appears to be no bounds checking between the returned
ret_obj->buffer.length and the size of the destination stack buffer. Can an
ACPI table overflow the kernel stack here? Finally, is buffer.pointer leaked
before the function returns?

>  	if (ret)
>  		return ret;
> =20
>  	if (i2c_param.connection_speed > 0 &&
>  	    i2c_param.connection_speed <=3D QUICKI2C_SUBIP_STANDARD_MODE_MAX_SP=
EED) {
> -		qcdev->i2c_speed_mode =3D THC_I2C_STANDARD;
> -		qcdev->i2c_clock_hcnt =3D i2c_config.SMHX;
> -		qcdev->i2c_clock_lcnt =3D i2c_config.SMLX;
> +		qcdev->i2c_config.speed =3D THC_I2C_STANDARD;
> +		qcdev->i2c_config.scl_hcnt =3D (u32)i2c_config.SMHX;
> +		qcdev->i2c_config.scl_lcnt =3D (u32)i2c_config.SMLX;
> +		qcdev->i2c_config.sda_tx_hold =3D (u32)i2c_config.SMTD;
> +		qcdev->i2c_config.sda_rx_hold =3D (u32)i2c_config.SMRD;

[Severity: High]
This isn't a bug introduced by this patch, but are the i2c_config and
i2c_param structures declared on the stack in quicki2c_get_acpi_resources()
without zero-initialization?

If the ACPI firmware returns a shorter buffer, quicki2c_acpi_get_dsd_proper=
ty()
will only populate part of the structures. This means the newly added code
above will read uninitialized stack memory for fields like SMTD and SMRD.
Can this lead to invalid bus timings and system instability?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727030310.3850=
984-1-even.xu@intel.com?part=3D2
