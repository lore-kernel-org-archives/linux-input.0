From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC v2] Another approach to IR
Date: Tue, 1 Dec 2009 11:16:16 -0500
Message-ID: <9e4733910912010816q32e829a2uce180bfda69ef86d@mail.gmail.com>
References: <9e4733910912010708u1064e2c6mbc08a01293c3e7fd@mail.gmail.com>
	 <1259682428.18599.10.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1259682428.18599.10.camel@maxim-laptop>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, mchehab@redhat.com, superm1@ubuntu.com, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 1, 2009 at 10:47 AM, Maxim Levitsky <maximlevitsky@gmail.co=
m> wrote:
> On Tue, 2009-12-01 at 10:08 -0500, Jon Smirl wrote:
>> While reading all of these IR threads another way of handling IR
>> occurred to me that pretty much eliminates the need for LIRC and
>> configuration files in default cases. The best way to make everythin=
g
>> "just work" is to eliminate it.
>>
>> The first observation is that the IR profile of various devices are
>> well known. Most devices profiles are in the published One-for-All
>> database. These device profiles consist of vendor/device/command
>> triplets. There is one triplet for each command like play, pause, 1,
>> 2, 3, power, etc.
>>
>> The second observation is that universal remotes know how to generat=
e
>> commands for all of the common devices.
>>
>> Let's define evdev messages for IR than contain vendor/device/comman=
d
>> triplets. I already posted code for doing that in my original patch
>> set. These messages are generated from in-kernel code.
>>
>> Now add a small amount of code to MythTV, etc to act on these evdev
>> messages. Default MythTV, etc to respond to the IR commands for a
>> common DVR device. Program your universal remote to send the command=
s
>> for this device. You're done. Everything will "just work" - no LIRC,
>> no irrecord, no config files, no command mapping, etc.
> You are making one =A0big wrong assumption that everyone that has a r=
emote
> uses mythtv, and only it.
>
> Many users including me, use the remote just like a keyboard, or even
> like a mouse.

So let's try and figure out a "just works" scheme for doing this. What
I'm trying to do is to get everyone to step back and think about this
problem instead of rushing head long into merging LIRC as is. irrecord
is not something a non-technical user can easily handle.

A basic scheme that can be used to eliminate configuration is to take
well known IR device profiles and emulate them in Linux.  So pick
another well known device to emulate (call it A) and map it to
mouse/keyboard events.  Mapping vendor/device/command codes for a
couple devices to mouse/keyboard events is a tiny amount of data and
can be done in-kernel.

This case could also be made to "just work". Set your universal remote
to device A. Commands from for device A will arrive and be mapped into
generic keyboard/mouse commands.

There are probably other solutions to making IR work without needing
irrecord and configuration. What would be some other possibilities?

Also consider the long term strategy of defining standard device
profiles and getting them into the IR database. Make an IR profile for
mouse/keyboard. After this gets into the database a universal remote
can be set to this profile which will be a better match than emulating
another device.


>
>
>>
>> Of course there are details involved in making this work. MythTV wil=
l
>> have to have a config option to allow it to emulate several differen=
t
>> DVR devices so that you can pick one that you don't own. It should
>> also have choices for emulating the common devices defined for the
>> remotes included with various Linux video board like the Hauppauge
>> remote.
>>
>> For apps that haven't been modified you will have to run a daemon
>> which will capture vendor/device/command evdev events and convert th=
em
>> into keystroke commands than work the menus. You'll need a config fi=
le
>> for this and have to write scripts. Instead I'd just go modify the a=
pp
>> the respond to the IR events, it is easy to do.
>>
>> Long run, we define a MythTV IR profile, mplayer profile, etc and ge=
t
>> these into the IR database for universal remotes. Now MythTV can sto=
p
>> emulating another vendor's device.
>>
>> For the default MythTV case no external support will need to be
>> installed if the protocol decode engines are in the kernel. The raw
>> data will come in, run through the engines, and pop out as evdev
>> messages with a vendor/device/command triplet. Devices that decode i=
n
>> hardware will just send vendor/device/command triplets.
>>
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
