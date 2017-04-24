From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 10:00:32 +0200
Message-ID: <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
References: <20170424094231.435f82de@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166375AbdDXIA4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 04:00:56 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id C83372015A
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 08:00:45 +0000 (UTC)
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com [209.85.223.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6A8201C8
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 08:00:38 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id a103so182377187ioj.1
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 01:00:38 -0700 (PDT)
In-Reply-To: <20170424094231.435f82de@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Apr 24, 2017 at 9:42 AM, Jean Delvare <jdelvare@suse.de> wrote:
> The tm2-touchkey driver is only useful on specific platforms. Add the
> missing hardware dependency so that the driver is not proposed on
> systems where the device does not exist.

Although the device exists in only two upstreamed Exynos boards but
there is no hardware dependency on Exynos. The hardware does not
depend on Exynos.

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 72d1f2346ded ("Input: tm2-touchkey - add touchkey driver support for TM2")

I do not see a bug to fix. Even if we agree that driver building
should be limited to Exynos then definitely there is no missing
dependency to fix.

Best regards,
Krzysztof

> Cc: Jaechul Lee <jcsing.lee@samsung.com>
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andi Shyti <andi.shyti@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Note: I am not familar with the hardware in question so I'm not sure
> if this is the right dependency to add, or if ARM64 would be more
> appropriate, or something else, or a combination thereof. Please
> advise.
>
>  drivers/input/keyboard/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-4.11-rc8.orig/drivers/input/keyboard/Kconfig  2017-04-03 02:23:54.000000000 +0200
> +++ linux-4.11-rc8/drivers/input/keyboard/Kconfig       2017-04-24 09:26:43.314252700 +0200
> @@ -670,6 +670,7 @@ config KEYBOARD_TM2_TOUCHKEY
>         tristate "TM2 touchkey support"
>         depends on I2C
>         depends on LEDS_CLASS
> +       depends on ARCH_EXYNOS || COMPILE_TEST
>         help
>           Say Y here to enable device driver for tm2-touchkey with
>           LED control for the Exynos5433 TM2 board.
>
>
> --
> Jean Delvare
> SUSE L3 Support
