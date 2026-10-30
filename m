Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382353;
	b=E9cQ2Khs7pkplRv7tiY8yl2UKeI/j9sA2iDEUNCnTIz9uU3xOcXqCUjCixYrtX6A93ER
	 TdbfWS4lW3Huam1ILIXQXANAOkzndiOrxMz38dNAuEiQYmW5qVtepYEO76EQN93Cnv6B8
	 Z8mssKue6zhPahIOgMgRg9XcLeAp2w7I/RnGYdZdqFPvoy87+gbXvuObS2HErQnUjw8Fo
	 6bG/+6hQXx5j/cEm2h1hLFCnOn/+SwDyPipfSMf7tDLpiq5wY/PUa0qgtd5M/4OEUvy0d
	 T/Tvqb0SV0hSLNY6FKT2qArMWPC50c0oaWfyyKTYvpH7arbCmpXIvLLsmYDEqcbg2KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382353;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mNy9bDCNuzspDANUkWYgxQ/VoVFlpXf7iLlWyxfPhWQ=;
	b=20BwExvFENhHvswCiw/vC2EG3fz8RsKsiyHnnymH4g1+HAFwAApPp8vKCwY6sgYZLo7Z
	 XWj80b3Sh4ZBf8M22KpFMSzZF54lc6wwyeE7z/86iMg27+A6v35z1rStqmFwdumDFEh+9
	 Y3m7+GnJcFfcL1sQO3gElNxwL2S88Tmp5xQJBpAMSDnGFPe69kCKQUCRXGODxXq4yR64F
	 o0d8nohiq2NFKp1OilSrE3td3NrFa25rlPnEw7EnaGkz1ikbdGn/S+TRSppV39YZGba3A
	 Xn1sH5dsXA2hjIJ+J/KVP25MFh3ePfGe03Bs+qOwRd+kmKYLA2nGwUWeL/nIz8zqi8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gErHz2GG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E3606A31F
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gErHz2GG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C61F00A18;
	Fri, 30 Oct 2026 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382353;
	bh=mNy9bDCNuzspDANUkWYgxQ/VoVFlpXf7iLlWyxfPhWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gErHz2GG+9gG424mP5rbP93xZPgMyemP8UlFbhhbbqqYLysFExXJUDVAZXbnv6MwT
	 K2cOMEEL3+gEu3xu2F20cCr782jAm3dC1jF2mBndKqpdkR+uou8pcFG75EfKWP37Py
	 OTikHIzy7+AfTphmk5QAWfDtw5klKU/NWs19YH39DY7NgCPCbcTGUUXtVCstJss5ed
	 i/NYW11K7MbRMtFQrERaBAh1+lRzzccsZp6VxmUoD74mw+vMA1Kz+WbM25dNy7BwaI
	 ahvno9kMIZahyKsy6OFL57aiMDP76RBcqmgt4Kt87k3eNnRCN8Oaah25t711H4fuTI
	 Uh4G/8Y08nJTQ==
Message-ID: <sashiko-outbox-191355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: Prevent NULL dereference in wireless work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devarjya Purkayastha" <unseentactician27062006@gmail.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261030173108.45408-1-unseentactician27062006@gmail.com>
References: <20261030173108.45408-1-unseentactician27062006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:45:52 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: wacom: incomplete NULL and binding checks in wacom_wireless_w=
ork()
--

commit 53aa61197952eeb0781af2deacd78d22c186ee96
Author: Devarjya Purkayastha <unseentactician27062006@gmail.com>

HID: wacom: Prevent NULL dereference in wireless work

This commit checks that usbdev->config->desc.bNumInterfaces is at least 3 in
wacom_wireless_work() before accessing interface[1] and interface[2].

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 628372ab818a2..dcf2811a5c483 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2619,7 +2619,7 @@ static void wacom_wireless_work(struct work_struct =
*work)
> =20
>  	wacom_destroy_battery(wacom);
> =20
> -	if (!usbdev)
> +	if (!usbdev || usbdev->config->desc.bNumInterfaces < 3)
>  		return;

[Severity: High]
Is checking usbdev->config->desc.bNumInterfaces < 3 sufficient to prevent a
NULL pointer dereference in wacom_wireless_work()?

First, the commit message states that this checks the active USB
configuration, but usbdev->config points to the array of all configurations
(&usbdev->config[0]), whereas usbdev->actconfig points to the currently
active configuration populated by usb_set_configuration(). On a malformed
multi-configuration device where config[0] has bNumInterfaces >=3D 3 while a
different configuration is active in usbdev->actconfig,
usbdev->config->interface[1] and usbdev->config->interface[2] will be NULL,
causing usb_get_intfdata() to dereference a NULL pointer:

	/* Stylus interface */
	hdev1 =3D usb_get_intfdata(usbdev->config->interface[1]);
	wacom1 =3D hid_get_drvdata(hdev1);
	wacom_wac1 =3D &(wacom1->wacom_wac);
	wacom_release_resources(wacom1);

Second, even when interface[1] and interface[2] are non-NULL, can hdev1 or
hdev2 be NULL? During usb_set_configuration(), interfaces are probed
sequentially. When interface[0] is probed, wacom_parse_and_register() opens
the HID device and starts interrupt URB reception before interface[1] and
interface[2] have been probed:

	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
		error =3D hid_hw_open(hdev);
		if (error) {
			hid_err(hdev, "hw open failed\n");
			goto fail_hw_stop;
		}
	}

In addition, on a malformed USB device where interface[1] or interface[2]
fails usbhid_probe() (for example, due to missing an interrupt-IN endpoint)
or is unbound, usb_get_intfdata() returns NULL for hdev1 or hdev2, and
hid_get_drvdata() will dereference a NULL pointer.

Third, even if usbhid_probe() succeeds so hdev1 and hdev2 are non-NULL,
wacom_probe() can fail on interface[1] or interface[2] (for example, if the
HID report descriptor is malformed), or the wacom driver can be unbound from
those interfaces. In that case hid_get_drvdata() returns NULL for wacom1 or
wacom2, and wacom_release_resources() immediately dereferences it:

static void wacom_release_resources(struct wacom *wacom)
{
	struct hid_device *hdev =3D wacom->hdev;

	if (!wacom->resources)
		return;

Should wacom_wireless_work() check usbdev->actconfig as well as verify that
the sibling interfaces and their hdev and wacom driver data pointers are
valid and bound before dereferencing them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030173108.4540=
8-1-unseentactician27062006@gmail.com?part=3D1
