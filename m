From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 23:26:00 +0200
Message-ID: <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55457 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2JLV0B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:26:01 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3475979vbb.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:26:00 -0700 (PDT)
In-Reply-To: <1350057346-15998-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Fri, Oct 12, 2012 at 5:55 PM, Daniel Mack <zonque@gmail.com> wrote:

> This allows DT driven boards to allocate and configure the pinmux once
> the driver is probed.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

(...)
> +       /* request pin mux */
> +       pinctrl = devm_pinctrl_get_select_default(dev);
> +       if (IS_ERR(pinctrl))
> +               dev_warn(dev, "pins are not configured from the driver\n");

I think dev_warn() is rather nasty to throw in here, dev_info() is OK.

However I suspect this driver could actually handle default, idle and sleep
states, especially after the runtime PM patches discussed elsewhere,
but that can be patched later.

Yours,
Linus Walleij
