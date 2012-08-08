From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Wed, 8 Aug 2012 09:04:12 +0100
Message-ID: <20120808080411.GB4728@gmail.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53423 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865Ab2HHIEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 04:04:16 -0400
Received: by eaac11 with SMTP id c11so118259eaa.19
        for <linux-input@vger.kernel.org>; Wed, 08 Aug 2012 01:04:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120807170333.GV16861@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org

On Tue, Aug 07, 2012 at 06:03:34PM +0100, Mark Brown wrote:
> On Tue, Aug 07, 2012 at 06:01:30PM +0100, Lee Jones wrote:
>=20
> > Okay, so I've just spent a small amount of time looking at this. I =
think
> > the best place for this would be in *_get_virq(), using the same lo=
gic that
> > selected a *_legacy or *_linear domain in the first place. The only=
 thing=20
> > the domain can test for is the 'type' of domain and the requested I=
RQ. This
> > is where the issue lies. If a hwirq to virq conversion is requested=
, but a
> > virq is passed (which happens in the non-DT case) a WARN() is trigg=
ered
> > because the irq passed is bigger than first_irq + size. I think *_g=
et_virq()
> > should ensure that only a hwirq is passed to irq_create_mapping().
>=20
> > Let me know if you had other ideas.
>=20
> I'd expect your driver to always pass a hwirq into _get_virq() here.

Okay, actually this isn't so easy. Currently we have:

During DT boot:
 - No platform data is passed, hence no IRQ base for AB8500 is either
 - No IRQ base means we register a Linear IRQ Domain
 - MFD sees there is no base and leaves the IRQ resource as a hwirq
 - AB8500 child devices use *_get_virq() to convert the hwirq to a virq

During non-DT boot:
 - Platform data is passed, which contains an IRQ base
 - If an IRQ base is requested we use it to register a Legacy IRQ Domai=
n
 - MFD adds the IRQ base to the hwirq and registers it as a virq
 - AB8500 child devices use *_get_virq() to convert virq to virq - *ERR=
OR*

I guess my suggestion falls-back to placing logic in *_get_virq() to on=
ly
call irq_create_mapping() when when !ab8500->irq_base.

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
