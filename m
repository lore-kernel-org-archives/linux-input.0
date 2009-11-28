From: David Brownell <david-b@pacbell.net>
Subject: Re: gpio_get_value in atomic context (was: make gpio-keys use  IRQF_SHARED)
Date: Fri, 27 Nov 2009 17:08:01 -0800
Message-ID: <200911271708.01727.david-b@pacbell.net>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com> <87eip6jkzr.fsf_-_@tac.ki.iif.hu> <d6200be20910140440t2357cb4fx5f7aeba0d4b15943@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.gq1.yahoo.com ([67.195.14.109]:22477 "HELO
	smtp106.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752365AbZK1BOg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2009 20:14:36 -0500
In-Reply-To: <d6200be20910140440t2357cb4fx5f7aeba0d4b15943@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-input@vger.kernel.org

On Wednesday 14 October 2009, Arve Hj=F8nnev=E5g wrote:
> 2009/10/14 Ferenc Wagner <wferi@niif.hu>:
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> >
> >> On Mon, Oct 12, 2009 at 07:09:50PM +0200, Ferenc Wagner wrote:
> >>
> >>> =A0 =A0 The gpio_get_value function may sleep, so it should not b=
e
> >>> =A0 =A0 called in a timer function.
> >>>
> >>> So is drivers/staging/dream/gpio_input.c in error, too?
> >>
> >> I guess so. Initially gpio method did not sleep but that has
> >> changed.
> >
> > Let's make Arve aware of this then (even though it may not affect
> > Android in practice).
>=20
> If gpio_get_value may sleep, then what is gpio_get_value_cansleep for=
?

To tell if this is one of the GPIOs for which it may sleep.

Whether the GPIO is atomic vs cansleep is an attribute of the
GPIO itself, not the routine it's called with.


> The gpio documentation claims gpio_get_value and gpio_set_value are
> safe to use from interrupt context, but a call to gpio_cansleep is
> probably needed in probe.

They're safe to use there ... if that GPIO is safe.  Yes, make sure
you know the answer before you call gpio_get_value() instead of
the always-safe gpio_get_value_cansleep().


> The matrix driver also need to change the direction of the gpio from
> the timer, so it would be useful to have a standard way to check if
> this is allowed as well.

If gpio_{set,get}_value() can sleep, so can gpio_direction_*().

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
