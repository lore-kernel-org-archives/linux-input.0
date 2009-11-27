From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Fri, 27 Nov 2009 14:21:13 -0500
Message-ID: <9e4733910911271121j452aa796j543f1fc3f6de7028@mail.gmail.com>
References: <9e4733910911270757j648e39ecl7487b7e6c43db828@mail.gmail.com>
	 <BDgcsm11qgB@lirc>
	 <9e4733910911270949s3e8b5ba9qfe5025d490ad0cfa@mail.gmail.com>
	 <874oof6b9u.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <874oof6b9u.fsf@tac.ki.iif.hu>
Sender: linux-media-owner@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, christoph@bartelmus.de, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Fri, Nov 27, 2009 at 2:03 PM, Ferenc Wagner <wferi@niif.hu> wrote:
> Jon Smirl <jonsmirl@gmail.com> writes:
>
>> On Fri, Nov 27, 2009 at 12:29 PM, Christoph Bartelmus <lirc@bartelmu=
s.de> wrote:
>>
>>>> Maybe we decide to take the existing LIRC system as is and not
>>>> integrate it into the input subsystem. But I think there is a wind=
ow
>>>> here to update the LIRC design to use the latest kernel features.
>>>
>>> If it ain't broke, don't fix it. =A0[...]
>>>
>>> We already agreed last year that we can include an interface in
>>> lirc_dev that feeds the signal data to an in-kernel decoder if noon=
e
>>> from userspace reads it. =A0[...]
>>>
>>> I also understand that people want to avoid dependency on external
>>> userspace tools. All I can tell you is that the lirc tools already =
do
>>> support everything you need for IR control. And as it includes a lo=
t of
>>> drivers that are implemented in userspace already, LIRC will just c=
ontinue
>>> to do it's work even when there is an alternative in-kernel.
>>
>> Christoph, take what you know from all of the years of working on LI=
RC
>> and design the perfect in-kernel system.
>
> Hi,
>
> I'm reading this thread with great interest. =A0Thank you (plural) fo=
r the
> very informative conversation, I think I learnt a lot. =A0But now I
> somehow lost the point, please correct me if the following is wrong.
>
> It looks like having lirc_dev (or a similar raw interface) is a must.
> It could be disguised as an input device, or changed in various ways,
> but is it worth the effort? =A0As I understand Christoph, he does not=
 want
> to do so, because he finds it wasted work, and also there's already a
> *single* user space daemon using it and doing everything users could
> want. =A0Except for plug&play.

The high level summary:

LIRC has developed it's own way of doing things. It has its own device
protocol, user space daemon, tools, etc. No one is denying that all of
that works.

The alternative is to rework IR to use standard kernel interfaces
(evdev, sysfs, configfs), standard user space tools (udev, ls, mkdir,
cat) and make the daemon optional.

Since IR hasn't been added to the kernel yet we are still free to
design the user space API before locking it in stone for the next
twenty years.


This is an architectural debate, not a debate on specific features.


>
> On the other hand, a one-liner could make in-kernel decoding possible=
,
> so those who haven't got lircd running could have plug&play easily, i=
f
> somebody writes the necessary in-kernel decoders to feed the input
> subsystem (which lircd also does, through uinput).
>
> But even if you can't find anybody at the moment to write those, this=
 is
> still good stuff (I don't know about the code), which is hurt by bein=
g
> developed out of kernel. =A0Is there any reason to keep this so?
> Admittedly, I don't know why /dev/mouse is evil, maybe I'd understand=
 if

/dev/mouse is evil because it is possible to read partial mouse
messages. evdev fixes things so that you only get complete messages.

> somebody pointed me to some reading.
> --
> Thanks,
> Feri.
>



--=20
Jon Smirl
jonsmirl@gmail.com
