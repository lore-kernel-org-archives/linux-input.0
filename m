From: Jarod Wilson <jarod@wilsonet.com>
Subject: Re: [PATCH 00/15] ir-core: Several improvements to allow adding LIRC
	and decoder plugins
Date: Mon, 5 Apr 2010 16:49:10 -0400
Message-ID: <p2ube3a4a1004051349y11e3004bk1c71e3ab38d3f669@mail.gmail.com>
References: <20100401145632.5631756f@pedra>
	 <t2z9e4733911004011844pd155bbe8g13e4cbcc1a5bf1f6@mail.gmail.com>
	 <20100402102011.GA6947@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:42423 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab0DEUtN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Apr 2010 16:49:13 -0400
In-Reply-To: <20100402102011.GA6947@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: Jon Smirl <jonsmirl@gmail.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Fri, Apr 2, 2010 at 6:20 AM, David H=E4rdeman <david@hardeman.nu> wr=
ote:
> On Thu, Apr 01, 2010 at 09:44:12PM -0400, Jon Smirl wrote:
>> On Thu, Apr 1, 2010 at 1:56 PM, Mauro Carvalho Chehab
>> <mchehab@redhat.com> wrote:
>> > This series of 15 patches improves support for IR, as discussed at=
 the
>> > "What are the goals for the architecture of an in-kernel IR system=
?"
>> > thread.
>> >
>> > It basically adds a raw decoder layer at ir-core, allowing decoder=
s to plug
>> > into IR core, and preparing for the addition of a lirc_dev driver =
that will
>> > allow raw IR codes to be sent to userspace.
>> >
>> > There's no lirc patch in this series. I have also a few other patc=
hes from
>> > David H=E4rdeman that I'm about to test/review probably later toda=
y, but
>> > as I prefer to first merge what I have at V4L/DVB tree, before app=
lying
>> > them.
>>
>> Has anyone ported the MSMCE driver onto these patches yet? That woul=
d
>> be a good check to make sure that rc-core has the necessary API.
>
> I still plan to make lots of changes to the rc-core API (I just have =
to
> convince Mauro first, but I'll get there). What I have done is to por=
t
> your port of the msmce driver to the suggested rc-core subsystem I se=
nt
> you in private a week or so ago, and it works fine (I've bought the
> hardware and tested it with 20 or so different protocols).
>
> The subsystem I suggested is basically what I'm using as inspiration
> while working with Mauro in improving rc-core so msmce should work we=
ll
> with the end product...but there's still some ground to cover.
>
> Porting the msmce driver to rc-core will be high on my list of
> priorities once I've done some more changes to the API.

Very cool. Though note that the latest lirc_mceusb is quite heavily
modified from what Jon had initially ported, and I still have a few
outstanding enhancements to make, such as auto-detecting xmit mask to
eliminate the crude inverted mask list and support for the mce IR
keyboard/mouse, though that'll probably be trivial once RC5 and RC6
in-kernel decoders are in place. I'd intended to start with porting
the imon driver I'm working on over to this new infra (onboard
hardware decoder, should be rather easy to port), and then hop over to
the mceusb driver, but if you beat me to it, I've got no problem with
you doing it instead. :)

>> Cooler if it works both through LIRC and with an internal protocol
>> decoder. The MSMCE driver in my old patches was very simplified, it
>> removed about half of the code from the LIRC version.
>
> Yes, and it was a great help to me at least...thanks :)

Yeah, copy that. Good to see we've got some major momentum going now,
just need to get off my butt and do some more work on it myself...

--=20
Jarod Wilson
jarod@wilsonet.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
