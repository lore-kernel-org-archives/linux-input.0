From: =?ISO-8859-1?Q?Fabien_Andr=E9?= <andre@lii-enac.fr>
Subject: Re: Can I limit the scope of an input device to specific processes ?
Date: Thu, 30 Jan 2014 15:42:29 +0100
Message-ID: <CAM18vYqvbVuSMSfASfuEpTS7fg9LhbkRwKZhwKkwL09MrsNyLA@mail.gmail.com>
References: <S1754733AbaA1IxR/20140128085317Z+41@vger.kernel.org>
	<52E78481.6040606@UKE.Uni-Hamburg.de>
	<CANq1E4ReNtJgC7zArLo=Bo87YZXOukFTTuxjYf_nupfmUkCL+A@mail.gmail.com>
	<52E7A24E.20601@UKE.Uni-Hamburg.de>
	<CANq1E4TUjuB9yfu5U0NJx97ysmNOo+7aeFSFYQgxi+eTu_PYQA@mail.gmail.com>
	<52E8CD67.4010705@UKE.Uni-Hamburg.de>
	<CAM18vYqBk7_WrUsdNQq7fjuPC1cm0vb1KTmJW7877OyYFeKj0g@mail.gmail.com>
	<52EA1A94.8090300@UKE.Uni-Hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:60807 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbaA3Oma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 09:42:30 -0500
Received: by mail-ob0-f181.google.com with SMTP id va2so3496933obc.26
        for <linux-input@vger.kernel.org>; Thu, 30 Jan 2014 06:42:30 -0800 (PST)
In-Reply-To: <52EA1A94.8090300@UKE.Uni-Hamburg.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: R.Zimmermann@uke.uni-hamburg.de, xorg@lists.x.org
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org

Hi Roger,


On Thu, Jan 30, 2014 at 10:25 AM, Dr. Zimmermann
<R.Zimmermann@uke.uni-hamburg.de> wrote:
> Or is there a better forum to ask about X (input) stuff?

xorg list (added) would definitely be a better place to discuss this to=
pic.

> that looks promising: I was able to separate our response-box-keyboar=
ds from
> the core keyboard so that pressed (response-)keys are no longer trans=
mitted
> by default anymore.
>
> Can You shortly point me to the next steps necessary?
> -> Create e new core pointer/keyboard pair and connect the
> reponse-box-keyboard to it?
>

The next steps would be to read events through xinput, that is,
instead of consuming event from your GUI toolkit, retrieve them
directly from X. ( It may exist supporting tool for that).
Main steps are
 * retrieve a display, (XOpenDisplay)
 * retrieve your device based on name (oR id),  (XIQueryDevice )
 * bind your display with some events of your device, (XISetMask,
XISelectEvents )
 * retrieve a file descriptor for your display event, feed your
mainloop with this file descriptor (ConnectionNumber)
 * read and decode event (XPending, XNextEvent, XGetEventData)

Here is an example tool relaying xinput events to a software bus you
may find interseting to throw a glance:
http://svn.tls.cena.fr/wsvn/ivy/xinput2-ivy/trunk/xinput2_ivy.c

I do not see the need for another pointer/keyboard (that would not be
core by the way) unless you use a tool that support multiple keyboard
(I know of no such tool).

Regards,
=46abien


On Thu, Jan 30, 2014 at 10:25 AM, Dr. Zimmermann
<R.Zimmermann@uke.uni-hamburg.de> wrote:
> Am 29.01.2014 13:31, schrieb Fabien Andr=E9:
>
>> An alternative to X config file is the xinput command line tool
>>
>> $> xinput list
>> to get the name and id of your device
>> $>xinput float NAME_OR_ID
>> to "detach" the device from the virtual core keyboard
>> (the name will be stable while id can change after unplug or restart=
, thus
>> name is a better candidate for scripting)
>
>
> Hi Fabien,
>
> that looks promising: I was able to separate our response-box-keyboar=
ds from
> the core keyboard so that pressed (response-)keys are no longer trans=
mitted
> by default anymore.
>
> Can You shortly point me to the next steps necessary?
> -> Create e new core pointer/keyboard pair and connect the
> reponse-box-keyboard to it?
>
> Or is there a better forum to ask about X (input) stuff?
>
> Thanx, Roger
>
>>
>>
>>
>> On Wed, Jan 29, 2014 at 10:44 AM, Dr. Zimmermann <
>> R.Zimmermann@uke.uni-hamburg.de> wrote:
>>
>>> Am 28.01.2014 13:49, schrieb David Herrmann:
>>>
>>>> Hi
>>>>
>>>>   Hi David,
>>>
>>>
>>>   On Tue, Jan 28, 2014 at 1:27 PM, Dr. Zimmermann
>>>>
>>>> <R.Zimmermann@uke.uni-hamburg.de> wrote:
>>>>
>>>>> Am 28.01.2014 12:15, schrieb David Herrmann:
>>>>>
>>>>>   Hi
>>>>>>
>>>>>>
>>>>>> On Tue, Jan 28, 2014 at 11:20 AM, Dr. Zimmermann
>>>>>> <R.Zimmermann@uke.uni-hamburg.de> wrote:
>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> we've got a special type of keyboard which should only be avail=
able
>>>>>>> in
>>>>>>> one
>>>>>>> specific process and not publicly, as usually keyboards are.
>>>>>>>
>>>>>>> Is it possible to limit the scope of a specific keyboard?
>>>>>>>
>>>>>>> Or is there a more suited forum where to ask?
>>>>>>>
>>>>>>
>>>>>
>>>>> Hi David,
>>>>>
>>>>>
>>>>>
>>>>>> There is no such interface in the kernel. However, with careful
>>>>>> access-management, you can get what you want by just allowing yo=
ur
>>>>>> single process access to the device. But I guess you are working=
 with
>>>>>> an X11 system, so a description of what you actually want to ach=
ieve
>>>>>> would help a lot.
>>>>>>
>>>>>
>>>>>
>>>>> Thnx for Your quick reply.
>>>>>
>>>>> (Yes, we are using X. No, the problem is not specific to X: It'll=
 also
>>>>> occur
>>>>> when You switch between system consoles.)
>>>>>
>>>>
>>>> Just don't use the system-console for that. It's not intended for =
that
>>>> purpose and no-one will enhance it to do device-separation (why wo=
uld
>>>> you.. it's mainly meant as system-administrator fallback). But see
>>>> below..
>>>>
>>>
>>> We've never intended to use it for our purposes, still the effect t=
hat
>>> we've got is the same than under X.
>>>
>>>
>>>>   For research purposes we are measuring human brain activity unde=
r the
>>>>>
>>>>> influence of external stimuli (visual/auditory/somatosensory). Th=
e
>>>>> subject
>>>>> has to reply to tasks using 'button boxes' which are implemented =
as
>>>>> keyboards. Usually, type and time of the buttonpress are of impor=
tance
>>>>> (and
>>>>> will probably change further procedere). Keyboard responses usual=
ly go
>>>>> to
>>>>> that window (or system console) which has the current focus or is
>>>>> active
>>>>> and
>>>>> *this* is something, we do not want.
>>>>>
>>>>> Sometimes we show visual stimuli on one screen(#1) and operate th=
e
>>>>> system
>>>>> from another screen(#2). Sometimes we even have no visual stimuli=
 at
>>>>> all,
>>>>> but like to read subject responses and control the stimuli from w=
ithin
>>>>> a
>>>>> control window. In all cases it would be helpful if the response-=
boxes
>>>>> would
>>>>> not automatically send their output to the active window resp.
>>>>> application.
>>>>>
>>>>> Helpful would be, if the output of the response-box-keyboards
>>>>> * could be restricted to a specific process
>>>>> * is not sent automatically, but only to a program which 'opened'=
 the
>>>>> device
>>>>> * is not sent automatically, but has to be read from a device.
>>>>> (Could this be done preserving the exact timepoint of each
>>>>> buttonpress?)
>>>>>
>>>>
>>>> First of all, nothing is "sent automatically". Processes have to r=
ead
>>>> the events from the kernel, so point #3 doesn't make much sense to=
 me.
>>>>
>>>
>>> Think of me as quite unaware in these matters. I'm seeing this 'sig=
nal'
>>> (keyboard events) distributed by default to every application which=
 gets
>>> active/the focus.
>>>
>>>   But regarding your issue: You should simply configure you xserver=
 to
>>>>
>>>> not use the devices in question. Add an X11 config to
>>>> /etc/X11/xorg.conf.d/50-ignore-custom-devices.conf which contains
>>>> something like:
>>>>
>>>> Section "InputClass"
>>>>       Identifier "Custom Input Blacklist"
>>>>       MatchProduct "<Product-Name-of-Your-Device>"
>>>>       MatchDevicePath "/dev/input/event*"
>>>>       Option "Ignore" "on"
>>>> EndSection
>>>>
>>>> You can read the product-name of your device via: `cat
>>>> /sys/class/input/input<num>/name`
>>>> where "input<num>" is your device in question.
>>>>
>>>> This will cause the Xserver to stop using your input devices and n=
o
>>>> window will get any events from them. Now you can program your cus=
tom
>>>> applications to open the correct devices manually and reading even=
ts
>>>> from them. However, this requires modifications to these applicati=
ons.
>>>> But if you just want your xserver to route specific events to spec=
ific
>>>> processes, your applications must be XInput2-aware/capable.
>>>>
>>>> Instructing the kernel to route specific events to specific proces=
ses
>>>> is the wrong approach here (except regarding the linux-console, wh=
ich
>>>> is special but *really* shouldn't be used for such stuff). The ker=
nel
>>>> does not care for policy but only provides hardware-abstraction. I=
t's
>>>> up to your applications to use the correct X11 APIs to only read
>>>> events from specific XInput2-devices. So the correct people to ask
>>>> about this are actually the developers of your applications and th=
e
>>>> X11 people. The kernel, by default, restricts input-device access =
to
>>>> root, so basically *no* user gets input access. The X-Server now
>>>> applies some default policies on these devices to route events to =
X11
>>>> applications. By default, hot-plugging is enabled in new X-Servers=
 and
>>>> all devices are markes as Master devices. This means, their events=
 are
>>>> broad-casted to all X11 windows. If you don't want that, you can m=
ark
>>>> devices as "Floating", which means, the device will not broadcast
>>>> events, but use the XInput API to report input events. Only
>>>> applications which use XInput can now request events from the devi=
ce.
>>>>
>>>> You can mark devices as floating via:
>>>> Section "InputClass"
>>>>       Identifier "Custom Input Blacklist"
>>>>       MatchProduct "<Product-Name-of-Your-Device>"
>>>>       MatchDevicePath "/dev/input/event*"
>>>>       Option "Floating" "on"
>>>> EndSection
>>>>
>>>> Also see "man xorg.conf" and search for "Floating".
>>>>
>>>
>>> Thanks for this explanation. It helped a lot and I now see, which '=
path'
>>> to go on...
>>>
>>>>
>>>> I hope that helps! I it's still unclear, let me know.
>>>> As a side-note, please always put the mailing-lists on CC. I'm not
>>>> doing that myself now, as I don't know whether you excluded them o=
n
>>>> purpose. But if you start a discussion on the mailing-list, you sh=
ould
>>>> keep it there so other people can comment, too. Most mail-clients
>>>> provide the "reply to all" feature to do that automatically.
>>>>
>>> My mailer didn't do it correctly. But short time after the mail to =
You,
>>> the same mail was sent to the list manually...
>>>
>>>>
>>>> Thanks
>>>> David
>>>>
>>>
>>> Thanks again & Regards,
>>> Roger
>>>
>>>   .
>>>>
>>>>
>>>>
>>> --
>>>
>>> Besuchen Sie uns auf: www.uke.de
>>> ___________________________________________________________________=
__
>>>
>>> Universit=E4tsklinikum Hamburg-Eppendorf; K=F6rperschaft des =F6ffe=
ntlichen
>>> Rechts; Gerichtsstand: Hamburg
>>> Vorstandsmitglieder: Prof. Dr. Christian Gerloff (Vertreter des
>>> Vorsitzenden), Prof. Dr. Dr. Uwe Koch-Gromus, Joachim Pr=F6l=DF, Ra=
iner
>>> Schoppik
>>> ___________________________________________________________________=
__
>>>
>>> SAVE PAPER - THINK BEFORE PRINTING
>>>
>>
>
> --
>
> Besuchen Sie uns auf: www.uke.de
> _____________________________________________________________________
>
> Universit=E4tsklinikum Hamburg-Eppendorf; K=F6rperschaft des =F6ffent=
lichen
> Rechts; Gerichtsstand: Hamburg
> Vorstandsmitglieder: Prof. Dr. Christian Gerloff (Vertreter des
> Vorsitzenden), Prof. Dr. Dr. Uwe Koch-Gromus, Joachim Pr=F6l=DF, Rain=
er Schoppik
> _____________________________________________________________________
>
> SAVE PAPER - THINK BEFORE PRINTING
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
