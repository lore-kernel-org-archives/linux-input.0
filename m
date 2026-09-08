Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD058FD05
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887716; cv=none; b=J/3IUQ83Sx1GemWgdTMbsOYcOwSakFlmh/DufbhKcALNgk1W68uhrs7u0Ulpq71+Sb6ZREI5KGoUClYY5LzQ/b8YKt+hEe2yKdloDrmm25WqM4Y1CVpoppT8lemO1blzGiF0KE9sVhEPUXsugR715QKiwZtM6IOVvUugL6WOoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887716; c=relaxed/simple;
	bh=8swcAGyxQPRPvhaN/qcTG3iXxUihthisIuSgkh+xBMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CVcLhwc0rr7XQrkIclvt8kz4PI+5ffTJ2sgrnMP/9s9fyOzubGw03Q4tvayjJbkwKfoOu7Do5j5kb1FyyJZ9bjJmWxOEOcUdoDzpmdgjtNDM9l4B+/ErDpIy71R9NHJmhDoTJLRdMaas8SBhAQvGV3z4KaTvquzSo2+oQh70SZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZBr5V14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZBr5V14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F0E1F00A3E;
	Tue,  8 Sep 2026 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887715;
	bh=m1upmG9zJC0t8wFVtsX2gBKOfowG4qG4zEIezkxMpec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZBr5V14874YzF+dxm0FDusLHclCdWECutopLrJJia3YozfDNndkImn4QCX+ZIzLW
	 fQV22Q9FWFeLPtc7XgYU/1SuI4fZ6f1J0bzX0krSGUQskPnB0ur7vS0j/SotvmxRN/
	 Qqq7DJ2yf5GLxSMtpcLuwDl+5SlPGfJylv9WMgFCNhLY5QYLjL3OT/IhX8WgEZjNfv
	 kVZTaZ8cI8b12OFr6T5qNmxY9RntKP6fMmTpABqEKWR24cP5TTjdpusfOKty3YMazv
	 JQVKZfoVpsJqT58431PEBGlsWUTCghox8pSNlXUU3FqjVPX9RdeVOb3RIrbq43Fvwl
	 aB3IFcalPhboA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix NULL dereference in the PM
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yogesh Gaur" <yogeshgaur.83@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908165925.2030-1-yogeshgaur.83@gmail.com>
References: <20260908165925.2030-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:15:14 +0000
Message-Id: <20260908171514.E2F0E1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free during concurrent device unbind and runtime suspend=
 due to flawed lockless check.

Pre-existing issues:
- [Critical] Slab Out-Of-Bounds read in `rmi_hid_read_block()` due to unval=
idated `read_input_count`.
- [Critical] Heap Buffer Overflow in `rmi_hid_write_block()` due to unvalid=
ated write length.
- [High] NULL pointer dereference in `rmi_set_attn_data()` due to unbound d=
river.
- [High] Use-After-Free due to inverted teardown order of asynchronous rese=
t work in `hid-rmi.c`.
- [High] Memory and resource leaks in `rmi_driver_probe()` error handling p=
aths.
--

commit 8770ae261623b4b40a29cfb4b477b2a4585aca4a
Author: Yogesh Gaur <yogeshgaur.83@gmail.com>

Input: synaptics-rmi4 - fix NULL dereference in the PM callbacks

rmi_driver_suspend() and rmi_driver_resume() are exported for the
transport drivers; hid-rmi calls them straight from its ->suspend and
->resume. Both reach code that dereferences the driver data right away:
[ ... ]

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..cff9209ec0b37 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -991,6 +991,14 @@ int rmi_driver_suspend(struct rmi_device *rmi_dev, b=
ool enable_wake)
>  {
>  	int retval;
> =20
> +	/*
> +	 * The transport driver registers rmi_dev before this driver has bound
> +	 * to it, so a PM transition can reach here while the driver data does
> +	 * not exist yet. There is nothing to suspend in that case.
> +	 */
> +	if (!dev_get_drvdata(&rmi_dev->dev))
> +		return 0;
> +

[Severity: High]
Can this lockless check pass during a concurrent device unbind, leading to a
use-after-free?

If the parent USB device runtime suspends concurrently with a sysfs driver
unbind, this check might pass because dev_get_drvdata() is only cleared
by the driver core after rmi_driver_remove() completes.=20

In this scenario, rmi_suspend_functions() will iterate over data->function_=
list
without locks:

drivers/input/rmi4/rmi_driver.c:rmi_suspend_functions() {
    ...
    list_for_each_entry(entry, &data->function_list, node) {
    ...
}

While rmi_driver_remove() concurrently calls rmi_free_function_list(),
which modifies and frees the elements:

drivers/input/rmi4/rmi_driver.c:rmi_free_function_list() {
    ...
    list_del(&fn->node);
    rmi_unregister_function(fn);
    ...
}

Could this cause list corruption and a use-after-free?


[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing NULL poi=
nter
dereferences due to unbound drivers, does the event reporting path suffer f=
rom
the exact same issue?

If a hardware event arrives immediately after rmi_register_transport_device=
()
succeeds but before rmi_driver_probe() completes, hid-rmi's rmi_input_event=
()
unconditionally forwards the data to rmi_set_attn_data() because RMI_STARTED
is already set:

drivers/hid/hid-rmi.c:rmi_input_event() {
    ...
    rmi_set_attn_data(rmi_dev, data[1], &data[2], size - 2);
    ...
}

Then rmi_set_attn_data() fetches drvdata (which would be NULL) and
dereferences it:

drivers/input/rmi4/rmi_driver.c:rmi_set_attn_data() {
    ...
    struct rmi_driver_data *drvdata =3D dev_get_drvdata(&rmi_dev->dev);
    ...
    if (!drvdata->enabled)
    ...
}

Could this crash the kernel?


[Severity: High]
This is a pre-existing issue, but does the teardown order of asynchronous r=
eset
work in hid-rmi.c cause a use-after-free?

In rmi_remove(), cancel_work_sync() is called before hid_hw_stop():

drivers/hid/hid-rmi.c:rmi_remove() {
    ...
    cancel_work_sync(&hdata->reset_work);
    rmi_unregister_transport_device(&hdata->xport);
    ...
    hid_hw_stop(hdev);
}

During this window, the hardware is still active. If a mouse report arrives,
rmi_event() triggers and re-queues the asynchronous work:

drivers/hid/hid-rmi.c:rmi_event() {
    ...
    schedule_work(&data->reset_work);
    return 1;
}

After remove() returns and devres frees hdata, the worker executes on freed
memory. Should hid_hw_stop() be called before canceling the work?


[Severity: High]
This is a pre-existing issue, but are there memory and resource leaks in the
error handling paths of rmi_driver_probe()?

If rmi_f34_create_sysfs() fails, the code jumps directly to the 'err' label:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
    retval =3D rmi_f34_create_sysfs(rmi_dev);
    if (retval)
        goto err;
    ...
}

This skips the 'err_destroy_functions' label, omitting the function list
and irqdomain cleanup:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
err_destroy_functions:
    rmi_free_function_list(rmi_dev);
err:
    return retval;
}

Similarly, if a step like rmi_irq_init() fails, it jumps to
err_destroy_functions, which frees the function list but bypasses sysfs
removal and irqdomain cleanup.


[Severity: Critical]
This is a pre-existing issue, but is there a slab out-of-bounds read in
rmi_hid_read_block() due to an unvalidated read_input_count?

rmi_hid_read_block() trusts the hardware-provided byte data->readReport[1]
as the read_input_count:

drivers/hid/hid-rmi.c:rmi_hid_read_block() {
    ...
    read_input_count =3D data->readReport[1];
    memcpy(buf + bytes_read, &data->readReport[2],
           min(read_input_count, bytes_needed));
    ...
}

If a malicious device sets this to a large value (e.g., 255) and the driver
requests a large read, memcpy will copy up to 255 bytes from
&data->readReport[2]. Since data->readReport is allocated based on the devi=
ce's
advertised input_report_size, could this read past the end of the slab
allocation into adjacent memory?


[Severity: Critical]
This is a pre-existing issue, but is there a heap buffer overflow in
rmi_hid_write_block() due to an unvalidated write length?

rmi_hid_write_block() receives 'len' and copies it into data->writeReport[4=
]:

drivers/hid/hid-rmi.c:rmi_hid_write_block() {
    ...
    data->writeReport[1] =3D len;
    data->writeReport[2] =3D addr & 0xFF;
    data->writeReport[3] =3D (addr >> 8) & 0xFF;
    memcpy(&data->writeReport[4], buf, len);
    ...
}

The size of the data->writeReport buffer (data->output_report_size) is
determined entirely by the HID report descriptor. If a malicious device
advertises a very small output report size (e.g., 5 bytes), and the driver
attempts a standard block write (e.g., 16 bytes), could this memcpy write
past the bounds of data->writeReport?

>  	retval =3D rmi_suspend_functions(rmi_dev);
>  	if (retval)
>  		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908165925.2030=
-1-yogeshgaur.83@gmail.com?part=3D1
