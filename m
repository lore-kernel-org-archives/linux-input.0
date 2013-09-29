From: =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 1/1] Input: rotary-encoder: Add 'stepped' irq handler
Date: Sun, 29 Sep 2013 14:29:31 -0300
Message-ID: <CAAEAJfDSW5rgGYXnL2Z_YUKUCVQ82BOg_Q5HtOKKpFvJAs5Qvw@mail.gmail.com>
References: <1380392798-23345-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1380392798-23345-2-git-send-email-ezequiel@vanguardiasur.com.ar>
	<524803A9.5090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:39401 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3I2R3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Sep 2013 13:29:32 -0400
Received: by mail-ve0-f171.google.com with SMTP id pa12so3455202veb.30
        for <linux-input@vger.kernel.org>; Sun, 29 Sep 2013 10:29:31 -0700 (PDT)
In-Reply-To: <524803A9.5090708@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 29 September 2013 07:40, Daniel Mack <zonque@gmail.com> wrote:
> Hi Ezequiel,
>
> On 28.09.2013 20:26, Ezequiel Garcia wrote:
>> Some rotary-encoder devices (such as those with detents) are capable
>> of producing a stable event on each step. This commit adds support
>> for this case, by implementing a new interruption handler.
>>
>> The handler needs only detect the direction of the turn and generate
>> an event according to this detection.
>>
>
>> +static irqreturn_t rotary_encoder_stepped_irq(int irq, void *dev_id=
)
>> +{
>> +     struct rotary_encoder *encoder =3D dev_id;
>> +     int state, sum;
>> +
>> +     state =3D rotary_encoder_get_state(encoder->pdata);
>> +
>> +     /*
>> +      * We encode the previous and the current state,
>> +      * in the 'sum' variable and then use a table
>> +      * to decide the direction of the turn.
>> +      */
>> +     sum =3D (encoder->last_stable << 2) + state;
>> +     switch (sum) {
>> +     case 0b1101:
>> +     case 0b0100:
>> +     case 0b0010:
>> +     case 0b1011:
>
> Binary constants are frowned upon, please avoid them in the kernel.
> checkpatch.pl should have warned you about them as well.
>

Well... despite any checkpatch.pl warnings, I think the above is much c=
lear
to the reader than any alternative. The numbers encode the previous and=
 current
gpio state, so the first two (LSB) bits have the current gpio's, while =
the other
two have the previous.

If binary values should be avoided by all means, then I would prefer to=
 encode
the previous and current in different nibbles:

sum =3D (encoder->last_stable << 4) + state;
switch (sum) {
        case 0x31:
        case 0x10:
        case 0x02:
        case 0x23:

Maybe this is better?

>> diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_e=
ncoder.h
>> index 3f594dc..499f6f7 100644
>> --- a/include/linux/rotary_encoder.h
>> +++ b/include/linux/rotary_encoder.h
>> @@ -11,6 +11,7 @@ struct rotary_encoder_platform_data {
>>       bool relative_axis;
>>       bool rollover;
>>       bool half_period;
>> +     bool on_each_step;
>
> Care to add a DT binding for this property as well?
>

Sure, I was just waiting for your ACK before I did that.

>
> Other than that, this looks good to me, but I can't test it due to th=
e
> lack of hardware.
>

OK.

I'm really curious about the rotary devices you originally used with
this driver.
I guess those have no detents, so there's no mechanical-click on each s=
tep?

Thanks,
--=20
Ezequiel Garc=EDa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
