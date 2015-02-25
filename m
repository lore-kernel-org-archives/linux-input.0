From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [SUSPECT SPAM] Re: [PATCH] Add a quirk for the Dell XPS 13 (2015)
 when in PS/2 mode.
Date: Wed, 25 Feb 2015 12:16:57 -0600
Message-ID: <54EE1199.3090501@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502221755.05587@pali> <54EBB868.2040405@dell.com> <201502240101.45446@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201502240101.45446@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org


On 02/23/2015 06:01 PM, Pali Roh=C3=A1r wrote:
> On Tuesday 24 February 2015 00:31:52 Mario Limonciello wrote:
> For older dell models (some old inspirions and maybe also
> latitude) it was possible to use undocumented DELLDIAG interface
> (which enter into SMM mode and call some functions) to enable
> that "RAW" mode.
>
> Now when you are discussing with us, do you have some information
> or can you comment (if it is not secret) that DELLDIAG SMM
> interface?
>
> In linux kernel we have for it driver (provides info about
> temperature, fan speed, power management, hotkeys, ...), but it
> use undocumented interface (and sometimes it has problems):
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
drivers/char/i8k.c
I don't have any more information I can share on this interface other t=
han I wouldn't recommend to rely on it.  It's generally not supposed to=
 be used by the OS but only for diagnostic purposes from BIOS level dia=
gnostic tools.
> Nothing new. It is that problem with repeating keys which is
> fixed by last version of BIOS.
>
> I saw one E6440 model with preinstalled Ubuntu 12.04.2 and
> distributed with A08 BIOS (which had that problem). And this was
> very very annoying! You could imagine it, you buy new Latitude
> (business class pro notebook), you started it and on preinstalled
> OS, keyboard is not usable. Updating to A10 fixed it.
>

I'm sorry that this had actually made it out the door with a pre-instal=
led machine, but I'm glad we were able to get it fixed in the field.

> In this forum thread people reported that "repeating keys"
> problem for more models: http://en.community.dell.com/support-forums/=
laptop/f/3518/t/19593360?pi239031352=3D19
Yes, there is a support agent in that thread relaying those models to t=
he BIOS team.
> And it looks like (from what I'm reading) last version A10 of
> E6440 BIOS broke USB3.0 support.
>
