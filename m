Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18A2AD03
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122130; cv=none; b=BsSfjraMadOfy88C2D47W9wUMjuov/SidMxtEn7jxcGYWZ8Sskqf/nvr3tRNiepYKUGTqONosx1MKZkqi61MCXL4Xepor2chClkIrA9cRsobxArK9khMufG70Ypi6s1cF+C0BQhd2CquZlI1bOsx/msRiKOP6BZvd1jm7mM9lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122130; c=relaxed/simple;
	bh=V+66jL/7CJUXInUsHg3gP4kO1rghxU2c3RbGRN6TWHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dG+U+q4jwjgvMuKO6ewt5B/ThlZbl6DnbyWgLLYISshmuGq2KBzL8NKN8hnZri3kEci2cBpPa/w26i/3oiWYBRYetQALkad2Z3KCsEVJYi5FRELocLY4PB3Li5JvFSgBSlFenY8xuYi2QkrLUKWN0AZVk20yUsB7w0BgAWX9o3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjWcXlVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjWcXlVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04D81F000E9;
	Mon, 27 Jul 2026 03:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785122128;
	bh=vo+/nI6ffusKUnKf0Faj+yDxRXQlFX25XpIx7UIAuVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OjWcXlVSbRBUF1qX4G8O0tWjr1tgSMjjXwbSzgLM+/trqiRmnVKL6f1prYQJmQAoX
	 UjYJBsNLVWxVM7ibq3sGzbH9MnYQJhkZwU8Ill52EozzeZqGZkEx/XllcNaOyVXtkO
	 OgVZgU7F9xNISGs+tsmhYF03ZdiX5R9xz0PPfY3eSVRwjvKJn6HxBWrMtzb8WjLuIQ
	 v7dP7dRf8uv/bXcmtWRCHLsvtBeEN1CpvX5ua731A67ztw1/J4iGQ2LU/s60RoVMSl
	 KgDqjoz35e8suLmjz3VkDJZ+PfkKXKq9nBuMmF/3tYhxOvmy6qixkC0mqLs+JHnKD9
	 GevBPIgbyOB0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: Intel-thc-hid: Intel-thc: Refactor I2C bus
 configuration with unified config structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727030310.3850984-2-even.xu@intel.com>
References: <20260727030310.3850984-1-even.xu@intel.com>
 <20260727030310.3850984-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 03:15:27 +0000
Message-Id: <20260727031527.F04D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Erroneous bitwise operation when configuring 10-bit address mode u=
sing FIELD_PREP reverses the 7-bit and 10-bit modes.
- [Low] The function signature of thc_i2c_subip_init() was modified to take=
 a configuration struct, but callers in pci-quicki2c.c were not updated, le=
ading to compilation failure.

Pre-existing issues:
- [Critical] Hardware-controlled stack and heap buffer overflows via unchec=
ked PIO read size in pio_complete().
--

--- Patch [1]: [PATCH 1/2] HID: Intel-thc-hid: Intel-thc: Refactor I2C bus =
configuration with unified config structure ---
commit e5a64a16b521af522ba816d8c4f239b2bd596a69
Author: Even Xu <even.xu@intel.com>
Subject: HID: Intel-thc-hid: Intel-thc: Refactor I2C bus configuration with=
 unified config structure

This commit introduces a new struct thc_i2c_config to consolidate configura=
ble
I2C bus parameters. It renames and updates thc_i2c_subip_set_speed to
thc_i2c_subip_bus_config and updates thc_i2c_subip_init to use the new
structure.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> index 9a8449428170b..7b4a58e1416d6 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> @@ -1422,14 +1422,25 @@ static int thc_i2c_subip_pio_write(struct thc_dev=
ice *dev, const u32 address,
>  #define I2C_SUBIP_DMA_TDLR_DEFAULT	7
>  #define I2C_SUBIP_DMA_RDLR_DEFAULT	7
> =20
> -static int thc_i2c_subip_set_speed(struct thc_device *dev, const u32 spe=
ed,
> -				   const u32 hcnt, const u32 lcnt)
> +static int thc_i2c_subip_bus_config(struct thc_device *dev, const struct=
 thc_i2c_config *i2c_config)
>  {
>  	u32 hcnt_offset, lcnt_offset;
> -	u32 val;
> +	u32 read_size =3D sizeof(u32);
> +	u32 val =3D 0;
>  	int ret;
> =20
> -	switch (speed) {
> +	ret =3D thc_i2c_subip_pio_read(dev, THC_I2C_IC_TAR_OFFSET, &read_size, =
&val);

[Severity: Critical]
This is a pre-existing issue, but could this cause a stack buffer overflow?

If a compromised or malicious peripheral returns a large size via the
hardware register in pio_complete(), it will be extracted and used directly
as the byte count for regmap_bulk_read():

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:pio_complete() {
    ...
    regmap_bulk_read(dev->thc_regmap, THC_M_PRT_SW_SEQ_DATA1_OFFSET,
                     buffer, *size / sizeof(u32));
    ...
}

Since the destination buffer here is a 4-byte local stack variable (val),
could an untrusted peripheral trigger a large out-of-bounds write to the
kernel stack?

> +	if (ret < 0)
> +		return ret;
> +
> +	val &=3D ~(THC_I2C_IC_TAR_IC_TAR | THC_I2C_IC_TAR_IC_10BITADDR_MASTER);
> +	val |=3D FIELD_PREP(THC_I2C_IC_TAR_IC_10BITADDR_MASTER, i2c_config->add=
r_mode);

[Severity: High]
Does this logic correctly enable 10-bit mode?

The struct documentation for thc_i2c_config explicitly instructs callers
to pass the literal value 7 or 10 to addr_mode:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h:
 * @addr_mode: Slave address mode of touch device (TIC), 7bit or 10bit

When these values are passed to FIELD_PREP with a 1-bit mask:
- For 7 (binary 0111), the mask yields 1, incorrectly enabling 10-bit mode.
- For 10 (binary 1010), the mask yields 0, incorrectly disabling 10-bit mod=
e.

Could this inadvertently reverse the 7-bit and 10-bit mode configuration,
causing I2C device communication to fail?

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
> index 0db435335e249..be8a9605d02fe 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
> @@ -121,8 +141,7 @@ int thc_spi_write_config(struct thc_device *dev, u32 =
spi_freq_val,
>  			 u32 io_mode, u32 opcode, u32 spi_wr_mps, u32 perf_limit);
>  void thc_spi_input_output_address_config(struct thc_device *dev, u32 inp=
ut_hdr_addr,
>  					 u32 input_bdy_addr, u32 output_addr);
> -int thc_i2c_subip_init(struct thc_device *dev, const u32 target_address,
> -		       const u32 speed, const u32 hcnt, const u32 lcnt);
> +int thc_i2c_subip_init(struct thc_device *dev, const struct thc_i2c_conf=
ig *i2c_config);

[Severity: Low]
Will this compile correctly given the other callers in the driver?

It looks like the function signature of thc_i2c_subip_init() was changed
from 5 arguments to 2 arguments, but callers in pci-quicki2c.c were not
updated:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_probe() {
    ...
    ret =3D thc_i2c_subip_init(qcdev->thc_hw, qcdev->i2c_slave_addr,
                             qcdev->i2c_speed_mode,
                             qcdev->i2c_clock_hcnt,
                             qcdev->i2c_clock_lcnt);
    ...
}

Would this regression trigger a build failure at quicki2c_probe() and
quicki2c_restore() since they still attempt to pass the old arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727030310.3850=
984-1-even.xu@intel.com?part=3D1
