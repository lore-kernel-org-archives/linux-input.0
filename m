From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv4 1/6] input/cma3000_d0x: Support devices without pdata
Date: Tue, 25 Oct 2011 09:38:18 +0200
Message-ID: <CAPybu_3EPJYd1EdzgF1oF6_k8u5nr4Kx1zmdPRXNZ_zcACrUEw@mail.gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-2-git-send-email-ricardo.ribalda@gmail.com> <20111024213104.GA4394@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41912 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1JYHi6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Oct 2011 03:38:58 -0400
In-Reply-To: <20111024213104.GA4394@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Grant

>> ---
>
> Drop this line, git cuts everything below a '---' line from the commi=
t text.

Done, thanks

>
> This binding needs documentation before it can be merged.

Documentation/input/cma3000_d0x.txt is the right place ?

>
> No of_device_id match table to match against compatible values?

I think it is not needed, the device will be matched against the
driver cma3000_d0x_spi.c and AFAIK on the spi/i2c devices you dont
need the device_id match. But you know much more about this :).  Can
you point me to a example where a spi driver uses of_device-id match.

>
>> +
>> =A0struct cma3000_accl_data *cma3000_init(struct device *dev, int ir=
q,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0const struct cma3000_bus_ops *bops)
>> =A0{
>> - =A0 =A0 const struct cma3000_platform_data *pdata =3D dev->platfor=
m_data;
>> + =A0 =A0 struct cma3000_platform_data *pdata;
>> =A0 =A0 =A0 struct cma3000_accl_data *data;
>> =A0 =A0 =A0 struct input_dev *input_dev;
>> =A0 =A0 =A0 int rev;
>> =A0 =A0 =A0 int error;
>>
>> - =A0 =A0 if (!pdata) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "platform data not found\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> - =A0 =A0 }
>> -
>> -
>> =A0 =A0 =A0 /* if no IRQ return error */
>> =A0 =A0 =A0 if (irq =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> @@ -309,10 +357,26 @@ struct cma3000_accl_data *cma3000_init(struct =
device *dev, int irq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 /*Init platform data*/
>> + =A0 =A0 if (dev->platform_data !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&data->pdata, dev->platform_data, s=
izeof(data->pdata));
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&data->pdata, &cma3000_default_pdat=
a,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(dat=
a->pdata));
>> + =A0 =A0 =A0 =A0 =A0 =A0 #ifdef CONFIG_OF
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev->of_node !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cma3000_get_pdata_of(dev, =
data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "platform da=
ta not found, using default\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 #else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "platform data not found, us=
ing default\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 #endif
>> + =A0 =A0 }
>> + =A0 =A0 pdata =3D &data->pdata;
>> +
>> =A0 =A0 =A0 data->dev =3D dev;
>> =A0 =A0 =A0 data->input_dev =3D input_dev;
>> =A0 =A0 =A0 data->bus_ops =3D bops;
>> - =A0 =A0 data->pdata =3D pdata;
>> =A0 =A0 =A0 data->irq =3D irq;
>> =A0 =A0 =A0 mutex_init(&data->mutex);
>>
>> --
>> 1.7.7
>>
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
