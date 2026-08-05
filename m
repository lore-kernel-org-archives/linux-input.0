Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4C3AFAFA
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895354; cv=none; b=Mf/FCDhktrLUOAQhimfqIbKoJSwaloIZ9CGEvkeS4u4O936wtc5FMnN9cuLytkQKpmva7iSUrvTcm9qmpUd4KcZUs1X1aiX7LckxgOnDO68v3dA10D7nz9gcS7gcLiV59t7o+kLTrR2t5ONCo7RV8ymf23jALof1PZUQ2CdClDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895354; c=relaxed/simple;
	bh=hIVF3xMGed7n6tW2onDYjHhdWHyN22WEMenuwh8H3JY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDSdewwy3AW2VLC97UyDlU5mRl7VqRjm6Q3FQuPiPaGJFJ9v7goKSiCpNsgYxFfaG5OGPXmn8+j0yLQ4FCMJSh7q8ipT/auoSLbwypSIgnAPpTNwvJ2YT7YrOuRK0qs9yjfr58VVh1tZclusohIdCQc0K4I5uddppVF1nouCG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqeagPeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqeagPeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE841F000E9;
	Wed,  5 Aug 2026 02:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895353;
	bh=IBlgWgarQizaZ2HlmyStG1EijIFo1pvt/JYD0kWUPIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqeagPeV8+wwUJgn+eqCL3fVGOUem86U8oIcxfB176KG94YYykP8FcEH7OPLBSmzZ
	 GCkQiLdlheuHUTrBVOQgXQcyTe7iXf+Z6EFur9F7K0ScVfIZfp1GOqS9aFWUVDie5s
	 QxnbFI9ZTIKs6PkCCAhqShKhs5hl5eSDerdQ/SlBsiK7xWoCvhz4i06sZRfrLzPwAw
	 4SfXngSkkudxPQbiSDjDIHoHD42kFeLc783ORSRObIT3qpVjDmwopgXfIrOemR2u3N
	 20X1Z1qnH/LVhy9mzhI5TRXWOcjO1q0StK6ig7xdDr2FVXBngM7F3N8VS9Qp6KTKl4
	 gFParwnDOOlwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] HID: steam: Fix wording of connect/disconnect logs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260805015116.3884465-3-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
 <20260805015116.3884465-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 02:02:32 +0000
Message-Id: <20260805020233.3AE841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in steam_register() fails to unregister the battery=
, leading to a leaked power supply and subsequent use-after-free if probe f=
ails.
--

--- Patch [2]: [PATCH 2/5] HID: steam: Fix wording of connect/disconnect lo=
gs ---
commit 86b8e9ab8ffc7b90075c933cefda13a663141100
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Fix wording of connect/disconnect logs
   =20
It always said Controller, even on Deck. Since we special-case other
instances of Controller vs. Deck in strings, let's be consistent here too.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 111e57926d049..fdf32722c8b31 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1397,7 +1397,8 @@ static int steam_register(struct steam_device *stea=
m)
>  			"%s:steam_get_attributes failed with error %d\n",
>  			__func__, ret);
> =20
> -	hid_info(steam->hdev, "Steam Controller '%s' connected",
> +	hid_info(steam->hdev, "Steam %s '%s' connected",
> +			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
>  			steam->serial_no);
> =20
>  	/* ignore battery errors, we can live without it */

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
issue regarding the battery registration near this log message.

If steam_battery_register() is called, but a subsequent registration fails:

drivers/hid/hid-steam.c:steam_register() {
    ...
	if (steam->quirks & (STEAM_QUIRK_WIRELESS | STEAM_QUIRK_IBEX))
		steam_battery_register(steam);
    ...
	ret =3D steam_input_register(steam);
	if (ret !=3D 0)
		goto steam_register_input_fail;
	ret =3D steam_sensors_register(steam);
	if (ret !=3D 0)
		goto steam_register_sensors_fail;
    ...
steam_register_sensors_fail:
	steam_input_unregister(steam);
steam_register_input_fail:
	return ret;
}

Could this error path leave the power supply registered when steam_register=
()
returns an error?

If probe fails, the driver core will release devres allocations, freeing the
steam_device struct. A user querying sysfs for battery properties could then
trigger a use-after-free since the power supply subsystem would still have
the freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805015116.3884=
465-1-vi@endrift.com?part=3D2
