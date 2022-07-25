Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B911ACCA48A
	for <linux-input@archiver.kernel.org>; Mon, 25 Jul 2022 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiGYUfC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiGYUe4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D422BFC;
        Mon, 25 Jul 2022 13:34:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf4so22715061ejc.3;
        Mon, 25 Jul 2022 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9QlVd3sY4PWP1LvgvsglsfYdo46+qKuYLSCKi5klpY=;
        b=kh+Aki1lVqKeBtJg/8dN55UIOrgM4lLUyefRybo33qn5mXHg5ruQyt607eWvl6XW6C
         jxpunR2ZxTytMHDyvGlCw780j3AUV8RH92yk9782xsGx4dYJTQxY7CYb46HOvp0cM7cn
         U1EUwA3uYu6Y/wAi+YGwTpFHC8WGW4otXGC0dqgxaZ+zWmNtFMp7/UQlJcUb4F8FKpLq
         51YxKGefmk76+gnkAfyzOnn+eEAUHrJd31CtzWtrEXJDUPmIAmAaqi+TR+HgKWa5Ohvg
         apIPDifFTqDBNqQhaxVB1CRfqneOhV5boGD/NBiEoE6/OgobXAvSahm8ukcbCJT9Ea1X
         2YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9QlVd3sY4PWP1LvgvsglsfYdo46+qKuYLSCKi5klpY=;
        b=lVaevs7ckjWZKlu1Ad/mqhLsbTeVXq+OulCXiLx5FhPGPwy/lJAcfrOLKQoGeLgvsx
         6K9/RZcU5IeuDXaoibGn7R0GEv2dO4iDDlaq8D47fy29rfoB3XDjN38wCCsZGp4aPBoW
         d81zAvaChbd6erdKlcZd5vDSGOzW4z+8mJRj///C85ar9klnvag/EXctDPrJ8KzIhZhn
         5qH2vLPMb/gCZiFu2rp/Su1hpHPYLLMh/Sw6lbkTYgsoe+DBRWaKVxJ35ducRaK14xrx
         3bELp7a7nMtFZoQ+GxdH5Y0s/ROhVIMoUeMd1lO0qkd2vO9ZJktHRaiFradfQVUZ1xsz
         kPHQ==
X-Gm-Message-State: AJIora87VZoZfHFyTXWialuKUhQGVAOVzCKJJm4yax29YXue8bGxjdl+
        a1rqkWd8e0oAzPIgIVzH8j+HrkbDYfWoeiNJ95vTboj5IKw=
X-Google-Smtp-Source: AGRyM1viPX6Y2qUKGqEyRljFJc8aIyvl2t52ya99spUMxKDkKiH7ivLGc1t2cvSXbq/20Q2ES5xf3ux8j9pnK2NlfjE=
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr11181691ejc.161.1658781292737; Mon, 25
 Jul 2022 13:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220721080423.156151-1-nuno.sa@analog.com> <20220721080423.156151-2-nuno.sa@analog.com>
In-Reply-To: <20220721080423.156151-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 22:34:16 +0200
Message-ID: <CAHp75Vfeq+7Ngj_wiXUXTGhyL=isqHy3DuPeJyE0C5YjYjZN=Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] input: keyboard: adp5588-keys: support gpi key
 events as 'gpio keys'
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Jul 21, 2022 at 10:03 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> This change replaces the support for GPIs as key event generators.
> Instead of reporting the events directly, we add a gpio based irqchip
> so that these events can be consumed by keys defined in the gpio-keys
> driver (as it's goal is indeed for keys on GPIOs capable of generating
> interrupts). With this, the gpio-adp5588 driver can also be dropped.
>
> The basic idea is that all the pins that are not being used as part of
> the keymap matrix can be possibly requested as GPIOs by gpio-keys
> (it's also fine to use these pins as plain interrupts though that's not
> really the point).
>
> Since the gpiochip now also has irqchip capabilities, we should only
> remove it after we free the device interrupt (otherwise we could, in
> theory, be handling GPIs interrupts while the gpiochip is concurrently
> removed). Thus the call 'adp5588_gpio_add()' is moved and since the
> setup phase also needs to come before making the gpios visible, we also
> need to move 'adp5588_setup()'.
>
> While at it, always select GPIOLIB so that we don't need to use #ifdef
> guards.

...

> +static void adp5588_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct adp5588_kpad *kpad =3D gpiochip_get_data(gc);

Can it be

  irq_hw_number_t hwirq =3D irqd_to_hwirq(d);

?

> +       unsigned long real_irq =3D kpad->gpiomap[irqd_to_hwirq(d)];
> +
> +       kpad->irq_mask[ADP5588_BANK(real_irq)] &=3D ~ADP5588_BIT(real_irq=
);
> +       gpiochip_disable_irq(gc, irqd_to_hwirq(d));
> +}
> +
> +static void adp5588_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct adp5588_kpad *kpad =3D gpiochip_get_data(gc);
> +       unsigned long real_irq =3D kpad->gpiomap[irqd_to_hwirq(d)];
> +
> +       gpiochip_enable_irq(gc, irqd_to_hwirq(d));
> +       kpad->irq_mask[ADP5588_BANK(real_irq)] |=3D ADP5588_BIT(real_irq)=
;

Ditto.

> +}

...

> +                       /* gpio line used as IRQ source */

GPIO

--=20
With Best Regards,
Andy Shevchenko
