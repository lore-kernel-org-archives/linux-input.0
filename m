From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 3/3] input: rotary-encoder: Support 'steps-per-period' DT property
Date: Thu, 15 Oct 2015 15:49:07 -0300
Message-ID: <CAAEAJfBPhLGr1Ge-ssWjHZedxVkeFhxm+a-cbraqRqBLT2TVmg@mail.gmail.com>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1444398416-3073-4-git-send-email-ezequiel@vanguardiasur.com.ar>
	<20151014065518.GG20406@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34791 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbbJOStJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 14:49:09 -0400
Received: by lfaz124 with SMTP id z124so42111937lfa.1
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2015 11:49:07 -0700 (PDT)
In-Reply-To: <20151014065518.GG20406@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

On 14 October 2015 at 03:55, Dmitry Torokhov <dmitry.torokhov@gmail.com=
> wrote:
> On Fri, Oct 09, 2015 at 10:46:56AM -0300, Ezequiel Garcia wrote:
>> As per the recent devicetree binding changes, this commit adds the
>> support for the new 'steps-per-period' property.
>>
>> Legacy properties to specify the rotary behavior, are now deprecated
>> and instead the new 'steps-per-period' is supported. The default beh=
avior
>> is retained.
>>
>> This allows to support rotary-encoder devices with detents wich are =
capable
>> of producing a stable event on each step.
>>
>> Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>>  drivers/input/misc/rotary_encoder.c | 87 ++++++++++++++++++++++++++=
+++++++++--
>>  include/linux/rotary_encoder.h      |  2 +-
>>  2 files changed, 84 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/mis=
c/rotary_encoder.c
>> index 15a4cc670a3f..e021615dd3c0 100644
>> --- a/drivers/input/misc/rotary_encoder.c
>> +++ b/drivers/input/misc/rotary_encoder.c
>> @@ -142,6 +142,55 @@ static irqreturn_t rotary_encoder_half_period_i=
rq(int irq, void *dev_id)
>>       return IRQ_HANDLED;
>>  }
>>
>> +static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void =
*dev_id)
>> +{
>> +     struct rotary_encoder *encoder =3D dev_id;
>> +     unsigned char sum;
>> +     int state;
>> +
>> +     state =3D rotary_encoder_get_state(encoder->pdata);
>> +
>> +     /*
>> +      * We encode the previous and the current state using a byte.
>> +      * The previous state in the MSB nibble, the current state in =
the LSB
>> +      * nibble. Then use a table to decide the direction of the tur=
n.
>> +      */
>> +     sum =3D (encoder->last_stable << 4) + state;
>> +     switch (sum) {
>> +     case 0x31:
>> +     case 0x10:
>> +     case 0x02:
>> +     case 0x23:
>> +             encoder->dir =3D 0; /* clockwise */
>> +             break;
>> +
>> +     case 0x13:
>> +     case 0x01:
>> +     case 0x20:
>> +     case 0x32:
>> +             encoder->dir =3D 1; /* counter-clockwise */
>> +             break;
>> +
>> +     default:
>> +             /*
>> +              * Ignore all other values. This covers the case when =
the
>> +              * state didn't change (a spurious interrupt) and the
>> +              * cases where the state changed by two steps, making =
it
>> +              * impossible to tell the direction.
>> +              *
>> +              * In either case, don't report any event and save the
>> +              * state for later.
>> +              */
>> +             goto out;
>> +     }
>> +
>> +     rotary_encoder_report_event(encoder);
>> +
>> +out:
>> +     encoder->last_stable =3D state;
>> +     return IRQ_HANDLED;
>> +}
>> +
>>  #ifdef CONFIG_OF
>>  static const struct of_device_id rotary_encoder_of_match[] =3D {
>>       { .compatible =3D "rotary-encoder", },
>> @@ -176,7 +225,26 @@ static struct rotary_encoder_platform_data *rot=
ary_encoder_parse_dt(struct devic
>>
>>       pdata->relative_axis =3D of_property_read_bool(np, "rotary-enc=
oder,relative-axis");
>>       pdata->rollover =3D of_property_read_bool(np, "rotary-encoder,=
rollover");
>> -     pdata->half_period =3D of_property_read_bool(np, "rotary-encod=
er,half-period");
>> +
>> +     if (!of_get_property(np, "rotary-encoder,steps-per-period", NU=
LL)) {
>> +             /*
>> +              * Fallback to a one step per period behavior if the
>> +              * 'steps-per-period' is not set.
>> +              */
>> +             pdata->steps_per_period =3D 1;
>> +     } else {
>> +             of_property_read_u32(np, "rotary-encoder,steps-per-per=
iod",
>> +                                  &pdata->steps_per_period);
>> +     }
>> +
>> +     /*
>> +      * The 'half-period' property has been deprecated, you must us=
e
>> +      * 'steps-per-period' and set an appropriate value.
>> +      */
>> +     if (of_get_property(np, "rotary-encoder,half-period", NULL)) {
>> +             pr_warn(FW_WARN "\"rotary-encoder,half-period\" is dep=
recated\n");
>> +             pdata->steps_per_period =3D 2;
>> +     }
>
> Hmm, I do not think we need to warn about old DTSes if we consider th=
em
> ABI. How about if we parse like this:
>
>         error =3D of_property_read_u32(np, "rotary-encoder,steps-per-=
period",
>                                      &pdata->steps_per_period);
>         if (error) {
>                 /*
>                  * The 'half-period' property has been deprecated, yo=
u must use
>                  * 'steps-per-period' and set an appropriate value, b=
ut we still
>                  * need to parse it to maintain compatibility.
>                  */
>                 if (of_property_read_bool(np, "rotary-encoder,half-pe=
riod")) {
>                         pdata->steps_per_period =3D 2;
>                 } else {
>                         /* Fallback to a one step per period behavior=
 */
>                         pdata->steps_per_period =3D 1;
>                 }
>         }
>
>
> (no need to resubmit if you are OK with this).
>

Looks good to me. Feel free to pick the patches and amend them
as above.

Thanks a lot!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
