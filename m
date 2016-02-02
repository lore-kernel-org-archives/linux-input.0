From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 4/7] HID: sony: make the check for BUZZ_CONTROLLER more
 readable
Date: Tue, 2 Feb 2016 16:19:13 +0100
Message-ID: <20160202161913.111f39918038b91287c234f2@ao2.it>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it>
	<1454001827-26732-5-git-send-email-ao2@ao2.it>
	<E1835BCB-CF3E-47D8-B782-A971D64685C5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:28004 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932505AbcBBPTV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 10:19:21 -0500
In-Reply-To: <E1835BCB-CF3E-47D8-B782-A971D64685C5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

On Mon, 1 Feb 2016 09:41:01 -0500
=46rank Praznik <frank.praznik@gmail.com> wrote:

>=20
> > On Jan 28, 2016, at 12:23, Antonio Ospite <ao2@ao2.it> wrote:
> >=20
> > Use a positive test for BUZZ_CONTROLLER which is the particular cas=
e,
> > and leave the 'else' branch for the general case.
> >=20
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> > drivers/hid/hid-sony.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index 8dcea69..3877101 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -1547,10 +1547,10 @@ static void buzz_set_leds(struct sony_sc *s=
c)
> >=20
> > static void sony_set_leds(struct sony_sc *sc)
> > {
> > -	if (!(sc->quirks & BUZZ_CONTROLLER))
> > -		schedule_work(&sc->state_worker);
> > -	else
> > +	if (sc->quirks & BUZZ_CONTROLLER)
> > 		buzz_set_leds(sc);
> > +	else
> > +		schedule_work(&sc->state_worker);
> > }
> >=20
> > static void sony_led_set_brightness(struct led_classdev *led,
> > --=20
> > 2.7.0
> >=20
>
> My nitpick here is that moving the common case to the =E2=80=98else=E2=
=80=99 branch
> can mean more branch mispredictions.  This isn=E2=80=99t a particular=
ly hot
> piece of code, but I still prefer common-case first.
>

Hi Frank,

I see your point. Let's drop 4/7 for now then.
Jiri, will you apply the other patches? They have Frank's ACK.

> Ultimately I=E2=80=99d really like to get rid of the special-case buz=
zer code
> and just use a state worker like all of the other devices, but I don=E2=
=80=99t
> have any buzzer controllers to test with and don=E2=80=99t know anyon=
e who
> does.

Agreed, a proper refactoring would be indeed better than my 4/7
proposal.

Looking at the history, support for the buzz controller was added by
Colin Leitner <colin.leitner@gmail.com>

Ciao ciao,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
