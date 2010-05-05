From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 05 May 2010 18:58:18 +0200
Message-ID: <4BE1A3AA.1090401@tudelft.nl>
References: <4BE16121.8040000@tudelft.nl> <20100505163951.GB7337@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:55291 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab0EEQ6W (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 12:58:22 -0400
In-Reply-To: <20100505163951.GB7337@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 05-05-10 18:39, Dmitry Torokhov schreef:
> On Wed, May 05, 2010 at 02:14:25PM +0200, =C9ric Piel wrote:
>> >From observation of the values sent from the hardware version 2, it
>> seems that the first four bits of byte 1 represents the width. So we=
 can
>> report it as well. Observed values on my hardware were always betwee=
n 1
>> and 12, so let's use this for min and max.
>>
>=20
> I think we shoudl have threshold for the firmware version when we sta=
rt
> reporting the width.
>=20
What do you mean? That the width might not be reported correctly by all
the firmwares? I have no idea if that is the case. For info, IIRC my
firmware report 2.1 with middle byte 8.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
