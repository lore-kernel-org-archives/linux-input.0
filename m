From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/3] Input: wacom - allow both MT and pen data to be
 reported
Date: Fri, 5 Nov 2010 08:43:07 +1000
Message-ID: <20101104224307.GB15793@barra.bne.redhat.com>
References: <1288741079-4993-1-git-send-email-pingc@wacom.com>
 <AANLkTim+QrSFNifQGJOsdg+Q_fkVbp0FZ_MkgMjCdTdq@mail.gmail.com>
 <20101104054609.GA15793@barra.bne.redhat.com>
 <AANLkTinpTk917Ne=Ssz6_zXxWsXg3aJi-Bp=QTf7JHDh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:29232 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0KDWnQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Nov 2010 18:43:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinpTk917Ne=Ssz6_zXxWsXg3aJi-Bp=QTf7JHDh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Thu, Nov 04, 2010 at 08:08:29AM -0500, Chris Bagwell wrote:
> On Thu, Nov 4, 2010 at 12:46 AM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Wed, Nov 03, 2010 at 09:10:28AM -0500, Chris Bagwell wrote:
> >> On Tue, Nov 2, 2010 at 6:37 PM, Ping Cheng <pinglinux@gmail.com> w=
rote:
> >> > It was suggested by app and X server developers that both MT and=
 pen data
> >> > should be reported to the userland if the data is valid. Bamboo =
series are
> >> > among these devices that both data are valid from the hardware p=
erspective.
> >> >
> >> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> >> > ---
> >> > =A0drivers/input/tablet/wacom_wac.c | =A0 13 +++++++------
> >> > =A01 files changed, 7 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/ta=
blet/wacom_wac.c
> >> > index b3252ef..b9534a1 100644
> >> > --- a/drivers/input/tablet/wacom_wac.c
> >> > +++ b/drivers/input/tablet/wacom_wac.c
> >> > @@ -868,13 +868,14 @@ static int wacom_bpt_touch(struct wacom_wa=
c *wacom)
> >> > =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int p =3D data[9 * i + 2];
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_slot(input, i);
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Touch events need to be disab=
led while stylus is
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in proximity because user's h=
and is resting on touchpad
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and sending unwanted events. =
=A0User expects tablet buttons
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to continue working though.
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We send touch events even a sty=
lus is in proximity. Apps or
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* userland clients have the opp=
ortunity to arbitrate these events
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* when pen is in proximity.
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Wacom X server driver arbitra=
tes the events for all apps that
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* are based on X server.
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p && !wacom->shared->stylus_in=
_proximity) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D get_una=
ligned_be16(&data[9 * i + 3]) & 0x7ff;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D get_una=
ligned_be16(&data[9 * i + 5]) & 0x7ff;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->qui=
rks & WACOM_QUIRK_BBTOUCH_LOWRES) {
> >> > --
> >> > 1.7.2.3
> >>
> >> I do not think we can remove this at this time; although I've hear=
d
> >> request before and why the original patch was separate.
> >>
> >> The issue is that tablet is isolated on one input device and touch=
pad
> >> on another. =A0This means, for example, that tablet can be handled=
 by
> >> xf86-input-wacom and touchpad by xf86-input-synaptics. =A0There is=
 no
> >> communication between the two apps so that xf86-input-synaptics wo=
uld
> >> know to disable itself while pen is in proximity. =A0Reverting the=
 patch
> >> in this combo would cause unwanted cursor movements.
> >
> > note that we have a similar tool in place for keyboards and touchpa=
ds with
> > syndaemon. again, there is no communication between the drivers, it=
's purely
> > client-side, monitoring the keyboard and flipping the property to d=
isable
> > the driver as required. not perfect, but it does the job.
> >
> > for the touchpad, you could monitor DeviceProximity events on the t=
ablet and
> > then do the same thing. of course, we should have some way of match=
ing the
> > input devices that belong to the same physical tablet. syndaemon ha=
s an easy
> > job here, usually we only have one touchpad on a laptop.
>=20
> Matching problem is really the only technical issue with removing it.
> Can we propose a way of ID'ing two related devices?
>=20
> If we can bound the problem by saying 2 related inputs will always be
> controlled by a single kernel driver then its easy to create a unique
> ID at plugin.
>=20
> If we tack the ID on to the device name, then it would already make i=
t
> to xinput and similar items so even user can also see associations.
> Ping has implemented a version of this in the past.
>=20
> Are there any better ideas?

we already have a serial ID property or so in the X driver, it's easy e=
nough
to tack another ID on that's generated for the first device and handed =
down
to the hotplugged dependent ones.
I strongly suggest _not_ using IDs in names, they're just not reliable.

Can't comment on the ID coming out of the kernel, I don't know the kern=
el
well enough.

Cheers,
  Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
