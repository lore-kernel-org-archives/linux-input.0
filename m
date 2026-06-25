Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C9360EC0
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379930; cv=none; b=l9kkCcozpwCYpPWNWvcy5DcnGmSC7y1LasNwMARCKdxJ2E5by8JvLlpxbq1leOB9U3zeATUQ581QLW8QwpqVEKqZySqQiS1Dk0aA4PKudtyAq61Lr7uGmbdHVbHv/PAigE+6k8vm0zUSgtbP7/19gH2Y36KXGAivI/9KAgCHyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379930; c=relaxed/simple;
	bh=9emCyUT/U8dT0XqHM+M6WU+JREiJF4Zud0ZtdnV+9As=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GnZEkEYrjUUuGSE7Ka9yFyRitmVGRjnzPDL12jRUScFSJ+XngPryGddiUWih+O5X5nixYHRWV4OiReMNJ10ayh6Vknv9HmzoRrsXCjcm7U4BgD6k3gHDxtmW1KzERNhAdOGpC4lhFB/RmKYgw8PYy+TsS/VmzjRd/3UkLb49VEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4szlbgZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4szlbgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B6B1F000E9;
	Thu, 25 Jun 2026 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782379929;
	bh=u+zKsvTIyiE2f/isXbZ5oaMVXGBzyUGzV7qHwR4gLrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g4szlbgZaGlPk0tHZXxJ8XbXsLfZ5UBeeN5ySUy8Lw/p4fhMNwzOXkJoPQAQvaITb
	 HXoU3Ng5+e+cdN4gIa1po/x/x/lCVt6kVTaaH7XhPcIJZ3t7a0asrafGCCXmT8OWAq
	 kDXbUsXXZ6Hpswx/UbQoA445vWrIYcleVDWvdvTnI82yXoM1Z/MjJz71hTKRgUEy+w
	 SBm/eBIg7A8Ej0mls84Do08Htb4SoNN+kJaN5CLZEmDNrClVOx47LbMRROJjaYIaYO
	 GJQG5+aY9zaCG+17ZMR5hTh7yXhhcYHLifYTswr5KKcyHb4WSHgF0FNYqrI3GyXK+S
	 XHVJ4yGOjIOxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: usbhid: Use seq_buf_putc() in three functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <89e9c672-efee-4ed2-9ef5-637ec9707f0b@web.de>
References: <89e9c672-efee-4ed2-9ef5-637ec9707f0b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:32:08 +0000
Message-Id: <20260625093209.34B6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Replacing `seq_buf_puts()` with `seq_buf_putc()` introduces a NU=
L-termination bug when the manufacturer string is exactly 127 bytes long, l=
eading to an out-of-bounds read.
--

commit c41669030bdd8635988fc175a1caf4183a28344a
Author: Markus Elfring <elfring@users.sourceforge.net>

HID: usbhid: Use seq_buf_putc() in three functions

This patch updates three probe functions to use seq_buf_putc() instead
of seq_buf_puts() when inserting a single space character into sequence
buffers.

> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1412,7 +1412,7 @@ static int usbhid_probe(struct usb_interface *intf,=
 const struct usb_device_id *
> =20
>  	if (dev->product) {
>  		if (dev->manufacturer)
> -			seq_buf_puts(&hid_name, " ");
> +			seq_buf_putc(&hid_name, ' ');

[Severity: Medium]
Does this change introduce a missing null termination bug in usbhid_probe()
if the manufacturer string is exactly 127 bytes long?

The previous code using seq_buf_puts() requires two bytes of available
capacity (one for the space, one for the trailing null byte) and safely fai=
ls
if there isn't enough room.

Looking at seq_buf_putc(), it only checks if there is room for one byte.
If the sequence buffer is exactly 128 bytes long and already contains 127
characters from dev->manufacturer plus the null terminator, seq_buf_putc()
will overwrite the null terminator at index 127 with a space character.

This leaves hid->name completely unterminated. When exposed to userspace via
sysfs or input ioctls, this could lead to an out-of-bounds read into the
adjacent hid->phys memory field.

>  		seq_buf_puts(&hid_name, dev->product);
>  	}
> =20
> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
> --- a/drivers/hid/usbhid/usbkbd.c
> +++ b/drivers/hid/usbhid/usbkbd.c

[ ... ]

> @@ -302,7 +302,7 @@ static int usb_kbd_probe(struct usb_interface *iface,
> =20
>  	if (dev->product) {
>  		if (dev->manufacturer)
> -			seq_buf_puts(&kbd_name, " ");
> +			seq_buf_putc(&kbd_name, ' ');

[Severity: Medium]
Does this have the same unterminated string issue for kbd->name in
usb_kbd_probe()?

If an untrusted USB device presents a manufacturer string of exactly 127
bytes, this overwrite could allow an out-of-bounds read into the adjacent
kbd->phys array.

>  		seq_buf_puts(&kbd_name, dev->product);
>  	}
> =20
> diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
> --- a/drivers/hid/usbhid/usbmouse.c
> +++ b/drivers/hid/usbhid/usbmouse.c

[ ... ]

> @@ -150,7 +150,7 @@ static int usb_mouse_probe(struct usb_interface *intf=
, const struct usb_device_i
> =20
>  	if (dev->product) {
>  		if (dev->manufacturer)
> -			seq_buf_puts(&mouse_name, " ");
> +			seq_buf_putc(&mouse_name, ' ');

[Severity: Medium]
Is mouse->name vulnerable to the same null terminator overwrite here in
usb_mouse_probe()?

Similarly, this could leak the contents of mouse->phys to userspace.

>  		seq_buf_puts(&mouse_name, dev->product);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/89e9c672-efee-4ed2-=
9ef5-637ec9707f0b@web.de?part=3D1
