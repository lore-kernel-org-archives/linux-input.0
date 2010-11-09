From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Mon, 8 Nov 2010 22:14:56 -0600
Message-ID: <AANLkTikDk99ikTYYJDwVzNBSzwMA5sqjXa5v3iqbvfid@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
	<20101109033149.GC19313@barra.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64118 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0KIEO5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 23:14:57 -0500
Received: by ywc21 with SMTP id 21so3966506ywc.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 20:14:56 -0800 (PST)
In-Reply-To: <20101109033149.GC19313@barra.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <tissoire@cena.fr>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 8, 2010 at 9:31 PM, Peter Hutterer <peter.hutterer@who-t.ne=
t> wrote:
> On Mon, Nov 08, 2010 at 03:54:51PM -0600, Chris Bagwell wrote:
>>
>> I think we may be mixing some topics and so I'd like to try to
>> re-frame the discussion.
>>
>> There are two different cases and they may have different answers
>> because of it.
>>
>> Case 1) 1 input device can support multiple tools that are in
>> proximity at same time.
>>
>> I believe this is currently a theoretical example (no driver exists =
like this).
>
> if you consider touch to be just another tool, we already have device=
s that
> support proximity of multiple tools. This isn't theoretical anymore.

Yes, I totally agree there.  I meant more a MT driver with both pen
and touch or really any case were one tool in proximity can invalidate
meaning of other tools in proximity.

2 paragraphs down describes todays 1 input device with MT behaviour.

>
>> In RFC example, this input devices has a pen and 2 finger touches.
>> They all share ABS_X/Y/PRESSURE values. =A0The single touch (ST) inp=
ut
>> filtering breaks being able to support this case and what multitouch
>> events (MT) were added for.
>>
>> To date, when converting drivers over to MT events the guideline is
>> *always* send MT events (because what app wants to randomly switch
>> between MT event processing and ST event processing for same
>> X/Y/PRESSURE?) and send something sane for ST events to be backwards
>> compatible with older apps.
>>
>> I think everyone is happy in this thread to always send pen+touch MT
>> events and let X drivers or similar filter/arbitrate out unwanted
>> touch events as needed.
>>
>> The ideal "sane" behavior for touch ST events has been leaning towar=
ds
>> tracking 1st touch and continue sending 1st touch during multi-touch
>> but there is some debate because tracking can be expensive in kernel=
=2E
>> In case of pen+touch, the sane may change to prefer pen over touch a=
nd
>> prefer first touch when 2 touches exist.
>>
>> Or "sane" can mean let the ST values go crazy during multi-touch and
>> hope user can use GUI enough after new kernel install to get a
>> MT-aware X driver.
>>
>> Its easy to implement preferring pen then preferring 1st touch so I
>> suggest doing that. =A0This is for backwards compatibility only
>> (un-modified xf86-input-wacom/synaptics/evdev/etc). =A0The future is=
 MT
>> events, in which case the ST events are meaningless and we are hidin=
g
>> nothing to applications that look at MT events.
>>
>> Case 2) 2 input devices can support multiple tools in proximity at s=
ame time.
>>
>> I believe it was Rafi that brought up point that dual pen+touch
>> interfaces will have different properties. =A0Touch will be lower
>> resolution then Pen and maybe different fuzz factor. =A0Also, on tab=
lets
>> I would think pretty easy to have different dimensions (one tool wor=
ks
>> over larger area of tablet). =A0This is easy to expose to user when =
2
>> input devices.
>
> Yes and no. We're talking about kernel level here and I don't think t=
his
> should be done at this level. The current behaviour of the X driver i=
s to
> split multiple tools up into multiple X devices, so the points above =
can
> easily be achieved in userspace.
>
>
>> Combining into single input to user would be nice but at least when
>> dimensions are different, we probably do not want to remove that
>> visibility to user and so must keep 2 input devices.
>
> If we run into issues with different axis ranges/resolutions for mult=
iple
> MT_SLOT devices, this should be addressed in the kernel as well.

Yes, that seems a fair statement.

> I feel uncomfortable about splitting up a physical device into multip=
le
> devices, it takes information away that cannot easily be re-created i=
n the
> userspace. Even with a method of associating multiple event devices t=
o the
> same physical device, the parsing of simultaneous events is harder be=
cause
> you're essentially deserialising event streams. In userspace, you hav=
e to
> re-serialize based on parallel inputs.
>
> That said, it also goes counter the whole multi-touch approach - allo=
wing
> more than one device on a single physical device.

Hmm, does this sum up your opinion?  You are a strong proponent of
having all related tools sent over a single input device so you get
natural context of events.  When you do it this way, todays sample MT
implementation for touchpad "just work" for pen+touch as well.  That
behaviour can basically be summed up with "send MT events for all
tools and let clients figure it out.  For older ST events do something
sane to help older apps."

So I get and do agree with that part but you've not clearly stated if
your also saying something like refuse to support split input
solutions and we should fix kernel instead of defining a behaviour for
this case.  If we are forced to support split inputs, I suspect your
basically OK with behaviour #2 because its effectively emulating
single input behaviour as best it can and we are just picking what
"sane" means in this case odd case.

I've copied #2 below and added my own text in "[]" to be sure and
clarify text in context of case #2.

2.     Report first finger touch as ABS_X/Y events [on touch input
device] when pen is not in
prox.  Arbitrating single touch data [on touch input device] when pen
is in prox. Pen data is
reported as ABS_X/Y events [on pen input device]. Both ABS_X/Y for pen
or the first finger
and ABS_MT_* for MT data are reported [each MT send].  [MT are even
sent on touch device even though only 1 in proximity tool possible so
that client can combine both inputs' events and see same behaviour as
if it was a single input device.]

Chris

>
> Cheers,
> =A0Peter
>
>> In this case, the RFC example becomes 2 touches on 1 input device an=
d
>> 1 pen on another input device.
>>
>> So using same MT guidelines, the touch input device would always sen=
d
>> MT events and always send ST events tracking the first touch.
>>
>> For pen input, ST-only events are OK because its not competing with
>> anything being in proximity at same time. =A0But we may wish to also
>> send MT events for this 1 tool/slot as a hint to X drivers that
>> somehow this input corresponds with another input device and so it
>> needs to do filtering/arbitration. =A0We also need to somehow give i=
nfo
>> to applications so they can bind these 2 inputs.
>>
>> Also, non-MT ware drivers are also same apps that will not know how =
to
>> bind 2 input devices and so can't filter/arbitrate the unwanted
>> touches. =A0So problem, we do want to filter ST events on touch inpu=
t
>> when pen is in proximity.
>>
>> There are lots of things needing to be addressed for this 2nd case s=
o
>> I'll not really give a personal opinion. =A0My opinion is likely to
>> change as we make individual decisions.
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
