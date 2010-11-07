From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sun, 7 Nov 2010 15:49:47 -0800
Message-ID: <AANLkTinR33Y1TKa-=HA87AXkFpGv5Mryap7YoWTPM9kC@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101107163037.GR14865@fooishbar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57282 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab0KGXtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 18:49:49 -0500
Received: by wwb39 with SMTP id 39so3258126wwb.1
        for <linux-input@vger.kernel.org>; Sun, 07 Nov 2010 15:49:47 -0800 (PST)
In-Reply-To: <20101107163037.GR14865@fooishbar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Sun, Nov 7, 2010 at 8:30 AM, Daniel Stone <daniel@fooishbar.org> wro=
te:
>> 1. =A0 =A0 Arbitrate all touch data in the kernel.
>>
>> This is the simplest solution for device driver developers. But I do
>> not feel it is end user and userland client friendly.
>>
>> [...]
>>
>> 3. =A0 =A0Report first finger touch as ABS_X/Y events when pen is no=
t in prox;
>> =A0 =A0 =A0 =A0Report pen data as ABS_X/Y events when there is no fi=
nger touch;
>> =A0 =A0 =A0 =A0Report touch data as MT_TOOL_TOUCH and pen data as MT=
_TOOL_PEN
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

Sorry for the noise (hit a wrong key).

There are two major differences between #1 and #3:

1.   #3 does not report any ABS_XY data when both pen and touch data
are received (#1 still sends pen ABS_X/Y);
2.   #3 sends both pen and touch data as MT events when both types of
data are received (#1 only sends pen data).

Which option do you like? We could go with a simple option. But that
would close the door to those feature rich applications.

Ping

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
