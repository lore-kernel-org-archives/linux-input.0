Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA42E7378;
	Mon, 29 Jun 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723850; cv=none; b=RV/3tVjOwLWPgqY+Et+HAnd/EOARHcjpSYA785ze1mnxfWFUNXSLCUQg5nx22XftPWPULExru50Ne7vw2j3YSR1mX1oOdwQ7k9kKGw3d7u7Pm4PQp0NdAYW0NoMavQf1+zlTj7538rHSgswyzz9Nhf1dlWs8OyMuzBIx1DU/vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723850; c=relaxed/simple;
	bh=RVdxQ2RAmOaNdTad8IiKHVXi3qAH2aFd0ABc3FHPUdI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QLvtE2qR/vC6L0TccFbMKgBP59/0MfJC4GqIcB7IyeUhRhX6r/QdUH/23HWq1tUNe/+oYJb5uPYGwWglee6LEXUNcLsz1tTOLRocgB8gbYkv7W0CmOXoyUUsqvZcuiKBfCllKTT2SeVZ4QVVvXQ7VhIy7Gxp3YUBd7dCGmNHp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMJckqs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMJckqs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581BD1F000E9;
	Mon, 29 Jun 2026 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723848;
	bh=Z78Z17Ge6giHMbB5UqVWbp5PTueMP2nMjA5h+9o/UAQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gMJckqs8wAN5zl9IJd3F3x4ik1u9Xl+sNQ6pv/x2ONxdG9oU5XL4L9Tq1lHfqtc8D
	 ckwonjJnQ2oZdw3tkzFAppDdNOb//XJkRJBFmCubRgkBzatmoyEfF74hqRe+wiRcdn
	 dgM0i19j1qAxSsp+VL2Do9V7/N9lrVwmgYxTVDseQ6RQObr6Ll0RSJB7RALIVftVLt
	 eTFbwWdPRbS2qgolWcKiEgJGTDfovFIJOWEG3nLhbdBMos/fspHds+UfQkWkBOxMdT
	 htx7RIxZ5rsL1cvGFXwyFhcZGoo7uKQdwjEZzijTIQdPlmdVOju+SH5mDbVClmNaOa
	 sQlSvzS10daWA==
Date: Mon, 29 Jun 2026 11:04:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?GB2312?Q?=D0=BB=D6=C2=B0=EE_=28XIE_Zhibang=29?= <Yeking@Red54.com>
cc: linux-input@vger.kernel.org, hansg@kernel.org, dmitry.torokhov@gmail.com, 
    bentiss@kernel.org, dianders@chromium.org, linux-kernel@vger.kernel.org, 
    sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
    superm1@kernel.org
Subject: Re: [PATCH v6] HID: i2c-hid: Refactor _DSM helper and add
 i2c-hid-acpi-prp0001 driver
In-Reply-To: <tencent_FD772005ED5B8FB435F3DFDF73437BC58F06@qq.com>
Message-ID: <360r0r52-n546-s91n-s51p-893o79415s74@xreary.bet>
References: <tencent_8AE8ED913FEC8151B4BA3D85D6BB7F3ACF08@qq.com> <tencent_FD772005ED5B8FB435F3DFDF73437BC58F06@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 Jun 2026, =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) wrote:

> Move the _DSM call that gets the HID descriptor address from
> i2c-hid-acpi.c into i2c-hid-acpi.h as a static inline so both the ACPI
> and the new PRP0001 driver can use it. While refactoring, move the
> blacklist check and the _DSM call to the top of probe() to avoid a
> pointless alloc when the device is blacklisted or does not implement the
> _DSM.
>=20
> Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
> are declared with _HID "PRP0001" and _DSD compatible "hid-over-i2c" but
> lack "hid-descr-addr" from the _DSD and provide the HID descriptor
> address only through an ACPI _DSM. The OF driver fails to probe them
> because it requires hid-descr-addr. Add a new driver that handles these
> devices by calling the shared _DSM helper.
>=20
> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separat=
e modules")
> Signed-off-by: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.co=
m>
> ---
> v2: Name the unused parameter and document why
> acpi_device_fix_up_power() is skipped.
> v3: Add a dev_warn() asking users to contact vendors for firmware
> updates, and use existing locals in devm_kzalloc() and
> acpi_device_fix_up_power().
> v4: Double the power-up delay from 250ms to 500ms.
> v5: Document why of_match_ptr() on the of_match_table is safe when
> CONFIG_OF=3Dn.
> v6: Increase power-up delay from 500ms to 750ms. During cold boot on low
> battery, 500ms causes non-fatal I2C transfer errors (-ENXIO). 750ms
> fixes them.

Thanks for all the effort you've put into this.

[ ... snip ... ]
> --- a/drivers/hid/i2c-hid/Kconfig
> +++ b/drivers/hid/i2c-hid/Kconfig
> @@ -22,6 +22,24 @@ config I2C_HID_ACPI
>  =09  will be called i2c-hid-acpi.  It will also build/depend on the
>  =09  module i2c-hid.
> =20
> +config I2C_HID_ACPI_PRP0001
> +=09tristate "Driver for PRP0001 devices missing hid-descr-addr"
> +=09depends on ACPI
> +=09depends on DRM || !DRM
> +=09select I2C_HID_CORE
> +=09help
> +=09  Say Y here if you want support for I2C HID touchpads that
> +=09  are declared with _HID "PRP0001" and _DSD compatible
> +=09  "hid-over-i2c" but lack the "hid-descr-addr" property from
> +=09  the _DSD. The HID descriptor address is instead provided
> +=09  through an ACPI _DSM. Known affected devices include the
> +=09  Lenovo KaiTian N60d and Inspur CP300L3.
> +
> +=09  If unsure, say N.
> +
> +=09  This support is also available as a module. If so, the
> +=09  module will be called i2c-hid-acpi-prp0001.

The only question I have -- do we really want to have this build-time=20
selectable by the endusers? It's unlikely that the description will make=20
sense to most of the people, being very low-level technical, and they'd be=
=20
unsure what to chose.

Is there a reason not to include it alwyas under the I2C_HID_CORE=20
umbrella?

Thanks,

--=20
Jiri Kosina
SUSE Labs

