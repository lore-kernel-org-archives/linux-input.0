From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Sat, 14 Mar 2015 15:17:25 -0400
Message-ID: <CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
	<201502202141.16017@pali>
	<54EE1917.4020805@dell.com>
	<201502252145.22577@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201502252145.22577@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Jason Ekstrand <jason@jlekstrand.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

[top posting, sorry]

Jason made some interesting progress today:
with the patch in https://lkml.org/lkml/2015/3/12/149, the sound card
is not switched in the I2S mode and works while the touchpad keeps
using I2C.
It looks like suspend/resume is also fixed by that :)

I thought it was worth mentioning to the people in this thread.

Cheers,
Benjamin

On Wed, Feb 25, 2015 at 3:45 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Wednesday 25 February 2015 19:48:55 Mario Limonciello wrote:
>> On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
>> > On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
>> >
>> > resetafter=3D0 means to never reset (even if driver receive
>> > e.g thousand invalid packets). I think this is very
>> > dangerous if there will be other bugs either in linux
>> > driver or some other HW problems.
>> >
>> > For ALPS issue I added resetafter =3D pktsize * 2 (Allow 2
>> > invalid packets without resetting device). Cannot you find
>> > something similar for synaptics touchpads on XPS? (pktsize
>> > for ALPS is 6, no idea how big are synaptics packets).
>>
>> Pali,
>>
>> I've done some experimentation with increasing the size to
>> resetafter to up to pktsize * 4.  It will decrease the number
>> of occurrences of this problem, but the problem still occurs
>> eventually.  pktsize for synaptics is 6 as well.  Would you
>> recommend to continue to go higher than that?  Since
>> out_of_sync_cnt is reset when a full packet gets received,
>> some arbitrarily high number should likely fix it to.
>>
>> That being said, if you try to more closely follow what
>> Windows does for the mouse, it's not issuing a reconnect no
>> matter how much bad data is received.
>
> I believe problem is similar to one as with ALPS devices. Driver
> always receive 6 bytes packet of data (no new byte is inserted
> and no byte is never lost), just one byte in packet is incorrect
> (does not match specification).
>
> Setting resetafter to > 0 prevent problems when driver enters
> into undefined state (either by bug in driver of other SW/HW
> problem). So I think setting resetafter to 0 is not good idea.
>
> But if we know that setting resetafter to 4*pktsize is not enough
> (e.g. with experimenting you saw that driver received more then 4
> invalid packets consecutively), set it to higher value.
>
> I think it is still good idea to ignore maximally as many packets
> which can be received in time which is equal to resetting device.
>
> E.g. when period of time in which we are dropping all packets is
> higher then time needed to reset touchpad, we should stop
> dropping packets and immediately reset touchpad. In this case we
> could hit maybe problem in driver (there can be bugs) or touchpad
> is in some bad state and out-of-sync...
>
> So if your tests show that there are never invalid 10 packets
> consecutively, then set resetafter to 10 packets. Value 10 is
> still not high and if it fix problem with touchpad I think it is
> acceptable. But rather ask Dmitry what he thinks about it. This
> is just my opinion.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
