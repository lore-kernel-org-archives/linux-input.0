From: Benjamin Tissoires <tissoire@cena.fr>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Mon, 08 Nov 2010 09:08:50 +0100
Message-ID: <4CD7B012.1030809@cena.fr>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com> <20101108035121.GA4630@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:60587 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab0KHIJR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Nov 2010 03:09:17 -0500
In-Reply-To: <20101108035121.GA4630@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

Le 08/11/2010 04:51, Peter Hutterer a =E9crit :
> fwiw, I'm not sure "arbitrate" is the right word here, filtering seem=
s
> easier to understand in this context. I guess "arbitrate" would apply=
 more
> if we emit the events across multiple devices like in the bamboo case=
=2E
> that's mostly bikeshedding though, my points below apply regardless o=
f what
> word we choose :)
>
> note that we also have two different approaches - single kernel devic=
e or
> multiple kernel devices and depending on the approach the device uses=
 the
> options below have different advantages and disadvantages.
>
> the tablets I've dealt with so far exposed a single event device, so =
that's
> what I'm focusing on in this email.
>
> On Fri, Nov 05, 2010 at 11:47:28AM -0700, Ping Cheng wrote:
>> Recent changes and discussion about MT support at LKML, UDS, and
>> xorg-devel encouraged me to migrate Wacom MT devices to the slot-bas=
ed
>> MT protocol (introduced in kernel 2.6.36). Since Wacom supports both
>> digitizer and touch devices, I need to decide how to report touch da=
ta
>> when the pen is in proximity.
>>
>> My goal is to understand how X server would like the MT data to be
>> reported from the kernel. I hope to keep kernel and X server driver =
MT
>> support in sync so we can avoid unnecessary confusion or extra work =
in
>> the userland.
>>
>> The existing solution for single touch events is to arbitrate touch
>> when pen is in prox. This is based on the assumption that we do not
>> want to have two cursors competing on the screen.
>>
>> With the introduction of MT, the touch data are most likely translat=
ed
>> into something other than pointer events. So, reporting both pen and
>> touch data makes sense now. However, I want to assure a smooth
>> tansition from single touch to MT for end users so they still get th=
e
>> single touch behavior as they used to be. I gathered the following
>> approaches:
>>
>> 1.     Arbitrate all touch data in the kernel.
>>
>> This is the simplest solution for device driver developers. But I do
>> not feel it is end user and userland client friendly.
>
> I'm strongly opposed to this. kernel filtering of these devices is ha=
rd to
> circumvent and there _will_ be use-cases where we need more than one =
tool to
> work simultaneously. right now we're worrying about pen + touch, but =
what
> stops tablets from becoming large enough to be used by 2+ users with =
2+
> pens simultaneously?
>
> from a purely event-stream focused viewpoint: why do we even care whe=
ther
> something is a pen or a touch? both are just tools and how these shou=
ld be
> used is mostly up to the clients anyway.  IMO, the whole point of
> MT_TOOL_TYPE is that we don't have to assume use-cases for the tools =
but
> just forward the information to someone who knows how to deal with th=
is.
>
>> 2.     Report first finger touch as ABS_X/Y events when pen is not i=
n
>> prox.  Arbitrating single touch data when pen is in prox. Pen data i=
s
>> reported as ABS_X/Y events. Both ABS_X/Y for pen or the first finger
>> and ABS_MT_* for MT data are reported.
>>
>> This approach reduces the overhead in dealing with two cursors in us=
erland.
>>
>> 3.    Report first finger touch as ABS_X/Y events when pen is not in=
 prox;
>>         Report pen data as ABS_X/Y events when there is no finger to=
uch;
>>         Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_P=
EN
>> events when both pen and touch data are received. No ABS_X/Y are
>> reported when pen and tocuh or multi-touch data are received.
>>
>> I feel this one makes sense to userland since pen can be considered =
as
>> another touch.
>>
>> 4.    Report first finger touch as ABS_X/Y events when pen is not in=
 prox;
>>         Report pen data as ABS_X/Y events when there is no finger to=
uch;
>>         Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_P=
EN
>> events when both pen and touch data are received. ABS_X/Y are also
>> reported for pen when both pen and tocuh data are received.
>
> I'd vote for this one. It provides all the data necessary for MT clie=
nts
> (and all the data the device can support) but has a reasonable single=
-touch
> strategy. Given that wacom tablets are still primarily pen-centric ta=
blets,
> the emphasis on pen overriding touch makes sense to me.

Hi,

I'd also vote for this.

I don't think that the kernel should make any assumption on the final=20
application. The data are available, so we have to pass them.

1. I read that people worry about sending "false" events (touch) while=20
using the pen. But in my mind, this is a _design_ problem of the final=20
application. I think the final application will have to filter these=20
events: for instance, what happens if the user is too lazy to remove hi=
s=20
pen (or just want to keep the hover on the application) out of the=20
proximity range and want to move its digital sheet of paper in his (her=
)=20
design application? The final application will have to choose whether=20
using or not the touch features (depending on the pressure for instance=
=2E..).

The solution 4. (*technical solution*) addresses the problem of the=20
"false" events for the applications (*design problem*) that are not=20
designed to used multitouch. They will just ignore the touch data.
So I think, it's a good start


2. I would also add that multitouch is not only available for trackpads=
:=20
there are also direct devices in absolute coordinate mode. With those=20
device, the touch data can be directed to an other Xclient that is used=
=20
by an other user if the surface is large enough. Currently we only see=20
relatively small surfaces (bamboo, ntrig devices), but in the future, w=
e=20
can easily imagine a whole table with both pen and touch.

And this solve Michal's problem as he will be able to use buttons in th=
e=20
application with the finger.

Cheers,
Benjamin

>
>> This one makes sense to userland too. It eases the backward
>> compatibility support for those clients that don't support MT at all=
=2E
>>
>> Which approach do you like? Or do you have other suggestions share?
>
> _______________________________________________
> xorg-devel@lists.x.org: X.Org development
> Archives: http://lists.x.org/archives/xorg-devel
> Info: http://lists.x.org/mailman/listinfo/xorg-devel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
