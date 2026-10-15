Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA3499F2F
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102336; cv=none; b=IfFjFIAvQxT3gvDfZnwdYev0sFKAVPBpCTlAOGDaJ0sV3Hh/ePAlkYmVSHNRnL2A/dE/YJC32tnd/RXcpM8jhKAq8pDqtsw4XFRTBwAG+NgwgpWrdli1uS+69oQtTAi6uM9UoO26CiSas2fI4fS9KGZqK9OjQ5BvIjclox3nse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102336; c=relaxed/simple;
	bh=wlohEXRjavvAReVTmR3nwESnFqOXGTUkXf42WyDfj3o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tLXsShG3hFx+ej/holgij2oOSDKN2Bfdn5HOIkZ9YyxoGWd4J64aNSP9m0TD4dqEgnzxkorgAi3Jd+37nevWuUl7rP6WlWydAvQkAC0s5wWBE1r4BBsl/iD3Om38Y9s+KkZa5SJ1A7j76bSEvUPWZCiyDH8LJrUWXNqop8/egHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMP0Qxhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMP0Qxhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F31F000C4;
	Thu, 15 Oct 2026 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792102334;
	bh=Ld5RRNvPRi56T4DC6KBn4UXUOONmJBX4KOmKsKv1VdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMP0Qxhx5QTNTeHp7DKW1JkykyEKm+STsxdAXzHYQBCbUvLuWm3hjlaDSEsfehxQm
	 o2bfNwSDYRjosB31VTi4q+Vj8xEqQXlZYLwerOFpNEvzctK5myjMFRlnK/llqpXTsI
	 Jgc5Lkaf+AKCeGVuJtK4H/CgXcGmyejr0P5unHghOrP54zmFGHwyvi3UzrwnoNIQE6
	 ibY0gJRxuwlpWNI4N61OV/VmtGaKD9lXBp78weUZbk1lHgryvG5knbTgMYznqe5vPv
	 BvPnLXpGhijgZFSnYrOmtvrQdM0ShLfxmMlepYXayzDGa4LPxzOXDn5/6rP8RcvZ5Q
	 ppzV75S3IJvSA==
Message-ID: <sashiko-outbox-173441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] xpad: Overhaul device data for wireless devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261015220126.102766-3-sanjay.govind9@gmail.com>
References: <20261015220126.102766-3-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 22:12:14 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] input: data race on x360w pad metadata between URB completion and w=
orkqueue
--

commit 623a5a67bf1fb99bf182903ceaa0fbfb964bfc7b
Author: Sanjay Govind <sanjay.govind9@gmail.com>

xpad: Overhaul device data for wireless devices
   =20
This commit updates Xbox 360 wireless controllers to extract and use vendor
IDs, subtypes, and product IDs from link and capability reports. It delays
creating the input device until 500ms after the pad is reported present to
ensure this information is available.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..bcad597b29b4a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -995,18 +1035,98 @@ static void xpad_presence_work(struct work_struct =
*work)
> -static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data)
> +static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data, u32 len)
>  {
>  	struct input_dev *dev;
>  	bool present;
> +	u16 parsed_vid;
> =20
>  	/* Presence change */
>  	if (data[0] & 0x08) {
>  		present =3D (data[1] & 0x80) !=3D 0;
> =20
> -		if (xpad->pad_present !=3D present) {
> +		if (xpad->pad_present && !present) {
> +			/* Forget everything we learned about the old pad */
> +			WRITE_ONCE(xpad->pad_gen, xpad->pad_gen + 1);
> +			xpad->sub_type =3D 0;
> +			xpad->flags =3D 0;
> +			xpad->wireless_vid =3D 0;
> +			xpad->wireless_pid =3D 0;
> +			xpad->wireless_version =3D 0;

[Severity: Low]
Can these pad metadata fields race with xpad_init_input() during device
initialization?

The URB completion handler xpad360w_process_packet() runs asynchronously in
softirq context and modifies these fields without holding any synchronizati=
on
primitive.

[ ... ]

> @@ -1943,8 +2088,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
>  	usb_to_input_id(xpad->udev, &input_dev->id);
> =20
>  	if (xpad->xtype =3D=3D XTYPE_XBOX360W) {
> -		/* x360w controllers and the receiver have different ids */
> -		input_dev->id.product =3D 0x02a1;
> +		if (xpad->wireless_vid)
> +			input_dev->id.vendor =3D xpad->wireless_vid;
> +		if (xpad->wireless_pid)
> +			input_dev->id.product =3D xpad->wireless_pid;

[Severity: Low]
Since the delayed xpad_presence_work can execute xpad_init_input() on anoth=
er
CPU concurrently with a disconnect packet or late capabilities report, could
this read torn, zeroed, or partially updated device identification data?

The 500ms delay defers the work, but does not serialize it against subseque=
nt
URB completions. This might cause the input device to be momentarily
registered with an incorrect ID (e.g., 0000:0000) or name before the
subsequent work iteration unregisters it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015220126.1027=
66-3-sanjay.govind9@gmail.com?part=3D1
