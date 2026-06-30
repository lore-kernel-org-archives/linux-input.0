Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3001A9F97
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780862; cv=none; b=r/E85tQXtc/P9d/27ijBbJK9kF7rL+EUKccPG/6FN80fdRCLGMxJXgldpzW3v+CmOcht7jpy3ugezqS2hc0ZwSPiazBH32YB3/6tnNxxPCjj3jnGTXE9vLOqwkhogS2WW16Vv4EzgBeOyZRWAcRak0yndSH1iWimVgscSYbdY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780862; c=relaxed/simple;
	bh=F8tvacUetMEEm22VpqwzM5C5jpch119R4VhBNKexNNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HHcBg0L1SVvRTIvPEbST3L1WvlW1Uwkr7aihDgR16/T7+k59cBCAVAyFqHLItxgh7FEvD2YzjHJGPj/YhstPZ3oUjy7c36AftlgZH+X5mWl6ZPr2ZQ+JVzEweJN19Tg/hcpzEpV5TP25TYAy9OFrGojnxSd/YE1XPwzMYWxtars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejboLSfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejboLSfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082D71F000E9;
	Tue, 30 Jun 2026 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780861;
	bh=1uIzddVBwU1QxbQa67lV4DhNGHh11crzdBl9G7j4Buc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ejboLSfpRvYZnWBrMkJFzp6SnMQm0SjYYKwQh2cUcA7H0JSRd9OLvMS3Bj6KiqStd
	 j5I48oXEvRcgh0aHOVkDSW/oeuD20B+yKJv33I2QL6lvNtiu/cRXLvDyzPFrNfNfWI
	 Dezt9I6IxJtwGMJT+n4vmYnwdffkJb9U1SXmE1+tkxn7PQte8TUv/Wue7XXqdhRq5N
	 A5LbqWtBuSLGAeq/VVX40/DVnHU28WkjXr5hlXLTNFjj6MaVHl85/7iYcqwj1sjlK+
	 Nh5edc3mDB9D+n6FBzAPpC0EEQ/Hra/S6PO/LfzFGEMOPSblZzekvD9cY0xz3lB/dj
	 2p92LUnj1nPMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair-void: Fix firmware event packet
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stuart Hayhurst" <stuart.a.hayhurst@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630004323.589696-3-stuart.a.hayhurst@gmail.com>
References: <20260630004323.589696-3-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 00:54:20 +0000
Message-Id: <20260630005421.082D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `corsair_void_raw_event()` function lacks a bounds check on th=
e `size` of the incoming HID report, which can lead to an out-of-bounds rea=
d when accessing elements up to `data[4]`.
--

commit d2f977ace02628f486f8135ff442479be032fad6
Author: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

HID: corsair-void: Fix firmware event packet description

This commit updates the comment describing the firmware event packet in the
corsair-void HID driver. It corrects the stated size to 5 bytes to include
the ID, and updates the corresponding indices for the firmware versions.

> diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-voi=
d.c
> index 5e9a5b8f7f167..ce92e3a9c0580 100644
> --- a/drivers/hid/hid-corsair-void.c
> +++ b/drivers/hid/hid-corsair-void.c
> @@ -51,20 +51,23 @@
>  /* Receiver report information: (ID 102)                                =
      */
>  /* ---------------------------------------------------------------------=
----- */
>  /*
> - * When queried, the recevier responds with 4 bytes to describe the firm=
ware
> - * The first 2 bytes are for the receiver, the second 2 are the headset
> + * When queried, the receiver responds with 5 bytes to describe the firm=
ware
> + * The first byte is the ID, then 2 bytes for the receiver, then 2 for t=
he headset
>   * The headset firmware version will be 0 if no headset is connected
>   *
> - * 0: Recevier firmware major version
> + * 0: Report ID
> + *  102 for the firmware packet
> + *
> + * 1: Receiver firmware major version
>   *  Major version of the receiver's firmware
>   *
> - * 1: Recevier firmware minor version
> + * 2: Receiver firmware minor version
>   *  Minor version of the receiver's firmware
>   *
> - * 2: Headset firmware major version
> + * 3: Headset firmware major version
>   *  Major version of the headset's firmware
>   *
> - * 3: Headset firmware minor version
> + * 4: Headset firmware minor version
>   *  Minor version of the headset's firmware
>   */

[Severity: High]
This is a pre-existing issue, but does corsair_void_raw_event() lack a boun=
ds
check on the size of the incoming HID report?

When the device sends a report matching the firmware report ID, it appears
the handler unconditionally accesses elements up to data[4]:

drivers/hid/hid-corsair-void.c:corsair_void_raw_event() {
    ...
    drvdata->fw_receiver_major =3D data[1];
    drvdata->fw_receiver_minor =3D data[2];
    drvdata->fw_headset_major =3D data[3];
    drvdata->fw_headset_minor =3D data[4];
    ...
}

If a malicious USB device sends a crafted HID descriptor defining a small
maximum report size, and then sends a 1-byte firmware report, can this lead
to an out-of-bounds read past the end of the report buffer?

It looks like the same issue might exist for the status report, which also
reads up to data[4] unconditionally:

drivers/hid/hid-corsair-void.c:corsair_void_raw_event() {
    ...
    drvdata->mic_up =3D FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
    drvdata->connected =3D (data[3] =3D=3D CORSAIR_VOID_WIRELESS_CONNECTED)=
 ||
                 drvdata->is_wired;

    corsair_void_process_receiver(drvdata,
                  FIELD_GET(CORSAIR_VOID_CAPACITY_MASK, data[2]),
                  data[3], data[4]);
    ...
}

Could these out-of-bounds bytes be subsequently exposed to userspace via
sysfs attributes, resulting in a kernel memory information leak?

Could this also potentially trigger a kernel panic if the dynamically
allocated report buffer is small?

>  /* ---------------------------------------------------------------------=
----- */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630004323.5896=
96-3-stuart.a.hayhurst@gmail.com?part=3D1
