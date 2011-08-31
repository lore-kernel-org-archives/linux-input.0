From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH v4 8/8] Input: elantech - add v4 hardware support
Date: Wed, 31 Aug 2011 14:50:59 +0200
Message-ID: <4E5E2E33.9040904@tudelft.nl>
References: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw> <1314606539-24722-9-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:50246 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab1HaMvD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Aug 2011 08:51:03 -0400
In-Reply-To: <1314606539-24722-9-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Op 29-08-11 10:28, JJ Ding schreef:
> v4 hardware is a true multitouch capable touchpad (up to 5 fingers).
> The packet format is quite complex, please see protocol document for
> reference.
Hi,

It's great that you add support for another version!

Looks good. Just a few comment (inline).

Cheers,
=C3=89ric


>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
> ---
>   Documentation/input/elantech.txt |  170 ++++++++++++++++++++++++++
>   drivers/input/mouse/elantech.c   |  247 +++++++++++++++++++++++++++=
+++++++----
>   drivers/input/mouse/elantech.h   |   29 ++++-
>   3 files changed, 420 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/input/elantech.txt b/Documentation/input/e=
lantech.txt
> index cee08ee..f63115a 100644
> --- a/Documentation/input/elantech.txt
> +++ b/Documentation/input/elantech.txt
> @@ -32,6 +32,12 @@ Contents
>       6.2 Native absolute mode 6 byte packet format
>           6.2.1 One/Three finger touch
>           6.2.2 Two finger touch
> + 7. Hardware version 4
> +    7.1 Registers
> +    7.2 Native absolute mode 6 byte packet format
> +        7.2.1 Status packet
> +        7.2.2 Head packet
> +        7.2.3 Motion packet
>
>
>
> @@ -573,3 +579,167 @@ The packet format is exactly the same for two f=
inger touch, except the hardware
>   sends two 6 byte packets. The first packet contains data for the fi=
rst finger,
>   the second packet has data for the second finger. So for two finger=
 touch a
>   total of 12 bytes are sent.
> +
> +////////////////////////////////////////////////////////////////////=
/////////
> +
> +7. Hardware version 4
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +7.1 Registers
> +    ~~~~~~~~~
> +* reg_07
> +
> +   bit   7   6   5   4   3   2   1   0
> +         0   0   0   0   0   0   0   A
> +
> +         A: 1 =3D enable absolute tracking
> +
> +7.2 Native absolute mode 6 byte packet format
> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +v4 hardware is a true multitouch touchpad, capable of tracking up to=
 5 fingers.
> +Unfortunately, due to PS/2's limited bandwidth, its packet format is=
 rather
> +complex.
> +
> +Whenever the numbers or identities of the fingers changes, the hardw=
are sends a
> +status packet to indicate how many and which fingers is on touchpad,=
 followed by
> +head packets or motion packets. A head packet contains data of finge=
r id, finger
> +position (absolute x, y values), width, and presure. A motion packet=
 contains
Typo: pres_s_ure

> +two fingers' position delta.
> +
:
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index c4ceefd..0d3936d 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -84,12 +84,6 @@ static int elantech_read_reg(struct psmouse *psmou=
se, unsigned char reg,
>   	unsigned char param[3];
>   	int rc =3D 0;
>
> -	if (reg<  0x10 || reg>  0x26)
> -		return -1;
> -
> -	if (reg>  0x11&&  reg<  0x20)
> -		return -1;
> -
You could still leave a check of reg being between 0x07 and 0x26, it's
better than nothing.

:
>
> +static void elantech_mt_sync(struct psmouse *psmouse)
> +{
> +	struct input_dev *dev =3D psmouse->dev;
> +	unsigned char *packet =3D psmouse->packet;
> +
> +	input_report_key(dev, BTN_LEFT, packet[0]&  0x01);
> +	input_report_key(dev, BTN_RIGHT, packet[0]&  0x02);
> +	input_mt_report_pointer_emulation(dev, true);
> +	input_sync(dev);
> +}
The function naming is a bit strange. If you put _mt_, I expect there i=
s=20
only code related to multitouch. Maybe rename to:
elantech_input_sync_v4()


> +
> +static void process_packet_status(struct psmouse *psmouse)
:
> +static void process_packet_head(struct psmouse *psmouse)
:
> +static void process_packet_motion(struct psmouse *psmouse)
Maybe rename these function to *_v4(), so that it's clear it's not for=20
v3 hardware or any other version.

:
> @@ -645,10 +807,11 @@ static int elantech_set_absolute_mode(struct ps=
mouse *psmouse)
>
>   static int set_range(struct psmouse *psmouse, unsigned int *x_min,
>   		     unsigned int *y_min, unsigned int *x_max,
> -		     unsigned int *y_max)
> +		     unsigned int *y_max, unsigned int *width)
>   {
>   	struct elantech_data *etd =3D psmouse->private;
>   	unsigned char param[3];
> +	unsigned char traces =3D 0;
Don't initialize it.

>   	int i;
>
>   	switch (etd->hw_version) {
> @@ -677,12 +840,16 @@ static int set_range(struct psmouse *psmouse, u=
nsigned int *x_min,
>   		}
>   		break;
>
> +	case 4:
> +		traces =3D etd->capabilities[1];
> +		/* pass through */
>   	case 3:
>   		if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
>   			return -1;
>
>   		*x_max =3D (0x0f&  param[0])<<  8 | param[1];
>   		*y_max =3D (0xf0&  param[0])<<  4 | param[2];
> +		*width =3D *x_max / (traces - 1);
>   		break;
>   	}
width is used only for firmware 4, right? If so then this code is too=20
tricky. Order normally the cases, and duplicate the few common lines.=20
Maintainability is more important than saving a couple of bytes :-)

Also, what happens if the firmware returns 1 in  etd->capabilities[1]?=20
Make sure a division by zero is _impossible_. Please add a check on san=
e=20
values for "traces", and bail out if it's not within these limits:
	if ((traces < 2) || (traces > *x_max))
		return -1;

=C3=89ric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
