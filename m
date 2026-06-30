Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98668408606;
	Tue, 30 Jun 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826119; cv=none; b=qmYuo9IVKayuBBmSOsFYwaM18mOmde852qaxZhzjT1XsNjKnhHeQl6a6il15UMJ9gdKJax1OE/gTCS8vhTWI5mTGxfAG7QT3g4iCTBByRk4Obq3Ktn3+lot31274uKQ0rgcZMjbdRYX4Vhw/yQQLAiMHNg++CwZhJSBD2iQVky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826119; c=relaxed/simple;
	bh=9NiflCoc3TKqKY7jEZG95f3gnZnoKca6z317hGOnnqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkGXWKUk3b+Di7MSd0KmPLh6x0uCt6CHDI5povndgSSb3aPTEzfE3xaNIMkoBu0jQX1rMpXwzBMrWTrb6DlUN/zGyUMGU5M0lI9KZtJZxAmcTpW0P6j1+Ms8rnkUgz6om0qn7eWMREzxevSU+csHulQ0Zzo6+gF3fibDSka9feA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlUdN6H+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlUdN6H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113F91F00A3A;
	Tue, 30 Jun 2026 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826118;
	bh=pGZSQjypMUdXOQ/qAERccKjvtdXttbB0Lef+ZubLVEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlUdN6H+zBVnvK+YP6U2SuoYEXBPxOvvCZgUa9/7NiQPljDR60Y7edF0HbPaXa1yP
	 uud5XZhetvShN7Oy/ksRjhASsWbssXUiJ/+p2lP309wEoqzpVsEYzLo1iicm63jbgd
	 elH9z5mwbcc97td+e4M5UfQvqd+ZoravZZFnBYK5CQnQ9qy0cajc/H8BVRU4G96xPj
	 LZno3zRVD34TluLFJEQPoXbHshpO4osPABIwRRfXwZLY0DHuAcMVJVrXVdCtFb/0YI
	 KsxiA4Oa77+LXOmHPVQcgNaoU9QQpXYQLIdc5ipOvTLMGMEOsK8+91Jr3pc5bhOHDy
	 yTLwIOCl7eEVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] gpiolib: remove linux/gpio.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-sunxi@lists.linux.dev, dmitry.torokhov@gmail.com, neil.armstrong@linaro.org, olteanv@gmail.com, vkoul@kernel.org, linux-phy@lists.infradead.org, linux-input@vger.kernel.org
In-Reply-To: <20260629132633.1300009-14-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-14-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:37 +0000
Message-Id: <20260630132838.113F91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Removing `include/linux/gpio.h` breaks the build for multiple drive=
rs across the kernel tree that still include it and rely on it for legacy G=
PIO declarations.
- [Low] Typographical error in `drivers/gpio/TODO` where `legacy.h` is miss=
pelled as `lagacy.h`.
--

commit eb8b9c8709d4fc96f518f3578deb6f0d05993604
Author: Arnd Bergmann <arnd@arndb.de>

gpiolib: remove linux/gpio.h

This commit removes the include/linux/gpio.h header entirely, cleaning up
leftover bits under the assumption that all drivers have been converted to
consumer.h or legacy.h. It also updates internal gpiolib includes and a=20
TODO file accordingly.

> diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> index 7ce80fde1f17e..894c7e1af252a 100644
> --- a/drivers/gpio/TODO
> +++ b/drivers/gpio/TODO
> @@ -52,9 +52,7 @@ Work items:
>    base can be made dynamic (set to -1) if CONFIG_GPIO_SYSFS is disabled.
> =20
>  - When this work is complete (will require some of the items in the
> -  following ongoing work as well) we can delete the old global
> -  numberspace accessors from <linux/gpio.h> and eventually delete
> -  <linux/gpio.h> altogether.
> +  following ongoing work as well) we can delete <linux/gpio/lagacy.h>.
                                                                ^^^^^^^^
[Severity: Low]
This isn't a bug, but there is a typo here (lagacy.h instead of legacy.h).

[ ... ]

> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> deleted file mode 100644
> index b0d4942a65de2..0000000000000
> --- a/include/linux/gpio.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
[ ... ]
> -#ifdef CONFIG_GPIOLIB_LEGACY
> -#include <linux/gpio/legacy.h>
> -#endif /* CONFIG_GPIOLIB_LEGACY */
> -
> -#endif /* __LINUX_GPIO_H */

[Severity: Low]
Does removing this header break the build for remaining unconverted legacy
GPIO consumers?

For example, drivers/input/keyboard/gpio_keys.c:gpio_keys_setup_key() still
appears to rely on this header for devm_gpio_request_one():

    error =3D devm_gpio_request_one(dev, button->gpio, GPIOF_IN, desc);

Similarly, drivers/leds/leds-gpio.c:gpio_led_get_gpiod() also relies on it:

    ret =3D devm_gpio_request_one(dev, template->gpio, GPIOF_OUT_INIT_LOW,
                                template->name);

And arch/x86/platform/olpc/olpc-xo1-sci.c:setup_ec_sci() still uses
gpio_request():

    r =3D gpio_request(OLPC_GPIO_ECSCI, "OLPC-ECSCI");

Will these drivers fail to compile since functions like devm_gpio_request_o=
ne()
and gpio_request() will now be missing or implicitly declared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D13
