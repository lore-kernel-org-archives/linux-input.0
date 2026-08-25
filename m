Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9803DB994
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654897; cv=none; b=SJmPvNQIlSoU+N47e2zMjt0LAp6z7XsqOGVn8Vs43wXeFKPkkB4eJaqWD9BN2LIFU7lngDR5L73PJ79OppAUqgWWSvWuDn6x7bzj+Q1TlxFRYROBzFmANKeBzqj0YqkmYRhxR874DSH/oAur1qL3r9/YHSRM+Anr7BqyqOt1wMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654897; c=relaxed/simple;
	bh=FXJXHXgjaYNh7GEDmCd8R4XlniuvTaEMHX2X+7KnEZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EgmofNSzQa3L7qobTUTPtraFQKM/5/jM1cTJ0XerlNKAiZH+kqi6CjyD+S5aNiWKJL9667tYXxYtcHs8JUEsSGdI2tixITRRnS7c9sxaosNZR4I/qlzMc+GZtTCLuDmkn6F6cDMohx1kERDEtJocGSPYBrU5OgVt7JHBq80aaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO6Mzi+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO6Mzi+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D0F1F000E9;
	Tue, 25 Aug 2026 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654896;
	bh=gTZZ4MVJ+Uc4BIBPfKfxHHj2FD+7pLwr2lDZRCAeZ1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bO6Mzi+nmSxbGlt/R6id+RCFy6F8VLAyrm6ER5JnvrluzpUtC6JSPfaLRU562LZzo
	 8SlbVia5/u55R0SyRWCJWWpbgSGaXFrqW7hJz5hTC7JzZzcqO20DxjMUh28iuDucQg
	 vPZ1wSBFqiI5UmRu29S4ImU2nXhnAGhO3C3xx/7RxmUN8jonvKIBb2E9snQ/Z1LMM8
	 b24FvSUgbjj1ciAJ6Vdzu8dsIFLGhwMkvkDd6rZyjwXj/lXkS/7VXmKYDh5RiMh6WK
	 9FDedpbk99DVglLkYtYLGe33XXp+b1mu1rPEGM7b34Sbc6GXUpNCGgFebVDMMPCuLx
	 +1T23wf+mRbeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: synaptics-rmi4 - fix input_dev->name
 use-after-free on unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825103139.12314-1-98lawweijie@gmail.com>
References: <20260825103139.12314-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:48:15 +0000
Message-Id: <20260825104815.D3D0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Bypassed cleanup of RMI functions on sysfs creation failure leads =
to memory leak and Use-After-Free.
- [High] Dangling sysfs group on probe error paths leads to NULL Pointer De=
reference (Kernel Oops).
- [High] Leak of non-devm irqdomain on all probe error paths leads to Use-A=
fter-Free.
- [High] TOCTOU race in sysfs `name` attribute read leading to Use-After-Fr=
ee.
--

--- Patch [1]: [PATCH v2] Input: synaptics-rmi4 - fix input_dev->name use-a=
fter-free on unplug ---
commit d914ebc7a5687cdc5cb5971b151029cd0e21cbb8
Author: Wei Jie Law <98lawweijie@gmail.com>
Input: synaptics-rmi4 - fix input_dev->name use-after-free on unplug

The commit fixes a use-after-free on input_dev->name when an RMI device is
unplugged. The transport driver's input device is reused, but its name is
assigned to memory owned by the RMI device. This causes the name to be freed
before the input device is unregistered. The patch restores the name to a
static string before dropping the reference.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..8696a6aa0fa9f 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -369,6 +369,24 @@ static void rmi_driver_set_input_name(struct rmi_dev=
ice *rmi_dev,
>  	input->name =3D name;
>  }
> =20
> +/*
> + * Let go of an input device that belongs to the transport driver.  It o=
utlives
> + * us, but rmi_driver_set_input_name() pointed its name at devres memory=
 of
> + * ours that is freed as soon as we are done - input_register_device() a=
nd both
> + * the add and the remove uevent print that name - so put the name back =
to a
> + * string with static storage duration before dropping the reference.
> + */
> +static void rmi_driver_put_input(struct rmi_device *rmi_dev,
> +				 struct rmi_driver_data *data)
> +{
> +	if (!data->input || data->input !=3D rmi_dev->xport->input)
> +		return;
> +
> +	data->input->name =3D SYNAPTICS_INPUT_DEVICE_NAME;

[Severity: High]
This isn't a bug introduced by this patch, but could swapping this pointer
cause a TOCTOU race for lockless sysfs readers?

The sysfs name_show() function reads input_dev->name without locking.
If a concurrent sysfs reader thread loads the old devm-allocated string
pointer just before data->input->name is updated here:

CPU1
sysfs reader
    // reads input_dev->name (old devm string)

CPU2
rmi_driver_put_input()
    data->input->name =3D SYNAPTICS_INPUT_DEVICE_NAME;

When rmi_driver_remove() completes, devres frees the old string. If the
preempted sysfs reader resumes and uses the old pointer, will it cause a
use-after-free?

> +	input_put_device(data->input);
> +	data->input =3D NULL;
> +}
> +

[ ... ]

> @@ -1287,6 +1307,7 @@ static int rmi_driver_probe(struct device *dev)
>  err_destroy_functions:
>  	rmi_free_function_list(rmi_dev);
>  err:

[Severity: High]
This is a pre-existing issue, but does rmi_driver_probe() leak RMI functions
if sysfs creation fails?

In rmi_driver_probe(), if rmi_f34_create_sysfs() fails, the code jumps
directly to err:

	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;

This bypasses err_destroy_functions:, which calls rmi_free_function_list().
Since the driver's devres memory is freed upon probe failure, will any
function devices left in data->function_list cause a use-after-free later?

[Severity: High]
This is a pre-existing issue, but does the probe error path leave dangling
sysfs files?

If probe fails after rmi_f34_create_sysfs() successfully creates the sysfs
group, the error handling jumps to err_destroy_functions: or
err_disable_irq:. None of these paths call rmi_f34_remove_sysfs().

Because the device is only unbound and not destroyed, the sysfs files remain
accessible. If userspace reads the lingering sysfs file, dev_get_drvdata(de=
v)
returns NULL. Could this cause rmi_driver_update_fw_status_show() to
dereference a NULL pointer?

[Severity: High]
This is a pre-existing issue, but does rmi_driver_probe() leak the irqdomain
on error paths?

In rmi_probe_interrupts(), the irqdomain is allocated:

	data->irqdomain =3D irq_domain_create_linear(fwnode, irq_count,
						   &irq_domain_simple_ops,
						   data);

If any failure occurs during probe, the code funnels to err: and returns
without calling irq_domain_remove().

Since the driver core frees data via devres, the leaked irqdomain retains a
freed host_data pointer. Will subsequent IRQ lookups reference this freed
memory?

> +	rmi_driver_put_input(rmi_dev, data);
>  	return retval;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103139.1231=
4-1-98lawweijie@gmail.com?part=3D1
