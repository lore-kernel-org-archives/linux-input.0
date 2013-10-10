From: =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2 2/2] input: rotary-encoder: Add 'on-each-step' to
 binding documentation
Date: Thu, 10 Oct 2013 10:55:45 -0300
Message-ID: <CAAEAJfA8iiuT-8k2psXLt5a9fAndwU=_YVR8OXU1Lz1xzZX5pA@mail.gmail.com>
References: <1380891203-17617-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1380891203-17617-3-git-send-email-ezequiel@vanguardiasur.com.ar>
	<20131004131956.GE6999@e106331-lin.cambridge.arm.com>
	<20131004140925.GA27809@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38684 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab3JJNzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 09:55:45 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so2601624pbc.37
        for <linux-input@vger.kernel.org>; Thu, 10 Oct 2013 06:55:45 -0700 (PDT)
In-Reply-To: <20131004140925.GA27809@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On 4 October 2013 11:09, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Fri, Oct 04, 2013 at 02:19:56PM +0100, Mark Rutland wrote:
>> On Fri, Oct 04, 2013 at 01:53:23PM +0100, Ezequiel Garcia wrote:
>> > The driver now supports a new mode to handle the interruptions gen=
erated
>> > by the device: on this new mode an input event is generated on eac=
h step
>> > (i.e. on each IRQ). Therefore, add a new DT property, to select th=
e
>> > mode: 'rotary-encoder,on-each-step'.
>> >
>> > Cc: Daniel Mack <zonque@gmail.com>
>> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> > Cc: Rob Herring <rob.herring@calxeda.com>
>> > Cc: devicetree@vger.kernel.org
>> > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> > ---
>> > I'm not at all happy with this DT binding as it's way to customize=
d
>> > for the current driver. For instance, if we want to support mappin=
g
>> > key events (or better arbitrary linux-input event types) it seems
>> > there's no easy way to fix the binding.
>> >
>> > Maybe a better way of handling the different 'modes' is through
>> > compatible strings?
>>
>> I'd prefer not to have more pseudo-devices in DT, and would prefer n=
ot
>> to have compatible strings that boil down to driver options. We end =
up
>> just embedding a tonne of Linux-specific driver configuration in the=
 DT
>> rather than describing hardware.
>>
>> That said, I'm not sure what the best solution is here.
>>
>> >
>> > I'm not really sure, so I hope the DT guys have some comment on th=
is.
>> >
>> >  Documentation/devicetree/bindings/input/rotary-encoder.txt | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/input/rotary-encode=
r.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> > index 3315495..b89e38d 100644
>> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> > @@ -15,6 +15,7 @@ Optional properties:
>> >  - rotary-encoder,rollover: Automatic rollove when the rotary valu=
e becomes
>> >    greater than the specified steps or smaller than 0. For absolut=
e axis only.
>> >  - rotary-encoder,half-period: Makes the driver work on half-perio=
d mode.
>> > +- rotary-encoder,on-each-step: Makes the driver send an event on =
each step.
>>
>> Could this not be something requested at runtime?
>>
>
> Sure. The different modes:
>
> * default (no option)
> * rotary-encoder,half-period
> * rotary-encoder,on-each-step
>
> Just map to different interruption handlers. I don't have any other
> rotary-encoder device, so I'm not at all sure what's the use of the
> other two cases.
> My particular device is detented, and produces a 'stable' event on ea=
ch
> step (i.e on each IRQ).
>
> Regarding the runtime specification: you mean as a module parameter?
> That should be trivial to add, no?
>
>> Could you explain what you want to achieve with this? -- what events=
 do
>> you want to occur when, to be handled in what way?
>>
>
> Hm.. maybe I should have added the binding to the 1/2 patch and CCed
> everybody involved for better context.
>
> Anyway, I hope the above is clearer, I'm not really sure how to speci=
fy
> the details in the DT binding, since it's a specific interruption han=
dler
> for this class of encoder devices (stable on each step).
>
> That said, I really hope I'm crafting a generic solution and not some
> tailor-made implementation that just happens to match my use case.
>
> The input maintainer's opinion on this would be valuable.

Any insights on this binding?

If nobody objects, then I'd like to get this change accepted,
together with the driver change.

Thanks!
--=20
Ezequiel Garc=EDa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
