From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Nexio touchscreen under X
Date: Sun, 14 Mar 2010 00:48:55 -0800
Message-ID: <20100314084854.GB8226@core.coreip.homeip.net>
References: <1268218600.2437.8.camel@nbiku1124.ikusi.net>
 <3ec861a71003100321q31e556dfy21e13506522233ab@mail.gmail.com>
 <1268220646.5240.7.camel@nbiku1124.ikusi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:40731 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab0CNIs7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Mar 2010 04:48:59 -0400
Received: by iwn6 with SMTP id 6so1060112iwn.4
        for <linux-input@vger.kernel.org>; Sun, 14 Mar 2010 00:48:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1268220646.5240.7.camel@nbiku1124.ikusi.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?I=F1igo_Mart=EDnez?= <martinez.i@ikusi.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>

Hi I=F1igo,
=20
On Wed, Mar 10, 2010 at 12:30:46PM +0100, I=F1igo Mart=EDnez wrote:
> Thank you for your answer Kristoffer.
>=20
> Umm, not totally, any sense. I mean, first, I think it has something
> todo with calibrating the device, as the pointer in the Y axis is onl=
y
> working between the edge and the middle of the screen, but I have
> noticed too, that only one axis is working.
>=20
> By default the Y axis, and if wrote an option for the input driver, t=
he
> X axis. I have been doing some tests, and I can't get both axis to ge=
t
> working.
>=20
> Can this throw any bright of light ?
>=20

Your best bet would be to wotk with Ondrej Zary
<linux@rainbow-software.org> (CCed) since he was working with iNexio
last and it is his patches that were accepted.

Thanks.

> On Wed, 2010-03-10 at 12:21 +0100, Kristoffer Ericson wrote:
> > how do you mean that the touches dont have any sense? Are the value=
s
> > completely wrong or?
> >=20
> > 2010/3/10 I=F1igo Mart=EDnez <martinez.i@ikusi.com>
> >         Hello:
> >        =20
> >         Lately, I have been trying to get a Nexio USB touchscreen
> >         working. It
> >         has been recently supported on the kernel, so I get in touc=
h
> >         with Andrew
> >         Morton, and he pointed me to this list and the author Richa=
rd
> >         Lemon.
> >        =20
> >         At the moment, I can see the output after touching it, and =
it
> >         does
> >         respond, but the touches don't have any sense at all.
> >        =20
> >         I want to know if anyone has tried this device under the X
> >         server with
> >         any success.
> >        =20
> >         Please, tell me if I'm out of the scope of this list, as I'=
m
> >         not sure.
> >        =20
> >         Thank you,
> >        =20
> >        =20
> >         --
> >         To unsubscribe from this list: send the line "unsubscribe
> >         linux-input" in
> >         the body of a message to majordomo@vger.kernel.org
> >         More majordomo info at
> >          http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
