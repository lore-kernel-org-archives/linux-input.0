Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5A3438B5
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515140; cv=none; b=Vq3EV53nACZJSK/Vsq1xyZpuOGh1fHQqi6ivhh66UjNwdqKDvp08FlUc8tLzlqiyxZuIYJn78+MRLgbj6G5E+2caa9jcMEIQXz93aZsBceSjAiJMgcc28rAcpUWdV7cawi6uE4YanDFja15Gb4Ubh5Ka/SejXYHGv9F9tlFai6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515140; c=relaxed/simple;
	bh=KukOWgXLv3rc5oNbSnXh4MOCJKIJUu3FDfaZaGh90eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+hv+PvBIQ+H5cSkvSSu2Hu0aBizkqr+9PE8srhYOryZ5A+HTHdjEqnez5j9J33tg36xcAmIEVVBxSgleiF/66rsJ22Gd0GOUTGsRFEs4GUkMsT4n5ELyoJ9pkJHszRFax2pjfUJgJxpTesezkpOocHQjqfes5oq+aNSIbhIwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUTAriXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUTAriXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5615B1F00A3A;
	Sat, 23 May 2026 05:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779515138;
	bh=6GVcSA1qgYL1JgtJiBp+fm2eXTsesJrYDKHn4y2azFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUTAriXmcz7205k/jHDhfmM47VEfmEc1JdBfW1SnowI7cmus2+PMKfDGIulkSzcWM
	 0fBLwqR+VOtp5Z6aQcqG0Y8w6ADuzamnVOVVZLwNoyASozA6+8WL/u+F4dYuDEb8xf
	 gb4KqGJg4cg6ELR+IdNbxQB3nrCWLZ2QrDKidOKIVFdKViYyH9SM3fGhQUWshJMMCw
	 xLRInFxRaCiGbFQy91qeQV5t+HMFBRwmx/zl2yygoOnOEIWKyKQliP65MMh7cGjyPC
	 V2OVjFvjUr0GiR6kilMimlyIKcgHEjOtEWXxjBxLsOzxPTaDfZRoEK7uOyQBr2Yil9
	 PJ6u2GWMBjM0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] Input: ims-pcu - fix use-after-free and
 double-free in disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260523050634.501509-2-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:45:38 +0000
Message-Id: <20260523054538.5615B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Concurrent unbinding of both the control and data interfaces via s=
ysfs triggers a Use-After-Free on the `pcu` structure.

Pre-existing issues:
- [Critical] The driver blindly trusts the CDC Union Descriptor to identify=
 interfaces, leading to memory corruption during probe and an unconditional=
 NULL pointer dereference in disconnect.
- [High] In `ims_pcu_buffers_free`, the input DMA buffer is freed using the=
 maximum output buffer size instead of its actual allocated size.
--

commit 73572626cc6ab15fc9107238c7a713e379862dd8
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - fix use-after-free and double-free in disconnect

This commit changes the interface verification in ims_pcu_disconnect() to
directly compare the disconnecting interface against the saved control
interface pointer. This prevents premature cleanup caused by malicious
devices presenting multiple interfaces with the same class.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 89737ef381c1c..2ad72fe4a51d9 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -2071,7 +2071,6 @@ static int ims_pcu_probe(struct usb_interface *intf,
>  static void ims_pcu_disconnect(struct usb_interface *intf)
>  {
>  	struct ims_pcu *pcu =3D usb_get_intfdata(intf);
> -	struct usb_host_interface *alt =3D intf->cur_altsetting;
> =20
>  	usb_set_intfdata(intf, NULL);
> =20
> @@ -2079,7 +2078,7 @@ static void ims_pcu_disconnect(struct usb_interface=
 *intf)
>  	 * See if we are dealing with control or data interface. The cleanup
>  	 * happens when we unbind primary (control) interface.
>  	 */
> -	if (alt->desc.bInterfaceClass !=3D USB_CLASS_COMM)
> +	if (intf !=3D pcu->ctrl_intf)

[Severity: High]
Can this introduce a use-after-free if both control and data interfaces are
unbound concurrently via sysfs?

If Process A unbinds the data interface, it gets the pcu pointer from
usb_get_intfdata() and might be preempted. The USB core sets the data
interface condition to USB_INTERFACE_UNBINDING.

Process B then unbinds the control interface, enters ims_pcu_disconnect(),
and calls usb_driver_release_interface() on the data interface.

Since the data interface is unbinding, usb_driver_release_interface() retur=
ns
immediately without waiting, and Process B proceeds to kfree(pcu).

When Process A resumes, evaluating intf !=3D pcu->ctrl_intf would dereferen=
ce
the freed pcu pointer.

[Severity: Critical]
This is a pre-existing issue, but does this new check introduce an
unconditional NULL pointer dereference if the CDC Union Descriptor is spoof=
ed?

During ims_pcu_probe(), the driver uses bMasterInterface0 from the CDC Union
Descriptor as pcu->ctrl_intf without verifying it matches the probed
interface.

If a malicious device supplies a descriptor pointing to an interface owned =
by
another driver, the actual probed interface's intfdata remains NULL.

In that scenario, usb_get_intfdata() returns NULL for pcu, and evaluating
intf !=3D pcu->ctrl_intf here will panic. Note that this is fixed later in =
the
patch series by commit af29ec151c71a.

>  		return;
> =20
>  	ims_pcu_stop_io(pcu);

[Severity: High]
This is a pre-existing issue, but could ims_pcu_buffers_free() be freeing
the input buffer with the wrong size?

Looking at ims_pcu_buffers_alloc(), pcu->urb_in_buf is allocated using
pcu->max_in_size. However, ims_pcu_buffers_free() appears to free it using
pcu->max_out_size:

usb_free_coherent(pcu->udev, pcu->max_out_size, pcu->urb_in_buf,
                  pcu->read_dma);

If a device specifies different maximum packet sizes for IN and OUT endpoin=
ts,
calling usb_free_coherent() with the wrong size could corrupt the DMA
allocator's buddy system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D2
