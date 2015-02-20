From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 15:21:43 -0600
Message-ID: <54E7A567.5030501@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202024.20741@pali> <54E79167.6070701@dell.com> <201502202141.16017@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from AUSXIPPC110.us.dell.com ([143.166.85.200]:59590 "EHLO
	ausxippc110.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbbBTVWB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 16:22:01 -0500
In-Reply-To: <201502202141.16017@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>


On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
> On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
> I have BIOS version A05 on my E6440 machine. That version does
> not have problems with "repeating keys" and my workaround for
> ALPS touchpad (which is in mainline tree and -stable trees now)
> works fine. If I do not see other problems, I will not update
> BIOS (just because current version working -- with workarounds).
>
> But CCing Rob. He told me as first about existence of new BIOS
> version for E6440 and he is already testing new version of BIOS,
> so can share details.
>
> Mario, can you share some details about that new BIOS update? If
> it is not secret, how was problem with "repeating keys" fixed?
> Why linux had more problems as Windows? Cannot we implement some
> "workaround" in linux kernel to prevent that (or similar)
> problems in future?

It's a bit ironic really.  The problem was introduced because a timer w=
as added to the EC last year to fix a key repeating problem found on Wi=
ndows.  In doing so the EC was blocking "BREAK" from being sent to the =
OS.  Windows OS didn't mind this, but Linux did. The fix doesn't block =
BREAK anymore.

> resetafter=3D0 means to never reset (even if driver receive e.g
> thousand invalid packets). I think this is very dangerous if
> there will be other bugs either in linux driver or some other HW
> problems.
>
> For ALPS issue I added resetafter =3D pktsize * 2 (Allow 2 invalid
> packets without resetting device). Cannot you find something
> similar for synaptics touchpads on XPS? (pktsize for ALPS is 6,
> no idea how big are synaptics packets).
I'll take a look and see if there's an upper limit I can find for this =
that works well enough.
> Older Dell HW (laptops, desktops, servers) supported BIOS update
> directly from Linux (ubuntu has needed tools in standard
> repositories). It is not supported/provided anymore? I see that
> dell_rbu driver is still in linux kernel.
>
> dell_rbu.ko:
> description:    Driver for updating BIOS image on DELL systems
Servers can (and I believe still do) use this method.  Latitude, Precis=
ion and XPS 13 (2015) do still support RBU for flashing but the BIOS ex=
ecutables no longer are distributed in a format that the payload can si=
mply be extracted and flashed this way.  The executable supports a vari=
ety of firmware targets and custom builds the payload for the machine i=
t's being executed upon.  Until we have a better method to do something=
 similar to this in Linux, the best bet is to use the F12 BIOS boot men=
u to perform the flash if it's supported on  the given machine.

> There is problem with some synaptics touchpad on some laptops
> (probably not dell). Windows driver loads own firmware into
> synaptics touchpad which use different protocol (as original
> firmware in touchpad). And that loaded firmware is active until
> laptop is not shut down. When you reboot from Windows to Linux
> then linux kernel driver refuse to identify & use touchpad
> because it does not support that new firmware loaded by
> Windows... I do not know lot of about this problem, I just heard
> about it from other people. I did not see any laptop "in action".
>
Ah, so it's a special interface that's implemented in the Synaptics Win=
dows driver.  As described above this sounds like a stop gap type solut=
ion to resolve a field problem until the firmware can be implemented in=
to manufactured parts.  I'd suspect that people who purchased the same =
model of this computer later might run into problems without warm booti=
ng as the firmware got updated into the manufacturer's factory.



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
