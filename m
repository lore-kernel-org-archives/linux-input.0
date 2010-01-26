From: Stanislav Brabec <utx@penguin.cz>
Subject: Re: gpio_keys and how PXA27x sets gpio_set_wake() (was Re: sharp
 c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1)
Date: Tue, 26 Jan 2010 11:13:44 +0100
Message-ID: <1264500824.4480.79.camel@utx.utx.cz>
References: <20100106071026.GD1382@ucw.cz>
	 <f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	 <20100107065230.GA1303@ucw.cz>
	 <f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	 <1264275669.9100.11.camel@utx.utx.cz>
	 <1264286611.11766.49.camel@utx.utx.cz>
	 <f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.penguin.cz ([84.21.108.25]:52233 "EHLO ns.penguin.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab0AZKMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2010 05:12:25 -0500
In-Reply-To: <f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, thommycheck@gmail.com, dbaryshkov@gmail.com, dtor@mail.ru, arminlitzel@web.de, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Dirk@opfer-online.de, "Rafael J. Wysocki" <rjw@sisk.pl>, lenz@cs.wisc.edu, rpurdie@rpsys.net, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Cyril Hrubis <metan@ucw.cz>, zaurus-devel@lists.linuxtogo.org, omegamoon@gmail.com, Vojtech Pavlik <vojtech@suse.cz>

Eric Miao wrota:

> I prefer 2) - the ugly and hardcoded setup in spitz_pm.c should reall=
y
> be removed. That's why the gpio_set_wake() and keypad_set_wake()
> are introduced.

I am unsure, whether gpio_keys driver is interested in the way, how wak=
e
happens. I guess that is interested only in the fact, that wake
happened.

Handling platform specific edge/level wake setup would only complicate
the code. (In fact, even the PXA270 platform code does not exist yet -
arch/arm/mach-pxa/mfp-pxa2xx.c:__mfp_config_gpio() is not capable to
configure Power Manager Keyboard Wake-Up Enable Register (PKWR).)

I talked to Vojt=ECch Pavl=EDk and he told that 1 is correct: Follow
include/linux/interrupt.h. Setting edge/level wake mode should be done
in the platform file. The driver could use just irq_set_wake() and don'=
t
care about details. And irq_set_wake() should do something useful even
for PKWR capable GPIO.

> keypad_set_wake() is really specifically introduced for use by pxa27x=
_keypad
> and no generic GPIO stuffs. So it's really annoying a GPIO will use
> the PKWR as a wakeup GPIO, I'd recommend one still get this hard code=
d
> into the platform file, with combination of WAKEUP_ON_LEVEL_HIGH (whi=
ch
> is specifically designed for keypad GPIOs) and keypad_set_wake().

Well, keypad_set_wake() seems to be possibly broken for GPIO 38. Imagin=
e
a device, that has a small keypad, but GPIO 38 has a different purpose
that requires an edge triggered wakeup (PWER). I think that
keypad_set_wake() reprograms it to PKWR.

The problem affects gpio_keys: It is a driver implementing "one key per
gpio". It now handles On/Off and lid switches on Zaurus. Lid switches
are on "normal" GPIOs, On/Off switch is wired to PKWR capable GPIO.

> The spitz, however, is doing a good job on this though it's using a G=
PIO
> emulated matrix keypad, that there is a separate SPITZ_GPIO_KEY_INT,
> which triggers whenever there is any key press on this matrix (I don'=
t
> know how that's designed in HW, but it seems to do that job), and
> which can be setup as a GPIO wakeup.

SPITZ_GPIO_KEY_INT happens if AC adapter is connected or key is pressed=
=2E
Surprisingly, the key press logic is part of NAND flash controller CPLD=
=2E
SPITZ_GPIO_KEY_INT=3D=3D0 - it makes possible to wake Zaurus even from =
deep
sleep by any key press. It would be impossible only with PKWR.

I guess that this and implementation of keypad_set_wake() is a reason,
why most devices suspend and resume correctly even if the irq_set_wake(=
)
refuses to configure wake and the warning is only visible symptom.


_______________________________________________________________________=
_
Stanislav Brabec
http://www.penguin.cz/~utx

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
