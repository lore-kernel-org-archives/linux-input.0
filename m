Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3D3546C7
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389897; cv=none; b=mNsXDPW+yjAvVzYFRND9mpKfVS+tRO9g7OEZw6nbEpyKiKwKeNYTKzwxiLV9m+wHZGFtCwHKeluvYQrnHfxfDu1qlPL7ahvzNNKFQmaw8KnVzTBaNwQijdHm31dNQWgraP62z+qobktUTpM7J2t/3eMhMHC8pEDwwjpd7l3qwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389897; c=relaxed/simple;
	bh=oQ0Zr87NoMOcXjRVJoRjeVj12xwsPJe3gyHnzv+2fjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTnM2TrRaV6wdEinVNrpEBNn2fU3AJX8N9k/znz8YY36joZOr5AZg81dhym7GB7C6UhoR3vHDOqFQbSLF2PckdK3sp6fx2m0T48BuHmlap9x9d4Z2qMB9L3p3dFmKws+Y7Y4BOetJpxChZt8Xtad/1ZyWjqOGRnrBusN5uxoyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULkmPNOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULkmPNOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7A71F000FF;
	Mon, 14 Sep 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789389895;
	bh=bAASQC5quH0/ttwVXIryMhCgBR9C66/yYD3mqdv5ODI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULkmPNOzyg+bVZvdIwtO32DTzRLnhNWrWGAEFDFMaGqDHvwg4E7Mgu9bA83OozUVu
	 YyaKnDqsvsyse+SWuq4mF4sbc6uWFQ/yAuo2YKdKeDzeAjZjL2YJ4AA6GPH9CvkSwC
	 /Zp76XKd1Rg1AbQ2OM220XvPyN0uEyh5PkpoYcWqOektBLVlCIq7EVLsMNYREXnfRw
	 inJ4rpknXjwe1V2PQW4GGJjiuLiY+Rst3bzeU3ooSaRGpaun8u7o5MvD9xVL0Hbb4+
	 7jHIfJpAKptlMysLFXuqrlwG2gNIisL/NCp99hkeBOauG+HQblKNAMP7MDsa9Qywx7
	 SEfrOPVVbgGzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] HID: roccat: fix device access in
 roccat_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914120240.1625442-2-dmantipov@yandex.ru>
References: <20260914120240.1625442-1-dmantipov@yandex.ru>
 <20260914120240.1625442-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:44:55 +0000
Message-Id: <20260914124455.8B7A71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] HID roccat sub-drivers free their private driver data before c=
alling hid_hw_stop(), causing a Use-After-Free in the raw_event callback.
- [High] roccat_report_event() accesses devices[minor] locklessly and does =
not check for NULL, leading to a NULL pointer dereference during device dis=
connect.
- [High] roccat_report_event() acquires sleepable mutexes from an atomic in=
terrupt context.
--

commit a846f43d2e5b4bec36ac11b09237b5b9c9ebabb4
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: fix device access in roccat_release()

In roccat_release(), access the device using file-specific reader data rath=
er
than global array, thus preventing the case when original device was
disconnected and a new device has connected using the same slot indexed by =
minor
number.

Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yand=
ex.ru?part=3D2

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 5deb6da8d4f74..007778922c21a 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c

[ ... ]

> int roccat_report_event(int minor, u8 const *data)
> {
> 	struct roccat_device *device;
> 	struct roccat_reader *reader;
> 	struct roccat_report *report;
> 	uint8_t *new_value;
>=20
> 	device =3D devices[minor];
>=20
> 	new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);

[Severity: High]
This isn't a bug introduced by this patch, but does roccat_report_event()
access devices[minor] locklessly and without checking for NULL?

If a device is disconnected, roccat_disconnect() sets devices[minor] =3D NU=
LL
and drops the device reference. Because sub-drivers like hid-roccat-kone fa=
il
to call hid_hw_stop() before roccat_disconnect(), incoming USB interrupts c=
an
still trigger roccat_report_event() concurrently.

Could this lead to a NULL pointer dereference when kmemdup() accesses
device->report_size?

> 	if (!new_value)
> 		return -ENOMEM;
>=20
> 	mutex_lock(&device->readers_lock);
> 	mutex_lock(&device->cbuf_lock);

[Severity: High]
This is a pre-existing issue, but does this code acquire sleepable mutexes =
from
an atomic interrupt context?

roccat_report_event() is called by raw_event callbacks in HID sub-drivers,
which execute in atomic interrupt context (URB completion handlers like
usbhid_irq_in).

Can calling mutex_lock() here cause a "scheduling while atomic" panic, or
a deadlock if the lock is contended?

> drivers/hid/hid-roccat-kone.c:
> static void kone_remove_specials(struct hid_device *hdev)
> {
> 	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> 	struct kone_device *kone;
>=20
> 	if (intf->cur_altsetting->desc.bInterfaceProtocol
> 			=3D=3D USB_INTERFACE_PROTOCOL_MOUSE) {
> 		kone =3D hid_get_drvdata(hdev);
> 		if (kone->roccat_claimed)
> 			roccat_disconnect(kone->chrdev_minor);
> 		kfree(hid_get_drvdata(hdev));
> 	}
> }
>=20
> static void kone_remove(struct hid_device *hdev)
> {
> 	kone_remove_specials(hdev);
> 	hid_hw_stop(hdev);
> }

[Severity: Critical]
This isn't a bug introduced by this patch, but do HID roccat sub-drivers fr=
ee
their private driver data before calling hid_hw_stop()?

During device unbinding/removal, kone_remove_specials() is called which fre=
es
the driver data with kfree(hid_get_drvdata(hdev)). However, hid_hw_stop() is
called after this free.

Since hid_hw_stop() is responsible for stopping hardware interrupts, an inc=
oming
USB report can trigger kone_raw_event() concurrently:

drivers/hid/hid-roccat-kone.c:kone_raw_event() {
	struct kone_device *kone =3D hid_get_drvdata(hdev);
	...
	if (kone =3D=3D NULL)
		return 0;
	...
	if (kone->roccat_claimed)
		kone_report_to_chrdev(kone, event);
}

Can this result in a Use-After-Free memory corruption when the raw_event
callback dereferences the freed driver data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914120240.1625=
442-1-dmantipov@yandex.ru?part=3D2
