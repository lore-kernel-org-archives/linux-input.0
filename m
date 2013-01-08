From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Tue, 8 Jan 2013 09:41:34 +0000
Message-ID: <20130108094134.GA21994@gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130107150341.GT21994@gmail.com>
 <201301071613.33573.marex@denx.de>
 <CAKohpon_h2ehq5Cf-fVyne33y7iyXCD35FVV1yuhgoDDstEcFQ@mail.gmail.com>
 <50EB97E3.8050703@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:51530 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab3AHJlk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 04:41:40 -0500
Received: by mail-bk0-f50.google.com with SMTP id jf3so101592bkc.23
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 01:41:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50EB97E3.8050703@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vipul kumar samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Marek Vasut <marex@denx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

> >Both can be killed. gpios as interrupt lines can be requested as:
> >
> >  interrupt-parent =3D<&gpio-controller>;
> >  interrupts =3D<25 0x1>;
> >
> >and probably the stmpe driver doesn't have to bother at all if
> >interrupt was over gpio or not.

> Yes, both can be killed and similarly we did for spear1340 machine
> but some how we missed it on spear320-hmi.

Bingo!

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
