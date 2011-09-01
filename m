From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH v4 8/8] Input: elantech - add v4 hardware support
Date: Thu, 01 Sep 2011 09:31:33 +0800
Message-ID: <87ty8x3v62.fsf@emc.com.tw>
References: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw> <1314606539-24722-9-git-send-email-jj_ding@emc.com.tw> <4E5E2E33.9040904@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:4300 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab1IAB31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Aug 2011 21:29:27 -0400
In-Reply-To: <4E5E2E33.9040904@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Hi =C3=89ric,

Thanks for your comments.
Reply below inline, thank you.

jj

On Wed, 31 Aug 2011 14:50:59 +0200, =C3=89ric Piel <E.A.B.Piel@tudelft.=
nl> wrote:
> Op 29-08-11 10:28, JJ Ding schreef:
> > v4 hardware is a true multitouch capable touchpad (up to 5 fingers)=
=2E
> > The packet format is quite complex, please see protocol document fo=
r
> > reference.
> Hi,
>=20
> It's great that you add support for another version!
>=20
> Looks good. Just a few comment (inline).
>=20
> Cheers,
> =C3=89ric
>=20
>=20
> >
> > Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
> > ---
> >   Documentation/input/elantech.txt |  170 +++++++++++++++++++++++++=
+
> >   drivers/input/mouse/elantech.c   |  247 +++++++++++++++++++++++++=
+++++++++----
> >   drivers/input/mouse/elantech.h   |   29 ++++-
> >   3 files changed, 420 insertions(+), 26 deletions(-)
> >
> > diff --git a/Documentation/input/elantech.txt b/Documentation/input=
/elantech.txt
> > index cee08ee..f63115a 100644
> > --- a/Documentation/input/elantech.txt
> > +++ b/Documentation/input/elantech.txt
> > @@ -32,6 +32,12 @@ Contents
> >       6.2 Native absolute mode 6 byte packet format
> >           6.2.1 One/Three finger touch
> >           6.2.2 Two finger touch
> > + 7. Hardware version 4
> > +    7.1 Registers
> > +    7.2 Native absolute mode 6 byte packet format
> > +        7.2.1 Status packet
> > +        7.2.2 Head packet
> > +        7.2.3 Motion packet
> >
> >
> >
> > @@ -573,3 +579,167 @@ The packet format is exactly the same for two=
 finger touch, except the hardware
> >   sends two 6 byte packets. The first packet contains data for the =
first finger,
> >   the second packet has data for the second finger. So for two fing=
er touch a
> >   total of 12 bytes are sent.
> > +
> > +//////////////////////////////////////////////////////////////////=
///////////
> > +
> > +7. Hardware version 4
> > +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +7.1 Registers
> > +    ~~~~~~~~~
> > +* reg_07
> > +
> > +   bit   7   6   5   4   3   2   1   0
> > +         0   0   0   0   0   0   0   A
> > +
> > +         A: 1 =3D enable absolute tracking
> > +
> > +7.2 Native absolute mode 6 byte packet format
> > +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +v4 hardware is a true multitouch touchpad, capable of tracking up =
to 5 fingers.
> > +Unfortunately, due to PS/2's limited bandwidth, its packet format =
is rather
> > +complex.
> > +
> > +Whenever the numbers or identities of the fingers changes, the har=
dware sends a
> > +status packet to indicate how many and which fingers is on touchpa=
d, followed by
> > +head packets or motion packets. A head packet contains data of fin=
ger id, finger
> > +position (absolute x, y values), width, and presure. A motion pack=
et contains
> Typo: pres_s_ure
=46ixed.
> > +two fingers' position delta.
> > +
> :
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/e=
lantech.c
> > index c4ceefd..0d3936d 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -84,12 +84,6 @@ static int elantech_read_reg(struct psmouse *psm=
ouse, unsigned char reg,
> >   	unsigned char param[3];
> >   	int rc =3D 0;
> >
> > -	if (reg<  0x10 || reg>  0x26)
> > -		return -1;
> > -
> > -	if (reg>  0x11&&  reg<  0x20)
> > -		return -1;
> > -
> You could still leave a check of reg being between 0x07 and 0x26, it'=
s
> better than nothing.
OK, I will add them back.=20
> :
> >
> > +static void elantech_mt_sync(struct psmouse *psmouse)
> > +{
> > +	struct input_dev *dev =3D psmouse->dev;
> > +	unsigned char *packet =3D psmouse->packet;
> > +
> > +	input_report_key(dev, BTN_LEFT, packet[0]&  0x01);
> > +	input_report_key(dev, BTN_RIGHT, packet[0]&  0x02);
> > +	input_mt_report_pointer_emulation(dev, true);
> > +	input_sync(dev);
> > +}
> The function naming is a bit strange. If you put _mt_, I expect there=
 is=20
> only code related to multitouch. Maybe rename to:
> elantech_input_sync_v4()
Changed.
>=20
> > +
> > +static void process_packet_status(struct psmouse *psmouse)
> :
> > +static void process_packet_head(struct psmouse *psmouse)
> :
> > +static void process_packet_motion(struct psmouse *psmouse)
> Maybe rename these function to *_v4(), so that it's clear it's not fo=
r=20
> v3 hardware or any other version.
Changed.
> :
> > @@ -645,10 +807,11 @@ static int elantech_set_absolute_mode(struct =
psmouse *psmouse)
> >
> >   static int set_range(struct psmouse *psmouse, unsigned int *x_min=
,
> >   		     unsigned int *y_min, unsigned int *x_max,
> > -		     unsigned int *y_max)
> > +		     unsigned int *y_max, unsigned int *width)
> >   {
> >   	struct elantech_data *etd =3D psmouse->private;
> >   	unsigned char param[3];
> > +	unsigned char traces =3D 0;
> Don't initialize it.
=46ixed.
>=20
> >   	int i;
> >
> >   	switch (etd->hw_version) {
> > @@ -677,12 +840,16 @@ static int set_range(struct psmouse *psmouse,=
 unsigned int *x_min,
> >   		}
> >   		break;
> >
> > +	case 4:
> > +		traces =3D etd->capabilities[1];
> > +		/* pass through */
> >   	case 3:
> >   		if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
> >   			return -1;
> >
> >   		*x_max =3D (0x0f&  param[0])<<  8 | param[1];
> >   		*y_max =3D (0xf0&  param[0])<<  4 | param[2];
> > +		*width =3D *x_max / (traces - 1);
> >   		break;
> >   	}
> width is used only for firmware 4, right? If so then this code is too=
=20
> tricky. Order normally the cases, and duplicate the few common lines.=
=20
> Maintainability is more important than saving a couple of bytes :-)
Yes, width is only used for firmware 4. I will change this for better
maintainability.
> Also, what happens if the firmware returns 1 in  etd->capabilities[1]=
?=20
> Make sure a division by zero is _impossible_. Please add a check on s=
ane=20
> values for "traces", and bail out if it's not within these limits:
> 	if ((traces < 2) || (traces > *x_max))
> 		return -1;
Thanks for reminding me this. I will fix it.
> =C3=89ric
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
