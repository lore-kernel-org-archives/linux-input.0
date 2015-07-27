From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Subject: Re: [PATCH] Input: zforce_ts - fix playload length check
Date: Mon, 27 Jul 2015 23:53:27 +0200
Message-ID: <1951392.TDEIdyDlDr@diego>
References: <20150727210619.GA2825@dtor-ws> <9298777.SjHtUzmdFZ@diego> <20150727214442.GB3613@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:50682 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbbG0Vxa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 17:53:30 -0400
In-Reply-To: <20150727214442.GB3613@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, linux-kernel@vger.kernel.org

Am Montag, 27. Juli 2015, 14:44:42 schrieb Dmitry Torokhov:
> On Mon, Jul 27, 2015 at 11:35:23PM +0200, Heiko St=FCbner wrote:
> > Hi Dmitry,
> >=20
> > Am Montag, 27. Juli 2015, 14:06:19 schrieb Dmitry Torokhov:
> > > Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce -=
 don't
> > > overwrite the stack") attempted to add a check for payload size b=
eing
> > > too
> > > large for the supplied buffer. Unfortunately with the currently s=
elected
> > > buffer size the comparison is always false as buffer size is larg=
er than
> > > the value a single byte can hold, and that results in compiler wa=
rnings.
> > > Additionally the check was incorrect as it was not accounting for=
 the
> > > already read 2 bytes of data stored in the buffer.
> > >=20
> > > Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
> > > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >=20
> > > This seems to shut up my GCC, I wonder if it is going to work gfo=
r
> > > everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
> > > comment and remove check.
> >=20
> > needed a bit to get to know my old zforce driver again ;-)
> >=20
> >=20
> > I may be blind, but currently I fail to see what problem the origin=
al
> > patch
> > actually tries to fix.
> >=20
> > buf[PAYLOAD_LENGTH] is an u8, so the max value it can contain is 25=
5. The
> > i2c_master_recv reads buf[PAYLOAD_LENGTH]-bytes into the buffer sta=
rting
> > at
> > buf[PAYLOAD_BODY] (=3D buf[2]). So it reads at max 255 bytes into a=
 257 byte
> > big buffer starting at index 2.
> >=20
> > zforce_read_packet, also is an internal function used only by the
> > interrupt
> > handler, which always only calls it with a buffer of FRAME_MAXSIZE =
size.
> >=20
> >=20
> > The original patch said "If we get a corrupted packet with PAYLOAD_=
LENGTH
> > >
> > FRAME_MAXSIZE, we will silently overwrite the stack." but payload_l=
ength
> > can never actually be greater than the buffer size?
>=20
> Right, not unless we for some reason decide to adjust FRAME_MAXSIZE t=
o
> make it smaller than 257 and then fail to add the check to make sure =
we
> do not go past the buffer.
>=20
> So everything is fine now, but I guess we'd like to be more safe in t=
he
> future...

I would argue that FRAME_MAXSIZE already indicates that it should not b=
e=20
changed. It's the maximum size a single frame can be. And this size is =
a=20
property of the hardware itself, because of the format, 257 bytes is al=
ways=20
the maximum you could get (2 bytes header + at max 255 bytes payload).

So this second check (while only taking up a minimal amount of time) ac=
tually=20
only checks against kernel-developer making errors in the future and no=
t=20
something the hardware can cause.


But your change itself looks correct, so if you prefer to keep that che=
ck you=20
can also add my
Reviewed-by: Heiko Stuebner <heiko.stuebner@bq.com>


Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
