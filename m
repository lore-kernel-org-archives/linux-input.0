From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: Colibri VF50 - Add missing #include
 <linux/of.h>
Date: Wed, 10 Feb 2016 11:38:16 -0800
Message-ID: <20160210193816.GA17738@dtor-glaptop>
References: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
 <20160209183324.GE40460@dtor-ws>
 <CAMuHMdU3oWoCTgy14mhuFAE33Bne0a18xErLRjYv_pugq4_V5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3oWoCTgy14mhuFAE33Bne0a18xErLRjYv_pugq4_V5Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bastien Nocera <hadess@hadess.net>, Sanchayan Maity <maitysanchayan@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 10, 2016 at 10:52:39AM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 9, 2016 at 7:33 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sun, Feb 07, 2016 at 03:18:06PM +0100, Geert Uytterhoeven wrote:
> >> drivers/input/touchscreen/colibri-vf50-ts.c: In function =E2=80=98=
vf50_ts_probe=E2=80=99:
> >> drivers/input/touchscreen/colibri-vf50-ts.c:302: error: implicit d=
eclaration of function =E2=80=98of_property_read_u32=E2=80=99
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Applied, thank you.
>=20
> Apparently you only applied patch 2/2, causing the abovementioned
> breakage in -next?

Hmm, I applied both, the Kconfig change went to next and include went i=
nto
for-linus and they both should have ended up in linux-next...

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
