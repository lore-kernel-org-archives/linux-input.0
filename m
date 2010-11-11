From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Wed, 10 Nov 2010 21:57:34 -0600
Message-ID: <AANLkTi=NV1u7YtxQZR61-G-C55NioaGpAZFaXupaXszM@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
	<20101109033149.GC19313@barra.redhat.com>
	<AANLkTikDk99ikTYYJDwVzNBSzwMA5sqjXa5v3iqbvfid@mail.gmail.com>
	<20101110044608.GA29110@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33237 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab0KKD5f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 22:57:35 -0500
Received: by gxk23 with SMTP id 23so931348gxk.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 19:57:34 -0800 (PST)
In-Reply-To: <20101110044608.GA29110@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <tissoire@cena.fr>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Nov 9, 2010 at 10:46 PM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Mon, Nov 08, 2010 at 10:14:56PM -0600, Chris Bagwell wrote:
>>
>> I've copied #2 below and added my own text in "[]" to be sure and
>> clarify text in context of case #2.
>>
>> 2. =A0 =A0 Report first finger touch as ABS_X/Y events [on touch inp=
ut
>> device] when pen is not in
>> prox. =A0Arbitrating single touch data [on touch input device] when =
pen
>> is in prox. Pen data is
>> reported as ABS_X/Y events [on pen input device]. Both ABS_X/Y for p=
en
>> or the first finger
>> and ABS_MT_* for MT data are reported [each MT send]. =A0[MT are eve=
n
>> sent on touch device even though only 1 in proximity tool possible s=
o
>> that client can combine both inputs' events and see same behaviour a=
s
>> if it was a single input device.]
>
> Assuming a split device - why do any filtering at all?
> Report ABS_X/Y for pen on the pen device, touch as MT events on the t=
ouch
> device _and_ first finger touch as ABS_X/Y on the touch device. If us=
erspace
> can somehow couple the two devices then it's easy enough to filter to=
uch
> events when necessary.

Who is audience of these ABS_X/Y events?  We are not sending them for
MT-aware application benefit.  Matter of fact, it slightly complicates
MT-aware apps because they have to filter them in addition to
filtering MT events.

The real audience of ABS_X/Y is either older apps or "simple" apps
(people that chose to keep it simple and not support MT events).  This
class of apps can't really be expected to bind two devices logically
and mask.  So without filtering ABS_X/Y on kernel side, we've
basically made Bamboo drivers unusable with a range of apps; which
probably means xf86-input-{evdev|synaptics} (I can't justify adding
binding logic to those two).

I think we also have some high level agreements that we should combine
input devices in kernel long term with minor technical decisions to be
made.  So that makes any logical binding code in xf86-input-*
transitional only.

So by masking in kernel for these special pen+touch 2 input case, its
simple, keeps Bamboo/Ntrig usable with existing
xf86-input-{evdev|synaptics|wacom} and keeps user land from writing
that transitional logic.

>
> Don't report pen as the only MT set on the pen device, that's just
> confusing.

Yeah, agree.  Its mainly only if it solves some large applications
binding issues but thats theoretically right now.  No real need to do
it.

>
> Does this answer your question?

Yes.  Thanks.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
