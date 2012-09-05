From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [eBeam PATCH 2/2] input: misc: New USB eBeam input driver.
Date: Wed, 05 Sep 2012 21:58:06 +0200
Message-ID: <5047AECE.80409@laposte.net>
References: <1346539923-9704-1-git-send-email-yann.cantin@laposte.net> <1346539923-9704-3-git-send-email-yann.cantin@laposte.net> <3991181.oZKWSZGdK8@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:57317 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759283Ab2IETzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Sep 2012 15:55:51 -0400
In-Reply-To: <3991181.oZKWSZGdK8@linux-lqwf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, jikos@suse.cz

Hi,

Le 05/09/2012 09:29, Oliver Neukum a =E9crit :
> before we add yet another sysfs interface, we should ask whether cali=
bration
> isn't a problem that should be solved with a common API.

Short answer : no.

##
Long answer (may be oot) :

Existing calibration tools or procedures (in kernel modules or xorg) fo=
r absolute
devices deals with hardware axis mostly matching system's ones (X scree=
n mainly), modulo
switching XY, inversion or simple tweaks. Plus you know from the beginn=
ing the ranges
used, and all parameters are stable.

eBeam device track an active stylus in his fov, usually on a whiteboard=
 where a
video-projector cast the computer screen. It then compute the stylus's =
position
and send it to the kernel in his own fixed 2D cartesian coordinate syst=
em relative
to the device.

The device is by design mobile (you stuck it anywhere on the border of =
the
projection plane for a session), his axis never match screen's ones, ne=
ither in range
nor orientation. Even worse, due to projection artifact, the two coordi=
nates
systems (ebeam and screen) can even not be linearly correlated.

Manufacturer's so-called drivers seems to use second order interpolatio=
ns,
i use an homography transformation (which is the right mathematical too=
l for
the problem, and seems quicker) to transform between coordinates system=
s. Anyway,
this need lot of parameters.

As ebeams are the only devices to my knowledge that work that way, i do=
n't think
a common API can be common, unless we mean an in-kernel generic purpose=
 calibration
API for input devices (stellar away for me), or a userland one (where s=
hould it be
in the stack ?). Sincerely, this look overkill.

In the other hand, the actual ebeam module transformation feeding event=
s subsys
works very well and expose straight and usable data to userland (xorg e=
vdev for now,
and any program that can eat kernel's input data).

##

I understand the sysfs interface is a problem. Eventually, in last reso=
rt, i can reduce
it to 4 files : pass the 9 matrix parameters as one big string, removin=
g min values. But
i think this obfuscate the api for a marginal gain.


--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
