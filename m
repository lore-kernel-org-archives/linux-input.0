Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCE4279F8
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131698; cv=none; b=Td/d7/7AL1WULna1xEGjbYJOFg4SatOCl89IWaZlK26X2GUpWmk3tYO1yu8LffFIaRNcub2mVrXZYTpQ9Il1XWllZlX0NfVmis/WCNYoPSNOqixa+a5IXmJP/lALuXzwGgKwXNo5RhYADwDVInp+3pnadjVsZVGInQ19yDv+Djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131698; c=relaxed/simple;
	bh=t7lCrbe8AhIhz0K9GO4PKZTwRQMLUrT69FStfz6wA8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I2B56cv6JFoPSUHcUxylck7f//hdtE6ZfD8IQjMeAtCdRBE7PxvDFZmYBqwaoMwTl5ndylffkIw47OfogMEVm4BU4IdAG9DHwl7aYlq3w29VG8/fPJaPeqQkuj2F7y37eGQFGGweY+/1EqXHxOuniGNFRHGHdzi2DRF2FIzWi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evjx9dEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evjx9dEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EC71F000E9;
	Wed, 19 Aug 2026 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131694;
	bh=lgCIPE5F9XSFbBnloMPexodHJ5mM2tHDyEtmRlWXSVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Evjx9dECIdQ2RKdHTnyjwxqbq9hpXHCjJHOMaUeov4N56IMvPY4gs+i5xw4T/Z8lx
	 AV8UDAYbBxf25zQLNQFtHQ0+C3zHdu4P5taY0va5OpHWE0bX8FaCp3yVRmoVQLsQbj
	 FFZzgOmlJ8XpX8Udmyg+7EwP1tb1pHXOpB04UZomwFhCmFLSLsgcFSMlP3aOJ3gy5d
	 WpMde76KcJnBuDQxZxfkOA+xIqDI/TZtXzZglleE3/eDu7HXveYM0T7GPnZ4G1798z
	 Q/d2mgkul2wR0vK9//yLPFAgD6/wUl/3Te+OWdytlU0ymPUjkfJO7wNhiZ/3wq67SH
	 GKT8JlJpHUHnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: multitouch: add support for Goodix GXTP7863
 touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruzal Daminov" <daminovruzal7@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819091515.332-1-daminovruzal7@gmail.com>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819091515.332-1-daminovruzal7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:28:13 +0000
Message-Id: <20260819092813.D6EC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch fails to eliminate the phantom input node and KEY_BRIGHT=
NESSUP autorepeat events because the selected multitouch class (MT_CLS_WIN_=
8_FORCE_MULTI_INPUT_NSMU) explicitly exports all unknown inputs.
--

--- Patch [1]: [PATCH v2] HID: multitouch: add support for Goodix GXTP7863 =
touchpad ---
commit 27cf212c4e16014a4475e61f74a677cd87497bef
Author: Ruzal Daminov <daminovruzal7@gmail.com>

HID: multitouch: add support for Goodix GXTP7863 touchpad

This commit adds the Goodix GXTP7863 touchpad controller to the mt_devices[]
table in hid-multitouch. It uses MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU with t=
he
intent of claiming the device to eliminate an erroneous phantom input node
that causes endless KEY_BRIGHTNESSUP autorepeat events.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index edb37b4c867e4..ca0b40e6b8a83 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2460,6 +2460,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
>  		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
>  			USB_DEVICE_ID_GAMETEL_MT_MODE) },
> =20
> +	/* Goodix GXTP7863 Touchpad */
> +	{ .driver_data =3D MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
> +	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
> +		     I2C_DEVICE_ID_GOODIX_01E0) },

[Severity: High]
Will this actually prevent the phantom KEY_BRIGHTNESSUP events?

Because MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU sets export_all_inputs =3D true,
the filter in drivers/hid/hid-multitouch.c:mt_input_mapping() is bypassed
for the vendor collection:

    if (!td->mtclass.export_all_inputs &&
        field->application !=3D HID_DG_TOUCHSCREEN &&
    ...
        return -1;

This causes mt_input_mapping() to return 0, delegating the mapping to
hid-input.c which still maps the telemetry usage to KEY_BRIGHTNESSUP.

Then, when the telemetry report arrives, mt_event() returns 0 for this
non-MT collection:

    rdata =3D mt_find_report_data(td, field->report);
    if (rdata && rdata->is_mt_collection)
        return mt_touch_event(hid, field, usage, value);

    return 0;

This allows hidinput_hid_event() to process it and emit the phantom
keypresses, which seems to leave the system in the same state it was
under hid-generic.

Would a different class that doesn't force export_all_inputs be more
appropriate here to successfully ignore the vendor telemetry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091515.332-=
1-daminovruzal7@gmail.com?part=3D1
