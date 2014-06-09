From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH v2 1/1] Input: max8997_haptic - Check return values
Date: Mon, 9 Jun 2014 09:32:39 +0530
Message-ID: <CAK5sBcF0B0sgOP5mKZt_8qQk5-1p8aYHgXrhibMo1q83R1nWnA@mail.gmail.com>
References: <1401704643-27846-1-git-send-email-sachin.kamat@linaro.org>
	<20140608061209.GC6982@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:65270 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaFIECl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jun 2014 00:02:41 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so2762788lbj.10
        for <linux-input@vger.kernel.org>; Sun, 08 Jun 2014 21:02:39 -0700 (PDT)
In-Reply-To: <20140608061209.GC6982@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, Donggeun Kim <dg77.kim@samsung.com>

On Sun, Jun 8, 2014 at 11:42 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jun 02, 2014 at 03:54:03PM +0530, Sachin Kamat wrote:
>> Check the return value of regulator_enable and pwm_enable to
>> avoid errors.
>> Fixes the following warning:
>> drivers/input/misc/max8997_haptic.c:185:19: warning: ignoring return=
 value of =E2=80=98regulator_enable=E2=80=99, declared with attribute w=
arn_unused_result [-Wunused-result]
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Donggeun Kim <dg77.kim@samsung.com>
>> ---
>> Changes since v1:
>> * checked the return value of pwm_enable as suggested by Dmitry.
>> * Make chip->enabled =3D true only if enablement is
>> successful.
>> ---
>>  drivers/input/misc/max8997_haptic.c |   17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/mis=
c/max8997_haptic.c
>> index 1fea5484941f..11f4d84625b3 100644
>> --- a/drivers/input/misc/max8997_haptic.c
>> +++ b/drivers/input/misc/max8997_haptic.c
>> @@ -181,11 +181,20 @@ static void max8997_haptic_enable(struct max89=
97_haptic *chip)
>>       }
>>
>>       if (!chip->enabled) {
>> -             chip->enabled =3D true;
>> -             regulator_enable(chip->regulator);
>> +             error =3D regulator_enable(chip->regulator);
>> +             if (error) {
>> +                     dev_err(chip->dev, "Failed to enable regulator=
\n");
>> +                     goto out;
>> +             }
>>               max8997_haptic_configure(chip);
>> -             if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>> -                     pwm_enable(chip->pwm);
>> +             if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
>> +                     error =3D pwm_enable(chip->pwm);
>> +                     if (error) {
>> +                             dev_err(chip->dev, "Failed to enable P=
WM\n");
>
> I think we should also disable regulator here, I'll add it.

Right. Thanks for fixing it, Dmitry.

Regards,
Sachin.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
