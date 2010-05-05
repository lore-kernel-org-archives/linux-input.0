From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 19:36:10 +0200
Message-ID: <4BE1AC8A.3050006@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1A591.3020201@tudelft.nl> <20100505171540.GF7337@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:57659 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab0EERgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 13:36:12 -0400
In-Reply-To: <20100505171540.GF7337@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Op 05-05-10 19:15, Dmitry Torokhov schreef:
> On Wed, May 05, 2010 at 07:06:25PM +0200, =C9ric Piel wrote:
>> Op 05-05-10 18:38, Dmitry Torokhov schreef:
>>> Hi Eric,
>>>
>>> On Wed, May 05, 2010 at 02:20:46PM +0200, =C9ric Piel wrote:
>>>>
>> :
>>>> =20
>>>>  	/* byte 0: n1  n0   .   .   .   .   R   L */
>>>>  	fingers =3D (packet[0] & 0xc0) >> 6;
>>>> -	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>>>
>>> Mousedev works a tad better if BTN_TOUCH is reported first. Otherwi=
se
>>> looks good.
>> I moved it there because somehow I had understood in the
>> multi-touch-protocol that all the old events had to be reported afte=
r
>> the last SYNC_MT. That said, I don't recall any influence on the
>> synaptics nor multitouch X drivers. Maybe it matters just for the AB=
S_*
>> events?
>=20
> I was talking about mousedev - the in-kernel mouse emulation.
Oh... never thought on how the emulation was working!
>=20
> I do not believe the order of events shoudl matter for userspace, whi=
ch
> should collect all data until it receives EV_SYN/SYN_REPORT and then =
act
> upon the collected data.
Then it should be safe to put back BTN_TOUCH at the beginning. I can
send you a new version, with also ABS_MT_WIDTH_MAJOR if Henrik
recommends it.

See you,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
