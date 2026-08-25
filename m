Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E34393DFB
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654825; cv=none; b=OQVik2BpQF1WpZHCTOaDo9sDoug4pypgJ0YjMOQywgKGy0VmsXSGJiCnZblp0hIwFwok32LL5eRBuPu1x8GodtaEBheYCQzzrLly5SSwWpKLkK4A7Ovvgo9n7WS3h7hg7rl0AS3DnhnBnZNfu1d1H4ywFzKS1QTJX+AdvTqUacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654825; c=relaxed/simple;
	bh=ilowP41RwVMW7kL/mHSVwEgVCjKDUGbQb5SZzd7VV1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXbZvKipN//kkmDvmhaGC66aXWkTj65UOtd2lIdMMasmO3WoRZi+Hr6o9txKhk3LkVdsh2Yc+XY57YMNX6ABoUZdpMJu82hslpo+1TX4F791TttlA7pbGMQxY02NcZMdAlT6JxI5fUxXNkzkqWP1meaJ1LQ04aMk5fObL9Nk/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNPkkLD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNPkkLD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEC31F00A3A;
	Tue, 25 Aug 2026 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654824;
	bh=C9zSIcgI6t+GbDX+UNKFEhuWcpUcOpCcgwK73YoSel4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kNPkkLD8uH19a7eIM5WQUe4Rpczau+LYbl8nqsYBrbyJ944MRhlYcf8RW8BF2bprR
	 db6JD7UThI1wXTi1hd8lzqQzml+np5EqfAJg5xQQb1vQe+KTknpidJwEwXX5kVrx9o
	 XD2BImLVluSKQ13o19HmKYdsEerrAe3HtMC4rdghrcf8tWvIqAkeSWa99y7BFLU/lU
	 hWjZ2lqsLAr4uSkXbHpX++U0Jc20t9NrT64jd+lOpwizQL821So3nuJl7i5ICeU+74
	 0jNEC9ulJABhMgoDn+Z+SN3KBNKOsZ0SztBiLk96Xef7MnPONgfjGgHScjX3H/MyFl
	 qIXc+hEooZD8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] Input: synaptics-rmi4 - reject a PDT that grows
 between scans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825103123.12216-3-98lawweijie@gmail.com>
References: <20260825103123.12216-1-98lawweijie@gmail.com>
 <20260825103123.12216-3-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:47:03 +0000
Message-Id: <20260825104704.2CEC31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the IRQ domain a=
llocated in `rmi_probe_interrupts()` is leaked on probe error paths and dur=
ing firmware updates, leading to a Use-After-Free.
- [High] This problem wasn't introduced by this patch, but if `rmi_f34_crea=
te_sysfs()` fails during probe, the error path bypasses RMI function cleanu=
p, leading to leaked child devices and Use-After-Free.
- [High] This problem wasn't introduced by this patch, but missing sysfs cl=
eanup on subsequent probe failures leaves dangling attributes that access f=
reed memory.
--

--- Patch [2]: [PATCH v4 2/2] Input: synaptics-rmi4 - reject a PDT that gro=
ws between scans ---
commit f03eebdf9f89cd4c6205418bac6b25e787999cba
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - reject a PDT that grows between scans

rmi_driver_probe() walks the Page Description Table three times, and each
walk reads the table back from the device. Validate the counts before the=20
function is allocated and fail the probe instead.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..f66be55677a94 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -885,6 +885,25 @@ static int rmi_create_function(struct rmi_device *rm=
i_dev,
>  	rmi_dbg(RMI_DEBUG_CORE, dev, "Initializing F%02X.\n",
>  			pdt->function_number);
> =20
> +	/*
> +	 * irq_mask[] was sized from the interrupt count collected by the
> +	 * earlier rmi_count_irqs() scan of the PDT, and irq[] holds
> +	 * RMI_FN_MAX_IRQS entries.  Nothing guarantees that this scan sees
> +	 * the same table -- the PDT is read back from the device every
> +	 * time -- so a device that grows its interrupt counts between the
> +	 * two scans would push the set_bit() calls below past the end of
> +	 * the flexible array.  Refuse the function instead, before anything
> +	 * is allocated for it.
> +	 */
> +	if (pdt->interrupt_source_count > RMI_FN_MAX_IRQS ||
> +	    *current_irq_count + pdt->interrupt_source_count > data->irq_count)=
 {
> +		dev_err(dev,
> +			"F%02X: interrupt count changed between PDT scans (pos %u + %u > %d)\=
n",
> +			pdt->function_number, *current_irq_count,
> +			pdt->interrupt_source_count, data->irq_count);
> +		return -EINVAL;
> +	}
> +
>  	fn =3D rmi_alloc_function(rmi_dev, pdt->function_number);
>  	if (!fn) {
>  		dev_err(dev, "Failed to allocate memory for F%02X\n",

[Severity: High]
This isn't a bug introduced by this patch, but the IRQ domain allocated in
rmi_probe_interrupts() is leaked on probe error paths and during firmware
updates, leading to a use-after-free.

Can this sequence actually occur? Looking at rmi_driver_probe() in
rmi_driver.c, if any step after rmi_probe_interrupts() fails, we jump
to err, but the irqdomain is never removed:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
...
	retval =3D rmi_probe_interrupts(data);
	if (retval)
		goto err;
...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

Since the irqdomain's host_data points to data which is devm-managed,
data will be freed on probe failure, leaving a dangling pointer in the
globally registered irqdomain.

Additionally, this happens during firmware updates:

drivers/input/rmi4/rmi_f34.c:rmi_firmware_update() {
...
	rmi_free_function_list(rmi_dev);

	ret =3D rmi_probe_interrupts(data);
...
}

Will this overwrite the irqdomain during reprobing without removing the
old one, leaking it again?


[Severity: High]
This isn't a bug introduced by this patch, but if rmi_f34_create_sysfs()
fails during probe, the error path bypasses RMI function cleanup, leading
to leaked child devices and a use-after-free.

Looking at rmi_driver_probe() again:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
...
	retval =3D rmi_init_functions(data);
	if (retval)
		goto err;

	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;
...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

If rmi_f34_create_sysfs() fails, the code executes goto err, bypassing
err_destroy_functions.=20

Since child RMI function devices are manually registered via device_add
and are not devres-managed, won't bypassing their cleanup leave them
permanently in the system?=20

When probe aborts, devres frees data. Could interacting with the orphaned
child devices then cause a use-after-free?


[Severity: High]
This isn't a bug introduced by this patch, but missing sysfs cleanup on
subsequent probe failures leaves dangling attributes that access freed
memory.

Looking at rmi_driver_probe():

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
...
	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;

	if (data->input) {
...
			retval =3D input_register_device(data->input);
			if (retval) {
...
				goto err_destroy_functions;
			}
...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

If a step fails after rmi_f34_create_sysfs() (like input_register_device()),
the code jumps to err_destroy_functions, which does not call
rmi_f34_remove_sysfs().=20

Since data is freed by devres on probe failure, won't userspace accessing
these dangling sysfs files dereference the freed data pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103123.1221=
6-1-98lawweijie@gmail.com?part=3D2
