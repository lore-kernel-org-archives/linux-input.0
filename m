From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] input: gpio-keys: Add runtime support
Date: Thu, 11 Oct 2012 16:21:29 +0100
Message-ID: <20121011152129.GE15428@gmail.com>
References: <1349964927-18619-1-git-send-email-lee.jones@linaro.org>
 <1349964927-18619-2-git-send-email-lee.jones@linaro.org>
 <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64336 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab2JKPVe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 11:21:34 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1058967bkc.19
        for <linux-input@vger.kernel.org>; Thu, 11 Oct 2012 08:21:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Jonas Aaberg <jonas.aberg@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Philippe Langlais <philippe.langlais@linaro.org>

> > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> Some change logs would have helped.

Granted.

Hopefully Jonas will be happy to step forward and answer any of
your following questions.

> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> > Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
> > Reviewed-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/key=
board/gpio_keys.c
> > index 7947315..78de557 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/pm_runtime.h>
> >
> >  struct gpio_button_data {
> >         const struct gpio_keys_button *button;
> > @@ -526,6 +527,7 @@ static int gpio_keys_open(struct input_dev *inp=
ut)
> >  {
> >         struct gpio_keys_drvdata *ddata =3D input_get_drvdata(input=
);
> >
> > +       pm_runtime_get_sync(input->dev.parent);
> I am not an expert of the runtime.
>=20
> However would be grateful if you explain me what it actually do.
>=20
> Also I did not see any runtime suspend/ resume handlers populated.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
