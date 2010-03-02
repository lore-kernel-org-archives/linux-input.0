From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/6] input/mc13783-ts: Don't use deprecated mc13783 API
	calls
Date: Tue, 2 Mar 2010 09:54:12 +0100
Message-ID: <20100302085412.GC17629@pengutronix.de>
References: <1267440825-14694-1-git-send-email-u.kleine-koenig@pengutronix.de> <1267440825-14694-2-git-send-email-u.kleine-koenig@pengutronix.de> <20100302075513.GC17307@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100302075513.GC17307@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-input@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Luotao Fu <l.fu@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 01, 2010 at 11:55:13PM -0800, Dmitry Torokhov wrote:
> On Mon, Mar 01, 2010 at 11:53:41AM +0100, Uwe Kleine-K=F6nig wrote:
> > mc13783_ackirq is deprecated, use the drop in replacement mc13783_i=
rq_ack.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I assume it will go thourgh MFD tree?
I don't know.  I would have suggest to let it go via Andrew[1] as the
biggest changes in this series are rtc related and these usually go via
him.  But MFD would be OK for me, too.

Best regards
Uwe

[1] hmm, forgot to Cc: him.  This is done now.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
