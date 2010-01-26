From: Stanislav Brabec <utx-ZsETY1VsSgLrBKCeMvbIDA@public.gmane.org>
Subject: Re: gpio_keys and how PXA27x sets gpio_set_wake()
 (was Re: sharp c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1)
Date: Tue, 26 Jan 2010 11:44:28 +0100
Message-ID: <1264502668.4480.97.camel@utx.utx.cz>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	<1264275669.9100.11.camel@utx.utx.cz>
	<1264286611.11766.49.camel@utx.utx.cz>
	<f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
	<1264500824.4480.79.camel@utx.utx.cz>
	<f17812d71001260220v5d03b0e1u1e3bc229827c37c8@mail.gmail.com>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <f17812d71001260220v5d03b0e1u1e3bc229827c37c8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/zaurus-devel>
List-Post: <mailto:zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
Errors-To: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, thommycheck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, arminlitzel-S0/GAf8tV78@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cyril Hrubis <metan-+ZI9xUNit7I@public.gmane.org>, Dirk-ngtJ1GK09nrbFfAX06+HdQ@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Eric Miao wrote:
> 2010/1/26 Stanislav Brabec <utx-ZsETY1VsSgLrBKCeMvbIDA@public.gmane.org>:

> > Handling platform specific edge/level wake setup would only complicate
> > the code. (In fact, even the PXA270 platform code does not exist yet -
> > arch/arm/mach-pxa/mfp-pxa2xx.c:__mfp_config_gpio() is not capable to
> > configure Power Manager Keyboard Wake-Up Enable Register (PKWR).)
> That's why WAKEUP_ON_EDGE_* is introduced, no need for gpio-keys
> to know this.

But WAKEUP_ON_EDGE_* is impossible for GPIO 95,
enable_irq_wake()/gpio_set_wake() returns EINVAL and disable_irq_wake()
complains on "Unbalanced IRQ 191".

In case of Zaurus, gpio_keys.c have to live with wakeup on level (PKWR)
when using enable/disable_irq_wake().

> > The problem affects gpio_keys: It is a driver implementing "one key per
> > gpio". It now handles On/Off and lid switches on Zaurus. Lid switches
> > are on "normal" GPIOs, On/Off switch is wired to PKWR capable GPIO.
> Ain't On/Off switch one of the matrix key? And so SPITZ_GPIO_KEY_INT
> could be used to handle that?

No. On/Off is connected directly to GPIO 95. Other keys use strobe/sense
matrix keypad.

SPITZ_GPIO_KEY_INT is a bit unspecific. I think it means: Charger was
inserted or key was pressed or On/Off was pressed.



________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
