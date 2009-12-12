From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Sat, 12 Dec 2009 00:30:54 -0800
Message-ID: <20091212083053.GB7534@core.coreip.homeip.net>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr> <20091211124226.GD17995@ibawizard.net> <20091211141038.0CBD8951F5@smtp.lii-enac.fr> <20091211223622.GA3067@core.coreip.homeip.net> <810DC55F-0AEC-4ED9-9EE8-1671810D810E@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53869 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZLLIaw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2009 03:30:52 -0500
Received: by pwj9 with SMTP id 9so1042835pwj.21
        for <linux-input@vger.kernel.org>; Sat, 12 Dec 2009 00:30:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <810DC55F-0AEC-4ED9-9EE8-1671810D810E@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>, linux-input@vger.kernel.org

On Sat, Dec 12, 2009 at 09:13:01AM +0100, St=E9phane Chatty wrote:
>
> Le 11 d=E9c. 09 =E0 23:36, Dmitry Torokhov a =E9crit :
>
>> Hi Stephane,
>>
>>
>>> +static int emulate_touchscreen =3D 1;
>>> +module_param_named(emulate_touchscreen, emulate_touchscreen, int, =
=20
>>> 0600);
>>> +MODULE_PARM_DESC(emulate_touchscreen,
>>> +		"Touchscreen emulation on 3M multitouch panel (0=3Doff, 1=3Don)"=
);
>>> +
>>
>> I thought we agreed that this option is unnecessary.
>>
>
> Well, actually I was unsure what the conclusion of your discussion wa=
s. I=20
> decided that I would send this patch as is to see what happens :-)
>
> Here are our options:
>  1) mix touchscreen emulation and multitouch at all times
>  2) only activate touchscreen emulation when requested (module =20
> parameter, or something else)
>  3) have separate input nodes
>  4) kill the touchscreen emulation code, let the higher layers do it =
if=20
> necessary
>
> I personally would rule out option 4. The others are OK to me. Your =20
> thoughts?

#1 until everyone moves on to multitouch... and everyone means
_everyone_, not only X and distributions. I could consider #3 if we see
that multitouch data overwhelms oldish userspace, but OTOH users would
probably prefer to update their userspace to take advantage of their
hardware so the multitouch data will be opened anyway... so we back to
#1.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
