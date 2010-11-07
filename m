From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sun, 7 Nov 2010 22:07:45 +0100
Message-ID: <AANLkTinrCuAxgX42a=gD3yMVgu84+KrBOWm-4YYJFPav@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com> <20101107163037.GR14865@fooishbar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52374 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0KGVIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 16:08:07 -0500
Received: by wyb36 with SMTP id 36so2835472wyb.19
        for <linux-input@vger.kernel.org>; Sun, 07 Nov 2010 13:08:06 -0800 (PST)
In-Reply-To: <20101107163037.GR14865@fooishbar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input

Hello

On 7 November 2010 17:30, Daniel Stone <daniel@fooishbar.org> wrote:
> Hi,
>
> On Fri, Nov 05, 2010 at 11:47:28AM -0700, Ping Cheng wrote:

>> The existing solution for single touch events is to arbitrate touch
>> when pen is in prox. This is based on the assumption that we do not
>> want to have two cursors competing on the screen.
>
> What do you mean by 'arbitrate' here? I guess you're talking about wh=
ich
> events should send ABS_[XY]?
>
>> 1. =C2=A0 =C2=A0 Arbitrate all touch data in the kernel.
>>
>> This is the simplest solution for device driver developers. But I do
>> not feel it is end user and userland client friendly.
>>
>> [...]
>>
>> 3. =C2=A0 =C2=A0Report first finger touch as ABS_X/Y events when pen=
 is not in prox;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Report pen data as ABS_X/Y events when th=
ere is no finger touch;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Report touch data as MT_TOOL_TOUCH and pe=
n data as MT_TOOL_PEN
>> events when both pen and touch data are received. No ABS_X/Y are
>> reported when pen and tocuh or multi-touch data are received.
>>
>> I feel this one makes sense to userland since pen can be considered =
as
>> another touch.
>
> I'd say that either #1 or #3 is the best idea here, simply because th=
ey
> seem to be the most straightforward, and thus easier to support.
> Assuming that xf86-input-wacom will track the state itself and decide
> (using whatever criteria) which events should send core x/y motion, t=
hen
> all you need to do with ABS_[XY] is just make a best effort to have i=
t
> more or less work for dumb userspace clients.
>

This is horrible.

If I understand this correctly if you use #1 then you can never get
events from both pen and touch. If you use #3 then devices would
suddenly start to send completely different events depending on state
of *other* devices, like if you are moving cursor with the pen and
touch the pad with your hand you create

a) MT even with pen and finger which does not make sense at all

b) out of prox for the ABS device and effectively lose input for non-MT=
 clients

I think that there should be either #1 or separate devices for pen and
touch both with their own ABS events.

In no event should devices report different events at random, decoding
that from the client side would be a nightmare.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
