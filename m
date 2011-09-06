From: =?ISO-8859-15?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Subject: elantech touchpad issues
Date: Tue, 06 Sep 2011 16:53:25 +0200
Message-ID: <4E6633E5.6080108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout03.t-online.de ([194.25.134.81]:42071 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab1IFOxf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 10:53:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everybody!

I'm owning a Samsung N145P netbook, that comes along with an elantech=20
touchpad:

[    5.949921] elantech: assuming hardware version 2, firmware version=20
4.2.22
[    5.985481] elantech: Synaptics capabilities query result 0x09, 0x14=
,=20
0x0b.

It has some annoying issues, which hopefully can be resolved now as=20
there is some ongoing development on the driver again. I have already=20
tested the current "[PATCH v5 0/8] Input: elantech: add support for=20
newer hardware" patchset, but without success.


The device's axis ranges, which are reported to userspace, seem to be=20
totally wrong.

(kernel 3.0.4)
[    17.940] (--) ETPS/2 Elantech Touchpad: x-axis range 8 - 1144
[    17.940] (--) ETPS/2 Elantech Touchpad: y-axis range 8 - 760

(kernel 3.0.4 + patchset)
[    16.936] (--) ETPS/2 Elantech Touchpad: x-axis range 0 - 1152
[    16.936] (--) ETPS/2 Elantech Touchpad: y-axis range 0 - 576

I get the following ranges, when I use synclient in monitor mode to loo=
k=20
which values really are passed to the synaptics driver in X:

(kernel 3.0.4)
x: 0-819
y: 355-760

(kernel 3.0.4 + patchset)
x: 0-819
y: 171-576

Because of this differences the edge/scrolling areas of the touchpad ar=
e=20
calculated wrong and can't be used by default.


The other issue occurs very often when two fingers are used:

(kernel 3.0.4)
     time     x    y   z f  w  l r u d m     multi  gl gm gr gdx gdy
    7.982  1020 -268 127 2  7  0 0 0 0 0  00000000

(kernel 3.0.4 + patchset)
     time     x    y   z f  w  l r u d m     multi  gl gm gr gdx gdy
    3.118  1020 -444 127 2  7  0 0 0 0 0  00000000

When the fingers are released this strange values are reported. This=20
makes two finger scrolling unusable, because it jumps back to the=20
beginning everytime.

--=20
Regards,
Richard Sch=FCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
