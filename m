From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
Date: Thu, 24 Oct 2013 17:26:44 +0200
Message-ID: <20131024172644.45816152@e6520eb>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
	<20131024151736.GE9044@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:54311 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375Ab3JXP1N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 11:27:13 -0400
In-Reply-To: <20131024151736.GE9044@ulmo.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Denis Carikli <denis@eukrea.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar =?ISO-8859-1?B?V2HfbWFubg==?= <LW@KARO-electronics.de>

Hi Thierry,

Le Thu, 24 Oct 2013 17:17:37 +0200,
Thierry Reding <thierry.reding@gmail.com> a =E9crit :
> > +- ti,max-rt: maximum pressure.
> > +- ti,fuzzy: specifies the absolute input fuzz value.
> > +  If set, it will permit noise in the data up to +- the value give=
n to the fuzz
> > +  parameter, that is used to filter noise from the event stream.
>=20
> Any reason why these can't be specified per axis? From my experience
> with this chip it can make sense to use different values for the
> different axes. Well, perhaps X and Y axes can share one fuzz factor,
> but the Z axis is sometimes different.
>=20
> You also modify the driver to ignore the X and Z axes fuzz factor eve=
n
> for platform data where specifying all three separately was explicitl=
y
> allowed. Have you verified that this doesn't cause any regressions?
>=20
That was not intended, that's an error, we will fix that.

Thanks,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
