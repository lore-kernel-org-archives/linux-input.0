From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 0/2] autodetection of multitouch devices
Date: Wed, 28 Sep 2011 22:32:26 +0200
Message-ID: <D3E37531-860E-415F-B2B9-58CEBB4E10A3@enac.fr>
References: <1316617015-11648-1-git-send-email-benjamin.tissoires@gmail.com> <alpine.LNX.2.00.1109261419330.13109@pobox.suse.cz> <20110926144635.GA6921@polaris.bitmath.org> <alpine.LNX.2.00.1109261644250.24692@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 88-230.252-81.static-ip.oleane.fr ([81.252.230.88]:48238 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab1I1Ujq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Sep 2011 16:39:46 -0400
In-Reply-To: <alpine.LNX.2.00.1109261644250.24692@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, USB list <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org


Le 26 sept. 2011 =E0 16:47, Jiri Kosina a =E9crit :

> On Mon, 26 Sep 2011, Henrik Rydberg wrote:
>=20
>>>> These two patches finally enable the kernel to handle multitouch d=
evices correctly.
>>>> If a device presents in its report descriptors the usage Contact I=
D, then it is considered as
>>>> a multitouch device and handled by hid-multitouch.
>>>=20
>>> Hi Banjamin,
>>>=20
>>> thanks a lot for working on this. I have now queued the patches in =
my=20
>>> tree.
>>=20
>> Hi Benjamin,
>>=20
>> Late as it seems, here are a couple of questions:
>>=20
>> 1. How was this tested? By removing all white-listed devices in
>> hid-multitouch.c to see if the usual suspects are still picked up?
>=20
> If we didn't have full test coverage (which I suppose to be the case)=
, we=20
> can still revert to the old method after the merge window if there re=
ports=20
> that this broke things on particular devices.
>=20
> Do you guys at least have report descriptor dumps from most of the=20
> supported devices?


Yes, we have report descriptors for about 20-30 different models now, a=
nd about 10 actual devices for testing purposes. Unfortunately, this st=
ill does not tell us exactly how all these devices manage to work with =
the same Win 7 driver, given their diversity. We are getting close, but=
 just not yet.

BTW we gladly accept to receive sample panels from vendors, this usuall=
y ensures fast support. Additionally, the panels are then reused by ENA=
C students in their projects, so this stimulates the market of multitou=
ch devices in aviation :-)

Cheers,

St.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
