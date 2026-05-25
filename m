Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1429827E
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725211; cv=none; b=Qun3IlHSxqsuyC9qGf2L6e1CAYmamOMuNwOYTM1ANrSB1zsfS22EDMST48bF3QuHsYBbQ6xsA58z3pFe3q0IUm7FsoxZOQNMT3iDKyzl4pLFCqK5anJMQghMPYAMK+7mN1UhD1CHsHt57tYSirYBWUULOymLrceES4u+PN0yToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725211; c=relaxed/simple;
	bh=ljaLzcbms+HkRv98RIHF+oBLwpaDt3YIp4HirQ0wJ4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKwhRgdK45DGy/NWISA1UzyCqdUIgzI3J1RedjI1Jt2C32E6zr6jrVjn4Rzxs6oJruraM43x1mzKWaAmnp8aq5PL031QaFtumwlj0PkRy92nGho4aKEezL4/xv/e2Qrz5GyXvDjI7rK7QiDsMJ+/oIk1bqVbaGcttXFLdkz5QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1UtHY2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1UtHY2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C077D1F000E9;
	Mon, 25 May 2026 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779725209;
	bh=kkpwAq2beT/m7dmkGGSQbMDfFGMMRDRVnAlXH6yq1uM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1UtHY2Ab+Gs+vQQ6Tua1/KEnU5PKd+6qNFSTkVxcRb7K/DpXU0tG+amA4uJkKXq4
	 Yfw8hWinCcM8LKRF+WMYnTbTFOc7JO8aFUC3NySNjHSMPCpJPUIaTW2cNuAuX5O3qP
	 HJZguI0k6morPizKfAhvMUxrg4s7Lq9eth5cEBakytGYrfaAnPibGWI7adkbAPJhEO
	 AUWHkxFHH1jWz8PGsZth6tU3k3cIe/W92jwLVhvE5HVriBAfX5/8VIyqYFmS1vnQkY
	 8XZqwdj5peyjXoK6MRsJVECbmb8QEpOTqy4PJ4ZDZp+b2CmsJ/zYKwlmbyoybgpjux
	 Y/yiIymwBWdCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: ims-pcu - fix use-after-free in probe error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhian Liang" <liangzhan5dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260525151410.42750-1-liangzhan5dev@gmail.com>
References: <20260525151410.42750-1-liangzhan5dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 16:06:49 +0000
Message-Id: <20260525160649.C077D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a useless `goto` statement immediately precedi=
ng its target label.

Pre-existing issues:
- [High] A malicious USB device can trigger a Double Free and Use-After-Fre=
e in the probe error path by spoofing the data interface class.
- [High] The driver blindly trusts the CDC Union descriptor's `bMasterInter=
face0` field, allowing a malicious device to corrupt other drivers' drvdata.
- [High] An infinite loop can occur in `ims_pcu_get_cdc_union_desc` if a US=
B descriptor has a `bLength` of 0.
- [High] The driver frees the `urb_in_buf` DMA coherent buffer using an inc=
orrect size parameter.
- [High] The driver assumes the first endpoint of the control interface is =
an Interrupt IN endpoint without verifying its type or direction.
--

commit a298fe95c1b14555659ce23349aaf55e3bb035b5
Author: Zhian Liang <liangzhan5dev@gmail.com>

Input: ims-pcu - fix use-after-free in probe error path

This commit addresses a use-after-free in the probe error path by clearing
the control interface data to NULL before freeing the pcu structure. This
prevents the disconnect handler from accessing the freed pointer if the
device is removed.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4c022a36dbe84..fce3232ebf072 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -2063,6 +2063,10 @@ static int ims_pcu_probe(struct usb_interface *int=
f,
>  	ims_pcu_buffers_free(pcu);

[Severity: High]
This is a pre-existing issue, but does this function properly free the
urb_in_buf?

Looking at ims_pcu_buffers_free(), it seems to use max_out_size instead of
max_in_size:

ims_pcu_buffers_free() {
        ...
        usb_free_coherent(pcu->udev, pcu->max_out_size,
                          pcu->urb_in_buf, pcu->read_dma);
        ...
}

Could a device with mismatched IN and OUT endpoint descriptors cause an
improper free size and corrupt the DMA allocator?

>  err_unclaim_intf:
>  	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);

[Severity: High]
This is a pre-existing issue, but can a device spoofing the data interface
class trigger a double free here?

If a device presents a data interface with bInterfaceClass =3D=3D USB_CLASS=
_COMM,
ims_pcu_disconnect() might fail to skip it. When
usb_driver_release_interface() is called on the data interface during a
probe failure, it synchronously unbinds the interface, triggering
ims_pcu_disconnect().=20

Could ims_pcu_disconnect() then incorrectly assume it is handling the
control interface and free the pcu structure, leading to a use-after-free
read on pcu->ctrl_intf and a double free on pcu in this error path?

> +	goto err_clear_intfdata;

[Severity: Low]
Is this goto statement necessary? Execution would naturally fall through to
the err_clear_intfdata label on the very next line, making this instruction
redundant.

> +err_clear_intfdata:
> +	if (pcu->ctrl_intf)
> +		usb_set_intfdata(pcu->ctrl_intf, NULL);

[Severity: High]
This is a pre-existing issue, but does the driver safely assign
pcu->ctrl_intf?

In ims_pcu_parse_cdc_data(), pcu->ctrl_intf is assigned using the
bMasterInterface0 field from the CDC Union descriptor. If a device sets
bMasterInterface0 to point to a different, already-bound interface, could
the probe function unconditionally overwrite that victim interface's drvdat=
a?

If the probe subsequently fails, this error path would clear the victim's
drvdata to NULL, which might cause the victim driver to crash when
disconnected.

>  err_free_mem:
>  	kfree(pcu);
>  	return error;

[Severity: High]
This is a pre-existing issue, but could there be an infinite loop during
descriptor parsing?=20

If a device provides a CDC union descriptor with a bLength of 0, the size
check in ims_pcu_get_cdc_union_desc() would pass since 0 is not greater
than the remaining length. The loop would then subtract 0 from buflen and
add 0 to buf, causing it to never advance or terminate. Would this hang
the USB enumeration thread?

[Severity: High]
This is a pre-existing issue, but does ims_pcu_parse_cdc_data() verify the
endpoint direction and type before using it?

The code assigns pcu->ep_ctrl to &alt->endpoint[0].desc and passes its
address to usb_fill_int_urb(). If a device exposes a Bulk or OUT endpoint
at this index instead, could submitting it as an Interrupt IN URB lead to
unhandled behavior or warnings in host controller drivers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525151410.4275=
0-1-liangzhan5dev@gmail.com?part=3D1
