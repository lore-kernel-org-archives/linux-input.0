From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Wed, 8 Aug 2012 08:35:19 +0100
Message-ID: <20120808073518.GA4728@gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
 <20120806153750.GI10524@gmail.com>
 <20120806160226.GF29272@sirena.org.uk>
 <20120807170129.GA3759@gmail.com>
 <20120807170333.GV16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34564 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515Ab2HHHfY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 03:35:24 -0400
Received: by eaac11 with SMTP id c11so109210eaa.19
        for <linux-input@vger.kernel.org>; Wed, 08 Aug 2012 00:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120807170333.GV16861@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org

> Restating my comment elsewhere...  why do we even need to do this in
> _get_virq() - I'd *really* expect this to be handled by the irq domai=
n
> code.

> > Okay, so I've just spent a small amount of time looking at this. I =
think
> > the best place for this would be in *_get_virq(), using the same lo=
gic that
> > selected a *_legacy or *_linear domain in the first place.=20

> I'd expect your driver to always pass a hwirq into _get_virq() here.

I actually had this thought last night.

(I really must learn to switch off in the evenings.) ;)

That's even easier then. I'll make the changes and submit.

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
