Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2223644C6
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708400; cv=none; b=gC7QC/NgsNdCoGINQ1z0YlC2gDvk7KRRKzL61XBRT+FojQEb2ra5IUf5yzzYPy4MRv2HcqEC+NmGkyJ9Ac3I48/+DK8XnYwnELxYeN23cRvX8yTuDt3ZIcanULExwxBKOY6SYDFSh1Y60Ee0cxuGTqSYBv0I84rDV75lWTMnufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708400; c=relaxed/simple;
	bh=b+Fs7E90lfKXf87VvPxiCA/kx9zdGd216OOE33rLzQw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SWPPfkWLOMqGulz1xYnu7H7pEt4kcHs+0n4JqUcQqOVjfPAv4Fj0oUUMGnZ+cr4EvzoGUaGXoaG0m0uLC+Cy9HQrSTQ8jrIHSy4xejPknm63hwzX+Bx1tBIKrjKtH8un60KcbV08i+ERTrIxHzHL3JFz2hv6W7RyvvNOBULiyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtPiGVKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtPiGVKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D977B1F0089B;
	Sun, 11 Oct 2026 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791708399;
	bh=TjaOQjpgEnPypVIviwZkRJMy6HZdo5AZTAcK3ahsxak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YtPiGVKo3Xn/s66oy/fs/9ab8GmGVrlo+4hdLpmcIw71aDfYka2gQ21vcm+rJNn+H
	 KDQRuEY6EOP6eRM1ohbJ15hCw81rHkGqmIyRc/2bdcJM2Jq0eKDoHlIseyYsbMsSD4
	 hjdlpfssfZ0sx3DipXcF2d28kkAsgGJc5/TMW9177uwhW41z66lzrWZVzF9hQhWYWd
	 bdOT7yKQZ2HaYmowfwVbCdqENb0EAH1l1U99UeioQCjrNhwzQBCYL3YxJ/A1H5TKZ4
	 BqFShBChtGfkIH7lzAbcbwuPbkpQXS5SxJkDsh88MmRlx+epvhDZCOaZ42H5NSQ5pt
	 cKUPNwXclrEsQ==
Message-ID: <sashiko-outbox-167132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] Input: synaptics-rmi4 - reject a PDT that grows
 between scans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261011083730.223083-3-98lawweijie@gmail.com>
References: <20261011083730.223083-1-98lawweijie@gmail.com>
 <20261011083730.223083-3-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 08:46:38 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: synaptics-rmi4: multiple resource leaks in rmi_driver_pro=
be error paths
--

commit 81cc67e5a61f0cfdb2ce1738f5778c94caef2b1c
Author: Wei Jie Law <98lawweijie@gmail.com>

    Input: synaptics-rmi4 - reject a PDT that grows between scans

This commit introduces a validation check in rmi_create_function() to preve=
nt
out-of-bounds writes if a device's interrupt count grows between Page
Description Table scans. It fails the probe by returning -EINVAL before
allocating memory for the invalid function.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 443ba41063524..b2ed5991b1970 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -898,6 +898,25 @@ static int rmi_create_function(struct rmi_device *rm=
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

[Severity: Medium]
Returning -EINVAL here aborts the device probe and exposes regressions where
the IRQ domain, function devices, and sysfs nodes are not properly freed in
the error handling paths of rmi_driver_probe() and its helpers.

First, does this error path permanently leak the IRQ domain? The domain is
allocated without devm in rmi_probe_interrupts():

drivers/input/rmi4/rmi_driver.c:rmi_probe_interrupts() {
	...
	data->irqdomain =3D irq_domain_create_linear(fwnode, irq_count,
						   &irq_domain_simple_ops,
						   data);
	...
	data->irq_memory =3D devm_kcalloc(dev, size, 4, GFP_KERNEL);
	if (!data->irq_memory) {
		dev_err(dev, "Failed to allocate memory for irq masks.\n");
		return -ENOMEM;
	}
	...
}

If devm_kcalloc() fails, it returns without calling irq_domain_remove().
Similarly, if rmi_create_function() returns -EINVAL (the new error path
added by this patch), the teardown block in rmi_driver_probe() fails to rem=
ove
the domain:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
	...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

Second, does jumping directly to the err label in rmi_driver_probe() leak
the RMI function devices?

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
	...
	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;
	...
}

If rmi_f34_create_sysfs() fails, the jump to the err label skips the
err_destroy_functions label and rmi_free_function_list(rmi_dev).

Finally, does the err_destroy_functions teardown block leave orphaned sysfs
nodes?

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
	...
	retval =3D rmi_irq_init(rmi_dev);
	if (retval < 0)
		goto err_destroy_functions;
	...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	...
}

If rmi_irq_init() or input_register_device() fails, the jump to
err_destroy_functions does not call rmi_f34_remove_sysfs(rmi_dev),
leaking the sysfs entries created earlier.

> +	}
> +
>  	fn =3D rmi_alloc_function(rmi_dev, pdt->function_number);
>  	if (!fn) {
>  		dev_err(dev, "Failed to allocate memory for F%02X\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011083730.2230=
83-1-98lawweijie@gmail.com?part=3D2
