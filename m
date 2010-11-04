From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/3] Input: wacom - allow both MT and pen data to be reported
Date: Thu, 4 Nov 2010 08:08:29 -0500
Message-ID: <AANLkTinpTk917Ne=Ssz6_zXxWsXg3aJi-Bp=QTf7JHDh@mail.gmail.com>
References: <1288741079-4993-1-git-send-email-pingc@wacom.com>
	<AANLkTim+QrSFNifQGJOsdg+Q_fkVbp0FZ_MkgMjCdTdq@mail.gmail.com>
	<20101104054609.GA15793@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47302 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab0KDNIb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Nov 2010 09:08:31 -0400
Received: by gxk23 with SMTP id 23so1368496gxk.19
        for <linux-input@vger.kernel.org>; Thu, 04 Nov 2010 06:08:30 -0700 (PDT)
In-Reply-To: <20101104054609.GA15793@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Thu, Nov 4, 2010 at 12:46 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Wed, Nov 03, 2010 at 09:10:28AM -0500, Chris Bagwell wrote:
>> On Tue, Nov 2, 2010 at 6:37 PM, Ping Cheng <pinglinux@gmail.com> wro=
te:
>> > It was suggested by app and X server developers that both MT and p=
en data
>> > should be reported to the userland if the data is valid. Bamboo se=
ries are
>> > among these devices that both data are valid from the hardware per=
spective.
>> >
>> > Signed-off-by: Ping Cheng <pingc@wacom.com>
>> > ---
>> > =A0drivers/input/tablet/wacom_wac.c | =A0 13 +++++++------
>> > =A01 files changed, 7 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tabl=
et/wacom_wac.c
>> > index b3252ef..b9534a1 100644
>> > --- a/drivers/input/tablet/wacom_wac.c
>> > +++ b/drivers/input/tablet/wacom_wac.c
>> > @@ -868,13 +868,14 @@ static int wacom_bpt_touch(struct wacom_wac =
*wacom)
>> > =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int p =3D data[9 * i + 2];
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_slot(input, i);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Touch events need to be disable=
d while stylus is
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in proximity because user's han=
d is resting on touchpad
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and sending unwanted events. =A0=
User expects tablet buttons
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to continue working though.
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We send touch events even a stylu=
s is in proximity. Apps or
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* userland clients have the oppor=
tunity to arbitrate these events
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* when pen is in proximity.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Wacom X server driver arbitrate=
s the events for all apps that
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* are based on X server.
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p && !wacom->shared->stylus_in_p=
roximity) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D get_unali=
gned_be16(&data[9 * i + 3]) & 0x7ff;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D get_unali=
gned_be16(&data[9 * i + 5]) & 0x7ff;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->quirk=
s & WACOM_QUIRK_BBTOUCH_LOWRES) {
>> > --
>> > 1.7.2.3
>>
>> I do not think we can remove this at this time; although I've heard
>> request before and why the original patch was separate.
>>
>> The issue is that tablet is isolated on one input device and touchpa=
d
>> on another. =A0This means, for example, that tablet can be handled b=
y
>> xf86-input-wacom and touchpad by xf86-input-synaptics. =A0There is n=
o
>> communication between the two apps so that xf86-input-synaptics woul=
d
>> know to disable itself while pen is in proximity. =A0Reverting the p=
atch
>> in this combo would cause unwanted cursor movements.
>
> note that we have a similar tool in place for keyboards and touchpads=
 with
> syndaemon. again, there is no communication between the drivers, it's=
 purely
> client-side, monitoring the keyboard and flipping the property to dis=
able
> the driver as required. not perfect, but it does the job.
>
> for the touchpad, you could monitor DeviceProximity events on the tab=
let and
> then do the same thing. of course, we should have some way of matchin=
g the
> input devices that belong to the same physical tablet. syndaemon has =
an easy
> job here, usually we only have one touchpad on a laptop.

Matching problem is really the only technical issue with removing it.
Can we propose a way of ID'ing two related devices?

If we can bound the problem by saying 2 related inputs will always be
controlled by a single kernel driver then its easy to create a unique
ID at plugin.

If we tack the ID on to the device name, then it would already make it
to xinput and similar items so even user can also see associations.
Ping has implemented a version of this in the past.

Are there any better ideas?

Chris

>
> Cheers,
> =A0Peter
>
>
>> When handled by a new xf86-input-wacom (or similar) then technically
>> there can be some communication to do masking but today that
>> communication does not exist across unrelated input devices.
>> Reverting the patch would also cause unwanted cursor movements in
>> today's xf86-input-wacom.
>>
>> One thing that would need to occur first is wacom driver would need =
to
>> publish some sort of ID so that user land can tell which two devices
>> are somehow related; also accounting for 2 wacom devices being plugg=
ed
>> in at same time. =A0Next, if implemented, I'd make it a sysfs option=
 to
>> control behavior so user has choice to also use apps like
>> xf86-input-multitouch which can't do masking.
>>
>> Chris
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
