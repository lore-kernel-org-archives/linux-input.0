Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB413DE42E
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841455; cv=none; b=bRpUxKcBy5B4Y2tso1sm3Y0+QkBFqOqSuGxwVt/VEG5uIIOgJbEl00DmHwE783ICaSHKhXWTe9urDRqsmxNDL7JdaztDN0x5IVaOQanzLYwcwfjfcaaaEPHlB+aCybBGHYxEOrlM7j0+NUapPmlxpiEkmMMX/PMnQQmCTUi7XlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841455; c=relaxed/simple;
	bh=GqoHTs/k3Lj9JkndPk5SGBiG3/wkcojmPzNqBny5hJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PrASB4Plk3N5v1QnzpPTE2j/N6Dhw7v8peRtPnI27Ftxz4wRW7g82y4ARMqMs2ZVPhYcVLfmyfN3LgIS2d6hIgA3AZ+jh2exrtyW2CcqcUfPV1nINZ2lbEzMGGPuBvefPB62wNwziY6mYZjp8IR0AAWHMNI1lQzJRofMA3XG6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJc+5WKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJc+5WKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D937A1F000E9;
	Tue, 30 Jun 2026 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841452;
	bh=N+Mnq8gOzZGJ7npJ7v3CwFJ4Px3bElcZ2BVqmSl/vqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJc+5WKcPfeglwppO4ssSfqvruiFiVBTNyI8s0itZVh4gGjnzO6/UuVfPUI9Q06WL
	 99Kn56tzZyi/vzGkDpR5sl1SI4X8mMX9pn++pdXsgApns+XcKd5Vri95p43wl/BtVu
	 aKRJASeUkYpOIz34hJOy16BcGgf4w3zAPuKBbV9spSP5tmCB+6JAVC367x7W4Fd0rM
	 9/Dha41ycu8Hk0losqLN/TPQY9/Da+k9GIRXzbKOi3V5iHwa+O70/qvmZSFMyHZHrw
	 Tz3T1Ejkgq07g/fRDds2DQQlhRm+pWSr9jyq1Ti67T+MjbAlnLijHznGgHtcQKFwWa
	 gOWi3M02r3Yxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] HID: steelseries: Add support for Arctis Nova 7
 Gen2 family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <8d6f139f082f2b985bad0cb3f60f260e60a7f2e9.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
 <8d6f139f082f2b985bad0cb3f60f260e60a7f2e9.1782840133.git.srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:44:11 +0000
Message-Id: <20260630174411.D937A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The global bounds check `if (size < 4)` incorrectly drops valid,=
 shorter unsolicited status reports.

Pre-existing issues:
- [High] Concurrent sysfs unbind leads to Use-After-Free of sibling `hid_de=
vice` and `steelseries_device`.
- [High] Type confusion when retrieving the sibling HID device can lead to =
an out-of-bounds memory read.
--

commit 70087cd16ba3bb84894fac86ae371e8ee1265c7a
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Add support for Arctis Nova 7 Gen2 family

This patch adds support for the Arctis Nova 7 Gen2 headsets. It introduces a
new parser for unsolicited battery and connection updates on a second HID
interface, and adds eight new USB product IDs to the supported devices list.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index 689435c60ecbd..31d31f3f4b0e9 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -162,6 +169,30 @@ static void steelseries_arctis_9_parse_status(struct=
 steelseries_device *sd,
>  	}
>  }
> =20
> +static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseri=
es_device *sd,
> +							u8 *data, int size)
> +{
> +	if (size < 4)
> +		return;

[Severity: Medium]
Could this global bounds check prematurely discard valid unsolicited battery
and connection updates?

The new opcodes 0xb7, 0xb9, and 0xbb only require up to data[1] to be valid.
If the headset firmware sends these unsolicited updates as 2-byte short USB
HID packets reflecting their actual content size, this check will drop them.

[ ... ]
> @@ -180,6 +211,14 @@ static const struct steelseries_device_info arctis_9=
_info =3D {
>  	.parse_status =3D steelseries_arctis_9_parse_status,
>  };
> =20
> +static const struct steelseries_device_info arctis_nova_7_gen2_info =3D {
> +	.sync_interface =3D 3,
> +	.async_interface =3D 5,

[Severity: High]
This is a pre-existing issue, but the addition of these new devices using t=
he
async/sync interface mechanism heavily exercises it. Is it possible for a
concurrent sysfs unbind to cause a use-after-free?

During the async interface probe, steelseries_get_sibling_sd() calls
usb_get_intfdata(sibling_intf) without holding the device lock for the sibl=
ing
interface. If a user concurrently unbinds the sibling interface (e.g., via
sysfs), usbhid destroys the hid_device. This causes the probe path to
locklessly dereference the freed sibling_hdev->driver:

	sibling_hdev =3D usb_get_intfdata(sibling_intf);
	if (!sibling_hdev || sibling_hdev->driver !=3D &steelseries_arctis_driver)
		return NULL;

	sd =3D hid_get_drvdata(sibling_hdev);
	if (sd)
		kref_get(&sd->refcnt);

It then calls kref_get(&sd->refcnt) on the associated private data, modifyi=
ng
freed memory.

[Severity: High]
This isn't a bug introduced by this patch, but adding these devices expands
the exposure to a pre-existing type confusion issue. Could this lead to an
out-of-bounds memory read?

In steelseries_get_sibling_sd(), the driver extracts the private data via
usb_get_intfdata() and assumes it is a struct hid_device *:

	sibling_intf =3D usb_ifnum_to_if(usb_dev, interface_num);
	if (!sibling_intf)
		return NULL;

	sibling_hdev =3D usb_get_intfdata(sibling_intf);
	if (!sibling_hdev || sibling_hdev->driver !=3D &steelseries_arctis_driver)
		return NULL;

If a crafted USB device is plugged in where the sibling interface (e.g.,
interface 0 or 3) is a non-HID class like USB Audio, a different driver will
bind and store its own private structure in intfdata.

The driver field sits hundreds of bytes deep into struct hid_device. Reading
it from a smaller structure belonging to another driver will read out-of-bo=
unds
of the allocated SLUB object.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782840133.gi=
t.srimanachanta@gmail.com?part=3D9
