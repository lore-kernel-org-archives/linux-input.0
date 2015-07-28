From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: zforce_ts - fix playload length check
Date: Tue, 28 Jul 2015 12:23:27 +0200
Message-ID: <CAMuHMdWAudXRafuey2whrZUaff4PZZBCt8823femWr7v44q+Ww@mail.gmail.com>
References: <20150727210619.GA2825@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150727210619.GA2825@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Heiko Stuebner <heiko.stuebner@bq.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 27, 2015 at 11:06 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce - don=
't
> overwrite the stack") attempted to add a check for payload size being=
 too
> large for the supplied buffer. Unfortunately with the currently selec=
ted
> buffer size the comparison is always false as buffer size is larger t=
han
> the value a single byte can hold, and that results in compiler warnin=
gs.
> Additionally the check was incorrect as it was not accounting for the
> already read 2 bytes of data stored in the buffer.

The check was indeed incorrect.

> Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> This seems to shut up my GCC, I wonder if it is going to work gfor
> everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
> comment and remove check.
>
>  drivers/input/touchscreen/zforce_ts.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/to=
uchscreen/zforce_ts.c
> index 2554efd..542ff02 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -441,7 +441,9 @@ static int zforce_read_packet(struct zforce_ts *t=
s, u8 *buf)
>                 goto unlock;
>         }
>
> -       if (buf[PAYLOAD_LENGTH] =3D=3D 0 || buf[PAYLOAD_LENGTH] > FRA=
ME_MAXSIZE) {
> +       if (buf[PAYLOAD_LENGTH] =3D=3D 0 ||
> +           (FRAME_MAXSIZE - 2 < 255 &&
> +            buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE - 2)) {

Doesn't help with gcc 4.1.2 :-(

Before:

drivers/input/touchscreen/zforce_ts.c: In function =E2=80=98zforce_read=
_packet=E2=80=99:
drivers/input/touchscreen/zforce_ts.c:432: warning: comparison is
always false due to limited range of data type

After:

drivers/input/touchscreen/zforce_ts.c: In function =E2=80=98zforce_read=
_packet=E2=80=99:
drivers/input/touchscreen/zforce_ts.c:434: warning: comparison is
always false due to limited range of data type

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
