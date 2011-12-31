From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 4/4] input: wacom - add 0xE5 (MT device) support
Date: Fri, 30 Dec 2011 21:34:36 -0600
Message-ID: <CAGzDe_arLo0JhxiAFPvVHsfJyG2Z3f7Ggf+2CsiVB+U3TmV5pg@mail.gmail.com>
References: <1324082302-334-1-git-send-email-pinglinux@gmail.com>
	<CAGzDe_as-4WtU0eH69xMsck8q_uMmsE2A-A3iHB-1zqq2uyD3A@mail.gmail.com>
	<CAF8JNhJS-b0hktyXiJ-T+8HheRXwW8yD0FFsgmMK=CnvSiFJOA@mail.gmail.com>
	<CAGzDe_ZDH2XHB0h-Zz0tP4ZMM9z4pCn1KadXY4Z7Z0xjRP9pfA@mail.gmail.com>
	<CAF8JNhK+xvme0bkAVPdcWVPu9G7XG-OMg8h6=RyoJ3reDMDXfQ@mail.gmail.com>
	<CAGzDe_YXpSd-gPF7X0d6PkHxuXy9eudBab-23rpoHoOKS0duAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47609 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1LaDei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Dec 2011 22:34:38 -0500
Received: by eaad14 with SMTP id d14so6902968eaa.19
        for <linux-input@vger.kernel.org>; Fri, 30 Dec 2011 19:34:36 -0800 (PST)
In-Reply-To: <CAGzDe_YXpSd-gPF7X0d6PkHxuXy9eudBab-23rpoHoOKS0duAg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 28, 2011 at 1:48 PM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> On Tue, Dec 27, 2011 at 6:48 PM, Ping Cheng <pinglinux@gmail.com> wro=
te:
>> On Wed, Dec 21, 2011 at 8:14 PM, Chris Bagwell <chris@cnpbagwell.com=
> wrote:
>>>
>>> On Wed, Dec 21, 2011 at 12:43 PM, Ping Cheng <pinglinux@gmail.com> =
wrote:
>>> > On Sun, Dec 18, 2011 at 6:07 PM, Chris Bagwell <chris@cnpbagwell.=
com> wrote:
>>> >>
>>> >> On Fri, Dec 16, 2011 at 6:38 PM, Ping Cheng <pinglinux@gmail.com=
> wrote:
>>> >> > Signed-off-by: Ping Cheng <pingc@wacom.com>
>>> >> > ---
>>> >> > =A0drivers/input/tablet/wacom_sys.c | =A0 26 ++++++------
>>> >> > =A0drivers/input/tablet/wacom_wac.c | =A0 82
>>> >> > +++++++++++++++++++++++++++++++++++++-
>>> >> > =A0drivers/input/tablet/wacom_wac.h | =A0 =A08 ++++
>>> >> > =A03 files changed, 101 insertions(+), 15 deletions(-)
>>> >> >
>>> >> > diff --git a/drivers/input/tablet/wacom_sys.c
>>> >> > b/drivers/input/tablet/wacom_sys.c
>>> >> > index b9736fb..eee06ef 100644
>>> >> > --- a/drivers/input/tablet/wacom_sys.c
>>> >> > +++ b/drivers/input/tablet/wacom_sys.c
>>> >> > @@ -297,6 +297,10 @@ static int wacom_parse_hid(struct usb_int=
erface
>>> >> > *intf,
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen
>>> >> > =3D WACOM_PKGLEN_TPC2FG;
>>> >> >
>>> >> > =A0features->touch_max =3D 2;
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> >> > +
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
>>> >> > MTSCREEN)
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>>> >> > =3D WACOM_PKGLEN_MTOUCH;
>>> >> > +
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D
>>> >> > BAMBOO_PT) {
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset
>>> >> > back */
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen
>>> >> > =3D WACOM_PKGLEN_BBTOUCH;
>>> >> > @@ -331,18 +335,15 @@ static int wacom_parse_hid(struct usb_in=
terface
>>> >> > *intf,
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_USAGE_=
Y:
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
if (usage =3D=3D WCM_DESKTOP) {
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0if (finger) {
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D
>>> >> > BTN_TOOL_FINGER;
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
>>> >> > TABLETPC2FG) {
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset
>>> >> > back */
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>>> >> > =3D WACOM_PKGLEN_TPC2FG;
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int type =3D
>>> >> > features->type;
>>> >> > +
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG
>>> >> > || type =3D=3D MTSCREEN) {
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>>> >> >
>>> >> > =A0get_unaligned_le16(&report[i + 3]);
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
>>> >> >
>>> >> > =A0get_unaligned_le16(&report[i + 6]);
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 7;
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if
>>> >> > (features->type =3D=3D BAMBOO_PT) {
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset
>>> >> > back */
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>>> >> > =3D WACOM_PKGLEN_BBTOUCH;
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (type =3D=3D
>>> >> > BAMBOO_PT) {
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
>>> >> >
>>> >> > =A0get_unaligned_le16(&report[i + 3]);distracted me.
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>>> >> > @@ -356,10 +357,6 @@ static int wacom_parse_hid(struct usb_int=
erface
>>> >> > *intf,
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0} else if (pen) {
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* penabled only accepts
>>> >> > exact bytes of data */
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
>>> >> > TABLETPC2FG)
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
>>> >> > =3D WACOM_PKGLEN_GRAPHIRE;
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D
>>> >> > BTN_TOOL_PEN;
>>> >>
>>> >> All makes sense. =A0Getting rid of duplicate code since X/Y will=
 always
>>> >> be present. =A0Maybe worth a 1 line comment now that its cleaned=
 up so
>>> >> someone doesn't let it creep back in.
>>> >
>>> >
>>> > I'll add some comments in v2.
>>> >
>>> >>
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>>> >> >
>>> >> > =A0get_unaligned_le16(&report[i + 3]);
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
>>> >> > @@ -432,7 +429,8 @@ static int wacom_query_tablet_data(struct
>>> >> > usb_interface *intf, struct wacom_feat
>>> >> >
>>> >> > =A0 =A0 =A0 =A0/* ask to report tablet data if it is MT Tablet=
 PC or
>>> >> > =A0 =A0 =A0 =A0 * not a Tablet PC */
>>> >> > - =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
>>> >> > + =A0 =A0 =A0 if (((features->type =3D=3D TABLETPC2FG) || (fea=
tures->type =3D=3D
>>> >> > MTSCREEN))
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && features->dev=
ice_type !=3D BTN_TOOL_PEN) {
>>> >>
>>> >> Glad to see this device_type check. =A0I thought it was probably=
 needed.
>>> >>
>>> >> I'll have to trust you on this one but its different than Bamboo=
's.
>>> >> The set on Bamboo is on Pen and causes it to start sending pen
>>> >> packets. =A0IIR, the touch packets are always sending. =A0So thi=
s is
>>> >> opposite and enables something related to touch?
>>> >
>>> >
>>> > There are two types' of devices: tabletPC or non-tabletPC. For al=
l tabletPC
>>> > devices that support more than one finger/contact, a set call is =
needed. For
>>> > all non-tabletPC devices, a set call is needed. Bamboo is a non-t=
abletPC
>>> > device.
>>> >
>>> >>
>>> >> Assuming you say yes, do you mind changing that to an affirmativ=
e
>>> >> check for TOUCH so it reads:
>>> >
>>> >
>>> > Well, it=A0does not depend on whether it is touch or=A0pen. It=A0=
depends on the
>>> > type of the device=A0as explained above. Do you still want me to =
use your
>>> > below logic?
>>>
>>> Let me ask this way. =A0On Bamboo there are 2 interfaces, 1 pen and=
 1
>>> touch. =A0I need to set feature report 2 to a specific value on the=
 pen
>>> interface to get useful packets. =A0If I set feature report 2 to
>>> something on touch interface, I get an error response back from
>>> device. =A0This aligns with HID descriptor because only the pen
>>> interface declares that feature report #2.
>>>
>>> I'm sure its similar for Tablet PC's. =A0 Its also writing to featu=
re
>>> report #2 but unique data values. What ever the values are, it
>>> probably also doesn't make sense to write to both pen interface and
>>> touch interface on Tablet PC.
>>>
>>> If the feature report is only on one of two interfaces I do suggest
>>> changing the if() to something like below to make it more obvious (=
"if
>>> (TOUCH)" is more obvious that your looking for specific interface t=
hen
>>> "if (!PEN)"). =A0If its on both and only 1 needs to be written to t=
hen
>>> that would probably be a good comment as well.
>>
>> I see your point. I'll use TOUCH/PEN for the if-statement and add a =
comment.
>>
>
> Thanks.
>
>>> >>
>>> >> =A0if (TOUCH)
>>> >> =A0 =A0/* do TOUCH set's */
>>> >> =A0if (PEN)
>>> >> =A0 =A0/* do PEN set's */
>>> >>
>>> >>
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0] =3D=
 3;
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[1] =3D=
 4;
>>> >> > @@ -479,9 +477,9 @@ static int wacom_retrieve_hid_descriptor(s=
truct
>>> >> > usb_interface *intf,
>>> >> > =A0 =A0 =A0 =A0features->pressure_fuzz =3D 0;
>>> >> > =A0 =A0 =A0 =A0features->distance_fuzz =3D 0;
>>> >> >
>>> >> > - =A0 =A0 =A0 /* only Tablet PCs and Bamboo P&T need to retrie=
ve the info */
>>> >> > + =A0 =A0 =A0 /* only devices that support touch need to retri=
eve the info */
>>> >> > =A0 =A0 =A0 =A0if ((features->type !=3D TABLETPC) && (features=
->type !=3D
>>> >> > TABLETPC2FG) &&
>>> >> > - =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT))
>>> >> > + =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT) && (feat=
ures->type !=3D
>>> >> > MTSCREEN))
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> >> >
>>> >> > =A0 =A0 =A0 =A0if (usb_get_extra_descriptor(interface, HID_DEV=
ICET_HID,
>>> >> > &hid_desc)) {
>>> >> > diff --git a/drivers/input/tablet/wacom_wac.c
>>> >> > b/drivers/input/tablet/wacom_wac.c
>>> >> > index 8dc185d..1a887a1 100644
>>> >> > --- a/drivers/input/tablet/wacom_wac.c
>>> >> > +++ b/drivers/input/tablet/wacom_wac.c
>>> >> > @@ -729,6 +729,73 @@ static int wacom_intuos_irq(struct wacom_=
wac
>>> >> > *wacom)
>>> >> > =A0 =A0 =A0 =A0return 1;
>>> >> > =A0}
>>> >> >
>>> >> > +static int wacom_mt_touch(struct wacom_wac *wacom)
>>> >> > +{
>>> >> > + =A0 =A0 =A0 struct wacom_features *features =3D &wacom->feat=
ures;
>>> >> > + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>>> >> > + =A0 =A0 =A0 char *data =3D wacom->data;
>>> >> > + =A0 =A0 =A0 struct input_mt_slot *mt;
>>> >> > + =A0 =A0 =A0 int i, id =3D -1, j =3D 0, k =3D 4;
>>> >> > + =A0 =A0 =A0 int x =3D 0, y =3D 0;
>>> >> > + =A0 =A0 =A0 int current_num_contacts =3D data[2];
>>> >> > + =A0 =A0 =A0 int contacts_to_send =3D 0;
>>> >> > + =A0 =A0 =A0 bool touch =3D false;
>>> >> > +
>>> >> > + =A0 =A0 =A0 /* reset the counter by the first packet */
>>> >> > + =A0 =A0 =A0 if (current_num_contacts) {
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts =3D curre=
nt_num_contacts;
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D =
current_num_contacts;
>>> >> > + =A0 =A0 =A0 }
>>> >>
>>> >> It seems that the saved contact values are only processed in cas=
e were
>>> >> data[2] indicates no contact counts in packet. =A0I would think =
that
>>> >> packets with no contacts could be ignored (return) unless there =
is
>>> >> some data that must be implied. =A0Why is it not ignored?
>>> >
>>> >
>>> > current_num_contacts is only reported, hence=A0updated,=A0by the =
first set of
>>> > data. Later touch data will be processed as long as number of con=
tacts does
>>> > not exceed current_num_contacts.
>>> >
>>> >>
>>> >>
>>> >> > +
>>> >> > + =A0 =A0 =A0 /* There are at most 5 contacts per packet */
>>> >> > + =A0 =A0 =A0 contacts_to_send =3D min(5, (int)features->num_c=
ontacts_left);
>>> >>
>>> >> Its not obvious to me if data[2] contains touches in packet or t=
otal
>>> >> touches on screen.
>>> >
>>> >
>>> > Total touches on the screen.
>>>
>>> OK. =A0I understand now. =A0It would be nice to add that to above c=
omment
>>> (the fact that num_contacts_left is total on screen).
>>
>> num_contacts_left is normally not the total on the screen. It is the
>> number of contacts that need to be processed. num_contacts is the
>> total on the screen. contacts_to_send is the number of contacts we a=
re
>> going to send.
>
> OK. =A0With understanding that data[2] is # of touches in packet and =
not
> total touches on screen then my questions change slightly.
>
> I assume if user put 6 touches a screen and moves around you'd get 2
> packets with movement; 1 with data[2] =3D=3D 5 and 1 with data[2] =3D=
=3D 1.
> There is this code then:
>
> int current_num_contacts =3D data[2];
> if (current_num_contacts) {
> =A0 =A0features->num_contacts =3D current_num_contacts;
> =A0 =A0features->num_contacts_left =3D current_num_contacts;
> }
>
> So it seems to me that num_contacts can never reach 6 (total touches
> on screen). =A0Maybe that needs to be a +=3D or something?

I get it now.  In first touch packet received, data[2] will contain
the total touches to be reported.  There will (data[2] / 5) additional
packets following this packet and they will all have data[2] set to 0.

So I understand how your logic is meant to work with that firmware
behaviour.  If you could throw in something about data[2] =3D=3D 0 bein=
g a
continuation packet then I think it would help future readers.

So that wraps up all the concerns/questions/comments I had on the patch=
es.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
