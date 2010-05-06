From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Thu, 06 May 2010 13:38:06 +0200
Message-ID: <4BE2AA1E.1060201@euromail.se>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl> <4BE1C198.3080809@euromail.se> <544AC56F16B56944AEC3BD4E3D5917712E568A0765@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:52747 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522Ab0EFLiZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 May 2010 07:38:25 -0400
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568A0765@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Benjamin Tissoires <tissoire@cena.fr>

Hennerich, Michael wrote:
> Henrik Rydberg wrote on 2010-05-05:
>> =C9ric Piel wrote:
>>> BTW, does anyone know a graphical app which reads the MT events fro=
m a
>>> /dev/input/eventX device and displays them as points in a window? T=
hat
>>> would be rather helpful to reverse-engineer/debug multitouch
>> hardwares.
>>
>> Something like fingermgmt in OSX? Not to my knowledge. The touchd
>> project includes some graphics via python, but is not based on MT
>> events. Maybe our friends at ENAC has something cooking?
>>
>> Henrik
>>
>=20
> I've been playing with Benjamin's xf86-input-evdev multitouch-subdevs=
 work.
> http://cgit.freedesktop.org/~tissoire/xf86-input-evdev/log/?h=3Dmulti=
touch-subdevs
>=20
> Its supports finger tracking ID and you can control multiple pointers=
 on your X.
> What's currently lacking is that xf86-input-evdev doesn't generate cl=
ick events (something like a LEFT CLICK) for touches.
>=20
> What also supports Linux MT events is Android =C9clair
> http://lukehutch.wordpress.com/2010/01/06/my-multi-touch-code-ported-=
to-eclair/
>=20
> It Uses:
> ABS_MT_POSITION_X
> ABS_MT_POSITION_Y
> ABS_MT_TOUCH_MAJOR
> ABS_MT_WIDTH_MAJOR
>=20
> Without ABS_MT_TRACKING_ID.
>=20
> Luke Hutchison wrote some basic MT demo applications, such as mtvisua=
lizer.apk.
> http://lukehutch.wordpress.com/2009/01/25/get-multi-touch-support-on-=
your-t-mobile-g1-today/

Thanks for the update on MT demos!

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
