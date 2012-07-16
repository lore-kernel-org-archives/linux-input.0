From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: On the fly input_set_abs_params changes
Date: Mon, 16 Jul 2012 08:48:46 +0200
Message-ID: <5003B94E.40402@laposte.net>
References: <50031664.6090302@laposte.net> <87liiknv3b.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:52349 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2GPGsq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 02:48:46 -0400
In-Reply-To: <87liiknv3b.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jian-Jhong Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org

Hi, Jian-Jhong

Le 16/07/2012 07:17, Jian-Jhong Ding a =E9crit :
>> I'm wondering if it's ok to change min/max parameters after registra=
tion, and how
>> it should be handled by xorg's evdev.
>=20
> I am really intrigued why you have to do this. Some specific feature =
of
> your device? Can you elaborate more on this?

A video projector project a computer screen on a whiteboard and an eBea=
m device is
placed on the whiteboard anywhere outside the image. A special pointer =
moved on the
whiteboard should act as a mouse device. The whole thing act like a gia=
nt touchscreen,
an interactive whiteboard.

The device send the pointer's coordinates in his own coordinate system =
(cartesian).
It can be place anywhere on the whiteboard, typically on a corner for t=
he one i have.

Unlike fixed interactive whiteboard, as the eBeam can be placed anywher=
e, the coordinates
you got aren't mapped to screen coordinates even remotely (scaled, rota=
ted and most of
the time subject to projection deformation : i plan to use a homography=
 to retrieve screen
coordinates).

So, the driver need to be calibrated, and this can only be done when th=
e device is
in place : get raw coordinate, compute transform, start mapping.

The simplest way to do this is to start the driver without coordinates =
transformation,
(input_set_abs_params set to raw axis, aka 0,0xFFFF, not corresponding =
to screen axis)
launch a calibration phase in user space, and reset input_set_abs_param=
s to the computed ones.


--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
