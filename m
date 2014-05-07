From: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [PATCH] input: rotary encoder: implement quarter period mode
Date: Wed, 7 May 2014 11:51:31 -0300
Message-ID: <CAAEAJfC3a6F3xORs9+-8q1vqAdbO=b8fA1QiUgEXC3GpdNeDpw@mail.gmail.com>
References: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
	<20140507144543.GE27177@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140507144543.GE27177-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 7 May 2014 11:45, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Dec 18, 2013 at 02:43:18PM +0000, Sascha Hauer wrote:
>> Some rotary encoders have a stable state in all output state
>> combinations. Add support for this type of encoder.
>>
>> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
>> Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> ---
>>  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
>>  Documentation/input/rotary-encoder.txt             |  9 +++++--
>>  drivers/input/misc/rotary_encoder.c                | 30 +++++++++++=
+++++++++--
>>  include/linux/rotary_encoder.h                     |  1 +
>>  4 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.=
txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> index 3315495..cbdb29b 100644
>> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> @@ -15,6 +15,7 @@ Optional properties:
>>  - rotary-encoder,rollover: Automatic rollove when the rotary value =
becomes
>>    greater than the specified steps or smaller than 0. For absolute =
axis only.
>>  - rotary-encoder,half-period: Makes the driver work on half-period =
mode.
>> +- rotary-encoder,quarter-period: Makes the driver work on quarter-p=
eriod mode.
>
> The new property looks as sane to me as the half-period property, so =
for
> the binding addition:
>
> Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>

Thanks!

> As a general nitpick it would be nicer if the binding didn't refer to
> the driver and had a description of {half,quarter} period modes inlin=
e,
> but that might be a bit tricky and shouldn't block this.
>

I can submit a follow-up patch to clean the binding. It shouldn't be
too hard to re-phrase
the properties so it's clear it's a hardware property.

Dmitry, Do you think you can merge this for v3.16? I've posted a
completely equivalent
patch a while ago [1], which was acked by Daniel, but it was never
merged. Sascha's patch
looks fine as well:

Acked-by: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>

[1] https://lkml.org/lkml/2013/10/4/167
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
