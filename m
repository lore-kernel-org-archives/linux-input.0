Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337141C2F0;
	Tue, 30 Jun 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826115; cv=none; b=tEEcrbiAOE9KGSdONPbkNgVZAO+ZS3hfm63b7L5sWot7+DwM8DDsLcND29E1/lv1o9qRtMAlhlOXceyCaICV1d3I2RxH3n6qnJDN1ToQjPcr9+EChEEO77vGgJ9ORKTE7aM+mz6oYGJfA6JF0iwH7CIzpX2N6TEnk9egf+J/dSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826115; c=relaxed/simple;
	bh=e50i/t+otz1MUxjpLg0k+QVIsU/EiHcY8BOMbSdt3oM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evbG2Qoc/c6Q63RRa4RcT+94r+E9LT1jpk4Z7L+JJ0Gug3rM4aU9Ltv2yqPTjeTpTZqqFrkUDB2enofkIqEm0Ql/FgJv6cBgLKD6vfZ+6VJi7ZVIoM9eXoiUff2OVNh7u7qVDElKtkBUcbdZIVfiXe+qZ01q6RsCQ7fhIexpabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb3wrXA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb3wrXA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450051F00A3A;
	Tue, 30 Jun 2026 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826113;
	bh=+FAD0oKS3SeQ82yLrtXGWjS6Gjvd3EoOnAU9Vn3DKCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gb3wrXA1wKlOsU4o5YpskKf7EaW/7Z5k4ogtGGTCHbKvSWIXMdTWcQ47xRXvmAuSV
	 ekA7zkyWW3SYG9AWBvQ0lL8tIAvV3r5t00rg95fP6gXHpoSPh8s6UiAIxJAgkHk59q
	 furj2i8HbcsnchP5GMCI+RxfNR3SrJUUF6oArUfYjFaWgoyL00Aad9wd582f9AY1vO
	 IxTj3TLbFkvdB+432Xbn2vr3xf4klRgcrVletBnYDj7dHdXtQIUq+iXwlpnuK2PYuz
	 6mLzSBSukM8pXEveX79W+u6HVQFoc6Tg3/OaCYPmlyZ1GJ4HwKnE0VYM+OZ2PmOzEP
	 sW4009xsEb+7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] pcmcia: replace linux/gpio.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev, vkoul@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260629132633.1300009-9-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-9-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:32 +0000
Message-Id: <20260630132833.450051F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid resource cleanup on error path leading to potential double=
-free of a devres-managed GPIO descriptor.
--

commit a1a20647914d78d6a15655dea889e9d53c734136
Author: Arnd Bergmann <arnd@arndb.de>

pcmcia: replace linux/gpio.h inclusions

The pcmcia drivers all use the legacy interfaces, so convert to
include linux/gpio/legacy.h instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[ ... ]

> diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
> index 10cb99c20a7f5..6c52d90795eb4 100644
> --- a/drivers/pcmcia/sa1100_h3600.c
> +++ b/drivers/pcmcia/sa1100_h3600.c
> @@ -11,7 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/legacy.h>

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
issue while reviewing the GPIO include changes.

Does the error path in h3600_pcmcia_hw_init() cause a double-free of a
devres-managed GPIO descriptor?

If gpio_request(H3XXX_EGPIO_OPT_NVRAM_ON) or subsequent legacy GPIO requests
fail, the code jumps to or falls through to the err01 label:

drivers/pcmcia/sa1100_h3600.c:h3600_pcmcia_hw_init() {
    ...
err06:  gpio_free(H3XXX_EGPIO_CARD_RESET);
err05:  gpio_free(H3XXX_EGPIO_OPT_RESET);
err04:  gpio_free(H3XXX_EGPIO_OPT_ON);
err03:  gpio_free(H3XXX_EGPIO_OPT_NVRAM_ON);
err01:  gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
        return err;
}

The err01 label incorrectly frees H3XXX_GPIO_PCMCIA_IRQ0. This GPIO is
managed by devres and was not explicitly requested using gpio_request() in
this function.=20

When devres cleans up the failed probe, it will attempt to free the GPIO
again. This could lead to a double-free, gpiolib state corruption, kernel
warnings, or accidentally freeing a GPIO acquired by a concurrent driver.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D8
