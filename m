From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Sat, 28 Aug 2010 19:07:05 +0200
Message-ID: <75AEF6DA-F09E-4B90-8E89-6F5B668724C9@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>  <1283005748-3293-3-git-send-email-rydberg@euromail.se>  <2A410207-8AAA-4D5A-846A-B69F007E6800@enac.fr> <4C79346F.4050409@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C79346F.4050409@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Le 28 ao=FBt 10 =E0 18:08, Henrik Rydberg a =E9crit :

>
> I think we use the term tracking id differently here. The =20
> HID_DG_CONTACTID is
> actually the slot id, and the tracking id is a sequential number, =20
> increased
> whenever the touch is new. I believe the patchset works correctly =20
> as long as
> there is less than 32768 new touches before releasing the oldest =20
> one. :-)

Oh, right. I definitely need to catch up with Protocol B.

Cheers,

St.
