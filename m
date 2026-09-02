Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9733BBC0
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312040; cv=none; b=YfOld4NDKH/okqNFr76l9GH1AIvrycAX3rmd11yDtuRE0Xa9QGAxnTSs8Wic32YLTUXem5lIgees+SLklp4NnyAD8Ss4PT0b9RKQzqgDlN9pWVC7wUJVPyuXTvrdnSOVb9eVUnqnVU8du5sKQhGgDDHLzl0M5UU+GABmzj1uPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312040; c=relaxed/simple;
	bh=5YgX4yVoaaIdK4ryggKXIljnDMy4+aX9wMvCEUhkRso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AP0j1NdB5genZUEW0ah2hDmsqj0rjpoJ7w6KABmVffU6bx/w0MTq2dmsW/u8WmwKmwEoF4BnhrePEXAsf7wBSYSdVa1rRB3apXnhofJJaV9KvIEZyHAPgLFhfXd0MLSy1MNsTqFDVXoIQ6r4GiD8juCS1nNXJ+W7oGSl14VnkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSOA0O7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSOA0O7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBBA1F000E9;
	Wed,  2 Sep 2026 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312039;
	bh=TxWGkHMKrDjZbwr0zNJA12HpENglSS5ydBUu/zXOO6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSOA0O7AsHp6lFy6Ywcb1fBmOiwTSld2kp42AJOOFO1W4Q9Hn3cjsYi1TkT4f9WxO
	 tdwMjnuEAFqeYui2I5yVRLr+j2fz2Nc55y82uAaT1QJKGAcHzjjxzlz1tk5AfPil2+
	 HS4vWgoNdHoGEYu6/I4N+LOk859JwayrLLXfwjZqrJj6oig1Qb7fGdX8y8ldvdGu/f
	 UDUll2wEo5yL5hTSd4wPnTiOZz3KHy8hPAMBQ1g9TlKd4JccVv6NwfAmzFXwL84E4s
	 KWhhkQAwvDKtXADp4HQSnfwGrdubz5lKTJV0uHxIsehy1yVU2kpS6QlInXD/GbiuRJ
	 rjR6+YYy0Keqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] Input: xbox_gip - Add battery support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902010237.865772-6-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:20:38 +0000
Message-Id: <20260902012038.DDBBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Devres actions on `input->dev` are delayed until userspace drops a=
ll references, causing the power supply to outlive the `attachment` structu=
re and resulting in a Use-After-Free.
- [High] Manually unregistering a devm-managed power supply and freeing its=
 name on an error path leads to a double-unregister and UAF when devres cle=
anup executes.
--

commit 7a0e19630adf51b35545780bfe01529fdc2adba8
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add battery support

This commit adds battery support to the xbox_gip driver by exposing the
controller's battery information as a power_supply device.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -1199,6 +1206,106 @@ static int gip_guide_led_probe(struct gip_attachm=
ent *attachment, struct device
[ ... ]
> +static int gip_battery_create(struct gip_attachment *attachment, struct =
device *dev)
> +{
> +	struct power_supply_config supply_config =3D { .drv_data =3D attachment=
, };
> +	int rc;
[ ... ]
> +	attachment->battery =3D devm_power_supply_register(dev,
> +		&attachment->battery_desc, &supply_config);
> +	if (IS_ERR(attachment->battery)) {
> +		rc =3D PTR_ERR(attachment->battery);
> +		goto err_out;
> +	}
> +
> +	rc =3D power_supply_powers(attachment->battery, dev);
> +	if (rc < 0) {
> +		power_supply_unregister(attachment->battery);
> +		goto err_out;
> +	}

[Severity: High]
Because attachment->battery was allocated using devm_power_supply_register(=
),
a devres action is already queued to unregister it. If power_supply_powers()
fails and we manually call power_supply_unregister() here, will devres
attempt to unregister it again later when the input device is cleaned up,
leading to a double-free?

[ ... ]
> @@ -1494,6 +1604,8 @@ static void gip_free_devices(struct gip_attachment =
*attachment)
> =20
>  	rcu_assign_pointer(attachment->input, NULL);
>  	rcu_assign_pointer(attachment->hdev, NULL);
> +	/* The following are freed by devres */
> +	attachment->battery =3D NULL;
>  	synchronize_rcu();

[Severity: High]
The battery was registered with devm using the input device (input->dev).
Since input device devres actions are delayed until userspace drops all
evdev file descriptor references, does setting attachment->battery to NULL
here leave the power supply active after the driver disconnects?

If a user reads the sysfs attributes for the power supply after the device
is unplugged, could gip_battery_get_property() attempt to access the freed
attachment structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D5
