Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C493CC7DF
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247131; cv=none; b=ZIt6Gq3/HGkXaz/4ONmpXmcuesBdHKOKxi1ZXn8iT98ADUPtNb6o8ZVQ/F5ycCZHUGEDGmV/fZP3JJH47/tHcH7GyL5qDg97ra/t1LSp+YSi0rnciqpSYj1wHb3uhgCvh8HQhR5XenL9doLfznQtFoPpqNtmxq/u1Wkwzqo5Wfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247131; c=relaxed/simple;
	bh=uwnTJB37QS3xgjPtqRt6Px53ly9zdcnS6sDEitrB9Og=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Lc/+jHbW6wGctZhkZhL+NWaiwQ5Ex/tPfcRs4e2kSiHKWY9CqtX6p14cq2/WnNGM/+cGKFESyJHwblYwlxa3u4xTDxnC+QAz6uuLzy4gdA7/ExHapBM6tAcYKkulZzui6NId2VJ9yvLdp+/qsKaS8YUqH1MZpHABtFQ3FMzw77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvKvn9fS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvKvn9fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4C91F000C4;
	Sat, 17 Oct 2026 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247129;
	bh=MB804161GppfXofo6if1qP7XdxoZi2KLorvjxFqnTKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvKvn9fSliMVBxClmN9OpLqyEPeiIALCEwtFKCsayKkvpCFnxdK7TV6NJNTI5Tn4L
	 U0qxHA2zvOOtjkV/jRSfjULodJ0GKxr2pAkbasrmfgw09HXgklbzBiwaJlygfv99/L
	 xjVcJMoW5ksjc68zREyJcEvJ69659J6vXV/WSSQxzjo8861rWspWUlUMdDadomnWOY
	 ZHGUPIvRB/oH6tZoiAM5PU7JAWP9P9sFtcG/zMHv0dDG36JEu3GHptIbOb6rWy29Ae
	 rBjqXLfxwVP7dWFnEu0LUKkaqdDeFtTZw6IXxHj2tDCyimIehcmF0TOAgDlcszBZae
	 4lig6uv4WSUAw==
Message-ID: <sashiko-outbox-175547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] HID: multitouch: give FF core ownership of
 haptic state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017140332.1480375-3-qwe.aldo@gmail.com>
References: <20261017140332.1480375-1-qwe.aldo@gmail.com>
 <20261017140332.1480375-3-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:25:28 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] HID: haptic: hid_haptic_input_configured() configures wrong or s=
kipped touchpad inputs
- [Low] HID: haptic: hid_haptic_init() mixes __free() cleanup with goto unw=
ind labels
--

commit 460ed664066c1c242ed1db3ec867440a01166da3
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: multitouch: give FF core ownership of haptic state

This commit clones the mapped haptic state in hid_haptic_init() and
transfers ownership of the clone to ff->private so the input core frees it
at final input device release. It also records the first configured input
device to avoid creating multiple force-feedback instances sharing the same
HID reports.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 0a6126e8de5e9..b0fb94f759a37 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -5,6 +5,7 @@
>   *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
>   */
> =20
> +#include <linux/cleanup.h>
>  #include <linux/input/mt.h>
>  #include <linux/module.h>
> =20
> @@ -92,6 +93,10 @@ int hid_haptic_input_configured(struct hid_device *hde=
v,
> =20
>  	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
> =20
> +	/* The HID reports are shared; create only one FF instance. */
> +	if (haptic->input_dev)
> +		return 1;
> +
>  	error =3D hid_haptic_init(hdev, haptic, hi->input);
>  	if (error) {
>  		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
> @@ -99,6 +104,8 @@ int hid_haptic_input_configured(struct hid_device *hde=
v,
>  		return error;
>  	}
> =20
> +	haptic->input_dev =3D hi->input;
> +

[Severity: Medium]
Can this attach the single force-feedback instance to the wrong input
device or mark skipped touchpad inputs with INPUT_PROP_PRESSUREPAD?

On a multi-input haptic touchpad (for example with
MT_CLS_WIN_8_FORCE_MULTI_INPUT, which sets HID_QUIRK_MULTI_INPUT),
hidinput_connect() invokes mt_input_configured() on each hid_input in
descriptor order before checking hidinput_has_been_populated():

drivers/hid/hid-input.c:hidinput_connect() {
	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
		if (drv->input_configured &&
		    drv->input_configured(hid, hidinput))
			goto out_unwind;

		if (!hidinput_has_been_populated(hidinput)) {
			/* no need to register an input device not populated */
			hidinput_cleanup_hidinput(hid, hidinput);
			continue;
		}
}

In mt_input_configured(), hid_haptic_input_configured() is called for any
hid_input with hi->application =3D=3D HID_DG_TOUCHPAD before checking
rdata->is_mt_collection:

drivers/hid/hid-multitouch.c:mt_input_configured() {
	if (td->is_haptic_touchpad && (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
	    td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
	    td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
		if (hi->application =3D=3D HID_DG_TOUCHPAD) {
			ret =3D hid_haptic_input_configured(hdev, td->haptic, hi);
}

If a non-multitouch or unpopulated HID_DG_TOUCHPAD report precedes the
multitouch report, hid_haptic_input_configured() initializes EV_FF on that
first hid_input (causing hidinput_has_been_populated() to keep and register
an otherwise empty input_dev), sets haptic->input_dev, and then skips the
actual multitouch touchpad input_dev.

In addition, because __set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit)
runs before checking haptic->input_dev, subsequent HID_DG_TOUCHPAD inputs
that skip hid_haptic_init() still advertise INPUT_PROP_PRESSUREPAD.

>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
> @@ -414,9 +421,11 @@ static void hid_haptic_destroy(struct ff_device *ff)
>  }
> =20
>  int hid_haptic_init(struct hid_device *hdev,
> -		    struct hid_haptic_device *haptic,
> +		    const struct hid_haptic_device *config,
>  		    struct input_dev *dev)
>  {
> +	struct hid_haptic_device *haptic __free(kfree) =3D
> +		kmemdup(config, sizeof(*config), GFP_KERNEL);
>  	struct ff_device *ff;
>  	int ret =3D 0, r;
>  	struct ff_haptic_effect stop_effect =3D {
> @@ -425,6 +434,9 @@ int hid_haptic_init(struct hid_device *hdev,
>  	const char *prefix =3D "hid-haptic";
>  	char *name;
> =20
> +	if (!haptic)
> +		return -ENOMEM;
> +
>  	haptic->hdev =3D hdev;
>  	haptic->max_waveform_id =3D max(2u, haptic->max_waveform_id);
>  	haptic->max_duration_id =3D max(2u, haptic->max_duration_id);
> @@ -517,7 +529,7 @@ int hid_haptic_init(struct hid_device *hdev,
>  	ff->stop =3D hid_haptic_stop;
>  	ff->destroy =3D hid_haptic_destroy;
>  	__module_get(THIS_MODULE);
> -	ff->private =3D haptic;
> +	ff->private =3D no_free_ptr(haptic);
>  	return 0;
> =20
>  ff_cap_clear:

[Severity: Low]
Should hid_haptic_init() avoid mixing __free(kfree) with goto-based cleanup
labels?

In hid_haptic_init(), haptic is declared with __free(kfree) and transferred
with no_free_ptr(haptic), while the rest of the function uses a goto unwind
ladder (ff_cap_clear, buffer_free, output_queue, duration_map, usage_map,
and exit) that dereferences haptic to free its sub-allocations before scope
exit runs.

Per include/linux/cleanup.h, goto cleanup labels and __free() helpers
should not be mixed in the same function. Could haptic be freed explicitly
at the exit label instead, or all resources in hid_haptic_init() converted
to scope-based cleanup?

[ ... ]

>
[::-1]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017140332.1480=
375-1-qwe.aldo@gmail.com?part=3D2
