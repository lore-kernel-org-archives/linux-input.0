From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/8] input: Remove OOM message after
 input_allocate_device
Date: Thu, 24 Oct 2013 11:48:48 -0700
Message-ID: <1382640528.22433.75.camel@joe-AO722>
References: <cover.1382555436.git.joe@perches.com>
	 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
	 <20131024182611.GA3512@pengutronix.de>
	 <1382640218.22433.71.camel@joe-AO722>
	 <20131024184612.GC3512@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131024184612.GC3512@pengutronix.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Ferruh Yigit <fery@cypress.com>, Wan ZongShun <mcuos.com@gmail.com>, Andrey Moiseev <o2g.org.ru@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Josh Wu <josh.wu@atmel.com>, linux-samsung-soc@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, 2013-10-24 at 20:46 +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Oct 24, 2013 at 11:43:38AM -0700, Joe Perches wrote:
[]
> > Any k.alloc without __GFP_NOWARN does a generic OOM message
> > and a dump_stack() so there could already be 2 messages anyway.
> Then mention that in the commit log if you still want this patch?!

How do you think this commit message should be changed:

Emitting an OOM message isn't necessary after input_allocate_device
as there's a generic OOM and a dump_stack already done.
