From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Bug in i2c-core?
Date: Sat, 28 Feb 2015 11:00:29 +0100
Message-ID: <20150228110029.0fab0874@free-electrons.com>
References: <54F0507F.6030804@armadeus.com>
	<20150227153725.7404dea1@free-electrons.com>
	<6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
	<20150227170545.GS7789@pengutronix.de>
	<20150227174611.GC6679@dtor-ws>
	<20150227183949.GT7789@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54794 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750761AbbB1KAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2015 05:00:34 -0500
In-Reply-To: <20150227183949.GT7789@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?U8OpYmFzdGll?= =?UTF-8?B?bg==?= SZYMANSKI <sebastien.szymanski@armadeus.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, laurent.pinchart+renesas@ideasonboard.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

Dmitry, Uwe,

On Fri, 27 Feb 2015 19:39:49 +0100, Uwe Kleine-K=C3=B6nig wrote:

> > Input is allocated with devm_* and input_register_device knows how =
to
> > deal with that:
> ah, something new each day. Thanks for teaching me.

Thanks as well, I also discovered that thanks to this discussion.

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
