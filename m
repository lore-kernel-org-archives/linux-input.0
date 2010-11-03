From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: wacom - allow both MT and pen data to be
 reported
Date: Wed, 3 Nov 2010 07:28:01 -0700
Message-ID: <20101103142800.GA3321@core.coreip.homeip.net>
References: <1288741079-4993-1-git-send-email-pingc@wacom.com>
 <AANLkTim+QrSFNifQGJOsdg+Q_fkVbp0FZ_MkgMjCdTdq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40608 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab0KCO2Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Nov 2010 10:28:25 -0400
Received: by yxk8 with SMTP id 8so482873yxk.19
        for <linux-input@vger.kernel.org>; Wed, 03 Nov 2010 07:28:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim+QrSFNifQGJOsdg+Q_fkVbp0FZ_MkgMjCdTdq@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Nov 03, 2010 at 09:10:28AM -0500, Chris Bagwell wrote:
> On Tue, Nov 2, 2010 at 6:37 PM, Ping Cheng <pinglinux@gmail.com> wrot=
e:
> > It was suggested by app and X server developers that both MT and pe=
n data
> > should be reported to the userland if the data is valid. Bamboo ser=
ies are
> > among these devices that both data are valid from the hardware pers=
pective.
> >
> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> > ---
> > =A0drivers/input/tablet/wacom_wac.c | =A0 13 +++++++------
> > =A01 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/table=
t/wacom_wac.c
> > index b3252ef..b9534a1 100644
> > --- a/drivers/input/tablet/wacom_wac.c
> > +++ b/drivers/input/tablet/wacom_wac.c
> > @@ -868,13 +868,14 @@ static int wacom_bpt_touch(struct wacom_wac *=
wacom)
> > =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int p =3D data[9 * i + 2];
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_slot(input, i);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Touch events need to be disabled=
 while stylus is
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in proximity because user's hand=
 is resting on touchpad
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and sending unwanted events. =A0=
User expects tablet buttons
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to continue working though.
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We send touch events even a stylus=
 is in proximity. Apps or
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* userland clients have the opport=
unity to arbitrate these events
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* when pen is in proximity.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Wacom X server driver arbitrates=
 the events for all apps that
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* are based on X server.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p && !wacom->shared->stylus_in_pr=
oximity) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D get_unalig=
ned_be16(&data[9 * i + 3]) & 0x7ff;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D get_unalig=
ned_be16(&data[9 * i + 5]) & 0x7ff;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->quirks=
 & WACOM_QUIRK_BBTOUCH_LOWRES) {
> > --
> > 1.7.2.3
>=20
> I do not think we can remove this at this time; although I've heard
> request before and why the original patch was separate.
>=20
> The issue is that tablet is isolated on one input device and touchpad
> on another.  This means, for example, that tablet can be handled by
> xf86-input-wacom and touchpad by xf86-input-synaptics.  There is no
> communication between the two apps so that xf86-input-synaptics would
> know to disable itself while pen is in proximity.

=46uture version of xf86-input-synaptics might be able to open the othe=
r
wacom interface and monitor events (just monitor, still letting
xf86-input-wacom to do the main job, and diable touch processing when
stylos is in proximity). Not sure if it the best way or if it is easier
to move everything in xf86-input-wacom.

>  Reverting the patch
> in this combo would cause unwanted cursor movements.
>=20
> When handled by a new xf86-input-wacom (or similar) then technically
> there can be some communication to do masking but today that
> communication does not exist across unrelated input devices.
> Reverting the patch would also cause unwanted cursor movements in
> today's xf86-input-wacom.
>=20
> One thing that would need to occur first is wacom driver would need t=
o
> publish some sort of ID so that user land can tell which two devices
> are somehow related; also accounting for 2 wacom devices being plugge=
d
> in at same time.

I guess it should be possible to examine 'phys' attribute and see that
both input devices are connected to the same USB parent, although I do
not like this too much.

>  Next, if implemented, I'd make it a sysfs option to
> control behavior so user has choice to also use apps like
> xf86-input-multitouch which can't do masking.

The problem with the options like this is that we assume that they are
the sole "owners" of the datastream. And time and time again there
scenarios where some other application with different requirements migh=
t
want to have different behavior than the "main" consumer.

I agree that we should not be breaking the xf86-input-synaptics until i=
t
is ready.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
