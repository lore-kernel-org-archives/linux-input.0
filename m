From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 1/2] Input: egalax_ts: get gpio from devicetree node
Date: Wed, 8 Aug 2012 13:35:11 +0800
Message-ID: <5021FA8F.5070308@gmail.com>
References: <1344332372-9287-1-git-send-email-jason77.wang@gmail.com> <1344332372-9287-2-git-send-email-jason77.wang@gmail.com> <8CDC3AFB-52FC-40B1-8D83-FBB5C7AD76F7@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38084 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab2HHFft (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 01:35:49 -0400
In-Reply-To: <8CDC3AFB-52FC-40B1-8D83-FBB5C7AD76F7@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing-B33651 <B33651@freescale.com>
Cc: Hui Wang <jason77.wang@gmail.com>, "<dmitry.torokhov@gmail.com>" <dmitry.torokhov@gmail.com>, "<linux-input@vger.kernel.org>" <linux-input@vger.kernel.org>, "<devicetree-discuss@lists.ozlabs.org>" <devicetree-discuss@lists.ozlabs.org>

OK, will add it in the V2.

Thanks,
Hui.

Zhang Jiejing-B33651 wrote:
> Hi Hui,
>
> You patch looks good to me, but can you add a check when it calling t=
he egalax_wake_up_device() function in egalax_ts_probe() ? If some conf=
igure gose wrong, the probe of driver will exit, rather than the suspen=
d failure every time.
>
> BR,
> Jiejing
> =D4=DA 2012-8-7=A3=AC=CF=C2=CE=E75:39=A3=ACHui Wang <jason77.wang@gma=
il.com> =D0=B4=B5=C0=A3=BA
>
>  =20
>> The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework =
and
>> don't support this API anymore.
>>
>> The i.MX6q sabrelite platform equips an egalax touchscreen controlle=
r,
>> and this platform already transfered to GENERIC_GPIO framework, to
>> support this driver, we use a more generic way to get gpio.
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>> drivers/input/touchscreen/egalax_ts.c |   12 ++++++++++--
>> 1 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/t=
ouchscreen/egalax_ts.c
>> index 70524dd..b94eb50 100644
>> --- a/drivers/input/touchscreen/egalax_ts.c
>> +++ b/drivers/input/touchscreen/egalax_ts.c
>> @@ -28,6 +28,7 @@
>> #include <linux/slab.h>
>> #include <linux/bitops.h>
>> #include <linux/input/mt.h>
>> +#include <linux/of_gpio.h>
>>
>> /*
>>  * Mouse Mode: some panel may configure the controller to mouse mode=
,
>> @@ -122,8 +123,15 @@ static irqreturn_t egalax_ts_interrupt(int irq,=
 void *dev_id)
>> /* wake up controller by an falling edge of interrupt gpio.  */
>> static int egalax_wake_up_device(struct i2c_client *client)
>> {
>> -	int gpio =3D irq_to_gpio(client->irq);
>> -	int ret;
>> +	struct device_node *np =3D client->dev.of_node;
>> +	int gpio, ret;
>> +
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	gpio =3D of_get_named_gpio(np, "irq-gpio", 0);
>> +	if (!gpio_is_valid(gpio))
>> +		return -ENODEV;
>>
>> 	ret =3D gpio_request(gpio, "egalax_irq");
>> 	if (ret < 0) {
>> --=20
>> 1.7.6
>>
>>
>>    =20
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
