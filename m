Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2234AAE9
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280653; cv=none; b=HHBYKpTHA4AaA+MxF/F/E59u+0USocV2vEeM+7L/B0AkIGP9OucLkMW9OIcf4Iz9aVvJguEViwdcz9lyyvxyRX4vXMcG647oE0kDQgoHgbnpTx8UbbcSBrAWDZQfOyKQFiCdtswjDtzYqbslRiwR/PJZtzcdpoj9H7qEYN3/SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280653; c=relaxed/simple;
	bh=xmuORC2KMLMmPE/yS3nT9WzoOJCLBoCyDsHPGO4DV34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OvCldBF90fMlLGuEa9j4YpNe1EC58tiTROR1oIlmsoD1hi0fFIjcuc1nW+W4rw9RU8jqh/CBOLJvf8h8kekwFK5GPGVVhaPrX67qHJmh/f7IjVGuifmgCKvxJu6dE5owrDJ871iQdXh1T8jcKAjC+pP5DuI3kkWCenrO2KAVpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAS03pXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAS03pXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F441F000E9;
	Tue,  1 Sep 2026 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280651;
	bh=zAuUa7J/oTD/54X7oDQ+2NuK7C+PB+HoSiO3YKpkKQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAS03pXaG7sePW2LyJ7DnrT/dVJVIyhZ0QlqYF8Y24jrfYcO0VXtLTcJXoCXRRk90
	 ngq4wc9c6Jxm+bt3qiuVwoPEntDxvzCFGtlfrF5MdAo8X8X3Qv5apaeurZUiJet/4f
	 9DIAso2jBQp11B2IQXgsCSESq2huj4gLBttkJudQ7PVuY+2zIr5AhS/6CQyPgxO6Mq
	 SCfKIiRNhg1a/KAtG6T9juaYFLEZLwXNwUfI19lsozTGhi/c69dpvbOOc0I4vWm6LM
	 D/EZIujDL/qKz7jx5VosxATogu6DHqs357/He65ArW3C/VpSikzd1DsKDVSgsz9lOG
	 hzRCKafMcjeKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-dj: forward Bolt receiver input to the dj
 child device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3LDqWdvaXJlIFN0ZWlu?= <greyxor@protonmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com>
References: <20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:37:31 +0000
Message-Id: <20260901163731.A0F441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The shared `djrcv_dev->unnumbered_application` field is overwritte=
n when multiple interfaces of a Bolt receiver use unnumbered reports, leadi=
ng to corrupted input routing.

Pre-existing issues:
- [Critical] Worker teardown race leading to a Use-After-Free of `djrcv_dev=
` when the device is unbound or disconnected.
--

commit 8ddfaefb25fbb11d3135bd6028112cdebd298409
Author: Gr=C3=A9goire Stein <greyxor@protonmail.com>

    HID: logitech-dj: forward Bolt receiver input to the dj child device

This patch drops the special case for Bolt receivers and sets no_dj_interfa=
ces
to 3, allowing interfaces 0 and 1 to be claimed by the dj driver so their
reports get properly forwarded to the child device.

> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 1d619d2345e12..5a8f63ced627c 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1907,9 +1907,6 @@ static int logi_dj_probe(struct hid_device *hdev,
>  	 * treat these as logitech-dj interfaces then this causes input events
>  	 * reported through this extra interface to not be reported correctly.
>  	 * To avoid this, we treat these as generic-hid devices.
> -	 *
> -	 * Bolt receivers only use LOGITECH_DJ_INTERFACE_NUMBER for receiver
> -	 * reporting. Treat all other Bolt interfaces as generic-hid devices.
>  	 */
>  	switch (id->driver_data) {
>  	case recvr_type_dj:		no_dj_interfaces =3D 3; break;
> @@ -1920,23 +1917,14 @@ static int logi_dj_probe(struct hid_device *hdev,
>  	case recvr_type_27mhz:		no_dj_interfaces =3D 2; break;
>  	case recvr_type_bluetooth:	no_dj_interfaces =3D 2; break;
>  	case recvr_type_dinovo:		no_dj_interfaces =3D 2; break;
> +	case recvr_type_bolt:		no_dj_interfaces =3D 3; break;
>  	}
>  	if (hid_is_usb(hdev)) {
>  		intf =3D to_usb_interface(hdev->dev.parent);
> -		if (intf) {
> -			bool generic_hid_interface;
> -
> -			if (id->driver_data =3D=3D recvr_type_bolt)
> -				generic_hid_interface =3D
> -					intf->altsetting->desc.bInterfaceNumber !=3D
> -					LOGITECH_DJ_INTERFACE_NUMBER;
> -			else
> -				generic_hid_interface =3D
> -					intf->altsetting->desc.bInterfaceNumber >=3D no_dj_interfaces;
> -			if (generic_hid_interface) {
> -				hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> -				return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -			}
> +		if (intf && intf->altsetting->desc.bInterfaceNumber >=3D
> +							no_dj_interfaces) {
> +			hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> +			return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  		}
>  	}

[Severity: High]
Does this code overwrite the shared djrcv_dev->unnumbered_application field
when multiple interfaces of a Bolt receiver use unnumbered reports?

By dropping the special case for Bolt, both the keyboard (interface 0) and
mouse (interface 1) bind to hid-logitech-dj. Because they share the same
dj_receiver_dev struct, the sequentially probed mouse interface overwrites
unnumbered_application with HID_GD_MOUSE:

drivers/hid/hid-logitech-dj.c:logi_dj_probe() {
    ...
    if (!input_report_enum->numbered)
        djrcv_dev->unnumbered_application =3D rep->application;
    ...
}

When unnumbered keyboard reports arrive on interface 0, does this cause the=
m to
be incorrectly routed and formatted as mouse reports in logi_dj_raw_event()?

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free regression duri=
ng
device teardown in logi_dj_remove()?

In logi_dj_remove(), the asynchronous work is cancelled before the hardware
is stopped:

drivers/hid/hid-logitech-dj.c:logi_dj_remove() {
    ...
    cancel_work_sync(&djrcv_dev->work);

    hid_hw_close(hdev);
    hid_hw_stop(hdev);
    ...
}

Since the hardware polling is not yet stopped, an incoming hardware interru=
pt
can re-queue the work via schedule_work() in
logi_dj_recv_queue_unknown_work() just before djrcv_dev is freed by
dj_put_receiver_dev().

Does this leave a window for incoming interrupts to queue freed work items,
leading to a use-after-free when the delayedwork_callback executes and
accesses djrcv_dev->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-bolt-scrol=
l-fix-v1-1-58bca7ae487f@protonmail.com?part=3D1
