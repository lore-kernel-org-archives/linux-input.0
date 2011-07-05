From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for
 device-tree platform data
Date: Tue, 5 Jul 2011 10:16:08 +0200
Message-ID: <20110705101608.7bf49e8c@archvile>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
	<1308823455-14446-2-git-send-email-david@protonic.nl>
	<BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
	<20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
	<BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
	<20110623180121.GA14950@core.coreip.homeip.net>
	<20110704082939.6da4aaeb@archvile>
	<94bc67c6-6a34-43f0-b88f-8a4278115730@email.android.com>
	<20110704085651.6408dcbc@archvile>
	<20110704172806.GE8144@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:28018 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab1GEIQL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 04:16:11 -0400
In-Reply-To: <20110704172806.GE8144@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Mon, 4 Jul 2011 10:28:06 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Jul 04, 2011 at 08:56:51AM +0200, David Jander wrote:
> > On Mon, 04 Jul 2011 10:52:55 +0400
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >=20
> > > David Jander <david.jander@protonic.nl> wrote:
> > >=20
> > > >On Thu, 23 Jun 2011 11:01:22 -0700
> > > >Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > >> On Thu, Jun 23, 2011 at 07:25:37AM -0600, Grant Likely wrote:
> > > >> > On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox
> > > ><alan@lxorguk.ukuu.org.uk> wrote:
> > > >> > >> > + =C2=A0 =C2=A0 =C2=A0 - gpios: OF devcie-tree gpio spe=
cificatin.
> > > >> > >> > + =C2=A0 =C2=A0 =C2=A0 - label: Descriptive name of the=
 key.
> > > >> > >> > + =C2=A0 =C2=A0 =C2=A0 - linux,code: Keycode to emit.
> > > >> > >>
> > > >> > >> The fact that this is the Linux internal keycode definiti=
ons
> > > >still
> > > >> > >> makes me nervous. =C2=A0Is there no existing standard for=
 keycodes
> > > >emitted
> > > >> > >> by keyboard devices?
> > > >> > >
> > > >> > > There is but no standard lookup table. For Intel MID we do=
 a
> > > >translation
> > > >> > > between Linux key names in the firmware and keycodes but t=
here
> > > >isn't a
> > > >> > > generic helper for it.
> > > >> >=20
> > > >> > I suppose the Linux keycodes are exported out to userspace, =
and are
> > > >> > therefore an ABI which will not change.  Okay.
> > > >>=20
> > > >> Right, keycodes form ABI that will not change.
> > > >>=20
> > > >> Another option would be to use codes from HID usage tables but=
 then
> > > >> they would have to be translated to Linux ones.
> > > >
> > > >Dmitry, will you accept this patch also?
> > > >Until now, part 2/2 is in your tree, thanks for that, but I'd li=
ke to
> > > >know if
> > > >this part (1/2) will also be accepted?
> > > >
> > >=20
> > > Yes, I will since there was no more discussion about hid codes an=
d I do
> > > believe that using linux definitions is fine.
> >=20
> > Ok, thanks.
> >=20
>=20
> Noticed that we leaked dynamically allocated button data in case when
> gpio_keys_probe() fails.

Eeek. Sorry. Thanks for pointing out.

> Also removed changelog from copyright notice
> (we have SCM for it) and got rid of a warning in case of !CONFIG_OF.

Ah, ok. I was just imitating others here, but this is a good point ;-)

> Could you please tell me if the patch below still work for you?

Yes, it seems to work fine.

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
