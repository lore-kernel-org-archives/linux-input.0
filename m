From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 4/4] input: wacom - add 0xE5 (MT device) support
Date: Wed, 21 Dec 2011 22:14:52 -0600
Message-ID: <CAGzDe_ZDH2XHB0h-Zz0tP4ZMM9z4pCn1KadXY4Z7Z0xjRP9pfA@mail.gmail.com>
References: <1324082302-334-1-git-send-email-pinglinux@gmail.com>
	<CAGzDe_as-4WtU0eH69xMsck8q_uMmsE2A-A3iHB-1zqq2uyD3A@mail.gmail.com>
	<CAF8JNhJS-b0hktyXiJ-T+8HheRXwW8yD0FFsgmMK=CnvSiFJOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48510 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab1LVEOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Dec 2011 23:14:54 -0500
Received: by eaad14 with SMTP id d14so1674657eaa.19
        for <linux-input@vger.kernel.org>; Wed, 21 Dec 2011 20:14:52 -0800 (PST)
In-Reply-To: <CAF8JNhJS-b0hktyXiJ-T+8HheRXwW8yD0FFsgmMK=CnvSiFJOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 21, 2011 at 12:43 PM, Ping Cheng <pinglinux@gmail.com> wrot=
e:
> On Sun, Dec 18, 2011 at 6:07 PM, Chris Bagwell <chris@cnpbagwell.com>=
 wrote:
>>
>> On Fri, Dec 16, 2011 at 6:38 PM, Ping Cheng <pinglinux@gmail.com> wr=
ote:
>> > Signed-off-by: Ping Cheng <pingc@wacom.com>
>> > ---
>> > =A0drivers/input/tablet/wacom_sys.c | =A0 26 ++++++------
>> > =A0drivers/input/tablet/wacom_wac.c | =A0 82
>> > +++++++++++++++++++++++++++++++++++++-
>> > =A0drivers/input/tablet/wacom_wac.h | =A0 =A08 ++++
>> > =A03 files changed, 101 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/drivers/input/tablet/wacom_sys.c
>> > b/drivers/input/tablet/wacom_sys.c
>> > index b9736fb..eee06ef 100644
>> > --- a/drivers/input/tablet/wacom_sys.c
>> > +++ b/drivers/input/tablet/wacom_sys.c
>> > @@ -297,6 +297,10 @@ static int wacom_parse_hid(struct usb_interfa=
ce
>> > *intf,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen
>> > =3D WACOM_PKGLEN_TPC2FG;
>> >
>> > =A0features->touch_max =3D 2;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
>> > MTSCREEN)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>> > =3D WACOM_PKGLEN_MTOUCH;
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D
>> > BAMBOO_PT) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset
>> > back */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen
>> > =3D WACOM_PKGLEN_BBTOUCH;
>> > @@ -331,18 +335,15 @@ static int wacom_parse_hid(struct usb_interf=
ace
>> > *intf,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_USAGE_Y:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
(usage =3D=3D WCM_DESKTOP) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0if (finger) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D
>> > BTN_TOOL_FINGER;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
>> > TABLETPC2FG) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset
>> > back */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>> > =3D WACOM_PKGLEN_TPC2FG;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 int type =3D
>> > features->type;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG
>> > || type =3D=3D MTSCREEN) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>> >
>> > =A0get_unaligned_le16(&report[i + 3]);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
>> >
>> > =A0get_unaligned_le16(&report[i + 6]);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 7;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if
>> > (features->type =3D=3D BAMBOO_PT) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset
>> > back */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>> > =3D WACOM_PKGLEN_BBTOUCH;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (type =3D=3D
>> > BAMBOO_PT) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
>> >
>> > =A0get_unaligned_le16(&report[i + 3]);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>> > @@ -356,10 +357,6 @@ static int wacom_parse_hid(struct usb_interfa=
ce
>> > *intf,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0} else if (pen) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 /* penabled only accepts
>> > exact bytes of data */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
>> > TABLETPC2FG)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>> > =3D WACOM_PKGLEN_GRAPHIRE;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D
>> > BTN_TOOL_PEN;
>>
>> All makes sense. =A0Getting rid of duplicate code since X/Y will alw=
ays
>> be present. =A0Maybe worth a 1 line comment now that its cleaned up =
so
>> someone doesn't let it creep back in.
>
>
> I'll add some comments in v2.
>
>>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>> >
>> > =A0get_unaligned_le16(&report[i + 3]);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
>> > @@ -432,7 +429,8 @@ static int wacom_query_tablet_data(struct
>> > usb_interface *intf, struct wacom_feat
>> >
>> > =A0 =A0 =A0 =A0/* ask to report tablet data if it is MT Tablet PC =
or
>> > =A0 =A0 =A0 =A0 * not a Tablet PC */
>> > - =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
>> > + =A0 =A0 =A0 if (((features->type =3D=3D TABLETPC2FG) || (feature=
s->type =3D=3D
>> > MTSCREEN))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && features->device_=
type !=3D BTN_TOOL_PEN) {
>>
>> Glad to see this device_type check. =A0I thought it was probably nee=
ded.
>>
>> I'll have to trust you on this one but its different than Bamboo's.
>> The set on Bamboo is on Pen and causes it to start sending pen
>> packets. =A0IIR, the touch packets are always sending. =A0So this is
>> opposite and enables something related to touch?
>
>
> There are two types' of devices: tabletPC or non-tabletPC. For all ta=
bletPC
> devices that support more than one finger/contact, a set call is need=
ed. For
> all non-tabletPC devices, a set call is needed. Bamboo is a non-table=
tPC
> device.
>
>>
>> Assuming you say yes, do you mind changing that to an affirmative
>> check for TOUCH so it reads:
>
>
> Well, it=A0does not depend on whether it is touch or=A0pen. It=A0depe=
nds on the
> type of the device=A0as explained above. Do you still want me to use =
your
> below logic?

Let me ask this way.  On Bamboo there are 2 interfaces, 1 pen and 1
touch.  I need to set feature report 2 to a specific value on the pen
interface to get useful packets.  If I set feature report 2 to
something on touch interface, I get an error response back from
device.  This aligns with HID descriptor because only the pen
interface declares that feature report #2.

I'm sure its similar for Tablet PC's.   Its also writing to feature
report #2 but unique data values. What ever the values are, it
probably also doesn't make sense to write to both pen interface and
touch interface on Tablet PC.

If the feature report is only on one of two interfaces I do suggest
changing the if() to something like below to make it more obvious ("if
(TOUCH)" is more obvious that your looking for specific interface then
"if (!PEN)").  If its on both and only 1 needs to be written to then
that would probably be a good comment as well.

>
>>
>>
>> =A0if (TOUCH)
>> =A0 =A0/* do TOUCH set's */
>> =A0if (PEN)
>> =A0 =A0/* do PEN set's */
>>
>>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0] =3D 3;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[1] =3D 4;
>> > @@ -479,9 +477,9 @@ static int wacom_retrieve_hid_descriptor(struc=
t
>> > usb_interface *intf,
>> > =A0 =A0 =A0 =A0features->pressure_fuzz =3D 0;
>> > =A0 =A0 =A0 =A0features->distance_fuzz =3D 0;
>> >
>> > - =A0 =A0 =A0 /* only Tablet PCs and Bamboo P&T need to retrieve t=
he info */
>> > + =A0 =A0 =A0 /* only devices that support touch need to retrieve =
the info */
>> > =A0 =A0 =A0 =A0if ((features->type !=3D TABLETPC) && (features->ty=
pe !=3D
>> > TABLETPC2FG) &&
>> > - =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT))
>> > + =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT) && (features=
->type !=3D
>> > MTSCREEN))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> >
>> > =A0 =A0 =A0 =A0if (usb_get_extra_descriptor(interface, HID_DEVICET=
_HID,
>> > &hid_desc)) {
>> > diff --git a/drivers/input/tablet/wacom_wac.c
>> > b/drivers/input/tablet/wacom_wac.c
>> > index 8dc185d..1a887a1 100644
>> > --- a/drivers/input/tablet/wacom_wac.c
>> > +++ b/drivers/input/tablet/wacom_wac.c
>> > @@ -729,6 +729,73 @@ static int wacom_intuos_irq(struct wacom_wac
>> > *wacom)
>> > =A0 =A0 =A0 =A0return 1;
>> > =A0}
>> >
>> > +static int wacom_mt_touch(struct wacom_wac *wacom)
>> > +{
>> > + =A0 =A0 =A0 struct wacom_features *features =3D &wacom->features=
;
>> > + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>> > + =A0 =A0 =A0 char *data =3D wacom->data;
>> > + =A0 =A0 =A0 struct input_mt_slot *mt;
>> > + =A0 =A0 =A0 int i, id =3D -1, j =3D 0, k =3D 4;
>> > + =A0 =A0 =A0 int x =3D 0, y =3D 0;
>> > + =A0 =A0 =A0 int current_num_contacts =3D data[2];
>> > + =A0 =A0 =A0 int contacts_to_send =3D 0;
>> > + =A0 =A0 =A0 bool touch =3D false;
>> > +
>> > + =A0 =A0 =A0 /* reset the counter by the first packet */
>> > + =A0 =A0 =A0 if (current_num_contacts) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts =3D current_n=
um_contacts;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D curr=
ent_num_contacts;
>> > + =A0 =A0 =A0 }
>>
>> It seems that the saved contact values are only processed in case we=
re
>> data[2] indicates no contact counts in packet. =A0I would think that
>> packets with no contacts could be ignored (return) unless there is
>> some data that must be implied. =A0Why is it not ignored?
>
>
> current_num_contacts is only reported, hence=A0updated,=A0by the firs=
t set of
> data. Later touch data will be processed as long as number of contact=
s does
> not exceed current_num_contacts.
>
>>
>>
>> > +
>> > + =A0 =A0 =A0 /* There are at most 5 contacts per packet */
>> > + =A0 =A0 =A0 contacts_to_send =3D min(5, (int)features->num_conta=
cts_left);
>>
>> Its not obvious to me if data[2] contains touches in packet or total
>> touches on screen.
>
>
> Total touches on the screen.

OK.  I understand now.  It would be nice to add that to above comment
(the fact that num_contacts_left is total on screen).

>
>>
>> > +
>> > + =A0 =A0 =A0 for (i =3D 0; i < contacts_to_send; i++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D le16_to_cpup((__le16 *)&data[=
k]);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* is there an existing slot for thi=
s contact? */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < features->touch_ma=
x; j++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt =3D &input->mt[j]=
;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (input_mt_get_val=
ue(mt, ABS_MT_TRACKING_ID)
>> > =3D=3D id )
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brea=
k;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no. then find an unused slot to f=
ill */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (j >=3D features->touch_max) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < fe=
atures->touch_max; j++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt =3D=
 &input->mt[j];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
input_mt_get_value(mt,
>> > ABS_MT_TRACKING_ID) =3D=3D -1 )
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> This may need a little more thought since hid-multitouch doesn't que=
ry
>> old value. =A0Is there a case were a touch is removed and new touch
>> added in same packet? =A0Probably that would never send the -1 to us=
er
>> land.
>
>
> Once a touch leaves the screen, a -1 will always be sent to indicate =
the
> touch is out. When a new touch is added, it may use any available pac=
ket.
> Hence the one used by the just removed touch can also be used. Do I g=
et your
> question properly?

I'm thinking of this sequence inside 1 packet (probably not easy to
produce in the wild):

 * 1st location in packet shows Finger with ID of 100 as not touching a=
ny more.
 * Loops threw and finds matching ID and sets to -1.
 * 2nd location in packet shows Finger with ID of 101 as touching.  Its=
 new.
 * Loops threw to find 1st slot with -1 and uses one we just cleared.
 * Sync window occurs.  User only sees Contact ID change from 100 and 1=
01.

>
>>
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch =3D data[k - 1] & 0x1;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, j);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (touch) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D le16_to_cpup((=
__le16 *)&data[k + 6]);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D le16_to_cpup((=
__le16 *)&data[k + 8]);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(inp=
ut, ABS_MT_POSITION_X, x);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(inp=
ut, ABS_MT_POSITION_Y, y);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D -1;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep the id from firmware since w=
e need
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it to process future events
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TRACK=
ING_ID, id);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 k +=3D WACOM_BYTES_PER_MT_PACKET;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
>> > +
>> > + =A0 =A0 =A0 features->num_contacts_left -=3D contacts_to_send;
>> > + =A0 =A0 =A0 if (features->num_contacts_left < 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D 0;
>>
>> Same comment as above. =A0Could use a comment on why storing this wo=
uld be
>> needed.
>
>
> If you understood the value of=A0current_num_contacts,=A0it would be =
easier to
> see the need for num_contacts_left. I'll add a comment for
> current_num_contacts.

I guess I still don't see why its needed or how its being used.

Now that I understand that current_num_contacts is total touches, I do
understand you need to know when a packet contains 5 full touches and
when it contains less than 5.  For example if 6 touches then 1st
packet could have 5 and next packet could have 1.  So you need to know
to stop looping after 1.  But I do not see how this num_contacts_left
helps that.  It looks like it would set contacts_to_send to 5 in both
packets.

Chris

>
> Thank you for the review.
>
> Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
