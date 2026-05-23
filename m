Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2D24A078
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779551419; cv=none; b=gGo+CM2kxONC8e5UOXFMfz2cDV5MN4Zu34rgKqR05nsnsI+SrEFSICmC979HLrxJ1Y21mMwSz4l7GIutjizrgLXiLgyd9kt527NbytQJ5OT0naPFlSETYBKM6YyI1ZvNFhl/Q3fQhBQ5W3kYcyBBUOqHbfHc26IMsW0IN/IKVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779551419; c=relaxed/simple;
	bh=FBhUc0OUo2IhlmpLVVSSkBpd2K3ZCKFUs0FJxE4n8v0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7D140lmNOidpni2OW2U+gdZCU2Azp+Stp6k7zriYstgaIryfu55V7iBzmYG3zhivzC8uhd4KDUfANV/Gc5N8TqxINEyo+fp+bz62LxAUbGPawNjpsm6/1tYFZTKbSmFLUlp2tUCABJ9Opw9u6EZz8vuNudxhaVEbEox+G3uLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKqgbfDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKqgbfDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9AF1F000E9;
	Sat, 23 May 2026 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779551417;
	bh=WMu15sIrOufZSPLN6W9RE/8PG9QB5zvsQeTItSn5WrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKqgbfDzUoA8Qt44eyQ74/PtFeeEChocez444lUPsQLDM9sJpXSan9hQz46H8kJR7
	 TXLQtARjpej6TkihS9FUZXhLr++6nxMb0RWqCUmpamEXwD8ILy+ZcDeNYlt8H5BIkI
	 /ISG9hbrbbXEvDNkeKlc+nviuHAXmUSnITCEwkUMrOeTlyF+JS9enzZHG6owsyewWm
	 N9AoskEC3xha+W8ukQKGcMlrg6oiObhjdD01Pw3mloTYgcbGzVikput9rNPmtLVUWn
	 h+InA8ri6SppOqVLWIsS4IY8v+bQ159recji95MJzWxb7w00AGyxYbwAnApdleGnld
	 4JXQtRBe+tO6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix NULL pointer dereference in
 wacom_intuos_pad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260523150619.615565-1-jinmo44.yang@gmail.com>
References: <20260523150619.615565-1-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 15:50:16 +0000
Message-Id: <20260523155017.6E9AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch's early return in `wacom_intuos_pad()` causes valid pad =
reports to fall through to pen handlers when `pad_input` is NULL.

Pre-existing issues:
- [High] The patch addresses a NULL pointer dereference for `pad_input` but=
 completely misses identical vulnerabilities for `pen_input` and `touch_inp=
ut`.
- [High] Concurrent execution of `wacom_mode_change_work()` and `wacom_raw_=
event()` can lead to a Use-After-Free of input devices.
- [High] A dangling pointer in `wacom->shared->touch_input` leads to Use-Af=
ter-Free when the Touch interface unbinds while the Pad interface remains a=
ctive.
--

commit e74a772fd06994c14eb8d49710acd3ad8740df1f
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: fix NULL pointer dereference in wacom_intuos_pad()

This commit adds a NULL check for pad_input at the top of
wacom_intuos_pad() to bail out early when the pad input device was not set
up, preventing a general protection fault.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..251ddda3ecb3d 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -515,7 +515,6 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	struct wacom_features *features =3D &wacom->features;
>  	unsigned char *data =3D wacom->data;
>  	struct input_dev *input =3D wacom->pad_input;
> -	int i;
>  	int buttons =3D 0, nbuttons =3D features->numbered_buttons;
>  	int keys =3D 0, nkeys =3D 0;
>  	int ring1 =3D 0, ring2 =3D 0;
> @@ -523,6 +522,10 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	bool prox =3D false;
>  	bool wrench =3D false, keyboard =3D false, mute_touch =3D false, menu =
=3D false,
>  	     info =3D false;
> +	int i;
> +
> +	if (!input)
> +		return 0;

[Severity: High]
Does returning 0 here allow the event to fall through to other handlers?

wacom_intuos_irq() relies on a non-zero return to halt processing. If this
returns 0, a crafted pad packet might fall through to wacom_intuos_inout().

Since wacom_intuos_inout() only checks data[1] and not the report ID, it
could misinterpret a pad report as a pen proximity event. For example, if
data[1] =3D=3D 0x80, could it trigger wacom_exit_report() and either inject=
 a
spurious pen exit event or cause a NULL pointer dereference if pen_input
is also NULL?

Would it be better to place this check after verifying the report ID, and
return 1 to securely drop the packet?

[Severity: High]
This isn't a bug introduced by this patch, but does the same NULL pointer
vulnerability exist for pen_input and touch_input?

A crafted UHID descriptor can omit pen and touch capabilities, leaving
wacom->pen_input and wacom->touch_input as NULL.

If valid pen or touch packets are subsequently received, handlers like
wacom_exit_report(), wacom_intuos_general(), and wacom_bpt3_touch_msg()
appear to blindly dereference these NULL pointers.

[Severity: High]
This is a pre-existing issue, but can concurrent execution of
wacom_mode_change_work() and wacom_raw_event() lead to a use-after-free
of the input devices?

wacom_mode_change_work() frees input devices asynchronously via
wacom_release_resources() and devres_release_group(), without holding the
lock that serializes input report processing.

Concurrently, a raw input report could enter wacom_intuos_pad(), read the
wacom->pad_input pointer, successfully pass this new if (!input) check,
and then access the input device right after it gets freed.

> =20
>  	/* pad packets. Works as a second tool and is always in prox */
>  	if (!(data[0] =3D=3D WACOM_REPORT_INTUOSPAD || data[0] =3D=3D WACOM_REP=
ORT_INTUOS5PAD ||

[Severity: High]
This is a pre-existing issue, but can wacom->shared->touch_input become a
dangling pointer if the touch interface unbinds while the pad interface
remains active?

When a touch interface is unbound, its input devices are freed via
devres_release_group(), but wacom_remove_shared_data() does not appear to
set wacom->shared->touch_input to NULL.

If a pad event is received later, the pad event handler invokes
input_report_switch() and input_sync() on the dangling pointer:

    if (wacom->shared && wacom->shared->touch_input) {
        input_report_switch(wacom->shared->touch_input,
                            SW_MUTE_DEVICE,
                            !wacom->shared->is_touch_on);
        input_sync(wacom->shared->touch_input);
    }

Could this result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523150619.6155=
65-1-jinmo44.yang@gmail.com?part=3D1
