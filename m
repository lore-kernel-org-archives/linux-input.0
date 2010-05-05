From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Thu, 06 May 2010 00:15:26 +0200
Message-ID: <4BE1EDFE.20001@euromail.se>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl> <4BE1C198.3080809@euromail.se> <4BE1E0CF.9020008@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:50525 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109Ab0EEWPh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 May 2010 18:15:37 -0400
In-Reply-To: <4BE1E0CF.9020008@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Benjamin Tissoires <tissoire@cena.fr>

=C9ric Piel wrote:
> Op 05-05-10 21:06, Henrik Rydberg schreef:
>> =C9ric Piel wrote:
>>> BTW, does anyone know a graphical app which reads the MT events fro=
m a
>>> /dev/input/eventX device and displays them as points in a window? T=
hat
>>> would be rather helpful to reverse-engineer/debug multitouch hardwa=
res.
>> Something like fingermgmt in OSX? Not to my knowledge. The touchd pr=
oject
>> includes some graphics via python, but is not based on MT events. Ma=
ybe our
>> friends at ENAC has something cooking?
>=20
> Thanks a lot for the tips.
> I've hacked up an app which does just this, based on touchd and
> pyinputevent.

Thanks for the app, works nicely after adjusting the touchpad resolutio=
n to fit
my bcm5974.

Henrik

> Apparently when there are two fingers, the hardware doesn't report
> really the finger coordinates but the lowest and highest points of th=
e
> rectangle defined by the two fingers.

I take it you are referring to the enumeration of the fingers, the orde=
r in
which they appear on the wire?

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
