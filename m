From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce_ts - fix playload length check
Date: Mon, 27 Jul 2015 14:44:42 -0700
Message-ID: <20150727214442.GB3613@dtor-ws>
References: <20150727210619.GA2825@dtor-ws>
 <9298777.SjHtUzmdFZ@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34631 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbG0Vor (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 17:44:47 -0400
Content-Disposition: inline
In-Reply-To: <9298777.SjHtUzmdFZ@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Cc: linux-input@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, linux-kernel@vger.kernel.org

On Mon, Jul 27, 2015 at 11:35:23PM +0200, Heiko St=FCbner wrote:
> Hi Dmitry,
>=20
> Am Montag, 27. Juli 2015, 14:06:19 schrieb Dmitry Torokhov:
> > Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce - d=
on't
> > overwrite the stack") attempted to add a check for payload size bei=
ng too
> > large for the supplied buffer. Unfortunately with the currently sel=
ected
> > buffer size the comparison is always false as buffer size is larger=
 than
> > the value a single byte can hold, and that results in compiler warn=
ings.
> > Additionally the check was incorrect as it was not accounting for t=
he
> > already read 2 bytes of data stored in the buffer.
> >=20
> > Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >=20
> > This seems to shut up my GCC, I wonder if it is going to work gfor
> > everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
> > comment and remove check.
>=20
> needed a bit to get to know my old zforce driver again ;-)
>=20
>=20
> I may be blind, but currently I fail to see what problem the original=
 patch=20
> actually tries to fix.
>=20
> buf[PAYLOAD_LENGTH] is an u8, so the max value it can contain is 255.=
 The=20
> i2c_master_recv reads buf[PAYLOAD_LENGTH]-bytes into the buffer start=
ing at=20
> buf[PAYLOAD_BODY] (=3D buf[2]). So it reads at max 255 bytes into a 2=
57 byte big=20
> buffer starting at index 2.
>=20
> zforce_read_packet, also is an internal function used only by the int=
errupt=20
> handler, which always only calls it with a buffer of FRAME_MAXSIZE si=
ze.
>=20
>=20
> The original patch said "If we get a corrupted packet with PAYLOAD_LE=
NGTH >=20
> FRAME_MAXSIZE, we will silently overwrite the stack." but payload_len=
gth can=20
> never actually be greater than the buffer size?

Right, not unless we for some reason decide to adjust FRAME_MAXSIZE to
make it smaller than 257 and then fail to add the check to make sure we
do not go past the buffer.

So everything is fine now, but I guess we'd like to be more safe in the
future...

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
