From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Thu, 25 Oct 2012 08:58:30 +0100
Message-ID: <20121025075830.GF971@gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com>
 <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
 <50788B53.6040309@gmail.com>
 <CACRpkda==SXUtS1AExnjaQfnCYssGbfH=LrgqWhBiq85Ln02og@mail.gmail.com>
 <50788E3D.2060404@gmail.com>
 <CACRpkdb+u2ho3KhRsuE_ykM8arCL7B=SmHNS7qarAwh2mGHsjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36298 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934422Ab2JYH6s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 03:58:48 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so583046bkc.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 00:58:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdb+u2ho3KhRsuE_ykM8arCL7B=SmHNS7qarAwh2mGHsjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>

On Fri, 12 Oct 2012, Linus Walleij wrote:

> On Fri, Oct 12, 2012 at 11:40 PM, Daniel Mack <zonque@gmail.com> wrot=
e:
>=20
> >> Because we wrote in Documentation/pinctrl.txt that if GPIO
> >> and pin control handle the same lines, they should be
> >> implemented in the gpio driver by calling out to pinctrl's
> >> extern int pinctrl_request_gpio(unsigned gpio);
> >> extern void pinctrl_free_gpio(unsigned gpio);
> >> extern int pinctrl_gpio_direction_input(unsigned gpio);
> >> extern int pinctrl_gpio_direction_output(unsigned gpio);
> >
> > Hmm. So how is a certain pin muxed to its GPIO function then?
>=20
> By calling exactly the above functions from the GPIO
> driver.
>=20
> > And how
> > can pullup/pulldown features be selected?
>=20
> So as stated in:
> "Drivers needing both pin control and GPIOs"
>=20
> This can be done in several ways, but this way is one option
> indeed, so that is a valid reason for having this pinctrl here.
>=20
> Is biasing what you need to do?
>=20
> > I admittedly might lack some background here, and if there's better
> > solution to what I want to do, I'd be happy to hear about it :)
>=20
> Sure, no problem we've even tried to document it :-)
>=20
> All I really want is that platforms have a clear idea about
> how and where the pins will be handled, and that if GPIO
> and pinctrl handle the same lines, they need to interact.
>=20
> Yours,
> Linus Walleij

=46riendly poke.

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
