From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for
 device-tree platform data
Date: Thu, 23 Jun 2011 16:09:31 +0200
Message-ID: <20110623160931.10a59c48@archvile>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
	<1308823455-14446-2-git-send-email-david@protonic.nl>
	<BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
	<20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
	<BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:9519 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab1FWOJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 10:09:24 -0400
In-Reply-To: <BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, 23 Jun 2011 07:25:37 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> =
wrote:
> >> > + =C2=A0 =C2=A0 =C2=A0 - gpios: OF devcie-tree gpio specificatin=
=2E
> >> > + =C2=A0 =C2=A0 =C2=A0 - label: Descriptive name of the key.
> >> > + =C2=A0 =C2=A0 =C2=A0 - linux,code: Keycode to emit.
> >>
> >> The fact that this is the Linux internal keycode definitions still
> >> makes me nervous. =C2=A0Is there no existing standard for keycodes=
 emitted
> >> by keyboard devices?
> >
> > There is but no standard lookup table. For Intel MID we do a transl=
ation
> > between Linux key names in the firmware and keycodes but there isn'=
t a
> > generic helper for it.
>=20
> I suppose the Linux keycodes are exported out to userspace, and are
> therefore an ABI which will not change.  Okay.

Right.
If I am not mistaken, it started out being AT keyboard scancodes one da=
y, but
nowadays it is a huge (and very useful) list of all possible keyboard-l=
ike
input events that can exist in linux. We use one such handy niche-code:
CYCLE_WINDOWS. We couldn't use this code if we were forced to emulate s=
ome
existing keyboard which probably wouldn't have this nifty key. It just =
fits
perfectly the intended function of the key. I have openbox configured t=
o
handle it more or less like ALT+TAB.

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
