From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 02/25] HID: multitouch: add support for Nexio 42" panel
Date: Mon, 28 Jan 2013 17:56:24 +0100
Message-ID: <D19C60C9-2701-4229-845A-20E0312F842F@enac.fr>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com> <1359120190-18281-3-git-send-email-benjamin.tissoires@gmail.com> <20130128150129.GA3460@polaris.bitmath.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 88-230.252-81.static-ip.oleane.fr ([81.252.230.88]:39255 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab3A1RDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jan 2013 12:03:43 -0500
In-Reply-To: <20130128150129.GA3460@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Le 28 janv. 2013 =E0 16:01, Henrik Rydberg a =E9crit :

> Hi Benjamin,
>=20
>> This device is the worst device I saw. It keeps TipSwitch and InRang=
e
>> at 1 for fingers that are not touching the panel.
>> The solution is to rely on the field ContactCount, which is accurate
>> as the correct information are packed at the begining of the frame.
>>=20
>> Unfortunately, CountactCount is most of the time at the end of the r=
eport.
>> The solution is to pick it when we have the whole report in raw_even=
t.
>>=20
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> ---
>> drivers/hid/hid-ids.h        |  3 ++
>> drivers/hid/hid-multitouch.c | 91 ++++++++++++++++++++++++++++++++++=
++--------
>> 2 files changed, 78 insertions(+), 16 deletions(-)
>=20
> I think it would make more sense to introduce a method where the
> driver sees all report values at once. We have had reasonable cause t=
o
> add it in the past, but never did.


I dreamed of this more than once in the early days of hid-multitouch, y=
es. But then it requires quite a few changes in hid-core.c, doesn't it?

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
