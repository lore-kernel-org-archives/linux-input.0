From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] input: touchscreen: add OF match table for ads7846
Date: Mon, 13 Jun 2011 16:15:26 +0800
Message-ID: <BANLkTimxhKWg1QwLEFpGKgg01DRkddmmTw@mail.gmail.com>
References: <1307672920-6261-1-git-send-email-Baohua.Song@csr.com> <BANLkTinTGHpyzg69OTcvmsGVLGK3qbZM7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64950 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1FMIPr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 04:15:47 -0400
Received: by bwz15 with SMTP id 15so3517883bwz.19
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2011 01:15:46 -0700 (PDT)
In-Reply-To: <BANLkTinTGHpyzg69OTcvmsGVLGK3qbZM7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Thomas Chou <thomas@wytron.com.tw>, devicetree-discuss@lists.ozlabs.org, Zhiwu Song <zhiwu.song@csr.com>, uclinux-dist-devel@blackfin.uclinux.org

Hi Grant,
Thanks.

2011/6/13 Grant Likely <grant.likely@secretlab.ca>:
> On Thu, Jun 9, 2011 at 8:28 PM, Barry Song <Baohua.Song@csr.com> wrot=
e:
>> The current ads7846 has no OF match table. The method used is by app=
lying a heuristic (of_modalias_node) which tries to name the device in =
a way that will match an existing device driver.
>> This patch adds explicit OF match table for ads7846, then the normal=
 device tree match behaviour will always work.
>> It has been tested on PRIMA2 EVB board of CSR with a SPI's child nod=
e like the below:
>> ts@0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D "ti,ads7845";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D <0x0>;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spi-max-frequency =3D <31250>;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D <90>;
>> };
>>
>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> cc: Thomas Chou <thomas@wytron.com.tw>
>> ---
>> =C2=A0drivers/input/touchscreen/ads7846.c | =C2=A0 14 ++++++++++++++
>
> There should also be documentation for the new binding added to
> Documentation/devicetree/bindings for the new compatible strings.

Which directory do you think is the best to place this document? or do
we build a new diretory named
Documentation/devicetree/bindings/input/touchscreen/ ?
The dir Documentation/devicetree/bindings seems to be for spi host,
not for spi clients.

>
>> =C2=A01 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/tou=
chscreen/ads7846.c
>> index 5196861..643138b 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -28,6 +28,7 @@
>> =C2=A0#include <linux/slab.h>
>> =C2=A0#include <linux/pm.h>
>> =C2=A0#include <linux/gpio.h>
>> +#include <linux/of.h>
>> =C2=A0#include <linux/spi/spi.h>
>> =C2=A0#include <linux/spi/ads7846.h>
>> =C2=A0#include <linux/regulator/consumer.h>
>> @@ -1425,12 +1426,25 @@ static int __devexit ads7846_remove(struct s=
pi_device *spi)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0}
>>
>> +#if defined(CONFIG_OF)
>> +static struct of_device_id ads7846_spi_of_match_table[] __devinitda=
ta =3D {
>> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "ti,ads7846", },
>> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "ti,ads7845", },
>> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "ti,ads7843", },
>> + =C2=A0 =C2=A0 =C2=A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, ads7846_spi_of_match_table);
>
> #else
> #define ads7846_spi_of_match_table NULL
>
>> +#endif
>> +
>> =C2=A0static struct spi_driver ads7846_driver =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =
=3D "ads7846",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bus =C2=A0 =C2=
=A0=3D &spi_bus_type,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =C2=A0=
=3D THIS_MODULE,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pm =C2=A0 =C2=
=A0 =3D &ads7846_pm,
>> +#if defined(CONFIG_OF)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D=
 ads7846_spi_of_match_table,
>> +#endif
>
> With the #else =C2=A0block added above, you can drop the #if/#endif
> protection around of_match_table.

ok. thanks

>
> Otherwise:
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
