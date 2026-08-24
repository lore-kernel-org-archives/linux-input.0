Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22615379EF5
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551477; cv=none; b=hr9kzV6Vph/HPLSSibIwmTWFfGjkcID5Y3Tic3VkE4u8uC64R2eFLmfBpgznlVuitwFNpvRoE3sH+y4Yd6zib/dz1myIh607gO8Hv4u42VQIE8aCKMegPIo4kfg8PgSEs85JY+sPZhp2Rr7a44Gl06j+p+88TCxLIUS3ryKvOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551477; c=relaxed/simple;
	bh=CiI1UreOj1aM/yOWdbwaWv3LawHZEwJGwYLovVdtekk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EcWQbGxQcacKewvSt1F9fN+rj6R701AB41Z/Z/xgEYnrJ74sSgF29X+FDSsfMRf/mI/VWHXm0OTq3ZPGLvAN73acwS353rtGddwXkDEUJZAY/PiVcVXkr+vYAogjb49yxfb4/x091vfq5l9X21gZT0TombBKTALG65oGX14qBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnfzZESS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnfzZESS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7EC1F00A3A;
	Mon, 24 Aug 2026 06:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787551475;
	bh=4/2K5YqVfleWs2kDrNs2pVYBPrLAG57BD+65fHh+aEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DnfzZESSodkCEMBB7tNN/XQDsqsGlHDQ8UxbRw//txKd7f4wQnxYnJef28FbxjQah
	 DO/6ZB5yFSPC7l0qUwx8Jr2+wtU2R7/b2aVr2wOqnMgMwGp8g1w1PqfvV2K6ZumB9Q
	 SmTdxI+vxu7+7KOrbsIsrxik0PTGb3i+nYxObB00rK0M9i93117h+HCfr69rGVrTCQ
	 9HyVRDidxVQGMQKt/cJDucB121OWoXAj19BTfZewZ1/DCvLcoaZ9VXEUlemNaFryrb
	 p1dstKcLieDkJODyWStPIbPmc7s1p5PGMZ0Q7+hk2Y1G175GOWOJfIqqmBeB/azRyi
	 AVFl2v6OY6oeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - reject a PDT that grows
 between scans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <2c26d7ce8c6b7371ab55607f53443961220e4b24.1787549234.git.98lawweijie@gmail.com>
References: <cover.1787549234.git.98lawweijie@gmail.com>
 <2c26d7ce8c6b7371ab55607f53443961220e4b24.1787549234.git.98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:04:35 +0000
Message-Id: <20260824060435.7C7EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The irq_domain allocated by irq_domain_create_linear() is leaked o=
n error paths during probe and firmware updates.
- [High] The RMI firmware sysfs group created by rmi_f34_create_sysfs() is =
leaked on error paths during probe, leading to a NULL pointer dereference.
- [High] Failure in rmi_f34_create_sysfs during probe skips child device cl=
eanup, leading to resource leaks and NULL pointer dereferences.
--

--- Patch [2]: [PATCH 2/2] Input: synaptics-rmi4 - reject a PDT that grows =
between scans ---
commit 55e35f385b70b6ccd0e388137406910db44c05ec
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - reject a PDT that grows between scans

This patch fixes an out-of-bounds access in rmi_create_function(). It adds
a validation check for fn->irq_pos + fn->num_of_irqs to ensure that a device
that grows its interrupt count between scans cannot walk past the end of the
flexible array. The probe will now fail instead of overflowing memory.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..c0e91a372eff4 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -899,6 +899,24 @@ static int rmi_create_function(struct rmi_device *rm=
i_dev,
>  	fn->irq_pos =3D *current_irq_count;
>  	*current_irq_count +=3D fn->num_of_irqs;
> =20
> +	/*
> +	 * irq_mask[] was sized from the interrupt count collected by the
> +	 * earlier rmi_count_irqs() scan of the PDT.  Nothing guarantees that
> +	 * this scan sees the same table -- the PDT is read back from the
> +	 * device every time -- so a device that grows its interrupt counts
> +	 * between the two scans would push these set_bit() calls past the end
> +	 * of the flexible array.  Refuse the function instead.
> +	 */
> +	if (fn->num_of_irqs > RMI_FN_MAX_IRQS ||
> +	    fn->irq_pos + fn->num_of_irqs > data->irq_count) {
> +		dev_err(dev,
> +			"F%02X: interrupt count changed between PDT scans (pos %u + %u > %d)\=
n",
> +			pdt->function_number, fn->irq_pos, fn->num_of_irqs,
> +			data->irq_count);
> +		put_device(&fn->dev);
> +		return -EINVAL;
> +	}
> +
>  	for (i =3D 0; i < fn->num_of_irqs; i++)
>  		set_bit(fn->irq_pos + i, fn->irq_mask);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does rmi_driver_probe() leak
the irqdomain allocated in rmi_probe_interrupts() on failure paths?

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

If any subsequent initialization step in rmi_driver_probe() fails, the error
path bypasses irq_domain_remove(), permanently leaking the domain.=20

Does this leak also occur during firmware updates when rmi_probe_interrupts=
()
is called repeatedly without cleaning up the previous irqdomain?

drivers/input/rmi4/rmi_f34.c:rmi_firmware_update() {
...
	ret =3D rmi_probe_interrupts(data);
	if (ret)
		return ret;
...
}

[Severity: High]
This is a pre-existing issue, but does the error path in rmi_driver_probe()
leave the f34 sysfs group active, potentially leading to a null pointer
dereference?

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
...
	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;

	if (data->input) {
		rmi_driver_set_input_name(rmi_dev, data->input);
		if (!rmi_dev->xport->input) {
			retval =3D input_register_device(data->input);
			if (retval) {
				dev_err(dev, "%s: Failed to register input device.\n",
					__func__);
				goto err_destroy_functions;
			}
...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

If input_register_device() fails, the code jumps to err_destroy_functions,
which cleans up the function list but neglects to call
rmi_f34_remove_sysfs().

When the probe fails, the driver core sets the device's drvdata to null. If
userspace accesses these stale files, callbacks will call dev_get_drvdata()
and dereference a null pointer.

[Severity: High]
This isn't a bug introduced by this patch, but does a failure in
rmi_f34_create_sysfs() bypass the cleanup for child functions?

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

If rmi_f34_create_sysfs() fails, the code jumps directly to the err label,
completely skipping the err_destroy_functions cleanup for the already
registered child functions.

When probe fails, the driver core clears drvdata and devres frees data,
leaving the child devices active and causing a null pointer dereference if
accessed from userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787549234.gi=
t.98lawweijie@gmail.com?part=3D2
