From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
Date: Sun, 10 Jul 2011 17:37:46 +0900
Message-ID: <20110710083744.GD23199@opensource.wolfsonmicro.com>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
 <20110710080450.GW29624@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51330 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755448Ab1GJIhz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2011 04:37:55 -0400
Content-Disposition: inline
In-Reply-To: <20110710080450.GW29624@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org

On Sun, Jul 10, 2011 at 10:04:50AM +0200, Uwe Kleine-K=F6nig wrote:

> 	- mfd/mc13xxx: implicitly enable leds and buttons (and
> 	  regulators?)

It's nicer to enable regulators unconditionally, even if they're not
controlled by software in the system reading their state can still be
useful.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
