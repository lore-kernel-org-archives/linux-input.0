From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Thu, 06 May 2010 01:00:33 +0200
Message-ID: <4BE1F891.7000801@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:53412 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0EEXAf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 19:00:35 -0400
In-Reply-To: <4BE1BA57.5080709@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 05-05-10 20:35, =C9ric Piel schreef:
:
>=20
> BTW, does anyone know a graphical app which reads the MT events from =
a
> /dev/input/eventX device and displays them as points in a window? Tha=
t
> would be rather helpful to reverse-engineer/debug multitouch hardware=
s.
Now that I have my little app, it was easier to test with the protocol.
When there are 3 fingers, there is only one coordinate reported, and it
is done in the same way as with one finger.

There might also be some additional info on the 5th and 6th bit of byte
3, and 5th to 8th bits of byte 4. No idea yet what they correspond to.

Cheers,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
