From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/3] Input: rotary-encoder - move configuration data
 to driver data
Date: Thu, 4 Feb 2016 13:18:42 -0800
Message-ID: <20160204211842.GA40137@dtor-ws>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1454408678-6011-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09CAB.5020600@zonque.org>
 <20160203093527.GD13664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35635 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbcBDVSq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Feb 2016 16:18:46 -0500
Content-Disposition: inline
In-Reply-To: <20160203093527.GD13664@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Mack <daniel@zonque.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-input@vger.kernel.org

On Wed, Feb 03, 2016 at 10:35:27AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Feb 02, 2016 at 01:10:19PM +0100, Daniel Mack wrote:
> > On 02/02/2016 11:24 AM, Uwe Kleine-K=F6nig wrote:
> > > This is a preparation for the next patche. There is no change in
> > > behaviour intended.
> >=20
> > This one looks good to me, but it clashes with Dmitry's latest patc=
h
> > sets (which I haven't found the time to test yet, sorry!).
>=20
> There is nothing in next-20160203, so I assume Dmitry either fixes th=
is
> up when applying my patches or tells me when I should rebase.

Please take a look at my rotary-encoder branch. I am waiting to merge i=
t
into next until I can get some testers. If you have raumfild device tha=
t
would be awesome.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
