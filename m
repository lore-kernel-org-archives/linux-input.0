From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 11:01:11 -0800
Message-ID: <AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
References: <20101109033149.GC19313@barra.redhat.com>
	<20101109065933.GA13921@core.coreip.homeip.net>
	<AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
	<AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
	<20101110050219.GB29110@barra.bne.redhat.com>
	<4CDA6D25.4070501@euromail.se>
	<20101110235355.GB4473@barra.bne.redhat.com>
	<4CDB3D6C.2000507@euromail.se>
	<20101111012251.GC2121@core.coreip.homeip.net>
	<AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
	<20101111082653.GC24415@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53437 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0KKTBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 14:01:13 -0500
Received: by wyb28 with SMTP id 28so1018933wyb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 11:01:12 -0800 (PST)
In-Reply-To: <20101111082653.GC24415@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michal Suchanek <hramrach@centrum.cz>, Henrik Rydberg <rydberg@euromail.se>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 12:26 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I do not believe that current protocol design has an issue. MT protoc=
ol
> is really for representing devices reporting multiple touches on the =
same
> working surface which means that size stays the same for all touches.

When we say multiple touches, do we mean multiple touches of the same
type or different types? If we mean different types (pen and finger),
the size could be different due to the differences in technology. For
Bamboo, the size is different for pen and touch.

>> I am asking because to me it does not make any sense to scale the va=
lues.
>>
>> Devices that have a touch layer superimposed over LCD screen have to
>> be calibrated for the system to know which ABS_X/Y corresponds to
>> which pixel. I suspect that Bamboo P&T may have similar issue with i=
ts
>> two superimposed input devices. Alos somebody suggested that the inp=
ut
>> area usable for pen might be smaller than area usable for touch.
>>
>> This means we are most likely talking apples and oranges, even if we
>> scale them to be the same size.
>>
>
> No, I do not believe this is true. Consider touchscreen that you can
> touch with either stylus or finger, with stylus having better
> resolution suited for drawing/writing and finger just used for select=
ing
> UI objects. Obviously they work with the same number of pixels even
> though ranges reported by the hardware might differ.
>
>> So I think it is most sensible to leave the scales are reported by t=
he
>> hardware because that gives a hint to the application which receives
>> the event that the inputs are in fact different. They will still be
>> when the events are scaled, it will be just harder to see from the
>> client point of view.
>
> It really depends on the device in question and we have several optio=
ns:
>
> 1. Single multitouch device - unified working surface with the same
> =A0 characteristics, kernel scales properly.
>
> 2. 2+ logical devices - may have different size/resolutions, userspac=
e
> =A0 will have to do arbitration if they are in the same physical pack=
age.
>
> With Bamboo I think option 1 makes more sense and is easier on everyo=
ne.

I agree with you on "different size/resolutions" and "unified working
surface" for the two opitons above. And I also agree with you that we
should leave the arbitration to the userland for MT events for both
opitons.

But, I think ABS_X/Y arbitration should be considered in the kernel to
reduce the overhead in userland.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
