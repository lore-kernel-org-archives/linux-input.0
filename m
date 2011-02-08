From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: drivers/input/touchscreen/ads7846.c:959: error: 'GPIOF_DIR_IN' undeclared
Date: Tue, 8 Feb 2011 21:03:27 +0100
Message-ID: <AANLkTim2706Negrvd-ektbNMLwucM9M0icphb_uFY_9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Dmitry Torokhov <dtor@mail.ru>
Cc: Linux-Next <linux-next@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

linux-next/m68k-allmodconfig/m68k:
http://kisskb.ellerman.id.au/kisskb/buildresult/3899710/

drivers/input/touchscreen/ads7846.c:959: error: 'GPIOF_DIR_IN'
undeclared (first use in this function)
drivers/input/touchscreen/ads7846.c:959: error: (Each undeclared
identifier is reported only once
drivers/input/touchscreen/ads7846.c:959: error: for each function it
appears in.)
make[4]: *** [drivers/input/touchscreen/ads7846.o] Error 1

As of commit e9b6e245c727767e6d64cb3dd47a0c6982aa5d23
("Input: ads7846 - use gpio_request_one to configure pendown_gpio"), th=
is
driver should depend on GENERIC_GPIO?
Else <linux/gpio.h> doesn't include <asm/gpio.h>, and we never see the
definition of GPIOF_DIR_IN.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
