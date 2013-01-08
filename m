From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Tue, 8 Jan 2013 11:11:04 +0000
Message-ID: <20130108111104.GF21994@gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130108094134.GA21994@gmail.com>
 <201301081044.14876.marex@denx.de>
 <201301081048.38149.marex@denx.de>
 <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:40070 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab3AHLLJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 06:11:09 -0500
Received: by mail-ee0-f50.google.com with SMTP id b45so148875eek.37
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 03:11:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Marek Vasut <marex@denx.de>, vipul kumar samar <vipulkumar.samar@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, 08 Jan 2013, Viresh Kumar wrote:

> On 8 January 2013 15:18, Marek Vasut <marex@denx.de> wrote:
> > Maybe I was too quick about understanding the issue at hand. So all=
ow me a
> > stupid question -- who's gonna configure the GPIO as input for it t=
o work as IRQ
> > GPIO?
>=20
> Hmm.. I tried a bit, but couldn't find any such call :(
> Probably an assumption is taken here. GPIO pins which are going to be=
 used as
> interrupt lines, wouldn't be getting set in output mode at all. So,
> once they are put
> in input mode in beginning, nobody would change it ever.
>=20
> Much of gpio controllers configure gpio pins in input mode in their p=
robe().
>=20
> Maybe, there is something else :)

Pinctrl?

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
