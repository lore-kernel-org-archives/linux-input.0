From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v5] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Sat, 30 Jan 2010 12:27:21 +0100
Message-ID: <1264850841.2587.0.camel@realization>
References: <1264799926.2975.3.camel@realization>
	 <20100129213727.GB21364@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:35180 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab0A3L1l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 06:27:41 -0500
Received: by ey-out-2122.google.com with SMTP id d26so668261eyd.19
        for <linux-input@vger.kernel.org>; Sat, 30 Jan 2010 03:27:40 -0800 (PST)
In-Reply-To: <20100129213727.GB21364@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-input <linux-input@vger.kernel.org>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>

On ven, 2010-01-29 at 22:37 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > [...]
> > +MODULE_LICENSE("GPL v2");
> There is no space expected in the string passed to MODULE_LICENSE.=20

in include/linux/module.h:

/*
 * The following license idents are currently accepted as indicating fr=
ee
 * software modules
 *
 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]
=2E..

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
