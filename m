From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Thu, 23 Jun 2011 11:01:22 -0700
Message-ID: <20110623180121.GA14950@core.coreip.homeip.net>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
 <1308823455-14446-2-git-send-email-david@protonic.nl>
 <BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
 <20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
 <BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52795 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933548Ab1FWSBi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 14:01:38 -0400
Received: by pwj7 with SMTP id 7so1363262pwj.19
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2011 11:01:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Thu, Jun 23, 2011 at 07:25:37AM -0600, Grant Likely wrote:
> On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> =
wrote:
> >> > + =A0 =A0 =A0 - gpios: OF devcie-tree gpio specificatin.
> >> > + =A0 =A0 =A0 - label: Descriptive name of the key.
> >> > + =A0 =A0 =A0 - linux,code: Keycode to emit.
> >>
> >> The fact that this is the Linux internal keycode definitions still
> >> makes me nervous. =A0Is there no existing standard for keycodes em=
itted
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

Right, keycodes form ABI that will not change.

Another option would be to use codes from HID usage tables but then
they would have to be translated to Linux ones.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
