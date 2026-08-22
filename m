Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A02EBDE9
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436189; cv=none; b=bMqq8h70A1jXM49sl1efmRlGQhC4O2/eWowx1b3Ex3U4GpL3i3fbfxSvl96DQ8EG1IdkCQSshTIttoWU3lBlREN423SStalFzDPi57C23mar7Rlg1qnxYX+8sWEjnIZ/LzNxAQRXmQpLtyRYKY8/uHlEWaxtnYp5rMEI6g/ezWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436189; c=relaxed/simple;
	bh=3hX7YiSSudY7BGaLUaALXHLKi+EI+7tkuYOBsghrxfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V0zorNd8tEWbOIyW1wtCD+5r1qqYD9oEHvmW0I+NdjVil55STtTcVo9RtvUSByDLJfTjAiPj47G9TwzugHW2TApLywUBgPaqZxtaZj4k3BxgwR4OlfHFup4RevXKhjeYywQIWmfdNCLHRpRI7CiyH6eTgxd8nj6+u2gKWXmhJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBdB8XFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBdB8XFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF13D1F000E9;
	Sat, 22 Aug 2026 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436188;
	bh=jYoenJDmsZBBL7nS8WsJ5FVcVHMHzkZJMO4z/o3KBPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBdB8XFukRPBlPJFEVpfI2J3QW3d2PhQg+dGh8iEwADsdcWExZpDfzXg1TPcPpmaZ
	 qe30GcH3hSfUuFxuphJg+oExLKVYyMSSNSyT5mN6zhZbhBVe1vrbUOnLKG3bP5YolY
	 vuZGcBcLK2qMyEU2VZ4GkiT1Jw4kKNCFSrGVwleeJKxAtcGjqqnkuBHnzKgLIuiDfw
	 dvqprrEmFgihPHDPnDuFFlWHBpwrBfQo9xhwlCgBHR1VxcxW24bWX3e7nt/7yd101S
	 N5np+GVgmeWkeHz4bS1XnqRPrp2D/774xGQhbeGnQUstaCdZLMPSVvS87K/OQhHImv
	 7MZmuGiBNVXHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR
 polarity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822213941.98882-11-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-11-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 22:03:07 +0000
Message-Id: <20260822220307.EF13D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Read-modify-write race condition in ft260_uart_tiocmset() due to r=
eading shared state outside of a mutex.
- [High] ft260_uart_tiocmget() fails to check if ft260_gpio_get_all() retur=
ns an error code, silently returning a corrupted modem status bitmask to us=
erspace.
--

--- Patch [10]: [PATCH 10/13] HID: ft260: uart: fix active-low RTS/CTS/DTR/=
DSR polarity ---
commit 1c4e1ea308d880a16bd5a589b4e5e279a4dec5e8
Author: Rio Liu <rio@r26.me>

HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity

This commit inverts the TIOCMGET sense and the TIOCMSET drive levels for
the active-low FT260 modem control GPIOs (RTS, CTS, DTR, and DSR). This
aligns the userspace ioctl state with the electrical lines, leaving DCD
and RI unchanged.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 0a1875a1a7eca..a2f4b6e5a16bb 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1985,10 +1985,10 @@ static int ft260_uart_tiocmget(struct tty_struct =
*tty)
> =20
>  	gpios =3D ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but ft260_gpio_get_all() can ret=
urn
a negative error code (such as -EIO) if a hardware or transport error occur=
s.

Does evaluating this negative error code as a bitmask in the return stateme=
nt
below risk masking the hardware error and returning a corrupted modem status
to userspace instead of propagating the error?

> -	return (((gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
> -		((gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
> -		((gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
> -		((gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
> +	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
> +		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
> +		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
> +		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
>  		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
>  		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
>  }
> @@ -2013,13 +2013,13 @@ static int ft260_uart_tiocmset(struct tty_struct =
*tty,
>  	mutex_lock(&port->lock);

[Severity: High]
This is also a pre-existing issue, but in ft260_uart_tiocmset(), the local
variable rep.gpio is populated from the shared state port->gpio before
acquiring port->lock:

	rep.gpio =3D port->gpio;
	mutex_lock(&port->lock);

Could this result in a read-modify-write race where a concurrent GPIO
modification (e.g., via sysfs) is silently reverted by the TTY ioctl?

Should rep.gpio be populated inside the critical section instead?

> =20
>  	if (set & TIOCM_RTS)
> -		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
>  	if (set & TIOCM_DTR)
> -		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
>  	if (clear & TIOCM_RTS)
> -		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
>  	if (clear & TIOCM_DTR)
> -		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
> =20
>  	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
>  		  rep.gpio.dirs, rep.gpio.vals,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D10
