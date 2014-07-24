From: =?ISO-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Subject: Trouble with an HP stylus
Date: Thu, 24 Jul 2014 17:52:27 +0200
Message-ID: <2325454.r4RE9vHMoF@romarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nef2.ens.fr ([129.199.96.40]:2901 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759002AbaGXQXq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2014 12:23:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org

Hi,

I have a HP EliteBook Revolve 810 (which is a hybrid laptop/tablet) wit=
h
the HP active pen that goes with it. I have installed fedora 20 (kernel
3.15.6-200.fc20.x86_64) on this, and the pen does not work out of the b=
ox.
Playing with evtest, it appears that the kernel reports the X coordinat=
e in
ABS_X and in ABS_Y, while the Y coordinate goes into ABS_Z and ABS_RX; =
here
are a few lines of output:

Event: time 1406153996.865044, -------------- SYN_REPORT ------------
Event: time 1406153996.873047, type 3 (EV_ABS), code 0 (ABS_X), value 1=
087
Event: time 1406153996.873047, type 3 (EV_ABS), code 1 (ABS_Y), value 1=
087
Event: time 1406153996.873047, type 3 (EV_ABS), code 2 (ABS_Z), value 1=
599
Event: time 1406153996.873047, type 3 (EV_ABS), code 3 (ABS_RX), value =
1599

Of course, XOrg's evdev driver is confused and the pointer is stuck on =
the
diagonal X=3DY.

I guess this hardware needs a new quirk to usbhid, unless there is alre=
ady
a way to correct it ?

Here is the content of /sys/class/input/event8/device/uevent:

PRODUCT=3D3/3eb/840b/111
NAME=3D"Atmel Atmel maXTouch Digitizer Pen"
PHYS=3D"usb-0000:00:1a.0-1.1/input0"
UNIQ=3D""
PROP=3D0
EV=3D1b
KEY=3Dc01 1 0 0 0 0
ABS=3D100000f
MSC=3D10
MODALIAS=3Dinput:b0003v03EBp840Be0111-
e0,1,3,4,k100,140,14A,14B,ra0,1,2,3,18,m4,lsfw

I hope I gave enough information on this. I don't read the mailing list=
,
please CC any answer.

Thanks,

	=C3=89ric Brunet

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
