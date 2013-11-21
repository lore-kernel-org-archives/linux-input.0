From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [PATCHv9][ 1/3] Input: tsc2007: Add device tree support.
Date: Thu, 21 Nov 2013 09:03:15 +0100
Message-ID: <20131121090315.298a4a14@e6520eb>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
	<20131121050544.GE18477@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:42086 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3KUIEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 03:04:35 -0500
In-Reply-To: <20131121050544.GE18477@ns203013.ovh.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Denis Carikli <denis@eukrea.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar Wa??mann <LW@KARO-electronics.de>

Hi Jean Christophe,

Le Thu, 21 Nov 2013 06:05:44 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a =E9crit :
> > +Optional properties:
> > +- gpios: the interrupt gpio the chip is connected to (trough the p=
enirq pin).
> nack use interrupt property this a non-sense that we do today to pass=
 irq via
> gpio property the should NEVER known it's a gpio just an irq

read previous email and you will see the GPIO is used to get the signal
level on the pin and not the IRQ.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
