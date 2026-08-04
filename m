Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CD4477F1
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840445; cv=none; b=TOIYXGcxjRI4ZUr2hWiCgDM1NcNBG9Qkx5CnPJxQhCG5kxxfPxdHWyzh/vGY3ucJTFm5Z8jxhbQgxjweOFskSfi7VrbsHg2IJeDBNhxjDO42/NVDEx7MHc1zdWdYWAhptVkHduWcVdoSsnhUEUNPiGI21J79dbmW7EnQ6jsHWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840445; c=relaxed/simple;
	bh=nWmOiY0/f+b5gea53Bo18cAYmgdwe1Myc0yjThej90g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFadsc88z7q649cXXycXD1SYMQNITnJtgtKH9WzE51b5wl9yA3KvzoNbcn5SP30UEGIqr968H9iwyh5b/jB2vitIdI/xgFautFkgjR50CIQC6txdSfAItm0MVkTSewXEk/dvT3fAAXeuFgTQbfqV84rI0J5n1AsF/BIEJtz4+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw4BsuoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw4BsuoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71221F00A3A;
	Tue,  4 Aug 2026 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840444;
	bh=vooSE7Z9K8HEb6i+oLE3pkh8Pd5gNwE0gdtRCk/G8CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lw4BsuoW6F0GDCYPeEQDh2Fo3Nt+3plkFhtM8IfNBPI6XYdf4DaOS3xn/cA+tJ9Gl
	 Kcj6vchPFleeTmrdlVVgW1voLWPInqiZJerQd9S1j/jOd7adyq5Q7FczlIDZqt6SRb
	 KNnp3qKgtmqvODU9GxvLTronEFOgzghaA6pqbCriNeidtDhwYBRDfn1B1E3xTb8gff
	 2I/s7Yta7cgSXg9M8WKF2t1Q4MH6iaAwV4ndDzoOnl3c16H0mH3TdFPpZUICHT7Wtw
	 1AXz6AI8QS6W6V6s1C82Ak7N4RYKuodPgpnKl+610VWRPUp9xM2pM/JBSkXvMSieg/
	 osxs2eP6PGZYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260804103209.1496683-1-lee@kernel.org>
References: <20260804103209.1496683-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:47:22 +0000
Message-Id: <20260804104723.C71221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free in wacom_wac_pad_event due to dangling shared->=
touch_input pointer.
--

--- Patch [1]: [PATCH v7 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capabili=
ty prior to registration ---
commit c2b94041c1337efa1a4a2cba0f9ae1c4dd7c4773
Author: Lee Jones <lee@kernel.org>

HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration

This commit moves the advertisement of the SW_MUTE_DEVICE capability to occ=
ur
before input device registration to comply with input subsystem guidelines.=
 It
also modifies composite USB generic touch devices to advertise the mute
capability by default.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..92b73ed0028f1 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom_w=
ac *wacom_wac)
>  			wacom_wac->shared->is_touch_on =3D true;
>  	}
> =20
> -	if (wacom_wac->shared->has_mute_touch_switch &&
> -	    wacom_wac->shared->touch_input) {
> -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> -				     SW_MUTE_DEVICE);
> -	}
>  }

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch, but while
reviewing the shared touch input changes, I noticed a potential use-after-f=
ree
with wacom_wac->shared->touch_input.

In wacom_remove_shared_data(), when the touch interface unbinds, the devres
cleanup routine clears the shared->touch pointer but leaves
shared->touch_input dangling:

drivers/hid/wacom_sys.c:wacom_remove_shared_data() {
    ...
		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
			wacom_wac->shared->touch =3D NULL;
		else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
			wacom_wac->shared->pen =3D NULL;
    ...
}

If the pad interface remains bound and a user triggers a touch mute event,
could wacom_wac_pad_event() access this freed input_dev?

drivers/hid/wacom_wac.c:wacom_wac_pad_event() {
    ...
	if ((equivalent_usage =3D=3D WACOM_HID_WD_MUTE_DEVICE) ||
	   (equivalent_usage =3D=3D WACOM_HID_WD_TOUCHONOFF)) {
		if (wacom_wac->shared->touch_input) {
			...
			input_report_switch(wacom_wac->shared->touch_input,
					    SW_MUTE_DEVICE, !(*is_touch_on));
			input_sync(wacom_wac->shared->touch_input);
		}
		return;
	}
    ...
}

Should wacom_remove_shared_data() also set shared->touch_input to NULL when
clearing shared->touch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804103209.1496=
683-1-lee@kernel.org?part=3D1
