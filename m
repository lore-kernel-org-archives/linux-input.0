From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH]input: Change timer function to workqueue for gpio_keys
 	driver
Date: Thu, 25 Jun 2009 21:06:42 +0800
Message-ID: <20090625210642.432e08a5@dxy.sh.intel.com>
References: <20090608152420.0e76c302@dxy.sh.intel.com>
	<5d5443650906121040n3f36c99eka01f5eb5274ee6ff@mail.gmail.com>
	<359ed6810906250329x70cf380cy278f23e3ebc6a829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22168 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbZFYNLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2009 09:11:41 -0400
In-Reply-To: <359ed6810906250329x70cf380cy278f23e3ebc6a829@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>

On Thu, 25 Jun 2009 18:29:25 +0800
Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:

> On Fri, Jun 12, 2009 at 8:40 PM, Trilok Soni<soni.trilok@gmail.com> w=
rote:
> >> =C2=A0static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_button_data *bdata =3D dev_=
id;
> >> @@ -62,10 +61,10 @@ static irqreturn_t gpio_keys_isr(int irq, void=
 *dev_id)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(irq !=3D gpio_to_irq(button->gpi=
o));
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (button->debounce_interval)
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&bdat=
a->timer,
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 jiffies + msecs_to_jiffies(button->debounce_interval));
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_delaye=
d_work(&bdata->work,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msecs_to_jiffies(button->debounce_interval));
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_keys_repor=
t_event(bdata);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&=
bdata->work.work);
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> >> =C2=A0}
>=20
> Correct me if I'm wrong, but as far as I can tell,
> schedule_delayed_work doesn't modify the timer if the work was alread=
y
> pending. The result is not the same as with the timer. This breaks th=
e
> debouncing.

No. The workqueue is per button, if the work is already pending, then l=
ast
key press is not handled yet. That keeps the debouncing. Why you want t=
he second
key press to break the first one? The second key press should be ignore=
d, that's
the meaning of debouncing right?

>=20
> It looks like a slightly modified version of this patch has already
> been committed [1], but it has the same problem.
>=20
> [1] 0b346838c5862bfe911432956a106d602535d030 Input: gpio-keys - chang=
e
> timer to workqueue

Yes, the patch is already in Linus tree.


Thanks,
Alek
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
