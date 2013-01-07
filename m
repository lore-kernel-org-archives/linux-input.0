From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Mon, 7 Jan 2013 15:44:01 +0000
Message-ID: <20130107154401.GW21994@gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130107150341.GT21994@gmail.com>
 <201301071613.33573.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56176 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab3AGPoI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 10:44:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so8492520bkw.5
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 07:44:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201301071613.33573.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

> > > +	pdata->irq_over_gpio =3D of_get_property(np, "irq-over-gpio", N=
ULL);
> >=20
> > This is a new DT binding and you haven't provided any documentation=
 for it.
> >=20
> > Also, there is no reason for the binding to exist.
> >=20
> > Lots of drivers use GPIO pins as IRQs.
>=20
> Right, this can be removed and only the 'irq-gpios' can be kept aroun=
d. What do=20
> you say?

I don't like it to be honest.

How many GPIOs does the STMPE driver need?

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
