Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608D299959
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291132; cv=none; b=A+miKD5Fbiqlp9cZQbpiVUkAtLbo2oIte5hUtnc/3d8TYV3xjt2Y1J5Tf0/j6TTYxY8SZOVYtg4sRi48ABk8XDWLHqj+SHFh8BxdKRqX/Ioc9MPrccS1Ru7p8msjA4YC6rdYosMuAZZ+HeMCQk+IbfDg9J4or4VJuqh2MbYhupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291132; c=relaxed/simple;
	bh=1E08JZmX4Od86DJpLMsf2VccGoxStn5Qku8Nir6QReI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3vK6UxYEU77k40CwkEnq5+u81h9itgE0PFfCR4Ib1bPbVwp6ZrTJkjk80a0gvHOR+jGKdnlGuMCUZHmxY68AINNYpot5AhdEVPFe9gIGFWlD98pc/Fu5qzE8FKHIjJs1L9WmlZXrhQFr9Jj7a+WNpk3+4SddfteWII5qwOko1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdzH5Fy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdzH5Fy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4861F000E9;
	Wed, 29 Jul 2026 02:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291130;
	bh=EQRwHim9vYoTRGtWGNyS7QI7ch7MhQoEtmXAsOy4H3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZdzH5Fy4V5nZ+wess3z4f6xDFDFss4raiVFEP1Qnz8cPsYrIg3tX+KllC7iDqTzM5
	 bEFEbjFggKkluxmyHXAP2CYGYrpS1HJ9+pLH8O9JG1fBpcuuJ+p55SLgIF6NGz3aDG
	 c2Kil6u9IARJCEKyekZki9DcvTvy/1XV0Wi7qo3D4pUFW9AqSk1J/ngKt1vZYbEw1Y
	 OUnoHcby53N8F9wxG/M7iyXpmoJr7T8X1MHiJH2w8n890PjtM1Np3WJjgiQh0ds2md
	 kexVbLgQ60n3CinAtv1iTeLBmPrZIerLBeXhMRBQKzNh5nY+eqPr6P44fiF7O/hvZN
	 UhxCkOOWnhjPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/11] HID: steam: Fully unregister controller when
 hidraw is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260729015243.1170573-8-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
 <20260729015243.1170573-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:12:09 +0000
Message-Id: <20260729021210.4B4861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unifying connect and unregister logic causes log spam and unnece=
ssary I/O on hidraw open/close.

Pre-existing issues:
- [High] Dangling pointer in the global `steam_devices` list on probe failu=
re.
--

--- Patch [7]: [PATCH v4 07/11] HID: steam: Fully unregister controller whe=
n hidraw is opened ---
commit d6b711a20faba4cc20306f07e01853b79872c545
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Fully unregister controller when hidraw is opened

To avoid conflicts between anything touching the hidraw and the driver, this
patch fully unregisters the controller internally when hidraw is opened,
leaving only the hidraw active until it's closed. It also unifies the
unregister and connect callbacks.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index a200878db8ac7..ff112aa1b0e91 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -1141,38 +1142,41 @@ static int steam_register(struct steam_device *st=
eam)
[ ... ]
>  static void steam_work_connect_cb(struct work_struct *work)
>  {
>  	struct steam_device *steam =3D container_of(work, struct steam_device,
>  							work_connect);
> +
>  	unsigned long flags;
>  	bool connected;
> +	bool opened;
>  	int ret;
> =20
>  	spin_lock_irqsave(&steam->lock, flags);
> +	opened =3D steam->client_opened;
>  	connected =3D steam->connected;
>  	spin_unlock_irqrestore(&steam->lock, flags);
> =20
> -	if (connected) {
> +	if (connected && !opened) {
>  		ret =3D steam_register(steam);

[Severity: High]
This is a pre-existing issue, but does steam_register() leak the list
entry if it fails?

If steam_register() fails (e.g., if input_allocate_device() fails inside
steam_input_register()), the device is added to the global steam_devices
list but not removed.

Also, in steam_probe(), if a wired Steam controller is probed but an error
occurs later, the error path jumps to err_hw_stop, bypassing
err_steam_unregister. Devres will free the steam_device structure, leaving a
dangling pointer in steam_devices. Could this lead to a use-after-free if t=
he
list is later traversed (e.g., when a user modifies lizard_mode)?

> -		if (ret) {
> +		if (ret)
>  			hid_err(steam->hdev,
>  				"%s:steam_register failed with error %d\n",
>  				__func__, ret);
> -		}
>  	} else {
>  		steam_unregister(steam);
>  	}

[Severity: Medium]
By unifying the connect and unregister logic here, will this cause log spam
and unnecessary synchronous USB I/O when hidraw is opened and closed?

steam_unregister() clears the serial number and logs a disconnect message.
When hidraw is closed, steam_register() logs a connect message and performs
synchronous USB I/O to re-fetch the serial number and device attributes.

Could an unprivileged userspace application rapidly open and close the
hidraw node (which is typical for gamepads managed by udev), flooding the
kernel log and triggering localized DoS via USB I/O?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729015243.1170=
573-1-vi@endrift.com?part=3D7
