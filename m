Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1D1D54FA
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101920; cv=none; b=GKUsxhTNo3ilzll5DZ/C6lZMz5f1dS77D1qdGCV/hSwa0ENZL1deiK5LLtsV75deRVBnC/Xf1kxITQotq5dvkY6ZSBvis+W03HnU5jyOQCZpjlW4OdaLqIs5fYKiaJzvfV7tGjBmIAkbpzyFrGyEY6kUe2LMlD7OETNyqLw2Mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101920; c=relaxed/simple;
	bh=cAp0azq4iprvbF3AqPC302noCh9YmfqyZbK5hfULo0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r3PrQwCyKOl1a/Pfy8IvDD3ro2rlhekCFWVqc1ogzkEQ7DP13yyTcrtY5mIABX5ASRqH9wJwX4FJ8ODxAbUkWEWPRkii14SU2Kcer55gDhnxHA9Z9CA/zG44AxvIp67qL7R7uvsowEWa4Ovwva3LeS8VHbizvhU4xD4TeH+L4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSlKBi3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSlKBi3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8E81F00893;
	Sat, 30 May 2026 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101919;
	bh=5azXZdv2RqJiD21eWDb54L1jGXyP+0uXX2Ken1gKGzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSlKBi3sJTd1QfvMx+RKtCiX0KqMfIlFbqFC8Q5O3hNblejCkFComdYyqm09tgfgG
	 gQ1lVGGvpGaPGrEVYqEWFdVcjtopCZyB+xyrs/sRPo6E9gPgWzQjs3raX6oS2VpwTw
	 CNDfLaUDYq5fdMOuPxudGYfAb4kaLREzT+IV/W5oPgO0QFmZoiGApzofpm+gOPKSvU
	 X5+ORcb/ePRR7ltZ22mraD49qc02zzQUp26OyHZXRTNa37lRma4C2f6MWS+q7cUTEQ
	 P5UDSksoezRthtb5oUMcYsJiMpSH+EwiMOElhidsxA340As/tXs3acJ7eTXyDHL4Xq
	 0FHFA3KmZAjmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib
 optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520183815.2510387-3-arnd@kernel.org>
References: <20260520183815.2510387-3-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:18 +0000
Message-Id: <20260530004519.1C8E81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying the legacy GPIO validation to check `!button->irq` break=
s legacy devices that legitimately provide both a GPIO and an IRQ.
- [Medium] Conditionally removing the `gpio` field from `struct gpio_keys_b=
utton` causes build failures in drivers that assign to this field when `CON=
FIG_GPIOLIB_LEGACY` is disabled.
--

commit cb399daff5ceabcf54d5ea611fd309f5c0600ab4
Author: Arnd Bergmann <arnd@arndb.de>

input: gpio-keys: make legacy gpiolib optional

This commit makes the legacy gpiolib interface optional for gpio-keys and
gpio-keys-polled by adding ifdef blocks. It also modifies the gpio-keys
driver to ignore the gpio number if an IRQ is passed to keep Rohm PMIC
drivers working with and without CONFIG_GPIOLIB_LEGACY.

Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmai=
l.com/
Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/

> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/=
gpio_keys.c
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
[ ... ]
> @@ -528,7 +528,8 @@ static int gpio_keys_setup_key(struct platform_device=
 *pdev,
>  			 */
>  			bdata->gpiod =3D NULL;
>  		}
> -	} else if (gpio_is_valid(button->gpio)) {
> +#ifdef CONFIG_GPIOLIB_LEGACY
> +	} else if (!button->irq && gpio_is_valid(button->gpio)) {

[Severity: High]
Does this change break legacy devices that legitimately provide both a valid
GPIO and a valid IRQ?

If a legacy platform provides both a valid GPIO and an IRQ, this condition
now evaluates to false.

By skipping the GPIO request entirely, the driver falls back to treating the
device as a pure IRQ button. This forces the driver to lose hardware
debouncing and rely on a simulated release timer instead of checking the
physical GPIO line.

[ ... ]
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
[ ... ]
> @@ -25,7 +25,9 @@ struct device;
>   */
>  struct gpio_keys_button {
>  	unsigned int code;
> +#ifdef CONFIG_GPIOLIB_LEGACY
>  	int gpio;
> +#endif
>  	int active_low;

[Severity: Medium]
Will this cause build failures for drivers that assign to this field when
CONFIG_GPIOLIB_LEGACY is disabled?

Other modern drivers dynamically create the platform device and pass legacy
GPIO numbers by directly assigning to this field:

drivers/input/misc/soc_button_array.c:soc_button_device_create() {
    ...
    gpio_keys[n_buttons].gpio =3D gpio;
    ...
}

When CONFIG_GPIOLIB_LEGACY is disabled, this results in a compilation failu=
re
since struct gpio_keys_button no longer has the gpio member.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520183815.2510=
387-1-arnd@kernel.org?part=3D2
