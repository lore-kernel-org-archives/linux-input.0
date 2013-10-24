From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/8] input: Remove OOM message after input_allocate_device
Date: Thu, 24 Oct 2013 21:15:57 +0200
Message-ID: <20131024191557.GD3512@pengutronix.de>
References: <cover.1382555436.git.joe@perches.com>
 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
 <20131024182611.GA3512@pengutronix.de>
 <1382640218.22433.71.camel@joe-AO722>
 <20131024184612.GC3512@pengutronix.de>
 <1382640528.22433.75.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382640528.22433.75.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Ferruh Yigit <fery@cypress.com>, Wan ZongShun <mcuos.com@gmail.com>, Andrey Moiseev <o2g.org.ru@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Josh Wu <josh.wu@atmel.com>, linux-samsung-soc@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 24, 2013 at 11:48:48AM -0700, Joe Perches wrote:
> On Thu, 2013-10-24 at 20:46 +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 24, 2013 at 11:43:38AM -0700, Joe Perches wrote:
> []
> > > Any k.alloc without __GFP_NOWARN does a generic OOM message
> > > and a dump_stack() so there could already be 2 messages anyway.
> > Then mention that in the commit log if you still want this patch?!
>=20
> How do you think this commit message should be changed:
>=20
> Emitting an OOM message isn't necessary after input_allocate_device
> as there's a generic OOM and a dump_stack already done.
after input_allocate_device and/or k.alloc ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
