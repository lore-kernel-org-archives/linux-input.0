Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DD2C1595
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785160; cv=none; b=CPtZuAwldt/2FntIdPdk8KlUYyp2N3Yq4fk3TDTnaDUH+9UFWUvwSC4tfZGLunO3HK1JBTv2oGFByQnUzSMJ8CDIT6c+P3e/9gI0aOlRbwzNRT1BdhXnc+Cae6Dhjd+19XPqGrolO8VO1LRXVJY3f4rNHf7V2fhlmKp51hD5erw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785160; c=relaxed/simple;
	bh=VCYioAdYaeo/PZ9GMonzvxtTo2IiQQJGnQOU3Qe7H0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sh9UHpTv1a/bbzXxsTtDQYJJh+o8PeO36qRfJ7gk7QUi+wtC94r+uvZkn+eSesN/mvVKWVU/QyRyI1zAsDocpkqPsI1mh/90UQ3SfaxfX3iJMffIb3qiJ9xMRsTpgU3MKgp8EbBnGmcQGPFXDqPVADdvif+DPjicqBoyuvLPuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9EySbe1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9EySbe1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F11F00A3A;
	Mon,  3 Aug 2026 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785158;
	bh=YRE4PO7DjmmYH9KQOw2uP9HXHU2/pz/oMyYV7pTaNZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9EySbe1JahyL/dFXQE1W/Ygba7wiQcNXvtKYqieQoHXbvI/chn5/PRxrxDSvoAVq
	 i/T9CzBjYFRYYKw8Yo6RE7pkvNftJY+JVII0zQs3TgLhGkIo/HJ4EgYYtflsNb2cUv
	 givH1NyPfuxVDWmslkuJoaRT5LTldlQajkJqSBa20Y5g1QPalWwPwihMKfw2JmMrPb
	 8Mrpu3s7mdciqf6hUIaMoIVeCtsbx8DlaKbXy2SudPLJnqCWPSvMcsta46CQCU6LX8
	 8c16M3+gPff0dRCfgsiGkMVC6JQTifqPZxAPylR5jJ+n9J406qeMQ76IZMcH5YqnW/
	 14lNcmbHEKmTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/8] HID: steelseries: Refactor Arctis driver to use
 device_info framework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260803191553.66368-4-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
 <20260803191553.66368-4-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 19:25:56 +0000
Message-Id: <20260803192557.9E9F11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition exposing ERR_PTR leading to kernel panic in raw_eve=
nt.
--

--- Patch [3]: [PATCH v7 3/8] HID: steelseries: Refactor Arctis driver to u=
se device_info framework ---
commit e1b5fdcaec23ba5cc7a2a2139ba1c9fa983d7894
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Refactor Arctis driver to use device_info framework

This commit refactors the Arctis driver to use a device_info struct
instead of a quirk bitmap for device capabilities. It also changes
battery polling to use a periodic delayed work instead of being
requested from raw_event.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index 6cae2e00bd8ba..c54c56db9ddd7 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -177,25 +271,27 @@ static int steelseries_headset_battery_register(str=
uct steelseries_device *sd)
[ ... ]
>  	sd->battery =3D devm_power_supply_register(&sd->hdev->dev,
>  			&sd->battery_desc, &battery_cfg);
>  	if (IS_ERR(sd->battery)) {
>  		ret =3D PTR_ERR(sd->battery);
> +		sd->battery =3D NULL;
>  		hid_err(sd->hdev,
>  				"%s:power_supply_register failed with error %d\n",
>  				__func__, ret);

[Severity: High]
Could this assignment expose an ERR_PTR to a concurrent event handler?

Because hid_hw_start() and hid_hw_open() are called before=20
steelseries_battery_register() in steelseries_arctis_probe(), USB interrupt=
s=20
can trigger steelseries_arctis_raw_event() concurrently.

If devm_power_supply_register() fails due to memory pressure or other error=
s,=20
sd->battery will briefly hold an ERR_PTR before it is set to NULL. A=20
concurrent execution of raw_event() evaluates if (sd->battery). Since an=20
ERR_PTR is not NULL, the check passes, and power_supply_changed(sd->battery=
)=20
will dereference the invalid pointer, causing a kernel panic.

Would it be safer to assign the return value to a local variable first, and=
=20
only assign it to sd->battery upon success?

Additionally, does the unconditional assignment of sd->battery_capacity =3D=
 100=20
just before registration risk silently overwriting a real status update=20
received by raw_event() during this window?

[ ... ]
> @@ -272,142 +365,92 @@ static void steelseries_arctis_remove(struct hid_d=
evice *hdev)
[ ... ]
> -	if (connected !=3D sd->headset_connected) {
> -		hid_dbg(sd->hdev,
> +	if (sd->headset_connected !=3D old_connected) {
> +		hid_dbg(hdev,
>  			"Connected status changed from %sconnected to %sconnected\n",
> -			sd->headset_connected ? "" : "not ",
> -			connected ? "" : "not ");
> -		sd->headset_connected =3D connected;
> -		steelseries_headset_set_wireless_status(hdev, connected);
> +			old_connected ? "" : "not ",
> +			sd->headset_connected ? "" : "not ");
> +
> +		if (sd->battery) {
> +			steelseries_headset_set_wireless_status(sd->hdev,
> +							       sd->headset_connected);
> +			power_supply_changed(sd->battery);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803191553.6636=
8-1-srimanachanta@gmail.com?part=3D3
