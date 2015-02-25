From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Wed, 25 Feb 2015 12:48:55 -0600
Message-ID: <54EE1917.4020805@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202024.20741@pali> <54E79167.6070701@dell.com> <201502202141.16017@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201502202141.16017@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org


On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
> On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
>
> resetafter=3D0 means to never reset (even if driver receive e.g
> thousand invalid packets). I think this is very dangerous if
> there will be other bugs either in linux driver or some other HW
> problems.
>
> For ALPS issue I added resetafter =3D pktsize * 2 (Allow 2 invalid
> packets without resetting device). Cannot you find something
> similar for synaptics touchpads on XPS? (pktsize for ALPS is 6,
> no idea how big are synaptics packets).
>
Pali,

I've done some experimentation with increasing the size to resetafter t=
o up to pktsize * 4.  It will decrease the number of occurrences of thi=
s problem, but the problem still occurs eventually.  pktsize for synapt=
ics is 6 as well.  Would you recommend to continue to go higher than th=
at?  Since out_of_sync_cnt is reset when a full packet gets received, s=
ome arbitrarily high number should likely fix it to.

That being said, if you try to more closely follow what Windows does fo=
r the mouse, it's not issuing a reconnect no matter how much bad data i=
s received.
