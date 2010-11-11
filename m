From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 10:23:55 -0800
Message-ID: <AANLkTino03EaUPBe2gDEYHWFYiFwpWx2jjjmH1ExtpOn@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
	<20101109033149.GC19313@barra.redhat.com>
	<AANLkTikDk99ikTYYJDwVzNBSzwMA5sqjXa5v3iqbvfid@mail.gmail.com>
	<20101110044608.GA29110@barra.bne.redhat.com>
	<AANLkTi=NV1u7YtxQZR61-G-C55NioaGpAZFaXupaXszM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63092 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0KKSX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 13:23:58 -0500
Received: by wyb28 with SMTP id 28so984483wyb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 10:23:56 -0800 (PST)
In-Reply-To: <AANLkTi=NV1u7YtxQZR61-G-C55NioaGpAZFaXupaXszM@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Wed, Nov 10, 2010 at 7:57 PM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> On Tue, Nov 9, 2010 at 10:46 PM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
>> On Mon, Nov 08, 2010 at 10:14:56PM -0600, Chris Bagwell wrote:
>>>
>>> I've copied #2 below and added my own text in "[]" to be sure and
>>> clarify text in context of case #2.
>>>
>>> 2. =A0 =A0 Report first finger touch as ABS_X/Y events [on touch in=
put
>>> device] when pen is not in
>>> prox. =A0Arbitrating single touch data [on touch input device] when=
 pen
>>> is in prox. Pen data is
>>> reported as ABS_X/Y events [on pen input device]. Both ABS_X/Y for =
pen
>>> or the first finger
>>> and ABS_MT_* for MT data are reported [each MT send]. =A0[MT are ev=
en
>>> sent on touch device even though only 1 in proximity tool possible =
so
>>> that client can combine both inputs' events and see same behaviour =
as
>>> if it was a single input device.]
>>
>> Assuming a split device - why do any filtering at all?
>> Report ABS_X/Y for pen on the pen device, touch as MT events on the =
touch
>> device _and_ first finger touch as ABS_X/Y on the touch device. If u=
serspace
>> can somehow couple the two devices then it's easy enough to filter t=
ouch
>> events when necessary.
>
> Who is audience of these ABS_X/Y events? =A0We are not sending them f=
or
> MT-aware application benefit. =A0Matter of fact, it slightly complica=
tes
> MT-aware apps because they have to filter them in addition to
> filtering MT events.
>
> The real audience of ABS_X/Y is either older apps or "simple" apps
> (people that chose to keep it simple and not support MT events). =A0T=
his
> class of apps can't really be expected to bind two devices logically
> and mask. =A0So without filtering ABS_X/Y on kernel side, we've
> basically made Bamboo drivers unusable with a range of apps; which
> probably means xf86-input-{evdev|synaptics} (I can't justify adding
> binding logic to those two).

I agree with Chris. Filtering touch ABS_X/Y when pen in prox is
necessary for non-MT aware apps. It also eases backward support.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
