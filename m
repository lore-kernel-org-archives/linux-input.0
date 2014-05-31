From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] Input: max8997_haptic - Check return value of regulator_enable
Date: Sat, 31 May 2014 12:29:15 +0530
Message-ID: <CAK9yfHzOYV=7sULeC0KzDTutPNbGvHtyqXrOmR2-FCX98c4FDg@mail.gmail.com>
References: <1401446173-21981-1-git-send-email-sachin.kamat@linaro.org>
	<20140530200526.GB27692@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:41507 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbaEaG7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 May 2014 02:59:15 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so2742675obc.28
        for <linux-input@vger.kernel.org>; Fri, 30 May 2014 23:59:15 -0700 (PDT)
In-Reply-To: <20140530200526.GB27692@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

- Donggeun (as his mail bounces)

 Hi Dmitry,

On 31 May 2014 01:35, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote=
:
> Hi Sachin,
>
> On Fri, May 30, 2014 at 04:06:13PM +0530, Sachin Kamat wrote:
>> Fixes the following warning:
>> drivers/input/misc/max8997_haptic.c:185:19: warning: ignoring return=
 value of =E2=80=98regulator_enable=E2=80=99, declared with attribute w=
arn_unused_result [-Wunused-result]
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Donggeun Kim <dg77.kim@samsung.com>
>> ---
>>  drivers/input/misc/max8997_haptic.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/mis=
c/max8997_haptic.c
>> index 1fea5484941f..4f4c34e135f5 100644
>> --- a/drivers/input/misc/max8997_haptic.c
>> +++ b/drivers/input/misc/max8997_haptic.c
>> @@ -182,7 +182,11 @@ static void max8997_haptic_enable(struct max899=
7_haptic *chip)
>>
>>       if (!chip->enabled) {
>>               chip->enabled =3D true;
>> -             regulator_enable(chip->regulator);
>> +             error =3D regulator_enable(chip->regulator);
>> +             if (error) {
>> +                     dev_err(chip->dev, "Failed to enable regulator=
");
>> +                     goto out;
>
> We should not be leaving with chip->enabled =3D=3D true in this case.

Right.

>
>> +             }
>>               max8997_haptic_configure(chip);
>>               if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>>                       pwm_enable(chip->pwm);
>
> What about checking this one as well?

OK.

 ---
With warm regards,
Sachin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
