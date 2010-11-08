From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Mon, 8 Nov 2010 15:54:51 -0600
Message-ID: <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48421 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab0KHVyw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 16:54:52 -0500
Received: by gyh4 with SMTP id 4so3814841gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 13:54:52 -0800 (PST)
In-Reply-To: <4CD7B012.1030809@cena.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <tissoire@cena.fr>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 8, 2010 at 2:08 AM, Benjamin Tissoires <tissoire@cena.fr> w=
rote:
> Le 08/11/2010 04:51, Peter Hutterer a =E9crit :
>>
>> fwiw, I'm not sure "arbitrate" is the right word here, filtering see=
ms
>> easier to understand in this context. I guess "arbitrate" would appl=
y more
>> if we emit the events across multiple devices like in the bamboo cas=
e.
>> that's mostly bikeshedding though, my points below apply regardless =
of
>> what
>> word we choose :)
>>
>> note that we also have two different approaches - single kernel devi=
ce or
>> multiple kernel devices and depending on the approach the device use=
s the
>> options below have different advantages and disadvantages.
>>
>> the tablets I've dealt with so far exposed a single event device, so
>> that's
>> what I'm focusing on in this email.
>>
>> On Fri, Nov 05, 2010 at 11:47:28AM -0700, Ping Cheng wrote:
>>>
>>> Recent changes and discussion about MT support at LKML, UDS, and
>>> xorg-devel encouraged me to migrate Wacom MT devices to the slot-ba=
sed
>>> MT protocol (introduced in kernel 2.6.36). Since Wacom supports bot=
h
>>> digitizer and touch devices, I need to decide how to report touch d=
ata
>>> when the pen is in proximity.
>>>
>>> My goal is to understand how X server would like the MT data to be
>>> reported from the kernel. I hope to keep kernel and X server driver=
 MT
>>> support in sync so we can avoid unnecessary confusion or extra work=
 in
>>> the userland.
>>>
>>> The existing solution for single touch events is to arbitrate touch
>>> when pen is in prox. This is based on the assumption that we do not
>>> want to have two cursors competing on the screen.
>>>
>>> With the introduction of MT, the touch data are most likely transla=
ted
>>> into something other than pointer events. So, reporting both pen an=
d
>>> touch data makes sense now. However, I want to assure a smooth
>>> tansition from single touch to MT for end users so they still get t=
he
>>> single touch behavior as they used to be. I gathered the following
>>> approaches:
>>>
>>> 1. =A0 =A0 Arbitrate all touch data in the kernel.
>>>
>>> This is the simplest solution for device driver developers. But I d=
o
>>> not feel it is end user and userland client friendly.
>>
>> I'm strongly opposed to this. kernel filtering of these devices is h=
ard to
>> circumvent and there _will_ be use-cases where we need more than one=
 tool
>> to
>> work simultaneously. right now we're worrying about pen + touch, but=
 what
>> stops tablets from becoming large enough to be used by 2+ users with=
 2+
>> pens simultaneously?
>>
>> from a purely event-stream focused viewpoint: why do we even care wh=
ether
>> something is a pen or a touch? both are just tools and how these sho=
uld be
>> used is mostly up to the clients anyway. =A0IMO, the whole point of
>> MT_TOOL_TYPE is that we don't have to assume use-cases for the tools=
 but
>> just forward the information to someone who knows how to deal with t=
his.
>>
>>> 2. =A0 =A0 Report first finger touch as ABS_X/Y events when pen is =
not in
>>> prox. =A0Arbitrating single touch data when pen is in prox. Pen dat=
a is
>>> reported as ABS_X/Y events. Both ABS_X/Y for pen or the first finge=
r
>>> and ABS_MT_* for MT data are reported.
>>>
>>> This approach reduces the overhead in dealing with two cursors in
>>> userland.
>>>
>>> 3. =A0 =A0Report first finger touch as ABS_X/Y events when pen is n=
ot in
>>> prox;
>>> =A0 =A0 =A0 =A0Report pen data as ABS_X/Y events when there is no f=
inger touch;
>>> =A0 =A0 =A0 =A0Report touch data as MT_TOOL_TOUCH and pen data as M=
T_TOOL_PEN
>>> events when both pen and touch data are received. No ABS_X/Y are
>>> reported when pen and tocuh or multi-touch data are received.
>>>
>>> I feel this one makes sense to userland since pen can be considered=
 as
>>> another touch.
>>>
>>> 4. =A0 =A0Report first finger touch as ABS_X/Y events when pen is n=
ot in
>>> prox;
>>> =A0 =A0 =A0 =A0Report pen data as ABS_X/Y events when there is no f=
inger touch;
>>> =A0 =A0 =A0 =A0Report touch data as MT_TOOL_TOUCH and pen data as M=
T_TOOL_PEN
>>> events when both pen and touch data are received. ABS_X/Y are also
>>> reported for pen when both pen and tocuh data are received.
>>
>> I'd vote for this one. It provides all the data necessary for MT cli=
ents
>> (and all the data the device can support) but has a reasonable
>> single-touch
>> strategy. Given that wacom tablets are still primarily pen-centric
>> tablets,
>> the emphasis on pen overriding touch makes sense to me.
>
> Hi,
>
> I'd also vote for this.
>
> I don't think that the kernel should make any assumption on the final
> application. The data are available, so we have to pass them.
>
> 1. I read that people worry about sending "false" events (touch) whil=
e using
> the pen. But in my mind, this is a _design_ problem of the final
> application. I think the final application will have to filter these =
events:
> for instance, what happens if the user is too lazy to remove his pen =
(or
> just want to keep the hover on the application) out of the proximity =
range
> and want to move its digital sheet of paper in his (her) design appli=
cation?
> The final application will have to choose whether using or not the to=
uch
> features (depending on the pressure for instance...).
>
> The solution 4. (*technical solution*) addresses the problem of the "=
false"
> events for the applications (*design problem*) that are not designed =
to used
> multitouch. They will just ignore the touch data.
> So I think, it's a good start
>
>
> 2. I would also add that multitouch is not only available for trackpa=
ds:
> there are also direct devices in absolute coordinate mode. With those
> device, the touch data can be directed to an other Xclient that is us=
ed by
> an other user if the surface is large enough. Currently we only see
> relatively small surfaces (bamboo, ntrig devices), but in the future,=
 we can
> easily imagine a whole table with both pen and touch.
>
> And this solve Michal's problem as he will be able to use buttons in =
the
> application with the finger.
>
> Cheers,
> Benjamin
>
>>
>>> This one makes sense to userland too. It eases the backward
>>> compatibility support for those clients that don't support MT at al=
l.
>>>
>>> Which approach do you like? Or do you have other suggestions share?
>>

I think we may be mixing some topics and so I'd like to try to
re-frame the discussion.

There are two different cases and they may have different answers
because of it.

Case 1) 1 input device can support multiple tools that are in
proximity at same time.

I believe this is currently a theoretical example (no driver exists lik=
e this).

In RFC example, this input devices has a pen and 2 finger touches.
They all share ABS_X/Y/PRESSURE values.  The single touch (ST) input
filtering breaks being able to support this case and what multitouch
events (MT) were added for.

To date, when converting drivers over to MT events the guideline is
*always* send MT events (because what app wants to randomly switch
between MT event processing and ST event processing for same
X/Y/PRESSURE?) and send something sane for ST events to be backwards
compatible with older apps.

I think everyone is happy in this thread to always send pen+touch MT
events and let X drivers or similar filter/arbitrate out unwanted
touch events as needed.

The ideal "sane" behavior for touch ST events has been leaning towards
tracking 1st touch and continue sending 1st touch during multi-touch
but there is some debate because tracking can be expensive in kernel.
In case of pen+touch, the sane may change to prefer pen over touch and
prefer first touch when 2 touches exist.

Or "sane" can mean let the ST values go crazy during multi-touch and
hope user can use GUI enough after new kernel install to get a
MT-aware X driver.

Its easy to implement preferring pen then preferring 1st touch so I
suggest doing that.  This is for backwards compatibility only
(un-modified xf86-input-wacom/synaptics/evdev/etc).  The future is MT
events, in which case the ST events are meaningless and we are hiding
nothing to applications that look at MT events.

Case 2) 2 input devices can support multiple tools in proximity at same=
 time.

I believe it was Rafi that brought up point that dual pen+touch
interfaces will have different properties.  Touch will be lower
resolution then Pen and maybe different fuzz factor.  Also, on tablets
I would think pretty easy to have different dimensions (one tool works
over larger area of tablet).  This is easy to expose to user when 2
input devices.

Combining into single input to user would be nice but at least when
dimensions are different, we probably do not want to remove that
visibility to user and so must keep 2 input devices.

In this case, the RFC example becomes 2 touches on 1 input device and
1 pen on another input device.

So using same MT guidelines, the touch input device would always send
MT events and always send ST events tracking the first touch.

=46or pen input, ST-only events are OK because its not competing with
anything being in proximity at same time.  But we may wish to also
send MT events for this 1 tool/slot as a hint to X drivers that
somehow this input corresponds with another input device and so it
needs to do filtering/arbitration.  We also need to somehow give info
to applications so they can bind these 2 inputs.

Also, non-MT ware drivers are also same apps that will not know how to
bind 2 input devices and so can't filter/arbitrate the unwanted
touches.  So problem, we do want to filter ST events on touch input
when pen is in proximity.

There are lots of things needing to be addressed for this 2nd case so
I'll not really give a personal opinion.  My opinion is likely to
change as we make individual decisions.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
