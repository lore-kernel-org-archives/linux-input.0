From: Stanislav Brabec <utx-ZsETY1VsSgLrBKCeMvbIDA@public.gmane.org>
Subject: Re: sharp c-3000 aka spitz: fix warn_on introduced
	in 2.6.32-rc1
Date: Sat, 23 Jan 2010 20:41:09 +0100
Message-ID: <1264275669.9100.11.camel@utx.utx.cz>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <f17812d71001062333y2e49fa21scf91718da9ae3091-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, thommycheck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, arminlitzel-S0/GAf8tV78@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dirk-ngtJ1GK09nrbFfAX06+HdQ@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Cyril Hrubis <metan-+ZI9xUNit7I@public.gmane.org>, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Eric Miao wrote:
> >
> > I don't get it; what is pxa27x_keypad used on? It looks like
> > matrix-keypad subset.

> pxa27x has its own specific keypad controller. And since we now
> use enable_irq_wake, and the keypad controller has only one
> such IRQ_KEYPAD, will have to setup the keypad GPIO wakeup
> as a whole.

Looking deeper into it, the problem seems to be elsewhere:
I just added debug message to start and end of set_irq_wake().

And here is what I got during suspend:

set_irq_wake() started IRQ: 191 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 191 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 108 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 108 to 1, desc->wake_depth: 1
set_irq_wake() started IRQ: 113 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 113 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 187 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 187 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 130 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 130 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 132 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 132 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 134 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 134 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 135 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 135 to 1, desc->wake_depth: 0
set_irq_wake() started IRQ: 31 to 1, desc->wake_depth: 0
set_irq_wake() done IRQ: 31 to 1, desc->wake_depth: 1

I think that if (desc->wake_depth =3D=3D 0) when set_irq_wake(foo, 1) is
done, then something went wrong. And it is not surprise, that it reports
Unbalanced IRQ on resume.

Note that other people (Cyril Hrubi=B9) with a bit different .config
report success with gpio keys driver turned on.

My config:
http://www.penguin.cz/~utx/zaurus/feed/images/spitz/config-2.6.33-rc4-spitz

OT: Serial console resume did not work properly even with
no_console_suspend and my patch:
[PATCH 4/8] serial-core: resume serial hardware with no_console_suspend


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
