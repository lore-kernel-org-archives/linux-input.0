From: =?ISO-8859-15?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Subject: elantech touchpad issues
Date: Sun, 23 Jan 2011 15:12:54 +0100
Message-ID: <4D3C3766.6040805@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout04.t-online.de ([194.25.134.18]:53826 "EHLO
	mailout04.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1AWO3t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Jan 2011 09:29:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I noticed that the elantech driver reports totally wrong axis range=20
values to the xf86-input-synaptics driver for the touchpad in my Samsun=
g=20
N145 Plus netbook.

kernel output:
elantech: assuming hardware version 2, firmware version 4.2.22
elantech: Synaptics capabilities query result 0x09, 0x14, 0x0b.

As it's detected as hardware version 2 the hardcoded ranges from=20
elantech.h are used:
[    16.863] (--) ETPS/2 Elantech Touchpad: x-axis range 8 - 1144
[    16.863] (--) ETPS/2 Elantech Touchpad: y-axis range 8 - 760

But with synclient's monitor mode I discovered that the correct values=20
for my touchpad seem to be:
min x: 0
max x: 819
min y: 355
max y: 760
(without ETP_EDGE_FUZZ_V2)

This results in unusuable edge areas by default.

When using more then one finger on the touchpad also sometimes this=20
strange thing happens and the cursor jumps:
    time     x    y   z f  w  l r u d m     multi  gl gm gr gdx gdy
155.600  1020 -268  31 2  0  0 0 0 0 0  00000000
155.610  1020 -268   0 0  0  0 0 0 0 0  00000000
(the second line is optional)

I guess this would have no effect (like jumping cursor) with correct=20
ranges. Can't they be queried from hardware? I have no clue if these=20
ranges I figured out are valid for my netbook only or if there was a=20
general change in newer firmware versions. Unfortunately, I own no othe=
r=20
hardware for figuring this out. I could patch the driver for my persona=
l=20
need, but I think this should by handled somehow in the driver=20
automatically. If that would not work adequate I would suggest to=20
introduce driver parameters to pass the ranges at runtime without the=20
need for recompiling.

--=20
Regards,
Richard Sch=FCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
