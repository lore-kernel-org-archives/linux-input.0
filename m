From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Question: Formula Force GP (Force) Feedback
Date: Wed, 6 Jan 2010 11:43:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001061141570.2277@pobox.suse.cz>
References: <1262554958.10612.19.camel@slim-one-desktop> <d6997e2e4e78b997b97d35bd63b2fe4a@www3-mail.volny.cz> <1262708415.13269.30.camel@slim-one-desktop> <fa35ef597eead3de0218fecf0b52bc51@www3-mail.volny.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60454 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755676Ab0AFKnL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Jan 2010 05:43:11 -0500
In-Reply-To: <fa35ef597eead3de0218fecf0b52bc51@www3-mail.volny.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wylda@volny.cz
Cc: christophe.borivant@wanadoo.fr, Peter <peter@slim-one.de>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org


[ adding some more CCs ]

I haven't been really succesfull extracting the nature of the problem f=
rom=20
the mail below. Could you please sum it up for the people who haven't s=
een=20
the thread from the beginning?

Thanks.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.

On Tue, 5 Jan 2010, wylda@volny.cz wrote:

> Hi Peter,
>=20
> i'm definitely interested, but i'm not a developer. So i try to resen=
d
> this mail to guys who helped last time in hope, they will be interest=
ed
> again and maybe they can provide you some info. I'm able to give just
> feedback based on patches and tests.
>=20
> Hi Jiri & Christophe,
> if you remember 15.6. ~ 23.6.2009 (subject: "Force feedback for Logit=
ech
> WingMan Formula Force GP") you help me with force feedback on my logi=
tech
> wheel and thus kernel support this wheel. Peter found some anomalies
> in behaviour/code and would like to consult that stuff.
>=20
> Sorry if this mail bothers you and you have other things to do...
>=20
> Regards,
> Pavel V.
>=20
> PS: I would like to stay in touch, so can you leave me on CC?
>=20
> ----- P=D9VODN=CD ZPR=C1VA -----
> Od: "Peter" <peter@slim-one.de>
> Komu: wylda@volny.cz
> P=F8edm=ECt: Re: Question: Formula Force GP (Force) Feedback
> Datum: 5.1.2010 - 17:20:15
>=20
> > Hi,
> >=20
> > you might be interested that im getting closer to finding
> > the source of
> > the problem.
> >=20
> > from drivers/hid/hid-lgff.c:=20
> > > static int hid_lgff_play(struct input_dev *dev, void
> > > *data, struct ff_effect *effect)
> > > > {
> > >         struct hid_device *hid          =3D input_get_drvdata(dev=
);
> > >         > >         >         struct list_head  *report_list  =3D=
 &hid->report_enum[HID_OUTPUT_REPORT].report_list;
> > >         >         > >         >         struct hid_report *report=
       =3D list_entry(report_list->next,
> > >         >         > >         struct hid_report, list);
> > >         >         int x, y;
> > >         unsigned int left, right;
> > >=20
> > > #define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff)
> > > x =3D 0xff
> > > >=20
> > >         switch (effect->type)
> > >         {
> > >                 case FF_CONSTANT:
> > >                         x =3D effect->u.ramp.start_level
> > >                         + 0x7f;  /* 0x7f is center
> > >                         */
> > >                         >                         y =3D effect->u=
=2Eramp.end_level
> > >                         >                         > >            =
             + 0x7f; /**/
> > >                        =20
> > i modified the last two lines and got (after some tests)
> > an idea how to interpret the 2
> > values and ho they correspond... funny thing is, that
> > the wheel
> > responds to both axes.
> >=20
> > 255   o   <   << <<< <<<<
> > 191   >   o   <   << <<<
> > 127  >>   >   o   <   <<
> > 63  >>>  >>  >   o   <
> > 0 >>>> >>>  >>  >   o
> > 0   63 127 191 255
> >=20
> > The problem (as far as i understand it now) seems to
> > be, that
> > effect->u.ramp.start_level should have a value between
> > -128 and 127,
> > but only goes from 0 to 127. How and why, i have no
> > idea so far, since
> > it doesnt seem to be an overflow, but im not so sure
> > right now. The
> > result however depends on the application and goes
> > from when the wheel
> > goes over center position, it jumps from soft left
> > to full left force
> > or just correct forcestrength, but only into the same
> > direction on both
> > sides.
> >=20
> > I dont know if youre the right person for this, since
> > the code in
> > hid-lgff.c doesnt seem to be written from you and your
> > commit doesnt
> > touch it. If you've got no idea, just drop me a note
> > :)
> >=20
> > Bye, Peter
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
