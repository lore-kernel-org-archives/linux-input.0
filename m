From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Date: Mon, 15 Apr 2019 13:01:51 -0700
Message-ID: <CABXOdTce7EXE7xZhh=YUj23wxRzwYKGv=7TueJ3nfUuKhUgz4A@mail.gmail.com>
References: <20190415192734.935387-1-arnd@arndb.de> <20190415192734.935387-2-arnd@arndb.de>
 <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
 <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com> <3665a5ad-ff6d-97a1-ca31-971973a7167f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3665a5ad-ff6d-97a1-ca31-971973a7167f@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartley Sweeten <HartleyS@visionengravers.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stefan Agner <stefan@agner.ch>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 15, 2019 at 12:56 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> Hi!
>
> On 15/04/2019 21:47, Arnd Bergmann wrote:
> >>> We can communicate the clock rate using platform data rather than setting a
> >>> flag to use a particular value in the driver, which is cleaner and avoids the dependency.
> >>>
> >>> No platform in the kernel currently defines the ep93xx keypad device structure, so this
> >>> is a rather pointless excercise.  Any out of tree users are probably dead now, but if not,
> >>>  they have to change their platform code to match the new platform_data structure.
> >> <snip>
> >>
> >>> diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
> >>> index 0e36818e3680..3054fced8509 100644
> >>> --- a/include/linux/platform_data/keypad-ep93xx.h
> >>> +++ b/include/linux/platform_data/keypad-ep93xx.h
> >>> @@ -9,8 +9,7 @@ struct matrix_keymap_data;
> >>>  #define EP93XX_KEYPAD_DIAG_MODE              (1<<1)  /* diagnostic mode */
> >>>  #define EP93XX_KEYPAD_BACK_DRIVE     (1<<2)  /* back driving mode */
> >>>  #define EP93XX_KEYPAD_TEST_MODE              (1<<3)  /* scan only column 0 */
> >>> -#define EP93XX_KEYPAD_KDIV           (1<<4)  /* 1/4 clock or 1/16 clock */
> >>> -#define EP93XX_KEYPAD_AUTOREPEAT     (1<<5)  /* enable key autorepeat */
> >>> +#define EP93XX_KEYPAD_AUTOREPEAT     (1<<4)  /* enable key autorepeat */
> >> You have re-defined the keypad register bits here.
> >>
> >> The KDIV bit changes the clock rate. The AUTOREPEAT bit enables key autorepeat.
> > As far as I can tell, they are not register bits, just software flags
> > for communicating between a board file and the driver, so I
> > assumed I could freely reorganize them.
> >
> > Did I miss something?
>
> They are indeed only software flags (just checked datasheet), so you are only changing
> platform data format. But as I do not know any keypad user in person, I'd rely on
> Hartley's opinion in this case (if it's a good idea to change platform data or not).
>

If there are out-of-tree users, it would be their responsibility to
upstream their code. If they don't, any changes in platform data is
their problem, not ours. Either case, platform data does, if anything,
reflect an in-kernel API, and thus is fair game for cleanup.

Guenter
