Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA693A6EEE
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991880; cv=none; b=d/CLQAXhVRRDeo2OX6a9tNMIHi5GZDMU8BegHAdoch7E8B3Rh+f9kNbO4c1REFxmbDNyNar6NfQ6NatiGRd514CcSt8eWdkzlJ2NouaXxPN9WqwI0CDs52Tih+bkubGSRj4Ikb3q/BG13Y9S9UPETqdBG3myb6AnU+Tzm2y1cmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991880; c=relaxed/simple;
	bh=JXEBRll1Qj/MJSpdaLyy/Mm7If7oebDKA6bSeiKqsxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rScbkhtB7J/cibP22Uh10/N/10HYutUMc/Ve8+5J/0Xi3Ajg5xt8+mKWcM8E99BvIH+RgUMawb1U5BDwG1ovW42pJmvtQZ5XW12v2buOHr+dt8WfXOrVyuBhNECQOVuKTziUAkGRZ4VSPkLeway/v4QrTcc//mDONpYzfGY7Pho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzHsEgxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzHsEgxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C98B1F000E9;
	Mon, 17 Aug 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786991879;
	bh=g61AOhYRRaI3NSFs/APuto+0sAJ37evSZCHKI/tmv/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzHsEgxvLeWYjmuAXbmsCSx18tW+4vU0ehVqw6/bFLN90Ri1lqsRZyBYlI1MOvwRJ
	 r1N2TEgPbobTx7dXcnTmLSZz+HZu5+IEzCpW8edbCGT9ya3iNf4N9IjltedsXV2zpT
	 mdyqJEhvly3V2fEBYPOCvkyi8tj1Hfg/R+jBt6BozTuEhr0GCE2kTSIhZiVaPThMw1
	 fvEOyUDgSAOa/kjUZpsI0d7uFk/9DHwiRpMxAAutyX+l3n+PtgGyE8drg5+BfIJW1D
	 6yYIxP2lX6Ug0228Nurt4a2ecqL6DYt2rozPJMQnoOynlNK2vaelhyIGr0O3RVxHEl
	 ePsL1IIBgm98g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - reject concurrent firmware
 updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuangpeng Bai" <shuangpeng.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260817182205.906592-1-shuangpeng.kernel@gmail.com>
References: <20260817182205.906592-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:37:58 +0000
Message-Id: <20260817183759.1C98B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless polling of sysfs attributes (e.g., `update_fw_status`) co=
ncurrently with a firmware update leads to Use-After-Free and NULL pointer =
dereferences.
- [High] Missing NULL check for `f34` driver data during re-probe in `rmi_f=
irmware_update()` leads to kernel panic.
- [High] Firmware updates unconditionally re-enable IRQs upon completion, b=
ypassing driver teardown intent and exposing destroyed data structures to t=
he IRQ handler.
- [High] If `rmi_driver_probe` fails after creating sysfs attributes, the s=
ysfs group is not removed, leading to a zombie sysfs interface.
- [Medium] Repeated firmware updates permanently leak `struct irq_domain` m=
emory.
- [Medium] The final firmware update status is immediately lost upon failur=
e, causing userspace to falsely read success.
--

--- Patch [1]: [PATCH] Input: synaptics-rmi4 - reject concurrent firmware u=
pdates ---
commit 9b19909f9bcb9b5bdbd8eed13e175804af90a281
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

Input: synaptics-rmi4 - reject concurrent firmware updates

This patch introduces a mutex to reject concurrent firmware updates. The
update_mutex is added to prevent multiple overlapping calls to
rmi_firmware_update() from tearing down and rebuilding the RMI function
list simultaneously.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..3a5cb17e938fe 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -1218,6 +1218,7 @@ static int rmi_driver_probe(struct device *dev)
> =20
>  	mutex_init(&data->irq_mutex);
>  	mutex_init(&data->enabled_mutex);
> +	mutex_init(&data->update_mutex);
> =20
>  	retval =3D rmi_probe_interrupts(data);
>  	if (retval)

[Severity: High]
This is a pre-existing issue, but if rmi_driver_probe() fails later in the
function (for example, in rmi_irq_init), does the error path leak the sysfs
group?

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;
    ...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

The error path doesn't seem to call rmi_f34_remove_sysfs(), which leaves
active world-readable sysfs attributes on the device while the devres
framework frees the driver data. Can this lead to a use-after-free when
reading those attributes?

[Severity: Medium]
This isn't a bug introduced by this patch, but does rmi_probe_interrupts()
leak the struct irq_domain memory when called repeatedly?

During rmi_firmware_update(), rmi_probe_interrupts() is called multiple
times to transition into and out of bootloader mode:

drivers/input/rmi4/rmi_driver.c:rmi_probe_interrupts() {
    ...
	data->irqdomain =3D irq_domain_create_linear(fwnode, irq_count,
						   &irq_domain_simple_ops,
						   data);
    ...
}

It seems irq_domain_create_linear() is called unconditionally, overwriting
data->irqdomain without removing the previous one. Does this cause a
permanent memory leak of the irqdomain during firmware updates?

[ ... ]

> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index f1947f03b06af..04f12165cab05 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -468,13 +468,15 @@ static ssize_t rmi_driver_update_fw_store(struct de=
vice *dev,
>  	if (error)
>  		return error;
> =20
> +	if (!mutex_trylock(&data->update_mutex))
> +		return -EBUSY;
> +
>  	dev_info(dev, "Flashing %s\n", fw_name);
> =20
>  	error =3D rmi_firmware_update(data, fw);

[Severity: High]
This is a pre-existing issue, but does lockless polling of the
update_fw_status attribute concurrently with rmi_firmware_update() lead to
a use-after-free?

During a firmware update, rmi_firmware_update() tears down the function
list, which frees data->f34_container in rmi_free_function_list() before
setting it to null:

drivers/input/rmi4/rmi_driver.c:rmi_free_function_list() {
    ...
		rmi_unregister_function(fn);
    ...
}

If a concurrent reader accesses the update_fw_status attribute, could it
fetch data->f34_container locklessly and dereference its .dev field while
it is being destroyed?

[Severity: Medium]
This is a pre-existing issue, but is the final firmware update status lost
upon failure?

At the end of rmi_firmware_update(), if the flash operation fails, the
error code is saved:

drivers/input/rmi4/rmi_f34.c:rmi_firmware_update() {
    ...
	if (ret) {
		f34->update_status =3D ret;
    ...
	rmi_free_function_list(rmi_dev);
    ...
}

However, it seems rmi_free_function_list() is called immediately after,
which destroys the f34 structure. When userspace reads the status later,
would it observe a newly zero-initialized f34_data context, effectively
losing the actual error code and falsely reporting success?

[Severity: High]
This is a pre-existing issue, but is there a missing null check for f34
during the re-probe in rmi_firmware_update()?

drivers/input/rmi4/rmi_f34.c:rmi_firmware_update() {
    ...
	f34 =3D dev_get_drvdata(&data->f34_container->dev);

	/* Perform firmware update */
	if (f34->bl_version >=3D 7)
    ...
}

If the internal f34 probe fails during rmi_init_functions(), the device
might remain unbound with a null driver data pointer. Could dereferencing
f34->bl_version unconditionally trigger a kernel panic here?

[Severity: High]
This is a pre-existing issue, but do firmware updates unconditionally
re-enable interrupts, potentially exposing destroyed data structures?

If device removal happens concurrently with a firmware update,
rmi_driver_remove() disables interrupts and blocks on sysfs removal waiting
for the update to complete:

drivers/input/rmi4/rmi_driver.c:rmi_driver_remove() {
    ...
	rmi_disable_irq(rmi_dev, false);
	rmi_f34_remove_sysfs(rmi_dev);
    ...
}

However, rmi_firmware_update() unconditionally calls rmi_enable_irq()
before returning:

drivers/input/rmi4/rmi_f34.c:rmi_firmware_update() {
    ...
	rmi_enable_irq(rmi_dev, false);
    ...
}

Does this bypass the driver teardown intent and allow interrupts to fire
while rmi_driver_remove() proceeds to tear down the function lists, causing
a use-after-free?

> -	if (error)
> -		return error;
> =20
> -	return count;
> +	mutex_unlock(&data->update_mutex);
> +	return error ?: count;
>  }
> =20
>  static DEVICE_ATTR(update_fw, 0200, NULL, rmi_driver_update_fw_store);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817182205.9065=
92-1-shuangpeng.kernel@gmail.com?part=3D1
