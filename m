From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Thu, 25 Oct 2012 09:20:10 +0100
Message-ID: <20121025082010.GA3348@gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com>
 <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
 <50788B53.6040309@gmail.com>
 <CACRpkda==SXUtS1AExnjaQfnCYssGbfH=LrgqWhBiq85Ln02og@mail.gmail.com>
 <50788E3D.2060404@gmail.com>
 <CACRpkdb+u2ho3KhRsuE_ykM8arCL7B=SmHNS7qarAwh2mGHsjg@mail.gmail.com>
 <20121025075830.GF971@gmail.com>
 <CACRpkdbr4VHJ+gNZjK43FmSU=p5FGdxqmOkkAz-VWqUCQ=R=5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51181 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab2JYIUP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 04:20:15 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so592873bkc.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 01:20:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdbr4VHJ+gNZjK43FmSU=p5FGdxqmOkkAz-VWqUCQ=R=5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>

On Thu, 25 Oct 2012, Linus Walleij wrote:

> On Thu, Oct 25, 2012 at 9:58 AM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > On Fri, 12 Oct 2012, Linus Walleij wrote:
> (...)
> >> Is biasing what you need to do?
> (...)
> >> All I really want is that platforms have a clear idea about
> >> how and where the pins will be handled, and that if GPIO
> >> and pinctrl handle the same lines, they need to interact.
> >>
> >> Yours,
> >> Linus Walleij
> >
> > Friendly poke.
>=20
> I don't know how to respond to that? I asked a question about
> what the intent of the patch was and the generic thinking
> behind this approach and it remains unanswered.
>=20
> I think I have seen other patches doing the proper thing
> for pinctrl-single by implementing the proper
> pinctrl_request_gpio()
> pinctrl_free_gpio()
> pinctrl_gpio_direction_input()
> pinctrl_gpio_direction_output()
> in that very GPIO driver.
>=20
> So I suspect that this patch should be dropped, unless you
> have some other compelling usecase to bring to the show?

Actually it is I who is confused. I thought you answered some of
the questions which was posed to me. The poke was a kind of does
anyone else have any comments.

I'm happy for the patch to be dropped. Does that mean it can
be eradicated from the internal tree too then, because that is
actually a suitable end result.

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
