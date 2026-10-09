Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFE4A261C
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545315; cv=none; b=Qy8699JeCTcwdUvbYjYcTmeeU4DBW71vN5t/gCB2UdoNZwjIiEK/iLv/oLpa0RV7nQjZgWCXWjbtOrUWoEBey6RCZwd2RGRo4B3gmXCoJha1HKXjWRT1CA2oGswn0BVWjTvd8v+Ahn/0pi3Enrjkbw+EzZ8JdVmLIbjAFvTCXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545315; c=relaxed/simple;
	bh=W5r/dCNq/NAmQs6Vz/8vLEnW8NZ6WGOrMgjv12jnhzA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Tmmjw8W+b/SUt9nvv2xxw/t3iT/6tZXgcj5OI0rmt6S+4l11HW0rSW5oa103x3HIOmioV2AIhgBwigWmlFdcQfVsz+iNRDwRozTVe2wCSCwsanriZhfi1EIiAztfOFVafX8Psk4s2Z6INv0uhEDf4+h+wnsJFKsMN1oaNd9ZOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ7GyswX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ7GyswX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B2A1F000FF;
	Fri,  9 Oct 2026 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545307;
	bh=EnnRvDv84bxx+o5aYVJPEZcjfbq5nsje4N/L4BjjQdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZ7GyswXc3qv7bOtfT5h5Vn1fqVTLLf3E0r31TnFZAvhX1I7ZjRh9kDJqkEkfuJTl
	 etPYdwmGRuRtRjOa0ncnxThK14DhyQy0hSdCQJrzZBnONp9Nl/eXykzG+98Y2n0LDZ
	 sxhFeLtJUZOzmegf56+S1XIH/qUd6zjJ97aVrN/pzl6irnR/rUT3F7JcMjrqbDMphH
	 HjAmFZi7nqH6QWqOyUG6RkqIoTs6TCP6nFnfX0bigWGzqpo0Kj8ZPJheqpBFFPUOq8
	 ajiZl5G38fD1usTDZ6gsXiOjlcd5Uxt9CjQqJaM8SANOPLqzItoLZju2UgMbLv+dTR
	 FHlciykdqaR2w==
Message-ID: <sashiko-outbox-165372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: multitouch: use kzalloc for haptic data to fix
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009110509.2432308-1-qwe.aldo@gmail.com>
References: <20261009032607.3233482-1-qwe.aldo@gmail.com>
 <20261009110509.2432308-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:28:26 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: hid-multitouch: UAF / Double-free of td->haptic on hid_haptic=
_init() failure
- [Medium] hid: memory leak of td->haptic due to premature flag set
--

commit a50aea65dd06f11fa05d83509c540cc3680b3b08
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

    HID: multitouch: use kzalloc for haptic data to fix use-after-free

This commit replaces devm_kzalloc() with plain kzalloc() for td->haptic
to ensure it survives driver unbind. It introduces manual kfree() calls on
error paths and when the haptic subsystem is not used.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 4e19a0c4d2381..9cbe61832328c 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
[ ... ]
> @@ -2195,8 +2197,11 @@ static int mt_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
>  		hdev->quirks |=3D HID_QUIRK_NOGET;
> =20
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -	if (ret)
> +	if (ret) {
> +		if (!td->is_haptic_touchpad)
> +			kfree(td->haptic);
>  		return ret;
> +	}

[Severity: Medium]
Does this error path leak td->haptic if hid_hw_start() fails after mapping
but before configuration?

td->is_haptic_touchpad is set to true during the report mapping phase in
mt_touch_input_mapping(). If hid_hw_start() fails after this mapping is don=
e,
but before the configuration phase (for example, if hidinput_connect() fails
to allocate an input device), td->is_haptic_touchpad will be true.=20

The input core has not taken ownership of td->haptic yet, so skipping kfree=
()
here would leak the memory.

[ ... ]
> @@ -2206,9 +2211,13 @@ static int mt_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
>  	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
> =20
>  	if (!td->is_haptic_touchpad)
> -		devm_kfree(&hdev->dev, td->haptic);
> +		kfree(td->haptic);
> =20
>  	return 0;

[Severity: High]
Does this skip kfree() and lead to a memory leak if
hid_haptic_input_configured() returns an error?

In mt_input_configured(), the flag is only cleared if the configuration
returns 0:

drivers/hid/hid-multitouch.c:mt_input_configured() {
    ...
    if (hid_haptic_input_configured(hdev, td->haptic, hi) =3D=3D 0)
        td->is_haptic_touchpad =3D false;
    ...
}

If hid_haptic_input_configured() returns -1 (e.g., when the device lacks a
touchpad application), the flag remains true. The success path in mt_probe()
would then skip freeing td->haptic, leading to a memory leak.

Additionally, can this cause a use-after-free or a double-free on
hid_haptic_init() failure?

If try_module_get() fails in hid_haptic_init(), it jumps to the input_free
label without setting an error code:

drivers/hid/hid-haptic.c:hid_haptic_init() {
    if (!try_module_get(THIS_MODULE)) {
        dev_err(&hdev->dev, "Failed to increase module count.\n");
        goto input_free;
    }
    ...
input_free:
    input_ff_destroy(dev);
    ...
}

This path calls input_ff_destroy(), which unconditionally frees ff->private
(which points to td->haptic). Because no error code is returned,
mt_input_configured() incorrectly assumes success and leaves
td->is_haptic_touchpad set to true.

This leaves a dangling pointer in td->haptic since it was already freed by
input_ff_destroy(), potentially leading to a use-after-free on subsequent
touch events.

If the missing error code in hid_haptic_init() is corrected,
mt_input_configured() would set the flag to false, and this success path
in mt_probe() would call kfree(td->haptic) on already freed memory, causing
a double-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009110509.2432=
308-1-qwe.aldo@gmail.com?part=3D1
