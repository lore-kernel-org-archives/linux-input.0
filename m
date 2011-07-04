From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for
 device-tree platform data
Date: Mon, 4 Jul 2011 08:29:39 +0200
Message-ID: <20110704082939.6da4aaeb@archvile>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
	<1308823455-14446-2-git-send-email-david@protonic.nl>
	<BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
	<20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
	<BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
	<20110623180121.GA14950@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:20990 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab1GDG3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 02:29:22 -0400
In-Reply-To: <20110623180121.GA14950@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Thu, 23 Jun 2011 11:01:22 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Thu, Jun 23, 2011 at 07:25:37AM -0600, Grant Likely wrote:
> > On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox <alan@lxorguk.ukuu.org.uk=
> wrote:
> > >> > + =C2=A0 =C2=A0 =C2=A0 - gpios: OF devcie-tree gpio specificat=
in.
> > >> > + =C2=A0 =C2=A0 =C2=A0 - label: Descriptive name of the key.
> > >> > + =C2=A0 =C2=A0 =C2=A0 - linux,code: Keycode to emit.
> > >>
> > >> The fact that this is the Linux internal keycode definitions sti=
ll
> > >> makes me nervous. =C2=A0Is there no existing standard for keycod=
es emitted
> > >> by keyboard devices?
> > >
> > > There is but no standard lookup table. For Intel MID we do a tran=
slation
> > > between Linux key names in the firmware and keycodes but there is=
n't a
> > > generic helper for it.
> >=20
> > I suppose the Linux keycodes are exported out to userspace, and are
> > therefore an ABI which will not change.  Okay.
>=20
> Right, keycodes form ABI that will not change.
>=20
> Another option would be to use codes from HID usage tables but then
> they would have to be translated to Linux ones.

Dmitry, will you accept this patch also?
Until now, part 2/2 is in your tree, thanks for that, but I'd like to k=
now if
this part (1/2) will also be accepted?

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
