From: "Dr. Zimmermann" <R.Zimmermann@UKE.Uni-Hamburg.de>
Subject: Re: Can I limit the scope of an input device to specific processes
 ?
Date: Wed, 29 Jan 2014 10:44:07 +0100
Message-ID: <52E8CD67.4010705@UKE.Uni-Hamburg.de>
References: <S1754733AbaA1IxR/20140128085317Z+41@vger.kernel.org> <52E78481.6040606@UKE.Uni-Hamburg.de> <CANq1E4ReNtJgC7zArLo=Bo87YZXOukFTTuxjYf_nupfmUkCL+A@mail.gmail.com> <52E7A24E.20601@UKE.Uni-Hamburg.de> <CANq1E4TUjuB9yfu5U0NJx97ysmNOo+7aeFSFYQgxi+eTu_PYQA@mail.gmail.com>
Reply-To: <R.Zimmermann@UKE.Uni-Hamburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------090705090509090106040106"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iplexus2.uke.uni-hamburg.de ([134.100.102.33]:10904 "EHLO
	IPLEXUS2.uke.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750829AbaA2JoK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 04:44:10 -0500
In-Reply-To: <CANq1E4TUjuB9yfu5U0NJx97ysmNOo+7aeFSFYQgxi+eTu_PYQA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

--------------090705090509090106040106
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Am 28.01.2014 13:49, schrieb David Herrmann:
> Hi
>
Hi David,

> On Tue, Jan 28, 2014 at 1:27 PM, Dr. Zimmermann
> <R.Zimmermann@uke.uni-hamburg.de> wrote:
>> Am 28.01.2014 12:15, schrieb David Herrmann:
>>
>>> Hi
>>>
>>> On Tue, Jan 28, 2014 at 11:20 AM, Dr. Zimmermann
>>> <R.Zimmermann@uke.uni-hamburg.de> wrote:
>>>>
>>>> Hi,
>>>>
>>>> we've got a special type of keyboard which should only be available in
>>>> one
>>>> specific process and not publicly, as usually keyboards are.
>>>>
>>>> Is it possible to limit the scope of a specific keyboard?
>>>>
>>>> Or is there a more suited forum where to ask?
>>
>>
>> Hi David,
>>
>>>
>>> There is no such interface in the kernel. However, with careful
>>> access-management, you can get what you want by just allowing your
>>> single process access to the device. But I guess you are working with
>>> an X11 system, so a description of what you actually want to achieve
>>> would help a lot.
>>
>>
>> Thnx for Your quick reply.
>>
>> (Yes, we are using X. No, the problem is not specific to X: It'll also o=
ccur
>> when You switch between system consoles.)
>
> Just don't use the system-console for that. It's not intended for that
> purpose and no-one will enhance it to do device-separation (why would
> you.. it's mainly meant as system-administrator fallback). But see
> below..

We've never intended to use it for our purposes, still the effect that =

we've got is the same than under X.

>
>> For research purposes we are measuring human brain activity under the
>> influence of external stimuli (visual/auditory/somatosensory). The subje=
ct
>> has to reply to tasks using 'button boxes' which are implemented as
>> keyboards. Usually, type and time of the buttonpress are of importance (=
and
>> will probably change further procedere). Keyboard responses usually go to
>> that window (or system console) which has the current focus or is active=
 and
>> *this* is something, we do not want.
>>
>> Sometimes we show visual stimuli on one screen(#1) and operate the system
>> from another screen(#2). Sometimes we even have no visual stimuli at all,
>> but like to read subject responses and control the stimuli from within a
>> control window. In all cases it would be helpful if the response-boxes w=
ould
>> not automatically send their output to the active window resp. applicati=
on.
>>
>> Helpful would be, if the output of the response-box-keyboards
>> * could be restricted to a specific process
>> * is not sent automatically, but only to a program which 'opened' the de=
vice
>> * is not sent automatically, but has to be read from a device.
>> (Could this be done preserving the exact timepoint of each buttonpress?)
>
> First of all, nothing is "sent automatically". Processes have to read
> the events from the kernel, so point #3 doesn't make much sense to me.

Think of me as quite unaware in these matters. I'm seeing this 'signal' =

(keyboard events) distributed by default to every application which gets =

active/the focus.

> But regarding your issue: You should simply configure you xserver to
> not use the devices in question. Add an X11 config to
> /etc/X11/xorg.conf.d/50-ignore-custom-devices.conf which contains
> something like:
>
> Section "InputClass"
>      Identifier "Custom Input Blacklist"
>      MatchProduct "<Product-Name-of-Your-Device>"
>      MatchDevicePath "/dev/input/event*"
>      Option "Ignore" "on"
> EndSection
>
> You can read the product-name of your device via: `cat
> /sys/class/input/input<num>/name`
> where "input<num>" is your device in question.
>
> This will cause the Xserver to stop using your input devices and no
> window will get any events from them. Now you can program your custom
> applications to open the correct devices manually and reading events
> from them. However, this requires modifications to these applications.
> But if you just want your xserver to route specific events to specific
> processes, your applications must be XInput2-aware/capable.
>
> Instructing the kernel to route specific events to specific processes
> is the wrong approach here (except regarding the linux-console, which
> is special but *really* shouldn't be used for such stuff). The kernel
> does not care for policy but only provides hardware-abstraction. It's
> up to your applications to use the correct X11 APIs to only read
> events from specific XInput2-devices. So the correct people to ask
> about this are actually the developers of your applications and the
> X11 people. The kernel, by default, restricts input-device access to
> root, so basically *no* user gets input access. The X-Server now
> applies some default policies on these devices to route events to X11
> applications. By default, hot-plugging is enabled in new X-Servers and
> all devices are markes as Master devices. This means, their events are
> broad-casted to all X11 windows. If you don't want that, you can mark
> devices as "Floating", which means, the device will not broadcast
> events, but use the XInput API to report input events. Only
> applications which use XInput can now request events from the device.
>
> You can mark devices as floating via:
> Section "InputClass"
>      Identifier "Custom Input Blacklist"
>      MatchProduct "<Product-Name-of-Your-Device>"
>      MatchDevicePath "/dev/input/event*"
>      Option "Floating" "on"
> EndSection
>
> Also see "man xorg.conf" and search for "Floating".

Thanks for this explanation. It helped a lot and I now see, which 'path' =

to go on...
>
> I hope that helps! I it's still unclear, let me know.
> As a side-note, please always put the mailing-lists on CC. I'm not
> doing that myself now, as I don't know whether you excluded them on
> purpose. But if you start a discussion on the mailing-list, you should
> keep it there so other people can comment, too. Most mail-clients
> provide the "reply to all" feature to do that automatically.
My mailer didn't do it correctly. But short time after the mail to You, =

the same mail was sent to the list manually...
>
> Thanks
> David

Thanks again & Regards,
Roger
> .
>

--

Besuchen Sie uns auf: www.uke.de
_____________________________________________________________________

Universit=E4tsklinikum Hamburg-Eppendorf; K=F6rperschaft des =F6ffentlichen=
 Rechts; Gerichtsstand: Hamburg
Vorstandsmitglieder: Prof. Dr. Christian Gerloff (Vertreter des Vorsitzende=
n), Prof. Dr. Dr. Uwe Koch-Gromus, Joachim Pr=F6l=DF, Rainer Schoppik
_____________________________________________________________________

SAVE PAPER - THINK BEFORE PRINTING

--------------090705090509090106040106
Content-Type: text/x-vcard; charset="utf-8"; name="R_Zimmermann.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="R_Zimmermann.vcf"

begin:vcard
fn:Dr. Roger Zimmermann
n:Zimmermann;Dr. Roger
org;quoted-printable;quoted-printable:Zentrum f=C3=BCr exp. Medizin;Institut f=C3=BCr Neuro- und Pathophysiologie
adr;quoted-printable:;;Martinistra=C3=9Fe 52;Hamburg;;20246;Germany
email;internet:R.Zimmermann@UKE.Uni-Hamburg.de
tel;work:..49 (0)40 42803 5351
tel;fax:..49 (0)40 42803 7255
x-mozilla-html:FALSE
url:http://www.uke.uni-hamburg.de
version:2.1
end:vcard


--------------090705090509090106040106--

