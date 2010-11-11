From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 09:06:14 +0100
Message-ID: <AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
References: <4CD7B012.1030809@cena.fr> <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
 <20101109033149.GC19313@barra.redhat.com> <20101109065933.GA13921@core.coreip.homeip.net>
 <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
 <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
 <20101110050219.GB29110@barra.bne.redhat.com> <4CDA6D25.4070501@euromail.se>
 <20101110235355.GB4473@barra.bne.redhat.com> <4CDB3D6C.2000507@euromail.se> <20101111012251.GC2121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47189 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757771Ab0KKIGh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 03:06:37 -0500
Received: by wyb28 with SMTP id 28so385044wyb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 00:06:36 -0800 (PST)
In-Reply-To: <20101111012251.GC2121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On 11 November 2010 02:22, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 11, 2010 at 01:48:44AM +0100, Henrik Rydberg wrote:
>> On 11/11/2010 12:53 AM, Peter Hutterer wrote:
>>
>> > On Wed, Nov 10, 2010 at 11:00:05AM +0100, Henrik Rydberg wrote:
>> >> A comment on pixels and resolution:
>> >>
>> >> A pen and a thumb may have different resolution (signal-to-noise ratio), but
>> >> there is no reason they cannot be reported on the same scale. In fact, it could
>> >> be argued that it is natural for objects on the same surface to be reported in
>> >> the coordinate system of the surface.
>> >
>> > it may be natural from a human perspective, but the computer doesn't care
>> > about it.
>>
>>
>> The fact that we discuss a computer protocol suggests the computer does care.
>> ;-) The question is whether we need to be able to support different scales for
>> different tools types. I argue that among the three things value range, physical
>> range and SN ratio, the one most naturally seen as an attribute of a tool is the
>> SN ratio.
>>
>> > And given that most input device interpretation is done in
>> > software, the scale used doesn't matter as long as it's correct.
>>
>> > in the UI, even with different ranges for different tools, top-left should
>> > refer to whatever coordinate that is.
>> >
>> > in other words, if the pure numbers matter in the UI, we've done something
>> > wrong.
>>
>> >
>> > what benefit do we get from reporting tools on the same scale if the HW
>> > doesn't do so?
>>
>>
>> The question is, given a set of tool types reported via MT events, what
>> additional information is needed. Having tools share the same ABS axes, I would
>> like to see that as a good thing. So what is missing from that picture?
>
> I think that with devices that share the same working surface with
> different tools (touch/pen) it would make sense to normalize the data in
> the kernel. If for no other reason but to simplify the protocol.
>
> In cases when tools are way to different driver writer might opt to
> export the device as 2 separate logical input devices (and then take
> care of coordinating them in userspace), in other cases treat them as
> one input device and scale to the same range.
>
> I tend to think [at the moment] that the latter would be most sensible
> option for Bamboo...
>

What is the purpose of scaling the inouts to the same range?

Is that a workaround for na issue with current protocol design or does
anybody think that it makes some sort of sense?

I am asking because to me it does not make any sense to scale the values.

Devices that have a touch layer superimposed over LCD screen have to
be calibrated for the system to know which ABS_X/Y corresponds to
which pixel. I suspect that Bamboo P&T may have similar issue with its
two superimposed input devices. Alos somebody suggested that the input
area usable for pen might be smaller than area usable for touch.

This means we are most likely talking apples and oranges, even if we
scale them to be the same size.

So I think it is most sensible to leave the scales are reported by the
hardware because that gives a hint to the application which receives
the event that the inputs are in fact different. They will still be
when the events are scaled, it will be just harder to see from the
client point of view.

Thanks

Michal
