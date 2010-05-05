From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 21:06:00 +0200
Message-ID: <4BE1C198.3080809@euromail.se>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:56859 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab0EETIk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 May 2010 15:08:40 -0400
In-Reply-To: <4BE1BA57.5080709@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Benjamin Tissoires <tissoire@cena.fr>

=C9ric Piel wrote:
>=20
> BTW, does anyone know a graphical app which reads the MT events from =
a
> /dev/input/eventX device and displays them as points in a window? Tha=
t
> would be rather helpful to reverse-engineer/debug multitouch hardware=
s.

Something like fingermgmt in OSX? Not to my knowledge. The touchd proje=
ct
includes some graphics via python, but is not based on MT events. Maybe=
 our
friends at ENAC has something cooking?

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
