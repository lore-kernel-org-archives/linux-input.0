Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947034;
	b=RrrrBYUxM/Ysyw9tu5lB9JhF2lJ2aBR7KMwduBOGvvZmt5WqjwyAYNn3HV9EYakPJmXB
	 F2h78u04O5UdMyPxi9dSjhSfR5HzQ6Lx0ZGIvEs5aOXkA3alaCwJC5mOz1LPv10RtEfXQ
	 aR7+GX1G+e601FjozxmiMXlmT2zCbUrd5FVB3spFARxU+cPHoonul9X1g0kQZaXxPsOnU
	 2T7JRCS/Hqd7l0O7Cn3F9/qNq+QIx8MiNGgIQRNkBwjZ0vTr5OyghaMMqKeniSUVPWycu
	 1LZAn2jrVnqE1GBlz8LF2zb9MhkK8skpJLcEIsqD26r+Oe/6qr3j8yesR+1IvEBQhpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ji+pYbrvXpbS8ZyIq11+7KwbyNSd+be87c88YcSwlb0=;
	b=priUfMnLz3YI6F6qLF2aNbtwju5pUmBqeOIi2ql8Rss+mwAcAqjkTxrS2W3sK1LSetDE
	 z9Jgqj0KKZbW/s9CqwwaS0hiQTy+R15z/nizv/jKZud5+2Z+zoHxLPoL1vidYqf4lXEBZ
	 +qHwFWAZLC2KgDY11lkEOGZWZJXSG2kT4Wq8iTPfqhntDQxghZYBKhkp+7A58LNFTWQvD
	 9bG+57W81T90n+yG+/JAUMyR/01IRYYn2gLncZFpaJ895fNIkjXvcSZzyFcnuIOSMY/Qa
	 d1GIlxRj+hqK4/5QrQM3Jhzd8KQy1kcU+RKHOvpqhPOpHtqRE8qWuCQVG4vCd0YpIng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y38LpLzo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2A606A331;
	Tue, 17 Nov 2026 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y38LpLzo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96F41F000D1;
	Tue, 17 Nov 2026 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947034;
	bh=Ji+pYbrvXpbS8ZyIq11+7KwbyNSd+be87c88YcSwlb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y38LpLzoW9qB3Afhe0LjWN33fClPzWr6b/aDAWtuF9LMTh6SfxZtXF92xZoYW47mT
	 jh30+HjDM000mYNswu5uqTd1SJADAMvjDtvDEmAwXd2I2Pjc7eGfAqm26QDQMh3taw
	 xSwP7/dbj5d341F/Gv5DZ16yUU/2DjNmtxh+0SKkHOeRsZUvVSUSuLzbkxu7s4ok2F
	 c+VPaBg5PhGVAIofH/4Sp5XS1a5yXiagE3Wzm6tMChWUG/RVbToL1XZQy4Dro/s4un
	 MgEvm+71V+yje/2jr9EuXEz3m0BwKvmzW28jYsu9C53l0vHLuvyUbAwU6/nm/u4nX3
	 wZyq1cC82E8yg==
Message-ID: <sashiko-outbox-219595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/16] HID: ft260: add GPIO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117200423.19561-4-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-4-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:23:52 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: ft260: unused gpio state field and macros in
  ft260_gpio_init()
--

commit 8d81adc5ba43eb8c745172cf336bbd09bc7bc28f
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: add GPIO support

This commit adds gpiochip support for the FT260 multifunctional pins,
exposes pin function selection via sysfs, and tracks enabled GPIOs across
UART modes.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 869e7b924b30a..acd92248256f9 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -57,6 +59,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messag=
es");
>  #define FT260_RD_DATA_MAX 180
>  #define FT260_WR_I2C_DATA_MAX 60
>  #define FT260_WR_UART_DATA_MAX 60
> +#define FT260_GPIOCHIP "ft260_gpio"
> +#define FT260_GPIO_0_5_COUNT 6
> +#define FT260_GPIO_A_H_COUNT 8
> +#define FT260_GPIO_TOTAL (FT260_GPIO_0_5_COUNT + FT260_GPIO_A_H_COUNT)
> +#define FT260_GPIO_MASK GENMASK(FT260_GPIO_TOTAL - 1, 0)
[ ... ]
> +/* GPIO groups */
> +#define FT260_GPIO_WAKEUP		FT260_GPIO_3
> +#define FT260_GPIO_I2C_DEFAULT		(FT260_GPIO_0 | FT260_GPIO_1)
[ ... ]
> @@ -359,6 +470,11 @@ struct ft260_device {
>  	u16 read_idx;
>  	u16 read_len;
>  	u16 clock;
> +	u16 gpio_en;
> +	struct gpio_chip gc;
> +	struct ft260_gpio_state gpio;
> +	u16 gpio_uart_mode[FT260_GPIO_UART_MODES];
> +	bool uart_dcd_ri;
>  };
[ ... ]
> +static int ft260_gpio_init(struct ft260_device *dev,
> +			   struct ft260_get_system_status_report *cfg)
> +{
[ ... ]
> +	/* Wakeup chip */
> +	(void)ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
> +					(u8 *)&ver, sizeof(ver));
> +
> +	ret =3D ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&gbuf,
> +					   sizeof(gbuf));
> +	if (ret < 0)
> +		hid_warn(hdev, "cannot read GPIO state: %d\n", ret);
> +	else
> +		dev->gpio =3D gbuf.gpio;

[Severity: Low]
Is dev->gpio (along with this FT260_GPIO feature report read in
ft260_gpio_init()) still needed now that ft260_gpio_set() and
ft260_gpio_direction_set() read FT260_GPIO from the chip before modifying a
pin?

dev->gpio is written in ft260_gpio_init(), ft260_gpio_set(), and
ft260_gpio_direction_set(), but never read in this commit.  Although commit
"HID: ft260: uart: add modem pins control via ioctl" briefly reads
port->gpio in ft260_uart_tiocmset(), commit "HID: ft260: i2c: recover a bus
held by a slave" changes ft260_uart_tiocmset() to read FT260_GPIO directly
from the chip as well, leaving dev->gpio write-only at the end of the
series.

Also, FT260_GPIOCHIP and FT260_GPIO_WAKEUP are unused because
ft260_gpio_init() formats dev->gc.label with devm_kasprintf() and checks
enable_wakeup_int with FT260_GPIO_3 directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D3
