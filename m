From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 19:06:25 +0200
Message-ID: <4BE1A591.3020201@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:35757 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0EERG3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 13:06:29 -0400
In-Reply-To: <20100505163832.GA7337@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Op 05-05-10 18:38, Dmitry Torokhov schreef:
> Hi Eric,
>=20
> On Wed, May 05, 2010 at 02:20:46PM +0200, =C9ric Piel wrote:
>>
:
>> =20
>>  	/* byte 0: n1  n0   .   .   .   .   R   L */
>>  	fingers =3D (packet[0] & 0xc0) >> 6;
>> -	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>=20
> Mousedev works a tad better if BTN_TOUCH is reported first. Otherwise
> looks good.
I moved it there because somehow I had understood in the
multi-touch-protocol that all the old events had to be reported after
the last SYNC_MT. That said, I don't recall any influence on the
synaptics nor multitouch X drivers. Maybe it matters just for the ABS_*
events?

>=20
> Henrik, should we report "tool width" as ABS_MT_WIDTH_MAJOR?
>=20
> Eric, we don't have the "width" for the 2nd point of contact, do we?
I looked a bit at the values generated when there are two touches, and
couldn't any changing when I was varying the pressure.

> Where is the proprietary driver BTW? Do we even care? I'd probably ge=
t
> rid of HAT abuse if our standard tools provide good user experience.
Actually I had never heard of a proprietary driver before reading the
code ;-) Maybe Florian knows?

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
