From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 16:31:23 -0500
Message-ID: <CAN+gG=F6TyoOb=nNeBAsdh7RrEUWoeJtznTY4YNmr3UGxQ1Hjg@mail.gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
	<201502202024.20741@pali>
	<54E79167.6070701@dell.com>
	<201502202141.16017@pali>
	<54E7A567.5030501@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E7A567.5030501@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 20, 2015 at 4:21 PM, Mario Limonciello
<mario_limonciello@dell.com> wrote:
>
> On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
>>
[snipped]
>
>> There is problem with some synaptics touchpad on some laptops
>> (probably not dell). Windows driver loads own firmware into
>> synaptics touchpad which use different protocol (as original
>> firmware in touchpad). And that loaded firmware is active until
>> laptop is not shut down. When you reboot from Windows to Linux
>> then linux kernel driver refuse to identify & use touchpad
>> because it does not support that new firmware loaded by
>> Windows... I do not know lot of about this problem, I just heard
>> about it from other people. I did not see any laptop "in action".
>>
> Ah, so it's a special interface that's implemented in the Synaptics W=
indows
> driver.  As described above this sounds like a stop gap type solution=
 to
> resolve a field problem until the firmware can be implemented into
> manufactured parts.  I'd suspect that people who purchased the same m=
odel of
> this computer later might run into problems without warm booting as t=
he
> firmware got updated into the manufacturer's factory.
>
>

What is most likely happening is that the synaptics driver switches
the touchpad into the i2c/hid protocol. And yes Synaptics told us that
only a reset re-enables the touchpad in the PS/2 mode.
Kernels 3.11 and later know how to deal with this mode (through
hid-rmi), so we should not see these problems in the future unless
hid-rmi is not compiled in the running kernel.

=46ortunately, we can deal with the Dell/Synaptics touchpads, the Lenov=
o
ones are using SMBus, and we have never been able to talk to the
devices with SMBus :(

Cheers,
Benjamin
