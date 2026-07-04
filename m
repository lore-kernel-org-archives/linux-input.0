Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70425A2B5
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783207411; cv=none; b=KcqRv1LzqlTQw76+XPwsJ/vlR4mscvi05jkN7s8GAX1jgIEMeIGv6G7ImMlyB48DYUXTpQpdeudae6LTuN+Hg/4/XEefP+xA+WuVqV5EX7Bwt4tDfSlv/qqX+ZmVcUE7Zm9xhqCpj9gkRBxcz0kh4fYG8PTXl261Kpdmtbcj04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783207411; c=relaxed/simple;
	bh=x7+UqvpgX/B25gV1Bc0jgEMWv9waI/gp3n/S8/APv2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ez/RdIQh4RAY6Csy8PSkkwo580F89yq9F4VZbIiRDXLlzDUIW2im/HwmYIbnSXLhR8CcJdAqEQ48B7/lD/rZY5b7bMDf1jW/RNOR2Z9wpeBM526MydFSaK45KvmwOeJhmq1f2MYyDQNgs65x6mnBfQM8CsJugonc4d5/zRhGXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqTgLH2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqTgLH2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388C01F000E9;
	Sat,  4 Jul 2026 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783207410;
	bh=9XBTDCcoik0PwmcwslEckZ9RVpjG39RvDNJf7kx7O1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqTgLH2Wu0f3yhRqis0Q8uTrgnZbZ8pNKH2qrSUO9LvFBqnde6sg81Lg28IdgkL3M
	 JmOvKNiMVBBDpF7qVSg5YaxPtZN54W/XP2RqTnZ1cUI+SEtV2DTTiniB2HlgxReusG
	 /mP81JHryaorzaDGHHN0KGcetXZzWoJiX3BMVRWZdTUFo8JSdmqtZahkJ3lubw1PTt
	 RUmuQgWCuDp0cG91YGNnrBoMDje4mw+I6tpEa6P7Uu1+pTJePonmODCmIVdzIGCs+n
	 FohrnXF4L6utfTM59mju5NsiWGpg97XSauj3bKjbuzWPe1v3LpMLPsbKkZRLRrO6DP
	 XyMEWZM9USbKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: logitech-hidpp: add HID++ 2.0
 reprogrammable button support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Elliot Douglas" <edouglas7358@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <d4c48a9d36c738abd02a0430a6ca8a5a792fb3ea.1783094954.git.edouglas7358@gmail.com>
References: <cover.1783094954.git.edouglas7358@gmail.com>
 <d4c48a9d36c738abd02a0430a6ca8a5a792fb3ea.1783094954.git.edouglas7358@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 23:23:29 +0000
Message-Id: <20260704232330.388C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer `hidpp->input` leads to Use-After-Free if `input_=
register_device()` fails.
- [High] Unbounded 64-byte structure copy in `hidpp_raw_hidpp_event` causes=
 a Kernel Heap Out-of-Bounds Read.
--

commit 13dc21807e8eb6f76d9029e89353e4bd2e6aa1c3
Author: Elliot Douglas <edouglas7358@gmail.com>
Subject: HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support

Some Logitech HID++ 2.0 mice can report diverted reprogrammable controls
through HID++ feature 0x1b04, SpecialKeysMseButtons / REPROG_CONTROLS_V4,
instead of the normal HID mouse report.

Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.html

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 70ba1a5e40d8e..f9189e14fb780 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -3601,6 +3606,195 @@ static int hidpp10_extra_mouse_buttons_raw_event(=
struct hidpp_device *hidpp,
[ ... ]
> +static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hidpp,
> +					     u8 *data, int size)
> +{
> +	const struct hidpp_reprog_control_mapping *mapping;
> +	struct hidpp_report *report =3D (struct hidpp_report *)data;
> +	u16 controls[4];
> +	bool pressed;
> +	unsigned int i, j;
> +
> +	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
> +	    !hidpp->input ||

[Severity: High]
This is a pre-existing issue, but could this lead to a use-after-free?

Looking at hidpp_connect_event(), if input_register_device() fails, it
cleans up by calling input_free_device() but leaves the hidpp->input=20
pointer dangling:

    ret =3D input_register_device(input);
    if (ret) {
            input_free_device(input);
            return;
    }

Because hid_device_io_start() has already enabled incoming packets before
this point, could a newly arriving event trigger this new
hidpp20_reprog_controls_raw_event() handler, pass the !hidpp->input check,
and dereference the freed pointer?

> +	    !hidpp->reprog_controls ||
> +	    hidpp->reprog_controls_feature_index =3D=3D 0xff)
> +		return 0;
[ ... ]
> @@ -3971,6 +4168,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_devi=
ce *hidpp, u8 *data,
>  			return ret;
>  	}
> =20
> +	ret =3D hidpp20_reprog_controls_raw_event(hidpp, data, size);
> +	if (ret !=3D 0)
> +		return ret;
> +

[Severity: High]
This is a pre-existing issue, but does hidpp_raw_hidpp_event() perform an
out-of-bounds read on the incoming data buffer?

Earlier in this function, if the packet matches a pending question, it does
a direct structure assignment:

    if (hidpp_match_answer(question, report) ||
            hidpp_match_error(question, report)) {
        *answer =3D *report;

Since struct hidpp_report is a 64-byte packed structure, won't this pointer
assignment perform a fixed 64-byte copy regardless of the actual size of the
received buffer (which could be as small as 7 bytes for a=20
REPORT_ID_HIDPP_SHORT packet)?=20

Could this copy adjacent heap memory into the answer buffer, potentially=20
leaking it when the data is parsed later?

>  	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
>  		ret =3D hidpp10_consumer_keys_raw_event(hidpp, data, size);
>  		if (ret !=3D 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783094954.gi=
t.edouglas7358@gmail.com?part=3D1
