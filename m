From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce_ts - fix playload length check
Date: Tue, 28 Jul 2015 09:30:54 -0700
Message-ID: <20150728163054.GA19610@dtor-ws>
References: <20150727210619.GA2825@dtor-ws>
 <CAMuHMdWAudXRafuey2whrZUaff4PZZBCt8823femWr7v44q+Ww@mail.gmail.com>
 <55B76760.10406@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34225 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbG1Qa7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 12:30:59 -0400
Content-Disposition: inline
In-Reply-To: <55B76760.10406@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Heiko Stuebner <heiko.stuebner@bq.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jul 28, 2015 at 01:28:32PM +0200, Dirk Behme wrote:
> On 28.07.2015 12:23, Geert Uytterhoeven wrote:
> >On Mon, Jul 27, 2015 at 11:06 PM, Dmitry Torokhov
> ><dmitry.torokhov@gmail.com> wrote:
> >>Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce - d=
on't
> >>overwrite the stack") attempted to add a check for payload size bei=
ng too
> >>large for the supplied buffer. Unfortunately with the currently sel=
ected
> >>buffer size the comparison is always false as buffer size is larger=
 than
> >>the value a single byte can hold, and that results in compiler warn=
ings.
> >>Additionally the check was incorrect as it was not accounting for t=
he
> >>already read 2 bytes of data stored in the buffer.
> >
> >The check was indeed incorrect.
> >
> >>Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
> >>Reported-by: kbuild test robot <fengguang.wu@intel.com>
> >>Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>---
> >>
> >>This seems to shut up my GCC, I wonder if it is going to work gfor
> >>everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
> >>comment and remove check.
> >>
> >>  drivers/input/touchscreen/zforce_ts.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/=
touchscreen/zforce_ts.c
> >>index 2554efd..542ff02 100644
> >>--- a/drivers/input/touchscreen/zforce_ts.c
> >>+++ b/drivers/input/touchscreen/zforce_ts.c
> >>@@ -441,7 +441,9 @@ static int zforce_read_packet(struct zforce_ts =
*ts, u8 *buf)
> >>                 goto unlock;
> >>         }
> >>
> >>-       if (buf[PAYLOAD_LENGTH] =3D=3D 0 || buf[PAYLOAD_LENGTH] > F=
RAME_MAXSIZE) {
> >>+       if (buf[PAYLOAD_LENGTH] =3D=3D 0 ||
> >>+           (FRAME_MAXSIZE - 2 < 255 &&
> >>+            buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE - 2)) {
> >
> >Doesn't help with gcc 4.1.2 :-(
> >
> >Before:
> >
> >drivers/input/touchscreen/zforce_ts.c: In function =E2=80=98zforce_r=
ead_packet=E2=80=99:
> >drivers/input/touchscreen/zforce_ts.c:432: warning: comparison is
> >always false due to limited range of data type
> >
> >After:
> >
> >drivers/input/touchscreen/zforce_ts.c: In function =E2=80=98zforce_r=
ead_packet=E2=80=99:
> >drivers/input/touchscreen/zforce_ts.c:434: warning: comparison is
> >always false due to limited range of data type
>=20
>=20
> If it's easier, then just revert 7d01cd261c76f95913c81.
>=20
> Sorry! It seems that at least 4 people have overlooked this issue :(

Yes, I guess that is an example where unified diff provides too little
of a context...

>=20
> Best regards
>=20
> Dirk
>=20
> Btw: Could anybody give me a hint how to get this warning? My GCC
> 4.8.1 with kernel default ARM Cortex A9 kernel options doesn't give
> me anything about this.

make KBUILD_CFLAGS=3D"-Wtype-limits" drivers/input/touchscreen/zforce_t=
s.o

may trigger it.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
