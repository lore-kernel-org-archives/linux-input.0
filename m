Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C6171B1
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628601; cv=none; b=l4cGlfmTq24L+L2ft0ZtSICM7WrtePt7GmVKXqwMGD7l9PMP0058WQiLLPZN6SwdPEJ/XXjHK10R6/e+/7HFhtW+N8UTCvhNHhJwrUwcksWqVBbdsmyGdcuBo/ACzplWTB7pA+AlLldn37h2utQXVgedL0IUqrAihiDwOjCSL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628601; c=relaxed/simple;
	bh=gm40c/7oT3OIdvyWBWpW8wACLC9VidLhg3ma8QNahVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1/H/Qr1K38OPLO1o7aK23VC/LuSQT3JNhuBOhxSCwUVRS5zO9szT85iQriVBgrcZF3dQViNd90kdkl9r8c8g2jtgopdwYhcqku4XWz0BYYOShYV+wGRR+Af6m2bBoPhmue007vnmyTSNLgw30G20nu/ZM5gTIwbeSnQNBnll9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fieqpBJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fieqpBJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9731F000E9;
	Tue, 25 Aug 2026 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787628599;
	bh=y+CPuh8V6KUIhCD6SAbpmrDvXu3Fyk48JEWd9kGmAfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fieqpBJMzMzTeE2deXJrQ0FnWtGACaHZTOPjO9hn5Om9V1sE78vjeR+z4+L9Z/jAv
	 5Rcf2+3RUThLj/Bpzbksbx0YJmItrKslt6Il86UGSL7qID6bHvFUsO4HJR+OLBPJJj
	 N1DhxPc04ZX0oHOCxx8j8AZn7TUXbCc6X/OleVb58Oql+3/7hfQxBNNOFIbQ71vYkT
	 N+xbJkTSIHonMui25kGEn4XtAOCn+ghHV13rhjCQD3C7Dz3m0DKpcdRu1fm0U86yx4
	 QnlQR7BoJG64kpl108sGQXtTMuNHytAk6wSvAI2rxTKBYkALwyWm0Np5UF9iYs6hqv
	 72wY7G7dQzuzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix input_dev->name
 use-after-free on unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825031315.51860-1-98lawweijie@gmail.com>
References: <20260825031315.51860-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 03:29:58 +0000
Message-Id: <20260825032959.1C9731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] TOCTOU race condition in sysfs name read leading to Use-After-Free.

Pre-existing issues:
- [High] Memory leak of IRQ domain on probe error and firmware update.
- [High] Use-After-Free due to bypassed function cleanup on sysfs creation =
failure.
- [High] Resource leak and Use-After-Free due to dangling sysfs group on pr=
obe failure.
- [High] NULL Pointer Dereference on F01 driver probe failure.
- [Medium] TOCTOU race condition causing memory leak of attention FIFO data.
--

--- Patch [1]: [PATCH] Input: synaptics-rmi4 - fix input_dev->name use-afte=
r-free on unplug ---
commit 9cd37129e649f20d52a9bc378f92b844e6f83fbd
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - fix input_dev->name use-after-free on unplug

rmi_driver_probe() reuses the transport driver's input device when it has
one, and then renames it out of memory owned by the RMI device. In the
borrowed case the name outlives its allocation. This commit puts the name
back to a static string when this driver lets go of an input device it
does not own.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..8696a6aa0fa9f 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -369,6 +369,24 @@ static void rmi_driver_set_input_name(struct rmi_dev=
ice *rmi_dev,
>  	input->name =3D name;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a NULL poin=
ter
dereference if the F01 driver probe fails?

In rmi_driver_set_input_name(), rmi_f01_get_product_ID() is called on
data->f01_container before verifying if the driver successfully bound:

drivers/input/rmi4/rmi_driver.c:rmi_driver_set_input_name() {
    ...
    const char *device_name =3D rmi_f01_get_product_ID(data->f01_container);
    ...
}

If the F01 hardware fails to communicate properly, the F01 driver's drvdata
might remain NULL. When rmi_f01_get_product_ID() fetches the drvdata and
dereferences it:

drivers/input/rmi4/rmi_f01.c:rmi_f01_get_product_ID() {
    ...
    struct f01_data *f01 =3D dev_get_drvdata(&fn->dev);
    return f01->properties.product_id;
}

Could this result in a kernel panic on initialization?

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
Is this non-atomic assignment safe against concurrent lockless sysfs reads?

If a concurrent sysfs read, such as input_dev_show_name(), fetches the old
devm_kasprintf allocated pointer just before this swap, could it dereference
the pointer after rmi_driver_remove() completes and devres frees the string?

Could this lead to a use-after-free if the sysfs reader is delayed and calls
sysfs_emit() with the freed pointer?

> +	input_put_device(data->input);
> +	data->input =3D NULL;
> +}
> +

[ ... ]

> @@ -1026,6 +1044,8 @@ static int rmi_driver_remove(struct device *dev)
>  	rmi_f34_remove_sysfs(rmi_dev);
>  	rmi_free_function_list(rmi_dev);
> =20
> +	rmi_driver_put_input(rmi_dev, data);
> +
>  	irq_domain_remove(data->irqdomain);
>  	data->irqdomain =3D NULL;
> =20

[Severity: Medium]
This is a pre-existing issue, but is there a race condition between
rmi_set_attn_data() and rmi_disable_irq() that could leak attention FIFO da=
ta?

In rmi_set_attn_data(), drvdata->enabled is checked locklessly before
allocating data and pushing it to the FIFO:

drivers/input/rmi4/rmi_driver.c:rmi_set_attn_data() {
    ...
    if (!drvdata->enabled)
        return;

    fifo_data =3D kmemdup(data, size, GFP_ATOMIC);
    ...
}

Concurrently, rmi_disable_irq(), which is called earlier during removal,
acquires the enabled_mutex, sets enabled to false, and flushes the FIFO:

drivers/input/rmi4/rmi_driver.c:rmi_disable_irq() {
    ...
    while (!kfifo_is_empty(&data->attn_fifo)) {
        count =3D kfifo_get(&data->attn_fifo, &attn_data);
    ...
}

If rmi_set_attn_data() reads enabled as true just before it is set to false,
could it append the allocated item to the FIFO after rmi_disable_irq() has
already flushed it? Since no further flushes occur upon driver removal, wou=
ld
this dynamically allocated memory be leaked?

[ ... ]

> @@ -1287,6 +1307,7 @@ static int rmi_driver_probe(struct device *dev)
>  err_destroy_functions:
>  	rmi_free_function_list(rmi_dev);
>  err:

[Severity: High]
This isn't a bug introduced by this patch, but does the error path bypass
function cleanup if rmi_f34_create_sysfs() fails?

In rmi_driver_probe(), if rmi_f34_create_sysfs() fails, the code executes
a goto to the err label:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
    retval =3D rmi_f34_create_sysfs(rmi_dev);
    if (retval)
        goto err;
    ...
}

This bypasses the err_destroy_functions label, leaving the child RMI functi=
on
devices registered. When the driver core cleans up the probe failure, it fr=
ees
the devres-managed data. Would any subsequent callbacks on the leaked child
devices dereference the freed data and cause a use-after-free?


[Severity: High]
This is a pre-existing issue, but does this error path leave a dangling sys=
fs
group if input_register_device() fails?

If input_register_device() fails later in rmi_driver_probe(), the code jumps
to err_destroy_functions, but rmi_f34_remove_sysfs() is never called:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
    retval =3D input_register_device(data->input);
    if (retval) {
        ...
        goto err_destroy_functions;
    }
    ...
}

Since the transport device outlives the probe failure, do the sysfs attribu=
tes
remain active? Could reading these attributes trigger callbacks that access
the freed devm-managed data, resulting in a use-after-free?


[Severity: High]
This is also a pre-existing issue, but does jumping to the err label leak t=
he
IRQ domain?

In rmi_probe_interrupts(), irq_domain_create_linear() allocates an IRQ doma=
in
which is not managed by devres:

drivers/input/rmi4/rmi_driver.c:rmi_probe_interrupts() {
    ...
    data->irqdomain =3D irq_domain_create_linear(fwnode, irq_count, &irq_do=
main_simple_ops, data);
    ...
}

If a subsequent step in rmi_driver_probe() fails and jumps to the err or
err_destroy_functions labels, irq_domain_remove() is omitted. Additionally,
since rmi_firmware_update() calls rmi_probe_interrupts() on every flash
operation without destroying the previously created domain, does this result
in repeated memory leaks?

> +	rmi_driver_put_input(rmi_dev, data);
>  	return retval;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825031315.5186=
0-1-98lawweijie@gmail.com?part=3D1
