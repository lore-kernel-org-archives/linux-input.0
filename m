From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/3] Input: rotary-encoder - move configuration data
 to driver data
Date: Fri, 5 Feb 2016 10:05:45 +0100
Message-ID: <20160205090545.GM13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1454408678-6011-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09CAB.5020600@zonque.org>
 <20160203093527.GD13664@pengutronix.de>
 <20160204211842.GA40137@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57342 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751206AbcBEJGW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 04:06:22 -0500
Content-Disposition: inline
In-Reply-To: <20160204211842.GA40137@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-input@vger.kernel.org

Hello Dmitry,

On Thu, Feb 04, 2016 at 01:18:42PM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 03, 2016 at 10:35:27AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Tue, Feb 02, 2016 at 01:10:19PM +0100, Daniel Mack wrote:
> > > On 02/02/2016 11:24 AM, Uwe Kleine-K=F6nig wrote:
> > > > This is a preparation for the next patche. There is no change i=
n
> > > > behaviour intended.
> > >=20
> > > This one looks good to me, but it clashes with Dmitry's latest pa=
tch
> > > sets (which I haven't found the time to test yet, sorry!).
> >=20
> > There is nothing in next-20160203, so I assume Dmitry either fixes =
this
> > up when applying my patches or tells me when I should rebase.
>=20
> Please take a look at my rotary-encoder branch. I am waiting to merge=
 it
> into next until I can get some testers. If you have raumfild device t=
hat
> would be awesome.

I don't have a raumfeld device. I did a similar conversion and the only
relevant difference is that I used

	.dev_id =3D "rotary_encoder.0",

while you used

	.dev_id =3D "rotary-encoder",

in raumfeld_rotary_gpios_table.
I think a mixture of these is the right thing, i.e.

	.dev_id =3D "rotary-encoder.0",

Your series obsoletes my first two patches, so I will port my third
patch on top of your branch and retest there.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
