From: Philippe =?iso-8859-1?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 0/6] mc13783 cleanup
Date: Thu, 25 Aug 2011 09:05:12 +0200
Message-ID: <201108250905.13168.philippe.retornaz@epfl.ch>
References: <20110824132740.GA28197@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:56850 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753064Ab1HYHFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 03:05:18 -0400
In-Reply-To: <20110824132740.GA28197@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, kernel@pengutronix.de, linux-input@vger.kernel.org

Le mercredi 24 ao=FBt 2011 15:27:40, Uwe Kleine-K=F6nig a =E9crit :
> Hello,
>=20
> this series removes the long obsolte mc13783 API after fixing all
> remaining users.

I posted a patch last month which was touching this MFD too.
We will need to synchronize both patch.=20

BTW, Sascha, could you give your ack/nack on my patch (mc13783: add pwr=
 button=20
support) ? it has been a month without any news from your side. Thanks =
!=20

Regards,

Philippe

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
