Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6955415F0F
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657093; cv=none; b=Tsc2qVaRr7aYJO9YFg18o3gZ/PNYKfKHF9GCoofnSAX/ZCI9YS2l2ag2IOry+b9vdXjJavSUsY5PmAJ0NIj9lXR4ofcrw0H2oO7XwfJSv5590ZjPhM05La6tOYW2OC9MVsrfs22yxWlkDUjBMGDC5jBLSHyyc6XjhpR6PDMTAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657093; c=relaxed/simple;
	bh=HLC7L0FkhZxPYBQWSyXTnpDYkgJandfMGamnqqw3GEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEMuVFNNeOcQbxey8lLfDXjFVqV+r9nqQFEk5IQq2TOUfnDkiNp2RNmVChMKi3PrprbTrLnuX3XjQBrdi1AmtWtb5IJIyrlCPIp4cjYaF5O8+P9DQd15NzJveU0Wa4cw+YMtVBj/5ZsD5BqHD7J5GP2uUQ0gKtUjcXXAz+ySu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me7v6pa2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me7v6pa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774131F000E9;
	Tue, 21 Jul 2026 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784657091;
	bh=Ze5jnGBBQB30Q8vbmzTaDOPC3H0UPYaKt0U7aNnjDrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=me7v6pa2Tl4TzBgtQP93e+FV7iCXxWdT5zp9bGUF4jPYlBZzz/OX3BtwTkmsDwtNN
	 7rgp/611hgPOwnyUGs4WvkMgMiI1VLtiWuS4vrtaNy6n2lEaXRRtqAwv/yUSiZUqyU
	 UAXMIIwHp1DPigx9ZXB9GrYkka7zrQe8zJ/WuQxsHbMpu1Dp+uZFoXWQ8wYj9e5kA2
	 afhbdPjAlxZxrYhpyALy724kpfv5xeSj48JDvnMZRYh90Osdplt0PEzDBxvBhTrzoL
	 6P9aibDv0uhGd2bjNCZIb8ZZEIy2B05VFcCzQK+BI/iL5fri1poAbNqxCZt/VQfxVK
	 cpp8Nori3TIVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] HID: amd_sfh: Add accessor to read the
 operating-mode sensor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721174422.3109166-2-Basavaraj.Natikar@amd.com>
References: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
 <20260721174422.3109166-2-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:04:51 +0000
Message-Id: <20260721180451.774131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The auxiliary device created for the tablet-mode switch is never d=
estroyed, leaking memory and leaving dangling device registrations.
- [High] Reading the operating mode on a v1.0 device accesses a register th=
at is corrupted by DMA addresses, returning invalid data.
- [Medium] The `amd_sfh_deinit_emp2_action` devres action is registered pre=
maturely and unconditionally clears the global `emp2` pointer, potentially =
corrupting global state.
- [Medium] The global `emp2` pointer is published before asynchronous initi=
alization completes, causing data races on dynamically populated structures.

Pre-existing issues:
- [High] Exported APIs accessing the global `emp2` pointer lack synchroniza=
tion, leading to a potential use-after-free and unmapped MMIO access if the=
 device is concurrently unbound.
--

--- Patch [1]: [PATCH 1/3] HID: amd_sfh: Add accessor to read the operating=
-mode sensor ---
commit 1243ba22a0e430d7c20b9d71ce0f64ee46332ff2
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Add accessor to read the operating-mode sensor

Allow other drivers to query the operating mode (laptop or tablet)
reported by the Sensor Fusion Hub. This is the interface used by the
tablet-mode switch driver to report the device posture to userspace.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-s=
fh-hid/amd_sfh_client.c
> index 96ae792beeb6c..0f5346d2174c2 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
[ ... ]
> @@ -383,3 +383,19 @@ int amd_sfh_hid_client_deinit(struct amd_mp2_dev *pr=
ivdata)
> =20
>  	return 0;
>  }
> +
> +bool amd_sfh_op_idx_enabled(struct amd_mp2_dev *mp2)
> +{
> +	struct amdtp_cl_data *cl =3D mp2->cl_data;
> +	int i;
> +
> +	if (!cl)
> +		return false;
> +
> +	for (i =3D 0; i < cl->num_hid_devices; i++)
> +		if (cl->sensor_idx[i] =3D=3D op_idx &&
> +		    cl->sensor_sts[i] =3D=3D SENSOR_ENABLED)
> +			return true;
> +
> +	return false;
> +}

[Severity: High]
Does enabling this operating mode index leak the auxiliary device?

When amd_sfh_op_idx_enabled() returns true, it appears to trigger the
creation of mp2->tm_auxdev in amd_sfh_maybe_register_tm():

drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:amd_sfh_maybe_register_tm() {
	...
	present =3D mp2->sfh1_1_ops ? mp2->dev_en.is_sra_present
				  : amd_sfh_op_idx_enabled(mp2);
	if (!present)
		return;

	mp2->tm_auxdev =3D auxiliary_device_create(&mp2->pdev->dev, KBUILD_MODNAME,
						 "tabletmode", NULL, 0);
	...
}

However, amd_mp2_pci_remove() does not seem to destroy this auxiliary
device, which could leave a dangling sysfs registration and leak memory
if the device is unbound.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index 4b81cebdc3359..a3672a9302c5d 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
[ ... ]
> @@ -471,6 +477,10 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *i
>  	if (rc)
>  		return rc;
> =20
> +	rc =3D devm_add_action_or_reset(&pdev->dev, amd_sfh_deinit_emp2_action,=
 NULL);
> +	if (rc)
> +		return rc;
> +

[Severity: Medium]
Could this unconditionally clear the global emp2 pointer on a probe failure?

If devm_add_action_or_reset() is called before the device successfully
assigns its privdata to emp2 (which happens later in probe), and a
subsequent probe step fails, the devres cleanup will fire.

Will this wipe the emp2 pointer via sfh_deinit_emp2() even if it is
currently owned by another active device in a multi-device scenario?

>  	privdata->sfh1_1_ops =3D (const struct amd_sfh1_1_ops *)id->driver_data;
>  	if (privdata->sfh1_1_ops) {
>  		if (boot_cpu_data.x86 >=3D 0x1A)
> @@ -480,6 +490,7 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *i
>  		if (rc)
>  			return rc;
> =20
> +		sfh_set_emp2(privdata);
>  		schedule_work(&privdata->work);
>  		return 0;
>  	}

[Severity: Medium]
Is there a data race when publishing the device globally before the workque=
ue
finishes?

sfh_set_emp2() exposes the device to exported APIs like amd_get_sfh_info().
If that API is called concurrently, amd_sfh_op_idx_enabled() might lockless=
ly
iterate over cl->num_hid_devices and cl->sensor_idx[] while they are still
being populated by the workqueue in amd_sfh_hid_client_init().

> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers=
/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
> index 837d59e7a6610..74b3d3382a82c 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
[ ... ]
> @@ -81,12 +81,43 @@ void sfh_deinit_emp2(void)
>  	emp2 =3D NULL;
>  }
> =20
> +void sfh_set_emp2(struct amd_mp2_dev *mp2)
> +{
> +	emp2 =3D mp2;
> +}
> +
> +static int amd_sfh_op_mode_info(u32 *op_mode)
> +{
> +	struct sfh_op_mode mode;
> +	bool present;
> +
> +	if (!op_mode)
> +		return -EINVAL;
> +	if (!emp2)
> +		return -ENODEV;

[Severity: High]
This is a pre-existing issue, but does this lockless check of emp2 create a
race condition with device unbind?

If a privileged user unbinds the SFH PCI driver concurrently, the teardown
path unmaps the MMIO, frees privdata, and the devres action clears emp2.
Could the querying thread dereference emp2 after it has been freed if the
unbind happens immediately after this !emp2 check?

> +
> +	present =3D emp2->sfh1_1_ops ? emp2->dev_en.is_sra_present
> +				   : amd_sfh_op_idx_enabled(emp2);
> +	if (!present)
> +		return -ENODEV;
> +
> +	mode.val =3D readl(emp2->mmio + amd_get_c2p_val(emp2, 3));

[Severity: High]
Will this read corrupted data on v1.0 hardware?

On v1.0 hardware, amd_start_sensor() uses a 64-bit writeq() to AMD_C2P_MSG2
to program the sensor's DMA address:

drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:amd_start_sensor() {
	...
	writeq(info.dma_address, privdata->mmio + AMD_C2P_MSG2);
	...
}

This 64-bit write spans both AMD_C2P_MSG2 and AMD_C2P_MSG3. Since
amd_get_c2p_val(emp2, 3) accesses AMD_C2P_MSG3, will it return the upper
32 bits of a DMA address instead of the actual operating mode?

> +	dev_dbg(&emp2->pdev->dev,
> +		"op-mode: raw=3D0x%08x mode=3D%u lid=3D%u angle=3D%u ontable=3D%u devm=
ode=3D%u\n",
> +		mode.val, mode.op_mode.mode, mode.op_mode.lidstatus,
> +		mode.op_mode.angle, mode.op_mode.ontablestate,
> +		mode.op_mode.devicemode);
> +	*op_mode =3D mode.op_mode.mode;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174422.3109=
166-1-Basavaraj.Natikar@amd.com?part=3D1
