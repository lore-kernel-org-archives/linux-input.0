Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E368003D
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630587; cv=none; b=g+dD2TWcSeGU6OXTlcMLi1D3kh4grg5AihE4wzcuGGhrilhcdgAkL9QZAHApKiGvEyu0lqTesKvFGung56wzshtwDFNxcVNT/TImPablI32320jOxVZPSn146lMRJszeGzixd+JFTOoy+tIH3/GlcGeFPYFWZz+GKlaK62ivNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630587; c=relaxed/simple;
	bh=vIpX/hdWZuIFq3kQ+4eyi4UYafo9MITYAhhZN3tVFOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jI//gAhACRqIi+LYYMLqirKpJTE/9M8SRiusile7h4d76ehwqCwJMrXAEhEYHX3mEmxDlkBYEoxZRXXWqtDT6P1btisOoWdd8tubtSewDSZG5ODDPTC802luXlyeBv+w65V4TFkpcB2SCVOj4K/hITid/xRhGw311TYvWfdb0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6cKkgIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6cKkgIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68531F000E9;
	Tue, 25 Aug 2026 04:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787630586;
	bh=+enX3illD74gu4JPYd0kKN/VrjfhrAz2BJCVeNwgxf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6cKkgIbW1fMbkfjOe/YphVGQMlCAAlDenm7i+TzP29yr8DCr6ZkHj9ERRDgY5MLJ
	 X63CoP0CHR4+5x3JVGOJBhti2hYEShPwVbPzzndDvVqPAWmmbpMiAd8yAA64xF0hbX
	 UJ6GwiZd6A1Qja+aFxVBQ20vv596LkxpWw/UU/OhUWY3za5pAnRJnubUxvpFZ9LsYS
	 EIyzUMtS2JIaHZmnKNYdx26XYDJ0bwljKg09K3NCz0WCPrzGWmqg9cKvJnKwIaKN2O
	 6kycOyRLHWTyGTQTcRMTLrHesvVPVijehOQ6XJrNmKAz6bzm5xFvEvfGHZNIoHM7II
	 9+0zxai3vdFwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: rmi: fix use-after-free of struct rmi_data via
 reset_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825034854.63555-1-98lawweijie@gmail.com>
References: <20260825034854.63555-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:03:05 +0000
Message-Id: <20260825040305.B68531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver allocates `writeReport` and `readReport` buffers ba=
sed on unvalidated `hid_report_len()` values from the device's HID descript=
or, leading to heap out-of-bounds accesses in `rmi_hid_write_block()` and `=
rmi_hid_read_block()`.
- [High] If the RMI4 core driver fails to bind to the registered transport =
device, `rmi_reset_attn_mode()` blindly dereferences a NULL `rmi_dev->drive=
r` pointer when triggered by a mouse report.
- [High] Preexisting Use-After-Free of `input_dev` if `input_register_devic=
e()` fails during `hid_hw_start()`.
--

--- Patch [1]: [PATCH] HID: rmi: fix use-after-free of struct rmi_data via =
reset_work ---
commit 46d084fef573949d9f74d0919ad4a8a2ea0ce1cc
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix use-after-free of struct rmi_data via reset_work

This commit fixes a use-after-free issue where rmi_remove() only cancels
the reset_work when RMI_STARTED is set, leaving it schedulable if probe fai=
ls.
It unconditionally cancels the work in rmi_remove() and adds extra checks
to prevent the work from running after the device is unregistered.

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 2bd781f1e0f53..4df6d8cd2dc3c 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -313,6 +313,14 @@ static void rmi_reset_work(struct work_struct *work)
>  	struct rmi_data *hdata =3D container_of(work, struct rmi_data,
>  						reset_work);
> =20
> +	/*
> +	 * A report that raced with rmi_remove() may have queued us after it
> +	 * cleared RMI_STARTED, i.e. after the transport device we would reset
> +	 * has been unregistered.
> +	 */
> +	if (!test_bit(RMI_STARTED, &hdata->flags))
> +		return;
> +
>  	/* switch the device to RMI if we receive a generic mouse report */
>  	rmi_reset_attn_mode(hdata->hdev);

[Severity: High]
This is a pre-existing issue, but can rmi_reset_attn_mode() dereference a
null rmi_dev->driver pointer here if the RMI core driver fails to bind to
the registered transport device?

If the RMI physical driver fails to probe, device_add() still succeeds.
The hid-rmi driver might mistakenly treat this as success, set the
RMI_STARTED flag, and leave the device active:

drivers/hid/hid-rmi.c:rmi_input_configured() {
    ...
    ret =3D rmi_register_transport_device(&data->xport);
    if (ret < 0) {
    ...
    set_bit(RMI_STARTED, &data->flags);
    ...
}

When the device later sends a mouse report, it triggers this worker that
calls into rmi_reset_attn_mode() and blindly dereferences
rmi_dev->driver->reset_handler:

drivers/hid/hid-rmi.c:rmi_reset_attn_mode() {
    ...
    if (test_bit(RMI_STARTED, &data->flags))
        ret =3D rmi_dev->driver->reset_handler(rmi_dev);
    ...
}

>  }
[ ... ]
> @@ -739,15 +753,29 @@ static int rmi_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)

[Severity: Critical]
This is a pre-existing issue, but does this driver allocate writeReport and
readReport buffers based on unvalidated hid_report_len() values from the
device's hid descriptor?

If an attacker plugs in a malicious usb device with a crafted hid report
descriptor that advertises an output report size smaller than the fixed
header written by the driver, it seems we might get a heap buffer overflow.

For example, in rmi_probe():

drivers/hid/hid-rmi.c:rmi_probe() {
    ...
    alloc_size =3D data->output_report_size + data->input_report_size;
    data->writeReport =3D devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);
    ...
}

Then in rmi_hid_write_block(), the driver blindly writes a 4-byte header
and a payload to data->writeReport without verifying that the allocated
buffer is large enough:

drivers/hid/hid-rmi.c:rmi_hid_write_block() {
    ...
    data->writeReport[0] =3D RMI_WRITE_REPORT_ID;
    ...
    memcpy(&data->writeReport[4], buf, len);
    ...
}

[Severity: High]
This is also a pre-existing issue, but does this code cause a use-after-free
of the input_dev structure if input_register_device() fails?

The hid-rmi driver copies the input_dev pointer and registers the transport
device before input_register_device() is called by the hid core:

drivers/hid/hid-rmi.c:rmi_input_configured() {
    ...
    data->xport.input =3D input;
    ...
}

If input_register_device() fails, the hid core unwinds and frees the
input_dev:

drivers/hid/hid-input.c:hidinput_connect() {
    ...
    if (input_register_device(hidinput->input))
        goto out_unwind;
    ...
out_unwind:
    /* unwind the ones we already registered */
    hidinput_disconnect(hid);
    ...
}

Because hid-rmi implements a raw_event handler, the device remains bound.
When the device subsequently sends hardware interrupts, the transport driver
unconditionally dereferences the freed input pointer:

drivers/input/rmi4/rmi_driver.c:rmi_process_interrupt_requests() {
    ...
    if (data->input)
        input_sync(data->input);
    ...
}

>  static void rmi_remove(struct hid_device *hdev)
>  {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825034854.6355=
5-1-98lawweijie@gmail.com?part=3D1
