From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT  messages
Date: Thu, 6 May 2010 10:49:58 +0200
Message-ID: <82B040EB-4970-456E-A72A-E63F47FAE53F@enac.fr>
References: <4BE1629E.50901@tudelft.nl>  <20100505163832.GA7337@core.coreip.homeip.net>  <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl>  <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl> <4BE1C198.3080809@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:40974 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0EFIuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 04:50:06 -0400
In-Reply-To: <4BE1C198.3080809@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <tissoire@cena.fr>


Le 5 mai 10 =E0 21:06, Henrik Rydberg a =E9crit :

> =C9ric Piel wrote:
>>
>> BTW, does anyone know a graphical app which reads the MT events =20
>> from a
>> /dev/input/eventX device and displays them as points in a window? =20
>> That
>> would be rather helpful to reverse-engineer/debug multitouch =20
>> hardwares.
>
> Something like fingermgmt in OSX? Not to my knowledge. The touchd =20
> project
> includes some graphics via python, but is not based on MT events. =20
> Maybe our
> friends at ENAC has something cooking?

Unfortunately, we're at least one coder short in the group, and so =20
far we've had to focus on low level code. I know that several distros =20
have asked me about what kind of demos they could build, and even who =20
they could get to code that for them, so there might be things =20
brewing somewhere.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
