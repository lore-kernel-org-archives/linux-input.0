From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Tue, 15 Dec 2009 15:29:51 -0500
Message-ID: <9e4733910912151229o371ee017tf3640d8f85728011@mail.gmail.com>
References: <4B1B99A5.2080903@redhat.com>
	 <9e4733910912060952h4aad49dake8e8486acb6566bc@mail.gmail.com>
	 <m3skbn6dv1.fsf@intrepid.localdomain>
	 <20091207184153.GD998@core.coreip.homeip.net>
	 <4B24DABA.9040007@redhat.com> <20091215115011.GB1385@ucw.cz>
	 <4B279017.3080303@redhat.com> <20091215195859.GI24406@elf.ucw.cz>
	 <9e4733910912151214n68161fc7tca0ffbf34c2c4e4@mail.gmail.com>
	 <20091215201933.GK24406@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20091215201933.GK24406@elf.ucw.cz>
Sender: linux-media-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Tue, Dec 15, 2009 at 3:19 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2009-12-15 15:14:02, Jon Smirl wrote:
>> On Tue, Dec 15, 2009 at 2:58 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> =A0 =A0 =A0 (11) if none is against renaming IR as RC, I'll do it=
 on a next patch;
>> >
>> > Call it irc -- infrared remote control. Bluetooth remote controls =
will
>> > have very different characteristics.
>>
>> How are they different after the scancode is extracted from the
>> network packet? The scancode still needs to be passed to the input
>> system, go through a keymap, and end up on an evdev device.
>>
>> I would expect the code for extracting the scancode to live in the
>> networking stack, but after it is recovered the networking code woul=
d
>> use the same API as IR to submit it to input.
>
> For one thing, =A0bluetooth (etc) has concept of devices (and reliabl=
e
> transfer). If you have two same bluetooth remotes, you can tell them
> apart, unlike IR.

IR has the same concept of devices. That's what those codes you enter
into a universal remote do - they set the device.

There are three classes of remotes..
=46ixed function - the device is hardwired
Universal - you can change the device
Multi-function - a universal that can be multiple devices - TV, cable,
audio, etc

If you set two Bluetooth remotes both to the same device you can't
tell them apart either.
Two identical fixed function remotes can be distinguished and they
shouldn't be distinguishable.

To distinguish between universal remotes just change the device being e=
mulated.


>
> So yes, keymapping is the same, but that's pretty much it. Decoding
> will not be the same (IR is special), etc...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
