From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT
 messages
Date: Thu, 6 May 2010 10:22:14 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568A0765@LIMKCMBX1.ad.analog.com>
References: <4BE1629E.50901@tudelft.nl>
 <20100505163832.GA7337@core.coreip.homeip.net>
 <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl>
 <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl>
 <4BE1C198.3080809@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:59762 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab0EFJWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 05:22:18 -0400
In-Reply-To: <4BE1C198.3080809@euromail.se>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, =?iso-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Benjamin Tissoires <tissoire@cena.fr>

Henrik Rydberg wrote on 2010-05-05:
> =C9ric Piel wrote:
>>
>> BTW, does anyone know a graphical app which reads the MT events from=
 a
>> /dev/input/eventX device and displays them as points in a window? Th=
at
>> would be rather helpful to reverse-engineer/debug multitouch
> hardwares.
>
> Something like fingermgmt in OSX? Not to my knowledge. The touchd
> project includes some graphics via python, but is not based on MT
> events. Maybe our friends at ENAC has something cooking?
>
> Henrik
>

I've been playing with Benjamin's xf86-input-evdev multitouch-subdevs w=
ork.
http://cgit.freedesktop.org/~tissoire/xf86-input-evdev/log/?h=3Dmultito=
uch-subdevs

Its supports finger tracking ID and you can control multiple pointers o=
n your X.
What's currently lacking is that xf86-input-evdev doesn't generate clic=
k events (something like a LEFT CLICK) for touches.

What also supports Linux MT events is Android =C9clair
http://lukehutch.wordpress.com/2010/01/06/my-multi-touch-code-ported-to=
-eclair/

It Uses:
ABS_MT_POSITION_X
ABS_MT_POSITION_Y
ABS_MT_TOUCH_MAJOR
ABS_MT_WIDTH_MAJOR

Without ABS_MT_TRACKING_ID.

Luke Hutchison wrote some basic MT demo applications, such as mtvisuali=
zer.apk.
http://lukehutch.wordpress.com/2009/01/25/get-multi-touch-support-on-yo=
ur-t-mobile-g1-today/


Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Gesch=
aeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
