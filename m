From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Thu, 06 May 2010 00:53:25 +0200
Message-ID: <4BE1F6E5.70103@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl> <4BE1C198.3080809@euromail.se> <4BE1E0CF.9020008@tudelft.nl> <4BE1EDFE.20001@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:44691 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab0EEWx2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 18:53:28 -0400
In-Reply-To: <4BE1EDFE.20001@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Benjamin Tissoires <tissoire@cena.fr>

Op 06-05-10 00:15, Henrik Rydberg schreef:
> =C9ric Piel wrote:
>> Op 05-05-10 21:06, Henrik Rydberg schreef:
:
>> Thanks a lot for the tips.
>> I've hacked up an app which does just this, based on touchd and
>> pyinputevent.
>=20
> Thanks for the app, works nicely after adjusting the touchpad resolut=
ion to fit
> my bcm5974.
Cool! (actually it could be possible to read this resolution from the
input info on the device, to make the app more user-friendly)

>> Apparently when there are two fingers, the hardware doesn't report
>> really the finger coordinates but the lowest and highest points of t=
he
>> rectangle defined by the two fingers.
>=20
> I take it you are referring to the enumeration of the fingers, the or=
der in
> which they appear on the wire?
No. What I mean is that one reported point always contains the maximum =
X
of the two coordinate and the maximum Y of the two coodinates, while th=
e
other point always get the minimum of both.

So if you have the fingers like this:
-------------------
|                 |
|            A    |
|                 |
|     B           |
|                 |
-------------------
You get the actual values, but if you put your fingers like this:
-------------------
|                 |
|     A           |
|                 |
|            B    |
|                 |
-------------------
You get the same values as for the previous configuration!

I guess that for a lot of gestures it doesn't matter much...

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
