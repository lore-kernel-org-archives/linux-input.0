From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH] Input: mma8450: add device tree probe support
Date: Fri, 29 Jul 2011 11:00:15 +0800
Message-ID: <CAMPhdO-VbfQoLXpNLDBTW=rKkvPmUF6YRA6HVeNjsmSE5ob1Gg@mail.gmail.com>
References: <1311265551-23233-1-git-send-email-shawn.guo@linaro.org> <20110729023855.GC1946@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:32772 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab1G2DAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 23:00:36 -0400
Received: by vws1 with SMTP id 1so2651130vws.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 20:00:35 -0700 (PDT)
In-Reply-To: <20110729023855.GC1946@S2100-06.ap.freescale.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-input@vger.kernel.org, patches@linaro.org, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, Sammy He <r62914@freescale.com>

On Fri, Jul 29, 2011 at 10:38 AM, Shawn Guo <shawn.guo@freescale.com> w=
rote:
> Any comments?
>

Shawn,

Patch looks OK to me.

> Regards,
> Shawn
>
> On Fri, Jul 22, 2011 at 12:25:51AM +0800, Shawn Guo wrote:
>> It adds device tree probe support for mma8450 driver.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sammy He <r62914@freescale.com>
>> Cc: Eric Miao <eric.miao@linaro.org>
>> Cc: Dmitry Torokhov <dtor@mail.ru>
>> ---
>> =C2=A0.../devicetree/bindings/input/fsl-mma8450.txt =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 11 +++++++++++
>> =C2=A0drivers/input/misc/mma8450.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 ++++++++
>> =C2=A02 files changed, 19 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 Documentation/devicetree/bindings/input/fsl=
-mma8450.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/fsl-mma8450.txt=
 b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
>> new file mode 100644
>> index 0000000..a00c94c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
>> @@ -0,0 +1,11 @@
>> +* Freescale MMA8450 3-Axis Accelerometer
>> +
>> +Required properties:
>> +- compatible : "fsl,mma8450".
>> +
>> +Example:
>> +
>> +accelerometer: mma8450@1c {
>> + =C2=A0 =C2=A0 compatible =3D "fsl,mma8450";
>> + =C2=A0 =C2=A0 reg =3D <0x1c>;
>> +};
>> diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma84=
50.c
>> index 20f8f92..6c76cf7 100644
>> --- a/drivers/input/misc/mma8450.c
>> +++ b/drivers/input/misc/mma8450.c
>> @@ -24,6 +24,7 @@
>> =C2=A0#include <linux/delay.h>
>> =C2=A0#include <linux/i2c.h>
>> =C2=A0#include <linux/input-polldev.h>
>> +#include <linux/of_device.h>
>>
>> =C2=A0#define MMA8450_DRV_NAME =C2=A0 =C2=A0 "mma8450"
>>
>> @@ -229,10 +230,17 @@ static const struct i2c_device_id mma8450_id[]=
 =3D {
>> =C2=A0};
>> =C2=A0MODULE_DEVICE_TABLE(i2c, mma8450_id);
>>
>> +static const struct of_device_id mma8450_dt_ids[] =3D {
>> + =C2=A0 =C2=A0 { .compatible =3D "fsl,mma8450", },
>> + =C2=A0 =C2=A0 { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mma8450_dt_ids);
>> +
>> =C2=A0static struct i2c_driver mma8450_driver =3D {
>> =C2=A0 =C2=A0 =C2=A0 .driver =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D MM=
A8450_DRV_NAME,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D TH=
IS_MODULE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D mma8=
450_dt_ids,
>> =C2=A0 =C2=A0 =C2=A0 },
>> =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mm=
a8450_probe,
>> =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __devex=
it_p(mma8450_remove),
>> --
>> 1.7.4.1
>>
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
