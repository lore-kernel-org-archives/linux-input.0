From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for MosArt multitouch panel
Date: Wed, 10 Feb 2010 13:50:36 +0100
Message-ID: <85636024-6AA2-49AE-9D42-ED1377DBB77F@enac.fr>
References: <20100206141713.EFC3C9520A@smtp.lii-enac.fr> <alpine.LNX.2.00.1002101207591.30967@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:40349 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0BJMum convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 07:50:42 -0500
In-Reply-To: <alpine.LNX.2.00.1002101207591.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


Le 10 f=E9vr. 10 =E0 12:08, Jiri Kosina a =E9crit :

> On Sat, 6 Feb 2010, Stephane Chatty wrote:
>
>>
>> +	/* currently, it's better to have one evdev device only */
>> +#if 0
>> +	hdev->quirks |=3D HID_QUIRK_MULTI_INPUT;
>> +#endif
>
> Could you please explain what is this about?

The device emits three kinds of reports. One is for multitouch =20
events, one is for a mouse emulation, and one is (as far as I can =20
remember) for a couple of buttons.

Originally I experimented using MULTI_INPUT, so that three devices =20
are created. It made things easier for debug, or so I thought. But =20
over time it appeared that people kept confusing the mouse device and =20
the mutitouch device and I lost three weeks trying to debug a driver =20
that worked perfectly well. More recently, it appeared that it also =20
creates confusion with hal and X.org.

Since all other mt devices have their own single touch emulation on =20
the same device (as discussed in a previous thread), I thought it =20
better to do the same here and ignore the mouse reports (through not =20
using MULTI_INPUT). I left it between #ifdefs in case things need to =20
change in the future.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
