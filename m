Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C740928C;
	Mon, 27 Jul 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157218; cv=none; b=I9xiWCb7NvOGY/1UJzg8opi0lIyTUOAEQygl76RfMrFrxvFX5f05aKYgRIFshhl3tOHDTKHmIUdJbsCZjZH2/CcW2IcTWBZn+HLOEYsu5pkeuGSwrPIU7CWDLf5t5NZFByEygmWhgb6fp8eYMgAD3GxDe2KCzLF6vMXvT3WKfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157218; c=relaxed/simple;
	bh=EbSbTD6EzfuNV5Tw4EJ7kb05pLhhq6V5fIWNbwNh1X8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dd7EW7Ag9k3FyJ36t++UfBrSNaCkij+d0qaM0DSwM1kB0HMgLWpAb+QKtaGuZiUJISHZRDFlgo/YSljXiaqbtvf2H2iSIgSwPy1bPRHKB9cQUkepAN0KSoKcE1Q2UQKrCNP6IOdXgLpnepoYhO5hHeZL+hmzpWxvj2D1WjnLW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D4ED3EC34;
	Mon, 27 Jul 2026 13:00:08 +0000 (UTC)
Message-ID: <ca28c348b95fdabc19ea86ab56716e0cbbae24ad.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for G502 X Plus USB
 mouse
From: Bastien Nocera <hadess@hadess.net>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Filipe =?ISO-8859-1?Q?La=EDns?=
	 <lains@riseup.net>
Date: Mon, 27 Jul 2026 15:00:07 +0200
In-Reply-To: <20260721171246.461232-5-stuart.a.hayhurst@gmail.com>
References: <20260721171246.461232-5-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGHLOXi9DBBza53PAUI4Sxk4LgDqNnfT+OUjyzwFTDSq4wnePxEeKntWvVKSnjSzVm288O625G2038cQKQ9D8QbqV4e6HT/pyjzPb6NW4Lb78NpkrHQ5L3Ka/Ss6wXT8Q/olCwHx0cdbPsCRCns/ikuC4vpbMTq84gCLv+9vHB3IJUbf07px5iAxxhgqkwc/Owfe3X71RdZH7KhZBWOyGkGUV/EcRq5LiKBHTi+0mDqswF6BqxILhfz+HNaAEV2tPelHrjTDaLEP8BahOE5BX02se8birHZyOYOHEtQlcXIdmHHFtEt6v5/8IDAjZ6S6qig4kj16EneXw+q9/pJzzONW+ezLd9se09d2U2LrIScoQJUKp8AgNGpdiLzWJH81nosnDhjrRRJ0IVJa0iMnIGoosh1jmFCHSilg7B5ZbgXy2nELGen2vLOHokp7SqHSyTFFfQG4EqTjtatVlIGZXyOqFC82ShIWRxDyc5pNTmM4In9H0E0Q7A2jZjYRyqt8aMwHNVpzcGua0GXt6dRA3iXFvhCqGZj/w294L1+2Sh8QvLo+ba6XfhCRYeto9mfXtc/jIqT42kJCyF9jNz7wZOhaTYv9rAEp0OCKSLVZJ3cSTpAQIPNi6z6Yl+rROQhOTFe5NSfnUf9sN7C4tJpK9JlxI3yDT0aizSQshyEYNUJbg

On Tue, 2026-07-21 at 18:12 +0100, Stuart Hayhurst wrote:
> The wireless dongle is already supported, this adds detection for
> the mouse in wired mode. Supports battery reporting.
>=20
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 90b0184df777..25620494e741 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4647,6 +4647,8 @@ static const struct hid_device_id
> hidpp_devices[] =3D {
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
> =C2=A0	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB
> */
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
> +	{ /* Logitech G502 X Plus Wireless Gaming Mouse over USB */
> +	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC095) },
> =C2=A0	{ /* Logitech G703 Gaming Mouse over USB */
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
> =C2=A0	{ /* Logitech G703 Hero Gaming Mouse over USB */
