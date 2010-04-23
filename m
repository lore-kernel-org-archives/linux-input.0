From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 00/15] ir-core: Several improvements to allow adding LIRC
	and decoder plugins
Date: Fri, 23 Apr 2010 14:06:49 -0400
Message-ID: <o2l9e4733911004231106te8b727e9nfa75bfd9c73e9506@mail.gmail.com>
References: <20100401145632.5631756f@pedra>
	 <t2z9e4733911004011844pd155bbe8g13e4cbcc1a5bf1f6@mail.gmail.com>
	 <20100402102011.GA6947@hardeman.nu>
	 <p2ube3a4a1004051349y11e3004bk1c71e3ab38d3f669@mail.gmail.com>
	 <20100407093205.GB3029@hardeman.nu>
	 <z2hbe3a4a1004231040uce51091fnf24b97de215e3ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <z2hbe3a4a1004231040uce51091fnf24b97de215e3ef1@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 23, 2010 at 1:40 PM, Jarod Wilson <jarod@wilsonet.com> wrot=
e:
> On Wed, Apr 7, 2010 at 5:32 AM, David H=E4rdeman <david@hardeman.nu> =
wrote:
>> On Mon, Apr 05, 2010 at 04:49:10PM -0400, Jarod Wilson wrote:
>>> On Fri, Apr 2, 2010 at 6:20 AM, David H=E4rdeman <david@hardeman.nu=
> wrote:
>>> > Porting the msmce driver to rc-core will be high on my list of
>>> > priorities once I've done some more changes to the API.
>>>
>>> Very cool. Though note that the latest lirc_mceusb is quite heavily
>>> modified from what Jon had initially ported, and I still have a few
>>> outstanding enhancements to make, such as auto-detecting xmit mask =
to
>>> eliminate the crude inverted mask list and support for the mce IR
>>> keyboard/mouse, though that'll probably be trivial once RC5 and RC6
>>> in-kernel decoders are in place. I'd intended to start with porting
>>> the imon driver I'm working on over to this new infra (onboard
>>> hardware decoder, should be rather easy to port), and then hop over=
 to
>>> the mceusb driver, but if you beat me to it, I've got no problem wi=
th
>>> you doing it instead. :)
>>
>> I'd be happy with you doing it, you seem to know the hardware better
>> than me. The mceusb driver I'm using right now with ir-core is based=
 on
>> Jon's driver which is in turn based on a version of lirc_mceusb whic=
h is
>> quite old by now. My version of the driver is basically just random =
bits
>> and pieces thrown together, enough to get pulse/space durations flow=
ing
>> through ir-core so that I can test the decoders, but not much more -=
 so
>> it's not something I'd even consider useful as a starting point :)
>
> So now that I'm more or less done with porting the imon driver, I
> think I'm ready to start tackling the mceusb driver. But I'm debating
> on what approach to take with respect to lirc support. It sort of
> feels like we should have lirc_dev ported as an ir "decoder"
> driver/plugin before starting to port mceusb to ir-core, so that we
> can maintain lirc compat and transmit support. Alternatively, I could
> port mceusb without lirc support for now, leaving it to only use
> in-kernel decoding and have no transmit support for the moment, then
> re-add lirc support. I'm thinking that porting lirc_dev as, say,
> ir-lirc-decoder first is probably the way to go though. Anyone else
> want to share their thoughts on this?

I'd take whatever you think is the simplest path. It is more likely
that initial testers will want to work with the new in-kernel system
than the compatibility layer to LIRC. Existing users that are happy
with the current LIRC should just keep on using it.

MSMCE is a good device for debugging protocol engines. It's easy to
use and pretty much always captures the pulses correctly.

>
> (Actually, while sharing thoughts... Should drivers/media/IR become
> drivers/media/RC, ir-core.h become rc-core.h, ir-keytable.c become
> rc-keytable.c and so on?)

Why aren't these files going into drivers/input/rc? My embedded system
has a remote control and it has nothing to do with media.

--=20
Jon Smirl
jonsmirl@gmail.com
