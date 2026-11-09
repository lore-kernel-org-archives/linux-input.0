Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241002;
	b=4CTfa2A0be+ljmghXcMatSEHeVNXfTE+mbfxxClBuu21GTHD0dT1PVWeHq+qdWaaqwcG
	 J4nlk9r2pGHhyg54CAu3adDXPTtxoRibWzK98DLGWiMHYAHWCZKhVopyKbd405C9td168
	 hwbDrXr9YrNarfxUnPiSfiGMlY9LxP5I8MsGYEY+f++o4NmamoxynBSG4Bo6q+qkQXY31
	 WXYMzODgsf8XQpH9cGmydE+hVEtuwAy2M5YQd5ub8UzOsSgjH1A70PjsvuVyMdgyBb9TX
	 Bct8YnQNw6kai5L4K4wjTBDqRHW8z6lYzOVB8KgU8CzeEd4RVdcrVDVc4PkcNyhorxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241002;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=H2Wioz1O6TcHqEi+DkEornUk3PVxiZUaQwIY/oZW1Z4=;
	b=SqbYAVQgFxRiZJ8dIEfvo7M4Khh/VbgcmYpxag1MUODa8ByATGdjP89GNy0iNnXZ4KKn
	 RE9DyNkwiDU2tpCGSQhbZ+cpGxKivTreBOoCxmsjNgg5PlZNcQRrzURgEHQA8WYsN9yfP
	 TvjYnlbj2gDUv673RjEPqyQzh14jRhQXJsnokcymK7IbULri16nt7BhP4VxRSeiJiYz9W
	 Hskj2NqIm3ZvtW8wd8oaz5a/2E4gP/mDNfg6HLj5iOcsdl15pDAFY2IXVqszPdmr6ujLR
	 36Dd7LAPQSCj2QAwWWZbgxpJFg/AqVjQm6q/ONbBkiLI8yirPEMX5VPj1f/1YGKUc5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Bd2KV+QN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F45606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 16:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F45606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Bd2KV+QN
ARC-Seal: i=1; a=rsa-sha256; t=1794240997; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SyFeDmzXN16XeQrhnwx422HGQHxaGZHSZY5Knwg8G87YkBxk/esOdeDm1Z4H/ngu6SBBWoBotcO/MyyhL4lvzVpT0UNZm3ARr/PWgs6g7tDnS0UMElNBw7RE5/BwEzFDpIm0Uxv4ATAn6KRkKbzHHabLhshkz1PsNoSCBf8D1Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794240997; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H2Wioz1O6TcHqEi+DkEornUk3PVxiZUaQwIY/oZW1Z4=; 
	b=KqAE1nbvhbfvJLnXY1EqqPXr0614aYzvl41iUrcLJHW4NrI49GxdhRVUew53ddoy6ik7QHld7KpHH7ccC8KdEXh2vO15qx2mWnhSKWGyE9Wivb1tvdjLw6R3dxOQxFTiOPezsJmps8Zx/FjkJAHQMbHSHbyCo4nMzUtb3o6V9Cw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=Bd2KV+QNQfRnXvJVqj1IGa3F0+CMT8/ZaM3qN2ysue2BMypxZQgK12FJPlCtGJ3EP3nqFquPot+xqWPIkKmS/b5jXCqQmGRU6UwR6yovuLmVJm+a7cK+rHNz0cMK8DaRbbdvdYjrNjLRD20jRCjfQV4XA59iOQ+Niz2O1IrTRN/BUqgbHTq7CSalTKAZj3lR7fBXa2sR63UwnNNnJUJr5YFeCM4PPGgtDjgknETPfWnRdYhQNDCEkbbe7KVpoeedGEbEKBpjkay6K3ICbPuVV2+MpSHffPhRWNQDOBPoeKcGXRTeJU1g8ZRay5S4oUlzXb+0pSBFCiSHbS8o7c2fJg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=H2Wioz1O6TcHqEi+DkEornUk3PVxiZUaQwIY/oZW1Z4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794240995952299.6904193871194;
	Mon, 9 Nov 2026 08:16:35 -0800 (PST)
Message-ID: <5b37cf208370a60373d27c13257eb10090d64578.camel@rong.moe>
Subject: Re: [PATCH 3/9] HID: haptic, multitouch: Check haptic prerequisite
 properly
From: Rong Zhang <i@rong.moe>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <sashiko-outbox-192550@kernel.org>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
	 <20261102-hid-haptic-kmod-v1-3-a3de5626dade@rong.moe>
	 <sashiko-outbox-192550@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:11:32 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi All,

On Sun, 2026-11-01 at 17:57 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] HID: haptic: hid_haptic_check_pressure_unit() misses non-force=
 unit mismatch
> - [Medium] HID: multitouch: one-way is_haptic_touchpad leaks state to oth=
er MT inputs
> --
>=20
> commit 8758bcd8ba263569bfbee87a3d749e9ff7ea4489
> Author: Rong Zhang <i@rong.moe>
>=20
> HID: haptic, multitouch: Check haptic prerequisite properly
>=20
> This commit stores the HID_DG_TOUCHPAD input device and validates pressur=
e
> unit annotations across usages in hid_haptic_check_pressure_unit(), ensur=
ing
> hid_haptic_input_configured() only initializes haptics for the matching i=
nput
> device. It also converts td->is_haptic_touchpad into a one-way flag and g=
uards
> probe-time hid_haptic_*() calls with td->haptic.
>=20
> > diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> > index 9cbacc827dc9c..27cc8a2d9b595 100644
> > --- a/drivers/hid/hid-haptic.c
> > +++ b/drivers/hid/hid-haptic.c
> > @@ -48,17 +48,40 @@ void hid_haptic_feature_mapping(struct hid_device *=
hdev,
> >  }
> >  EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
> > =20
> > -bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
> > +void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
> >  =09=09=09=09    struct hid_input *hi, struct hid_field *field)
> >  {
> > -=09if (field->unit =3D=3D HID_UNIT_GRAM || field->unit =3D=3D HID_UNIT=
_NEWTON) {
> > -=09=09haptic->force_logical_minimum =3D field->logical_minimum;
> > -=09=09haptic->force_physical_minimum =3D field->physical_minimum;
> > -=09=09haptic->force_resolution =3D input_abs_get_res(hi->input,
> > -=09=09=09=09=09=09=09     ABS_MT_PRESSURE);
> > -=09=09return true;
> > +=09if (hi->application !=3D HID_DG_TOUCHPAD)
> > +=09=09return;
> > +
> > +=09/* Don't care about input devices with no pressure sensor. */
> > +=09if (field->unit !=3D HID_UNIT_GRAM && field->unit !=3D HID_UNIT_NEW=
TON)
> > +=09=09return;
> > +
> > +=09if (IS_ERR(haptic->input_dev))
> > +=09=09return;
> > +
> > +=09if (!haptic->input_dev) {
> > +=09=09haptic->input_dev =3D hi->input;
> > +=09=09haptic->pressure_field =3D field;
> > +=09=09haptic->force_resolution =3D input_abs_get_res(hi->input, ABS_MT=
_PRESSURE);
> > +=09=09return;
> >  =09}
> > -=09return false;
> > +
> > +=09if (haptic->input_dev =3D=3D hi->input &&
> > +=09    haptic->pressure_field->unit =3D=3D field->unit &&
> > +=09    haptic->pressure_field->logical_minimum =3D=3D field->logical_m=
inimum &&
> > +=09    haptic->pressure_field->physical_minimum =3D=3D field->physical=
_minimum &&
> > +=09    haptic->force_resolution =3D=3D input_abs_get_res(hi->input, AB=
S_MT_PRESSURE))
> > +=09=09return;
> > +
> > +=09/*
> > +=09 * Reject if:
> > +=09 * - there are multiple input devices with pressure sensors
> > +=09 * - the pressure annotation mismatches
> > +=09 */
> > +=09haptic->input_dev =3D ERR_PTR(-EPROTO);
> > +=09return;
> >  }
>=20
> [Severity: Medium]
> What happens if a HID_DG_TOUCHPAD input device has multiple
> HID_DG_TIPPRESSURE usages where some specify HID_UNIT_GRAM or HID_UNIT_NE=
WTON
> and others have a non-force unit (such as 0)?
>=20
> In mt_input_mapping() -> mt_touch_input_mapping():
>=20
> =09case HID_DG_TIPPRESSURE:
> =09=09set_abs(hi->input, ABS_MT_PRESSURE, field,
> =09=09=09cls->sn_pressure);
> =09=09if (td->haptic)
> =09=09=09hid_haptic_check_pressure_unit(td->haptic, hi, field);
>=20
> Because hid_haptic_check_pressure_unit() returns early when field->unit i=
s
> neither HID_UNIT_GRAM nor HID_UNIT_NEWTON before checking haptic->input_d=
ev:
>=20
> 1. If an earlier HID_DG_TIPPRESSURE usage on hi->input has a valid force =
unit
> and a later usage on the same hi->input has unit 0, set_abs() overwrites
> ABS_MT_PRESSURE parameters and resets its resolution to 0 on hi->input, w=
hile
> hid_haptic_check_pressure_unit() returns early instead of setting
> haptic->input_dev =3D ERR_PTR(-EPROTO).
>=20
> 2. Conversely, if the first HID_DG_TIPPRESSURE usage on hi->input has uni=
t 0
> and a subsequent usage has HID_UNIT_GRAM or HID_UNIT_NEWTON, the first us=
age
> is ignored and the subsequent usage sees !haptic->input_dev and accepts t=
he
> device despite the mismatched annotations across usages.
>=20
> Should hid_haptic_check_pressure_unit() reject the device when a non-forc=
e
> unit is encountered on the same hi->input as a force unit?

Makes sense. I will soon submit a v2 fixing this.

>=20
> [ ... ]
>=20
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
> > index 4e19a0c4d2381..d744ccc3e0b0b 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
>=20
> [ ... ]
>=20
> > @@ -1955,14 +1956,11 @@ static int mt_input_configured(struct hid_devic=
e *hdev, struct hid_input *hi)
> >  =09struct hid_report *report;
> >  =09int ret;
> > =20
> > -=09if (td->is_haptic_touchpad && (td->mtclass.name =3D=3D MT_CLS_WIN_8=
 ||
> > -=09    td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> > -=09    td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
> > -=09=09if (hid_haptic_input_configured(hdev, td->haptic, hi) =3D=3D 0)
> > -=09=09=09td->is_haptic_touchpad =3D false;
> > -=09} else {
> > -=09=09td->is_haptic_touchpad =3D false;
> > -=09}
> > +=09if (td->haptic && !td->is_haptic_touchpad &&
> > +=09    (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
> > +=09     td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> > +=09     td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE))
> > +=09=09td->is_haptic_touchpad =3D hid_haptic_input_configured(hdev, td-=
>haptic, hi);
> > =20
> >  =09list_for_each_entry(report, &hi->reports, hidinput_list) {
> >  =09=09rdata =3D mt_find_report_data(td, report);
>=20
> [Severity: Medium]
> When a composite HID device has a haptic HID_DG_TOUCHPAD collection along=
side
> another multitouch application collection (such as a HID_DG_TOUCHSCREEN
>=20

I don't know whether devices with both HID_DG_TOUCHSCREEN and
HID_DG_TOUCHPAD really exist or not. Such a combination sounds cursed...

>  or a
> second non-haptic HID_DG_TOUCHPAD without a pressure sensor),
>=20

It should become irrelevant as long as the previous issue is fixed.

Anyway, I will fix both issues in v2.

Thanks,
Rong

>  does latching
> td->is_haptic_touchpad to true here affect the other multitouch inputs on=
 the
> same hid_device?
>=20
> Once mt_input_configured() configures the haptic touchpad hid_input and s=
ets
> td->is_haptic_touchpad =3D true, any subsequent hid_input processed by
> mt_input_configured() -> mt_touch_input_configured() will see:
>=20
> =09if (td->is_haptic_touchpad)
> =09=09app->mt_flags |=3D INPUT_MT_TOTAL_FORCE;
>=20
> and set INPUT_MT_TOTAL_FORCE on that non-haptic application as well.
>=20
> Similarly, at runtime, mt_process_slot() and mt_sync_frame() only check
> td->is_haptic_touchpad rather than verifying whether input matches
> td->haptic->input_dev:
>=20
> =09if (td->is_haptic_touchpad)
> =09=09hid_haptic_pressure_increase(td->haptic, *slot->p);
>=20
> and:
>=20
> =09if (td->is_haptic_touchpad)
> =09=09hid_haptic_pressure_reset(td->haptic);
>=20
> Could touches on a non-haptic multitouch input on the same HID device fee=
d
> into and reset td->haptic->pressure_sum?
