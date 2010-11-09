From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Tue, 9 Nov 2010 12:10:26 -0800
Message-ID: <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
	<20101109033149.GC19313@barra.redhat.com>
	<20101109065933.GA13921@core.coreip.homeip.net>
	<AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55862 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab0KIUK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 15:10:29 -0500
Received: by ewy7 with SMTP id 7so3871220ewy.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 12:10:27 -0800 (PST)
In-Reply-To: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Tue, Nov 9, 2010 at 8:28 AM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> On Tue, Nov 9, 2010 at 12:59 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, Nov 09, 2010 at 01:31:49PM +1000, Peter Hutterer wrote:
>>>
>>> That said, it also goes counter the whole multi-touch approach - al=
lowing
>>> more than one device on a single physical device.
>>>
>>
>> So maybe we should teach wacom to handle all devices as a single inp=
ut device even
>> in cases when they use several USB interfaces? We should be able to
>> detect related interfaces by examining intf->intf_assoc (I hope) and
>> using usb_driver_claim_interface() to claim them.
>
> Thanks for tips. =A0I may try it just to prove its possible.
>
> Here is extra info on resolution/dimension issue to also solve when
> combining. =A0Taken from current logic on touch input of Wacom Bamboo=
:
>
> input_mt_create_slots(input_dev, 2);
> input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, features->x_max=
,
> features->x_fuzz, 0);
>
> Combining 2 inputs means MT slots increases from 2 to 3 (2 touches an=
d
> 1 stylus).
>
> Today, Pen has x_max=3D17420, x_fuzz=3D4 and resolution of 2540. =A0A=
lso
> today, Touch has x_max=3D15360, x_fuzz=3D128 and resolution=3Ddunno (=
we are
> scaling up touch x_max in driver and I haven't calculated its affects
> on resolution).
>
> I believe that a normalized value of x_max would show that there is a
> greater area of tablet can be used for touch then pen.

Normalization can be a way to address this issue. But, I am not sure
if we want normalization in the kernel. You are onto the right point
though. How are we going to pass the different resolution and x/y_max
with the same SLOT array? This is an issue we can not avoid for serial
MT devices since all data are from the same interface (your case #1).

The USB case (your case #2) can work around it since pen and touch are
on different logical port. But, I think we want to have an unified
approach for both serial and USB to avoid userland inconsistency. What
I did in the current code is to report touch x/y_max through ABS_RX/Y
so we don't step on ABS_X/Y for serial devices.

I know there are people don't like this idea either. So, any more sugge=
stions?

Specifying individual resolution and x/y_max for each MT slot is
another way to address this issue. But that requires MT implementation
and (maybe) spec change.

Thank you for thinking out loud. I am sure you understood why I
haven't picked up that Bamboo for so long ;).

Ping

> To handle this difference, we can scale reported values in driver suc=
h
> that x_max=3Dx_max for all slots. =A0I'm not clear on fuzz logic so d=
on't
> know what 4 vs 128 does.
>
> Or we can maybe update MT interface so you can have per slot values
> for clients to query (or MT logic automatically scales for driver as
> another option). =A0Then slots 0-1 are reserved for touch and slot 3 =
is
> reserved for pen.
>
> Chris
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
