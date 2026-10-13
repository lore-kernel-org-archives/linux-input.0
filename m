Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B43D565A
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886908; cv=none; b=Sy7iOz7FC30awuSVKNWDdOZLFNkDIA7kiegwKnZBcKwxIbNXsbWdIZcCoM9Wx1uuJbnCWLJLq15DZtDxU9CZChpkxEMZ4a9xQreAVZ/wvieS4A9w6LYxIpv8gGSUf5qfZwzKwQE3yP4i9aIM4ZB1rHq8+UcIEK02geWR5Ls1uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886908; c=relaxed/simple;
	bh=Uus4mo2PIP4joi0KkgesyTIDG0Gx7MAghXECPiVhbaI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RJcVH6YKp8O9GcnTvB8187NB8rOhVBNogkNFa9inktJd/Qjt6fj1tssOwp6tCRhwoPS3InrSkXFk1cvUqJtgnORLQr48YBxAQxpYrrxMwLILAO3BMfIiioa7vgoCqTIZNXknIfX44vWeKxbGDyazC1CssuNCmGylkTTtcGdTGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQiMWoMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQiMWoMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292DA1F000FF;
	Tue, 13 Oct 2026 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791886907;
	bh=JLYO7Xre+O50csj4V2C/sgE97be+eF5ZE4ScYkTpD3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQiMWoMvqJ69H7F7cRw9gtT0weVC296OVcvubFWVjJJk7HqHMAjGgDGdYOFygkN0c
	 p2siojvrEU6KFGpCT+dA6T1W1m5sILnnkzRyDhFVcc0ILwjk855lHcBA6SKLQMM7of
	 4/QQV8iwifQO+rzsypbpDA9YhDwYEeJe4lEGO9ZOsSM4ioW54RfgOcM0T5oCChzNjv
	 RIDRr0P8ak/G+tmd8vwqBL63ReG4Fif+NMSh+xv51ycfnvRxKhshudbT0K45NhuhdD
	 uXCUnL7qi/Q/lCQhKzJ82byfldlrR1FnpssTnpaqFWury6pBT1jO1vioU2Uv8hjLIN
	 rcRtZXFxY7gaA==
Message-ID: <sashiko-outbox-169488@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v5.15-v5.10 5/6] HID: steam: Refactor registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261013091215.529531-5-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
 <20261013091215.529531-5-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 10:21:46 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: steam: initial connection status dropped due to missing hid=
_device_io_start
--

commit 06e6c231f0f1bba41bfa16d27899ea2f3bb451a9
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: steam: Refactor registration

This commit refactors and simplifies the registration/unregistration flow.
It relies on the client open state and a single boolean flag to manage
registration logic, and ensures the battery device is unregistered if later
initialization steps fail.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -739,20 +768,33 @@ static int steam_probe(struct hid_device *hdev,
[ ... ]
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>  		hid_info(hdev, "Steam wireless receiver connected");
>  		/* If using a wireless adaptor ask for connection status */
>  		steam->connected =3D false;
>  		steam_request_conn_status(steam);
>  	} else {
>  		/* A wired connection is always present */
>  		steam->connected =3D true;
>  		ret =3D steam_register(steam);
>  		if (ret) {
>  			hid_err(hdev,
>  				"%s:steam_register failed with error %d\n",
>  				__func__, ret);
> -			goto input_register_fail;
> +			goto err_hw_close;
>  		}
>  	}
> =20
> +	steam->client_hdev =3D steam_create_client_hid(hdev);
> +	if (IS_ERR(steam->client_hdev)) {
> +		ret =3D PTR_ERR(steam->client_hdev);
> +		goto err_stream_unregister;
> +	}
> +	steam->client_hdev->driver_data =3D steam;
> +
> +	ret =3D hid_add_device(steam->client_hdev);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Will the earlier asynchronous status request be dropped because the HID core
input gate is still closed?

By moving the hid_add_device(steam->client_hdev) call to execute after
steam_request_conn_status(), the steam_probe() function takes longer to
return.

The hardware replies asynchronously with a STEAM_EV_CONNECT event on the
interrupt endpoint. Because hid_device_io_start() has not been called, the
HID core driver_input_lock remains held while the rest of steam_probe()
executes.

If the interrupt URB completes during this widened window, won't the HID
core unconditionally drop the connection status report, leaving the wireless
controller unresponsive?

> +	if (ret)
> +		goto err_destroy;
> +
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013091215.5295=
31-1-lee@kernel.org?part=3D5
