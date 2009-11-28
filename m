From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Sat, 28 Nov 2009 14:32:46 -0500
Message-ID: <9e4733910911281132m5d0cce31t5544c5a6361813bd@mail.gmail.com>
References: <9e4733910911270757j648e39ecl7487b7e6c43db828@mail.gmail.com>
	 <1259370501.11155.14.camel@maxim-laptop>
	 <m37hta28w9.fsf@intrepid.localdomain>
	 <1259419368.18747.0.camel@maxim-laptop>
	 <m3zl66y8mo.fsf@intrepid.localdomain>
	 <1259422559.18747.6.camel@maxim-laptop>
	 <9e4733910911280845y5cf06836l1640e9fc8b1740cf@mail.gmail.com>
	 <1259433959.3658.0.camel@maxim-laptop>
	 <9e4733910911281056s77e9bc8frd9200a81ebab8d7e@mail.gmail.com>
	 <4B117A4C.1070304@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4B117A4C.1070304@s5r6.in-berlin.de>
Sender: linux-media-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Christoph Bartelmus <christoph@bartelmus.de>, jarod@wilsonet.com, awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Sat, Nov 28, 2009 at 2:30 PM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Jon Smirl wrote:
>> If these drivers are for specific USB devices it is straight forward
>> to turn them into kernel based drivers. If we are going for plug and
>> play this needs to happen. All USB device drivers can be implemented
>> in user space, but that doesn't mean you want to do that. Putting
>> device drivers in the kernel subjects them to code inspection, they
>> get shipped everywhere, they autoload when the device is inserted,
>> they participate in suspend/resume, etc.
>
> Huh? =A0Userspace implementations /can/ be code-reviewed (but they ca=
n't
> crash your machine), they /can/ be and are shipped everywhere, they /=
do/
> auto-load when the device is inserted. =A0And if there should be an i=
ssue
> with power management (is there any?), then improve the ABI and libus=
b
> can surely be improved. =A0I don't see why a device with a userspace
> driver cannot be included in power management.

If you want a micro-kernel there are plenty to pick from. Linux has
chosen not to be a micro-kernel. The Linux model is device drivers in
the kernel.

--=20
Jon Smirl
jonsmirl@gmail.com
