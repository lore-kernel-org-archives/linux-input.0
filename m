From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Sat, 12 Dec 2009 09:13:01 +0100
Message-ID: <810DC55F-0AEC-4ED9-9EE8-1671810D810E@enac.fr>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr> <20091211124226.GD17995@ibawizard.net> <20091211141038.0CBD8951F5@smtp.lii-enac.fr> <20091211223622.GA3067@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:47449 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZLLINE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2009 03:13:04 -0500
In-Reply-To: <20091211223622.GA3067@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>
Cc: linux-input@vger.kernel.org


Le 11 d=E9c. 09 =E0 23:36, Dmitry Torokhov a =E9crit :

> Hi Stephane,
>
>
>> +static int emulate_touchscreen =3D 1;
>> +module_param_named(emulate_touchscreen, emulate_touchscreen, int, =20
>> 0600);
>> +MODULE_PARM_DESC(emulate_touchscreen,
>> +		"Touchscreen emulation on 3M multitouch panel (0=3Doff, 1=3Don)")=
;
>> +
>
> I thought we agreed that this option is unnecessary.
>

Well, actually I was unsure what the conclusion of your discussion =20
was. I decided that I would send this patch as is to see what =20
happens :-)

Here are our options:
  1) mix touchscreen emulation and multitouch at all times
  2) only activate touchscreen emulation when requested (module =20
parameter, or something else)
  3) have separate input nodes
  4) kill the touchscreen emulation code, let the higher layers do it =20
if necessary

I personally would rule out option 4. The others are OK to me. Your =20
thoughts?

St.

PS: since yesterday, I have a working firmware on my NTrig panel. It =20
will be interesting to see what happens with a device that =20
distinguishes fingers and stylus but does not provide finger =20
tracking. Maybe it will give a new light on this.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
