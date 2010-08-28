From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Sat, 28 Aug 2010 18:08:15 +0200
Message-ID: <4C79346F.4050409@euromail.se>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-3-git-send-email-rydberg@euromail.se> <2A410207-8AAA-4D5A-846A-B69F007E6800@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:52973 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752737Ab0H1QIv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Aug 2010 12:08:51 -0400
In-Reply-To: <2A410207-8AAA-4D5A-846A-B69F007E6800@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/28/2010 05:56 PM, St=E9phane Chatty wrote:

>=20
> Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :
>=20
>> The current code sometimes misses to report the last BTN_TOUCH event
>> when multiple fingers are lifted simultaneously.  With the
>> introduction of MT slots, the tracking id is available to determine
>> the oldest active contact.
>=20
> Hi Henrik,
>=20
> good job on exploiting the sync quirk!
>=20
> About the oldest active contact, I'm not so sure though. I don't have=
 the device
> with me but I remember that 3M recycle IDs, giving the lowest availab=
le ID to
> any new finger; this means that the lowest ID is not always the oldes=
t finger.


Hi St=E9phane,

I think we use the term tracking id differently here. The HID_DG_CONTAC=
TID is
actually the slot id, and the tracking id is a sequential number, incre=
ased
whenever the touch is new. I believe the patchset works correctly as lo=
ng as
there is less than 32768 new touches before releasing the oldest one. :=
-)

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
