From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4] input: wacom - add 0xE5 (MT device) support
Date: Tue, 27 Dec 2011 16:48:44 -0800
Message-ID: <CAF8JNhK+xvme0bkAVPdcWVPu9G7XG-OMg8h6=RyoJ3reDMDXfQ@mail.gmail.com>
References: <1324082302-334-1-git-send-email-pinglinux@gmail.com>
	<CAGzDe_as-4WtU0eH69xMsck8q_uMmsE2A-A3iHB-1zqq2uyD3A@mail.gmail.com>
	<CAF8JNhJS-b0hktyXiJ-T+8HheRXwW8yD0FFsgmMK=CnvSiFJOA@mail.gmail.com>
	<CAGzDe_ZDH2XHB0h-Zz0tP4ZMM9z4pCn1KadXY4Z7Z0xjRP9pfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60396 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1L1Asp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Dec 2011 19:48:45 -0500
Received: by ghbg21 with SMTP id g21so1678653ghb.19
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2011 16:48:45 -0800 (PST)
In-Reply-To: <CAGzDe_ZDH2XHB0h-Zz0tP4ZMM9z4pCn1KadXY4Z7Z0xjRP9pfA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 21, 2011 at 8:14 PM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
>
> On Wed, Dec 21, 2011 at 12:43 PM, Ping Cheng <pinglinux@gmail.com> wr=
ote:
> > On Sun, Dec 18, 2011 at 6:07 PM, Chris Bagwell <chris@cnpbagwell.co=
m> wrote:
> >>
> >> On Fri, Dec 16, 2011 at 6:38 PM, Ping Cheng <pinglinux@gmail.com> =
wrote:
> >> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> >> > ---
> >> > =A0drivers/input/tablet/wacom_sys.c | =A0 26 ++++++------
> >> > =A0drivers/input/tablet/wacom_wac.c | =A0 82
> >> > +++++++++++++++++++++++++++++++++++++-
> >> > =A0drivers/input/tablet/wacom_wac.h | =A0 =A08 ++++
> >> > =A03 files changed, 101 insertions(+), 15 deletions(-)
> >> >
> >> > diff --git a/drivers/input/tablet/wacom_sys.c
> >> > b/drivers/input/tablet/wacom_sys.c
> >> > index b9736fb..eee06ef 100644
> >> > --- a/drivers/input/tablet/wacom_sys.c
> >> > +++ b/drivers/input/tablet/wacom_sys.c
> >> > @@ -297,6 +297,10 @@ static int wacom_parse_hid(struct usb_inter=
face
> >> > *intf,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen
> >> > =3D WACOM_PKGLEN_TPC2FG;
> >> >
> >> > =A0features->touch_max =3D 2;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
> >> > MTSCREEN)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
> >> > =3D WACOM_PKGLEN_MTOUCH;
> >> > +
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D
> >> > BAMBOO_PT) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset
> >> > back */
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen
> >> > =3D WACOM_PKGLEN_BBTOUCH;
> >> > @@ -331,18 +335,15 @@ static int wacom_parse_hid(struct usb_inte=
rface
> >> > *intf,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_USAGE_Y:
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i=
f (usage =3D=3D WCM_DESKTOP) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0if (finger) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D
> >> > BTN_TOOL_FINGER;
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
> >> > TABLETPC2FG) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset
> >> > back */
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
> >> > =3D WACOM_PKGLEN_TPC2FG;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int type =3D
> >> > features->type;
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG
> >> > || type =3D=3D MTSCREEN) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> >> >
> >> > =A0get_unaligned_le16(&report[i + 3]);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> >> >
> >> > =A0get_unaligned_le16(&report[i + 6]);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 7;
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if
> >> > (features->type =3D=3D BAMBOO_PT) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset
> >> > back */
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
> >> > =3D WACOM_PKGLEN_BBTOUCH;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (type =3D=3D
> >> > BAMBOO_PT) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> >> >
> >> > =A0get_unaligned_le16(&report[i + 3]);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> >> > @@ -356,10 +357,6 @@ static int wacom_parse_hid(struct usb_inter=
face
> >> > *intf,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0} else if (pen) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* penabled only accepts
> >> > exact bytes of data */
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D
> >> > TABLETPC2FG)
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen
> >> > =3D WACOM_PKGLEN_GRAPHIRE;
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D
> >> > BTN_TOOL_PEN;
> >>
> >> All makes sense. =A0Getting rid of duplicate code since X/Y will a=
lways
> >> be present. =A0Maybe worth a 1 line comment now that its cleaned u=
p so
> >> someone doesn't let it creep back in.
> >
> >
> > I'll add some comments in v2.
> >
> >>
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> >> >
> >> > =A0get_unaligned_le16(&report[i + 3]);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
> >> > @@ -432,7 +429,8 @@ static int wacom_query_tablet_data(struct
> >> > usb_interface *intf, struct wacom_feat
> >> >
> >> > =A0 =A0 =A0 =A0/* ask to report tablet data if it is MT Tablet P=
C or
> >> > =A0 =A0 =A0 =A0 * not a Tablet PC */
> >> > - =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
> >> > + =A0 =A0 =A0 if (((features->type =3D=3D TABLETPC2FG) || (featu=
res->type =3D=3D
> >> > MTSCREEN))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && features->devic=
e_type !=3D BTN_TOOL_PEN) {
> >>
> >> Glad to see this device_type check. =A0I thought it was probably n=
eeded.
> >>
> >> I'll have to trust you on this one but its different than Bamboo's=
=2E
> >> The set on Bamboo is on Pen and causes it to start sending pen
> >> packets. =A0IIR, the touch packets are always sending. =A0So this =
is
> >> opposite and enables something related to touch?
> >
> >
> > There are two types' of devices: tabletPC or non-tabletPC. For all =
tabletPC
> > devices that support more than one finger/contact, a set call is ne=
eded. For
> > all non-tabletPC devices, a set call is needed. Bamboo is a non-tab=
letPC
> > device.
> >
> >>
> >> Assuming you say yes, do you mind changing that to an affirmative
> >> check for TOUCH so it reads:
> >
> >
> > Well, it=A0does not depend on whether it is touch or=A0pen. It=A0de=
pends on the
> > type of the device=A0as explained above. Do you still want me to us=
e your
> > below logic?
>
> Let me ask this way. =A0On Bamboo there are 2 interfaces, 1 pen and 1
> touch. =A0I need to set feature report 2 to a specific value on the p=
en
> interface to get useful packets. =A0If I set feature report 2 to
> something on touch interface, I get an error response back from
> device. =A0This aligns with HID descriptor because only the pen
> interface declares that feature report #2.
>
> I'm sure its similar for Tablet PC's. =A0 Its also writing to feature
> report #2 but unique data values. What ever the values are, it
> probably also doesn't make sense to write to both pen interface and
> touch interface on Tablet PC.
>
> If the feature report is only on one of two interfaces I do suggest
> changing the if() to something like below to make it more obvious ("i=
f
> (TOUCH)" is more obvious that your looking for specific interface the=
n
> "if (!PEN)"). =A0If its on both and only 1 needs to be written to the=
n
> that would probably be a good comment as well.

I see your point. I'll use TOUCH/PEN for the if-statement and add a com=
ment.

> >>
> >> =A0if (TOUCH)
> >> =A0 =A0/* do TOUCH set's */
> >> =A0if (PEN)
> >> =A0 =A0/* do PEN set's */
> >>
> >>
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0] =3D 3=
;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[1] =3D 4=
;
> >> > @@ -479,9 +477,9 @@ static int wacom_retrieve_hid_descriptor(str=
uct
> >> > usb_interface *intf,
> >> > =A0 =A0 =A0 =A0features->pressure_fuzz =3D 0;
> >> > =A0 =A0 =A0 =A0features->distance_fuzz =3D 0;
> >> >
> >> > - =A0 =A0 =A0 /* only Tablet PCs and Bamboo P&T need to retrieve=
 the info */
> >> > + =A0 =A0 =A0 /* only devices that support touch need to retriev=
e the info */
> >> > =A0 =A0 =A0 =A0if ((features->type !=3D TABLETPC) && (features->=
type !=3D
> >> > TABLETPC2FG) &&
> >> > - =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT))
> >> > + =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT) && (featur=
es->type !=3D
> >> > MTSCREEN))
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> >> >
> >> > =A0 =A0 =A0 =A0if (usb_get_extra_descriptor(interface, HID_DEVIC=
ET_HID,
> >> > &hid_desc)) {
> >> > diff --git a/drivers/input/tablet/wacom_wac.c
> >> > b/drivers/input/tablet/wacom_wac.c
> >> > index 8dc185d..1a887a1 100644
> >> > --- a/drivers/input/tablet/wacom_wac.c
> >> > +++ b/drivers/input/tablet/wacom_wac.c
> >> > @@ -729,6 +729,73 @@ static int wacom_intuos_irq(struct wacom_wa=
c
> >> > *wacom)
> >> > =A0 =A0 =A0 =A0return 1;
> >> > =A0}
> >> >
> >> > +static int wacom_mt_touch(struct wacom_wac *wacom)
> >> > +{
> >> > + =A0 =A0 =A0 struct wacom_features *features =3D &wacom->featur=
es;
> >> > + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> >> > + =A0 =A0 =A0 char *data =3D wacom->data;
> >> > + =A0 =A0 =A0 struct input_mt_slot *mt;
> >> > + =A0 =A0 =A0 int i, id =3D -1, j =3D 0, k =3D 4;
> >> > + =A0 =A0 =A0 int x =3D 0, y =3D 0;
> >> > + =A0 =A0 =A0 int current_num_contacts =3D data[2];
> >> > + =A0 =A0 =A0 int contacts_to_send =3D 0;
> >> > + =A0 =A0 =A0 bool touch =3D false;
> >> > +
> >> > + =A0 =A0 =A0 /* reset the counter by the first packet */
> >> > + =A0 =A0 =A0 if (current_num_contacts) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts =3D current=
_num_contacts;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D cu=
rrent_num_contacts;
> >> > + =A0 =A0 =A0 }
> >>
> >> It seems that the saved contact values are only processed in case =
were
> >> data[2] indicates no contact counts in packet. =A0I would think th=
at
> >> packets with no contacts could be ignored (return) unless there is
> >> some data that must be implied. =A0Why is it not ignored?
> >
> >
> > current_num_contacts is only reported, hence=A0updated,=A0by the fi=
rst set of
> > data. Later touch data will be processed as long as number of conta=
cts does
> > not exceed current_num_contacts.
> >
> >>
> >>
> >> > +
> >> > + =A0 =A0 =A0 /* There are at most 5 contacts per packet */
> >> > + =A0 =A0 =A0 contacts_to_send =3D min(5, (int)features->num_con=
tacts_left);
> >>
> >> Its not obvious to me if data[2] contains touches in packet or tot=
al
> >> touches on screen.
> >
> >
> > Total touches on the screen.
>
> OK. =A0I understand now. =A0It would be nice to add that to above com=
ment
> (the fact that num_contacts_left is total on screen).

num_contacts_left is normally not the total on the screen. It is the
number of contacts that need to be processed. num_contacts is the
total on the screen. contacts_to_send is the number of contacts we are
going to send.

> >>
> >> > +
> >> > + =A0 =A0 =A0 for (i =3D 0; i < contacts_to_send; i++) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D le16_to_cpup((__le16 *)&dat=
a[k]);
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* is there an existing slot for t=
his contact? */
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < features->touch_=
max; j++) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt =3D &input->mt[=
j];
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (input_mt_get_v=
alue(mt, ABS_MT_TRACKING_ID)
> >> > =3D=3D id )
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 br=
eak;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no. then find an unused slot to=
 fill */
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (j >=3D features->touch_max) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < =
features->touch_max; j++) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt=
 =3D &input->mt[j];
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if=
 (input_mt_get_value(mt,
> >> > ABS_MT_TRACKING_ID) =3D=3D -1 )
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 break;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>
> >> This may need a little more thought since hid-multitouch doesn't q=
uery
> >> old value. =A0Is there a case were a touch is removed and new touc=
h
> >> added in same packet? =A0Probably that would never send the -1 to =
user
> >> land.
> >
> >
> > Once a touch leaves the screen, a -1 will always be sent to indicat=
e the
> > touch is out. When a new touch is added, it may use any available p=
acket.
> > Hence the one used by the just removed touch can also be used. Do I=
 get your
> > question properly?
>
> I'm thinking of this sequence inside 1 packet (probably not easy to
> produce in the wild):
>
> =A0* 1st location in packet shows Finger with ID of 100 as not touchi=
ng any more.
> =A0* Loops threw and finds matching ID and sets to -1.
> =A0* 2nd location in packet shows Finger with ID of 101 as touching. =
=A0Its new.
> =A0* Loops threw to find 1st slot with -1 and uses one we just cleare=
d.
> =A0* Sync window occurs. =A0User only sees Contact ID change from 100=
 and 101.

Oh, I know where you are. You are in the real world, not in the
firmware ;). The firmware can not tell if the second finger (101) is
the same finger as the first one (100) or not. All it can do is:
report a finger out then a finger in. So, in any moment if there is
one finger on the screen, it report one finger. If none, it reports
none. If, by any chance, the second one (101) touches before the first
one out, we get two finger data before one if out.

Your case won't happen, at least in theory.

> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch =3D data[k - 1] & 0x1;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, j);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (touch) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D le16_to_cpup=
((__le16 *)&data[k + 6]);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D le16_to_cpup=
((__le16 *)&data[k + 8]);
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(i=
nput, ABS_MT_POSITION_X, x);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(i=
nput, ABS_MT_POSITION_Y, y);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D -1;
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep the id from firmware since=
 we need
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it to process future events
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TRA=
CKING_ID, id);
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 k +=3D WACOM_BYTES_PER_MT_PACKET;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
> >> > +
> >> > + =A0 =A0 =A0 features->num_contacts_left -=3D contacts_to_send;
> >> > + =A0 =A0 =A0 if (features->num_contacts_left < 0)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D 0;
> >>
> >> Same comment as above. =A0Could use a comment on why storing this =
would be
> >> needed.
> >
> >
> > If you understood the value of=A0current_num_contacts,=A0it would b=
e easier to
> > see the need for num_contacts_left. I'll add a comment for
> > current_num_contacts.
>
> I guess I still don't see why its needed or how its being used.
>
> Now that I understand that current_num_contacts is total touches, I d=
o
> understand you need to know when a packet contains 5 full touches and
> when it contains less than 5. =A0For example if 6 touches then 1st
> packet could have 5 and next packet could have 1. =A0So you need to k=
now
> to stop looping after 1. =A0But I do not see how this num_contacts_le=
ft
> helps that. =A0It looks like it would set contacts_to_send to 5 in bo=
th
> packets.

Why do you think contacts_to_send could be 5? If num_contacts_left is
1, min(5, (int)features->num_contacts_left) should return 1, which is
the contacts_to_send. Do I miss something?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
