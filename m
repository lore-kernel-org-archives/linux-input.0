From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] ntrig tool separation
Date: Wed, 17 Jun 2009 15:41:47 +0200
Message-ID: <9A2A8015-912B-498D-B5E1-1D79B933DECD@enac.fr>
References: <4A388422.7020802@seas.upenn.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:48850 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbZFQNlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 09:41:49 -0400
In-Reply-To: <4A388422.7020802@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org


Le 17 juin 09 =E0 07:50, Rafi Rubin a =E9crit :

> When both touch and pen are active send a tool announcement before
> sending any status changes so that event users may differentiate
> which tool is changing.
>

With my multitouch-enabled TouchSmart tx2 (firwmare 4.2.17.8.5, =20
finally found it!) I get a series of ten BTN_TOOL_DOUBLETAP (value =3D =
=20
0 then 1, five times) in every event. This is because the device =20
emits HID_GD_X several times in every event, whatever the real number =20
of touches on the screen.

The way to avoid this would be to delay the emission of your =20
BTN_TOOL_DOUBLETAP as I did for ABS_X and ABS_Y, that is when we =20
receive HID_DG_HEIGHT (single touch firmware) or 0xff000002 (multi-=20
touch firmware)

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
