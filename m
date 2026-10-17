Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12B3451DA
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248755; cv=none; b=K5kOnjPTbt8uvU0yxD8TbetyMlQktBfgp1q6TNTOOpMIaxxnC9UMQ7t+IDEKbl0AbUenjgESeJtCDMxykzZ9vE1g79Joi0Eyqfxyo7mCCOcZ0llS2klUZO+iUaoJLJgBUzCL7xBq/2LPVAUMOORUf6Qg25WLWqUlN6a5FtcfzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248755; c=relaxed/simple;
	bh=WwkY0OTWRWDNKJMDqozmh60TLgmwlkz6r4oAFjmEsis=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LrRFZM7Mg52rXaWyg2xT37S26CvuHCgeBLEf57NHBR2Dgc5oreO5GDqoP1WRQU7aZzj/jHshsqnvUKrJasikhisPaYNyhSI4muyYEXN9BDDMvxcyJIe/lHiHUkBw7fm42FatxMZiWrY4LhDoJBFM7hqq0Lo7dpqW285XxSzjFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtYstKly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtYstKly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD271F000C4;
	Sat, 17 Oct 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792248753;
	bh=6AeCjPIpQ+AAnRQmvgeV5MC2XY/Vxo13Ol0Z9IMGkpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtYstKlyabD320YZXC45py7xP391XNjJbfh5CUykIq26heXIcCxDtqDjfk9tBI7L4
	 P75jSQDX61SL0XoTIKN+AEZd/6/Gp4bm6zGET9odBRG10zAQ8YLQnyDSEgT1IZmHfl
	 Q9zZHA2E0orJw2Czt7oWt3x0xixOsWmv6Gii5wRt/w/Mv9+MOrh0r/+qiwMpGGBCjZ
	 l6ZuoKBCrmj7WXjt2tVl6g/peIinWPg8EEx/ejpyX1UWYbfbJmJE7gfkSpSOKA12Kd
	 omq3VReX47wzHfv+cnqoGhuU0QVEMuX+/k3MmAYNp/oamx2AUJx3R0sg18QFBtAKKh
	 QHQn7a901ZsIg==
Message-ID: <sashiko-outbox-175569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] HID: multitouch: give FF core ownership of
 haptic state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017143810.1567677-3-qwe.aldo@gmail.com>
References: <20261017143810.1567677-1-qwe.aldo@gmail.com>
 <20261017143810.1567677-3-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:52:33 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: multitouch: mt_input_configured() validates is_haptic_touch=
pad too late
--

commit a6c433e1de88f40d35d53fd68c994b47885232f5
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: multitouch: give FF core ownership of haptic state

This commit clones the mapped haptic state in hid_haptic_init() and
transfers ownership to ff->private so the input core frees it on final
input device release. It also restricts FF initialization to the first
input device containing a multitouch touchpad report.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 154dc948b156e..e53389e28ad53 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1954,25 +1954,9 @@ static int mt_input_configured(struct hid_device *=
hdev, struct hid_input *hi)
>  	struct mt_report_data *rdata;
>  	struct mt_application *mt_application =3D NULL;
>  	struct hid_report *report;
> +	bool has_mt_touchpad =3D false;
>  	int ret;
> =20
> -	if (td->is_haptic_touchpad && (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
> -	    td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> -	    td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
> -		if (hi->application =3D=3D HID_DG_TOUCHPAD) {
> -			ret =3D hid_haptic_input_configured(hdev, td->haptic, hi);
> -			if (ret < 0) {
> -				td->haptic_init_error =3D ret;
> -				td->is_haptic_touchpad =3D false;
> -				return ret;
> -			}
> -			if (ret =3D=3D 0)
> -				td->is_haptic_touchpad =3D false;
> -		}
> -	} else {
> -		td->is_haptic_touchpad =3D false;
> -	}
> -
>  	list_for_each_entry(report, &hi->reports, hidinput_list) {
>  		rdata =3D mt_find_report_data(td, report);
>  		if (!rdata) {
> @@ -1987,9 +1971,29 @@ static int mt_input_configured(struct hid_device *=
hdev, struct hid_input *hi)
>  							mt_application);
>  			if (ret)
>  				return ret;
> +			if (hi->application =3D=3D HID_DG_TOUCHPAD)
> +				has_mt_touchpad =3D true;
>  		}
>  	}
> =20
> +	if (td->is_haptic_touchpad &&
> +	    (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
> +	     td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> +	     td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
> +		if (has_mt_touchpad) {
> +			ret =3D hid_haptic_input_configured(hdev, td->haptic, hi);
> +			if (ret < 0) {
> +				td->haptic_init_error =3D ret;
> +				td->is_haptic_touchpad =3D false;
> +				return ret;
> +			}
> +			if (ret =3D=3D 0)
> +				td->is_haptic_touchpad =3D false;
> +		}
> +	} else {
> +		td->is_haptic_touchpad =3D false;
> +	}

[Severity: Medium]
Does moving the td->is_haptic_touchpad validation after the hi->reports loop
cause mt_touch_input_configured() to observe an unvalidated
td->is_haptic_touchpad state?

During descriptor mapping, mt_touch_input_mapping() sets
td->is_haptic_touchpad =3D true whenever hid_haptic_check_pressure_unit() s=
ees
a HID_DG_TIPPRESSURE field with gram or newton units, without checking
td->mtclass.name or whether Simple Haptic Controller trigger reports exist:

drivers/hid/hid-multitouch.c:mt_touch_input_mapping()
	case HID_DG_TIPPRESSURE:
		set_abs(hi->input, ABS_MT_PRESSURE, field,
			cls->sn_pressure);
		td->is_haptic_touchpad =3D
			hid_haptic_check_pressure_unit(td->haptic,
						       hi, field);

Inside the hi->reports loop, mt_touch_input_configured() checks
td->is_haptic_touchpad and passes INPUT_MT_TOTAL_FORCE to
input_mt_init_slots():

drivers/hid/hid-multitouch.c:mt_touch_input_configured()
	if (td->is_haptic_touchpad)
		app->mt_flags |=3D INPUT_MT_TOTAL_FORCE;
	...
	ret =3D input_mt_init_slots(input, td->maxcontacts, app->mt_flags);

Because this now runs before mt_input_configured() checks td->mtclass.name
or calls hid_haptic_input_configured(), INPUT_MT_TOTAL_FORCE is already set=
 in
input->mt->flags even if td->is_haptic_touchpad is cleared to false right
after the loop (or on non-haptic MT inputs of a multi-input device), causing
input_mt_report_pointer_emulation() to sum ABS_MT_PRESSURE across contacts.

Also, if a Win8-class device sets td->is_haptic_touchpad on a non-touchpad
MT collection and has no HID_DG_TOUCHPAD MT collection, has_mt_touchpad will
be false for all inputs, leaving td->is_haptic_touchpad true so mt_probe()
keeps td->haptic and mt_process_slot() / mt_sync_frame() update
td->haptic->pressure_sum on every frame.

> =20
>  	switch (hi->application) {
>  	case HID_GD_KEYBOARD:
>  	case HID_GD_KEYPAD:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017143810.1567=
677-1-qwe.aldo@gmail.com?part=3D2
