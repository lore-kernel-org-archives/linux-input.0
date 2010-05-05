From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 20:35:03 +0200
Message-ID: <4BE1BA57.5080709@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:58636 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab0EESfF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 14:35:05 -0400
In-Reply-To: <4BE1B84C.1040903@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 05-05-10 20:26, Henrik Rydberg schreef:
> =C9ric Piel wrote:
:
>> Let me give you some more details. From what is seems, the hardware =
can
>> reports the width of a touch, but only when there is one single touc=
h.
>> So far we report it via ABS_TOOL_WIDTH. When there is 2 or 3 touches=
,
>> the width is unknown. So the precise question is:
>> Should we report also ABS_MT_TOUCH_MAJOR in addition to ABS_TOOL_WID=
TH,
>> whenever it is known (ie: one finger), or just not bother and only
>> report ABS_TOOL_WIDTH?
>=20
> With only partial information available it will not be of much use an=
yway, so
> omitting ABS_MT_TOUCH is probably best. The ABS_TOOL_WIDTH will most =
likely not
> be used by a driver either (it wont in the Multitouch X Driver anyway=
s). The
> synaptics driver cares for palm detection, but the scale has to be ve=
ry specific
> to work properly (i.e., requires testing with synaptics to be useful)=
=2E
Thanks for clarifying!

BTW, does anyone know a graphical app which reads the MT events from a
/dev/input/eventX device and displays them as points in a window? That
would be rather helpful to reverse-engineer/debug multitouch hardwares.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
