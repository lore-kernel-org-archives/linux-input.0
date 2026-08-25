Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F83C09E3
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638912; cv=none; b=o9YO0I+qzPTQVJx4UcNK12iy2ER77280F50UZ001nVW2xCdY6i+fRIlE9uDFCnur9UsCuh/sm5gUZzWbRsLkGvobT1Cmb+uAvXzyq74XyzPaCUeOKwA4vQS2LYqO/xKFGEnR+P0SY46l/i9Mz58RLWuUd+ehjW3xc4IXmWwTZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638912; c=relaxed/simple;
	bh=rGL/9kP/DbsbmssnmNiqFmEa5nz82X7nOdEw5x7NlUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eFBVF/drfBMLEJm2XTX2vT3R3yVf02Su6AWbPOMA0rw4rqAULSU1nWtLmAtUcVy5hx8IfR+LECltaGTKHrmI602uQjIdsRftSyMDalviaDsqTi4tfb8XYiC2eVcdYX+qIU9z2mRVWOzL4lNU+X5CDyVkaZ4NF6bir8igGAJm6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyiDclbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyiDclbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1206E1F000E9;
	Tue, 25 Aug 2026 06:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787638911;
	bh=tlacqhFwyno4BxdBtW/fuPL3OFocn5QOiilw6e1BxOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MyiDclbMw6fb1vZlJ52QlxQdYDH4yyyD8Ou84tiKIw+eIHrUMeWvxfyyZ/KRmp1JG
	 sPNUFSyVkWBh/Ifk/mr74pSd8Pflx5fEktkw2+4lT9iije0dOzPRhy1Cka5QVFq5ht
	 3iEflMwDq751FeQceZDfxJXAoXITMKX7v5n36l+eHAShPrbrsA9/7n2qmjGBzX4+RA
	 vAi2PJIM/TNRE+k2+2VnzMPKZ3rq9wgn0aZot7uXbu2I7slghIIKvhKnJjHZzKGfp7
	 sToegb6z5X5UbFvT0nLiS+4CDb46V0kLjJfuVdcZihOTGBbLJvr4K9zciPn+fLBytH
	 rQ0EjIgpBJitA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Input: synaptics-rmi4 - reject a PDT that grows
 between scans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie LAW" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825061027.105062-3-98lawweijie@gmail.com>
References: <20260825061027.105062-1-98lawweijie@gmail.com>
 <20260825061027.105062-3-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:21:50 +0000
Message-Id: <20260825062151.1206E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If rmi_f34_create_sysfs() fails during probe, the error path skips=
 function cleanup, leading to a use-after-free of the driver's private data=
 and leaking registered devices.
- [High] Concurrent sysfs writes to the `update_fw` attribute execute firmw=
are updates without serialization, leading to list corruption, data races, =
and potential double-frees.
--

--- Patch [2]: [PATCH v3 2/2] Input: synaptics-rmi4 - reject a PDT that gro=
ws between scans ---
commit 2fad09409bb9588b1763723ac01bfc86aa11a46f
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - reject a PDT that grows between scans

This commit validates the interrupt counts gathered during Page Description
Table (PDT) scans to ensure they haven't grown between consecutive reads fr=
om
the device. By checking the counts before allocating the function, it preve=
nts
an out-of-bounds write in the flexible array at the end of struct rmi_funct=
ion.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..f66be55677a94 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c

[ ... ]

While reviewing this code, I noticed a couple of pre-existing issues in the
surrounding functions.

In drivers/input/rmi4/rmi_driver.c:rmi_driver_probe():

	retval =3D rmi_init_functions(data);
	if (retval)
		goto err;

	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;

[Severity: High]
This isn't a bug introduced by this patch, but if rmi_f34_create_sysfs() fa=
ils
during probe, the error path jumps to 'err', which bypasses
err_destroy_functions.

Does this skip rmi_free_function_list() and leave the registered rmi_functi=
on
child devices active? Because rmi_driver_probe() returns an error, the driv=
er
core cleans up the devm-managed struct rmi_driver_data. Any subsequent acce=
ss
by the still-active child devices could dereference the freed driver data,
leading to a use-after-free.

Should this error path use goto err_destroy_functions instead?


In drivers/input/rmi4/rmi_f34.c:rmi_driver_update_fw_store():

	error =3D rmi_firmware_update(data, fw);
	if (error)
		return error;

[Severity: High]
This is a pre-existing issue, but does this sysfs attribute lack serializat=
ion?

If multiple threads write to the update_fw sysfs file concurrently, they wi=
ll
execute rmi_firmware_update() simultaneously:

drivers/input/rmi4/rmi_f34.c:rmi_firmware_update() {
	...
	/* Tear down functions and re-probe */
	rmi_free_function_list(rmi_dev);
	...
}

Because rmi_free_function_list() modifies the global data->function_list wi=
thout
any synchronization, won't concurrent execution corrupt the linked list and=
 lead
to double-frees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825061027.1050=
62-1-98lawweijie@gmail.com?part=3D2
