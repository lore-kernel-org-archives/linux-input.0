From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 20:26:20 +0200
Message-ID: <4BE1B84C.1040903@euromail.se>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:52536 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757371Ab0EES0h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 May 2010 14:26:37 -0400
In-Reply-To: <4BE1B595.9090705@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

=C9ric Piel wrote:
> Op 05-05-10 20:01, Henrik Rydberg schreef:
>> Dmitry Torokhov wrote:
>>>> @@ -253,7 +253,6 @@ static void elantech_report_absolute_v2(struct=
 psmouse *psmouse)
>>>> =20
>>>>  	/* byte 0: n1  n0   .   .   .   .   R   L */
>>>>  	fingers =3D (packet[0] & 0xc0) >> 6;
>>>> -	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>>> Mousedev works a tad better if BTN_TOUCH is reported first. Otherwi=
se
>>> looks good.
>>>
>>> Henrik, should we report "tool width" as ABS_MT_WIDTH_MAJOR?
>> I might be missing some context here, I see no prior use of width in=
 the driver.
>> The answer is either ABS_MT_TOUCH_MAJOR or ABS_MT_WIDTH_MAJOR depend=
ing on how
>> the width is actually computed. Generally, it makes little sense to =
have
>> ABS_MT_WIDTH_MAJOR (width of approaching finger) without ABS_MT_TOUC=
H_MAJOR
>> (width of touching finger), but it is ok to have only ABS_MT_TOUCH_M=
AJOR. Things
>> like thumb detection requires both values to be reliable.
> Ok, so it seems in this case, ABS_MT_TOUCH_MAJOR is the most
> appropriate... if we care at all.
>=20
> Let me give you some more details. From what is seems, the hardware c=
an
> reports the width of a touch, but only when there is one single touch=
=2E
> So far we report it via ABS_TOOL_WIDTH. When there is 2 or 3 touches,
> the width is unknown. So the precise question is:
> Should we report also ABS_MT_TOUCH_MAJOR in addition to ABS_TOOL_WIDT=
H,
> whenever it is known (ie: one finger), or just not bother and only
> report ABS_TOOL_WIDTH?

With only partial information available it will not be of much use anyw=
ay, so
omitting ABS_MT_TOUCH is probably best. The ABS_TOOL_WIDTH will most li=
kely not
be used by a driver either (it wont in the Multitouch X Driver anyways)=
=2E The
synaptics driver cares for palm detection, but the scale has to be very=
 specific
to work properly (i.e., requires testing with synaptics to be useful).

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
