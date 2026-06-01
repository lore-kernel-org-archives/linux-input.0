Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59133DEE0;
	Mon,  1 Jun 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335073; cv=pass; b=j7MtPpu5dZ7cgHLQluLjUYIFyDRBxB2iYJHULqHKRgUwYbbopefX+oDaZZlOuaQCV3r52i6ycp3pD1vGHZr7H7YIjTs0yKrHjdPCoIDIuBNrJtXQFOHI6s2S06HfBVA+v793VHt6j8BptbWZlEEZUR9CJOImcL8biVizQJFAPyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335073; c=relaxed/simple;
	bh=gVs1fQHCTMN8AaO4JEtra9mFsuHwycI0WcRQ0JYWYEw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:Content-Type:Date:
	 MIME-Version; b=WTEunf8MMjHbr/OVBQkosWdSzOVRfon/TC03YTPkdOIesDtH/No5Hn+hSL3W1/lT+3dMdQJYZi7WIIFp8nedjcUW7yJRF2quhTwMX/+5CwiOcakPmHsyTDNIVTKkjNrYD8mejZo2UD5R5r3H22JJVzzYfvVPtvfAap9sk5gEqDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Mkuc/zZb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Mkuc/zZb"
ARC-Seal: i=1; a=rsa-sha256; t=1780335066; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HuTdqn9Wz6hgF79OOyZqoFGXN3/9TaodJEettxDk6mXOnaRcLyuUX0i8Rn62X5ZyNdtK5QhvIczzSZFixEFacGgwnj41HqsVoSBTB5DIghlV4F+CHTPHLnkVTRdlBO4X9AUkjo8drj6LoxfEUJvYB3s8P0QU2wW1fWOztN5AP+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780335066; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TErnEhvYQocHA/w+yxxFJm1xhoVlzroH2fCaIXyAGr4=; 
	b=AnqnNMQEKIKQxpdZRquJl7ioOnfbdOIb0hPCyTkd2FxkmOlYcC11djQ81CMSEkqTl3PVbib5tInG9lU9gOE62FTtLFteLvH8GOYFSoM3EsS7fEqc/9eYeISIBwli/dEdo3cR4Z2qQKmiVdU3Ejr18UZORVAOX+74Toz3/3LIDGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780335066;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=TErnEhvYQocHA/w+yxxFJm1xhoVlzroH2fCaIXyAGr4=;
	b=Mkuc/zZbwCwH5vN1yJ1fQKgVl76/tFfAPnJUmtuxd/oP+fWaZlQ6opAJsrTTKDZO
	AAKdHyH600dVW3IjmgfctaIzP94bfaun0YPXsbSS5HQBGPRxhOREzIdxopOuX79e8dB
	IdQv2Tk0ymw6nsquiVvHHdhPgSYwOdv7768ll3IjpNo6wjzx/tEJ955D3ipIRA+qIdG
	/6LxtniwtCGIqoU7Jkz80kNKqJ7OWrtR2Vm+pSRCren8du98s8Wbq9bg+DPei21JRMq
	pfGguxzPEqe5xu1aiv/iLxYw/YxdbpDDcU4uiuYbrTVFXsoFd/gTtYkWJyj9nmxQtKb
	7S2Wt5nu9A==
Received: by mx.zohomail.com with SMTPS id 1780335064918433.33760150363105;
	Mon, 1 Jun 2026 10:31:04 -0700 (PDT)
Message-ID: <fb198851093477d958eae61665e9cfda0be5b48f.camel@rong.moe>
Subject: Re: [PATCH v2 1/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD
 based on Digitizer/Button Type
From: Rong Zhang <i@rong.moe>
To: devnull+peter.hutterer.who-t.net@kernel.org
Cc: bentiss@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, peter.hutterer@who-t.net,
 shuah@kernel.org, 	vadim@cirque.com
In-Reply-To: <20251222-wip-hid-pressurepad-v2-1-054ac9689bb7@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 01:25:57 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External


Hi all,

Hopefully I'm not too late to show up here.

> From: Peter Hutterer <peter.hutterer@who-t.net>
>=20
> A Digitizer/Button Type value of 1 indicates the device is a
> pressurepad, see
> https://learn.microsoft.com/en-us/windows-hardware/design/component-guide=
lines/touchpad-windows-precision-touchpad-collection#device-capabilities-fe=
ature-report
>=20
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/hid/hid-multitouch.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 179dc316b4b518d78bdc900d9fd15756c5eba83e..382e6f50c4f7e663af7d028ab=
b8be7cb2e6e7b8e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -81,6 +81,7 @@ MODULE_LICENSE("GPL");
>  #define MT_INPUTMODE_TOUCHPAD		0x03
> =20
>  #define MT_BUTTONTYPE_CLICKPAD		0
> +#define MT_BUTTONTYPE_PRESSUREPAD	1
> =20
>  enum latency_mode {
>  	HID_LATENCY_NORMAL =3D 0,
> @@ -179,6 +180,7 @@ struct mt_device {
>  	__u8 inputmode_value;	/* InputMode HID feature value */
>  	__u8 maxcontacts;
>  	bool is_buttonpad;	/* is this device a button pad? */
> +	bool is_pressurepad;	/* is this device a pressurepad? */
>  	bool is_haptic_touchpad;	/* is this device a haptic touchpad? */
>  	bool serial_maybe;	/* need to check for serial protocol */
> =20
> @@ -530,8 +532,14 @@ static void mt_feature_mapping(struct hid_device *hd=
ev,
>  		}
> =20
>  		mt_get_feature(hdev, field->report);
> -		if (field->value[usage->usage_index] =3D=3D MT_BUTTONTYPE_CLICKPAD)
> +		switch (field->value[usage->usage_index]) {
> +		case MT_BUTTONTYPE_CLICKPAD:
>  			td->is_buttonpad =3D true;
> +			break;
> +		case MT_BUTTONTYPE_PRESSUREPAD:
> +			td->is_pressurepad =3D true;
> +			break;
> +		}
> =20
>  		break;
>  	case 0xff0000c5:
> @@ -1393,6 +1401,8 @@ static int mt_touch_input_configured(struct hid_dev=
ice *hdev,
> =20
>  	if (td->is_buttonpad)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> +	if (td->is_pressurepad)
> +		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);

I noticed that this leads to dual reporting on my device.

Consider previous checks:

	if (application =3D=3D HID_DG_TOUCHPAD) {
		mt_application->mt_flags |=3D INPUT_MT_POINTER;
		td->inputmode_value =3D MT_INPUTMODE_TOUCHPAD;
	}

...

	/* check for clickpads */
	if ((app->mt_flags & INPUT_MT_POINTER) &&
	    (app->buttons_count =3D=3D 1))
		td->is_buttonpad =3D true;

... where `td->is_buttonpad' is set to true when a pressure pad has only
one button, i.e., the "touchpad button integrated with digitizer" [1].
Most (if not all) pressure pads fall into this category. As a result,
the presence of INPUT_PROP_PRESSUREPAD is always accompanied by the
presence of INPUT_PROP_BUTTONPAD.

Since the corresponding testcase neither expects dual reporting nor
prohibits it, I am confused of the intended properties to expose. Is it
a mistake or an intended behavior? If it's the former, I am going to
submit a patch to fix it.=20

[1]: https://learn.microsoft.com/en-us/windows-hardware/design/component-gu=
idelines/touchpad-buttons-report-level-usages

Thanks,
Rong

> =20
>  	app->pending_palm_slots =3D devm_kcalloc(&hi->input->dev,
>  					       BITS_TO_LONGS(td->maxcontacts),
>=20
> --=20
> 2.51.1
>=20
