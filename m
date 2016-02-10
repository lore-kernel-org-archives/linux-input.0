From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] Input: Colibri VF50 - Add missing #include <linux/of.h>
Date: Wed, 10 Feb 2016 10:52:39 +0100
Message-ID: <CAMuHMdU3oWoCTgy14mhuFAE33Bne0a18xErLRjYv_pugq4_V5Q@mail.gmail.com>
References: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
	<20160209183324.GE40460@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160209183324.GE40460@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Sanchayan Maity <maitysanchayan@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 9, 2016 at 7:33 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Feb 07, 2016 at 03:18:06PM +0100, Geert Uytterhoeven wrote:
>> drivers/input/touchscreen/colibri-vf50-ts.c: In function =E2=80=98vf=
50_ts_probe=E2=80=99:
>> drivers/input/touchscreen/colibri-vf50-ts.c:302: error: implicit dec=
laration of function =E2=80=98of_property_read_u32=E2=80=99
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Applied, thank you.

Apparently you only applied patch 2/2, causing the abovementioned
breakage in -next?

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
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
