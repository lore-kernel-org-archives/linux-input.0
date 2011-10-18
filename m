From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 1/5] input/cma3000_d0x: Support devices without pdata
Date: Tue, 18 Oct 2011 14:07:04 +0200
Message-ID: <CAPybu_0_31N-v2h2oM3-yEod=gAu1dn2gG2mO2UFgDWNN9kQuQ@mail.gmail.com>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318926486-10330-2-git-send-email-ricardo.ribalda@gmail.com> <4E9D3999.1080802@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E9D3999.1080802@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Jonathan

 Thanks for your fast reply :)

> I'm not that familiar with DT yet, but surely there is a means to sup=
plying
> the equivalent data? =A0I'd prefer to see that provided here as well.

If you check the file drivers/of/of_spi.c you can see that only reg,
spi-cpha, spi-cpol, spi-cs-high, spi-max-freq and irq is imported
straight from the DT, that is why I created the default configuration.

I can give it a second thought, but I think it wont hurt to have a
per-default configuration.

>> +
>> =A0struct cma3000_accl_data {
>> =A0 =A0 =A0 const struct cma3000_bus_ops *bus_ops;
>> =A0 =A0 =A0 const struct cma3000_platform_data *pdata;
>> @@ -283,19 +295,24 @@ EXPORT_SYMBOL(cma3000_resume);
>> =A0struct cma3000_accl_data *cma3000_init(struct device *dev, int ir=
q,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0const struct cma3000_bus_ops *bops)
>> =A0{
>> - =A0 =A0 const struct cma3000_platform_data *pdata =3D dev->platfor=
m_data;
>> + =A0 =A0 const struct cma3000_platform_data *pdata;
> Leave this line alone....
>> =A0 =A0 =A0 struct cma3000_accl_data *data;
>> =A0 =A0 =A0 struct input_dev *input_dev;
>> =A0 =A0 =A0 int rev;
>> =A0 =A0 =A0 int error;
>>
>> + =A0 =A0 if (!dev->platform_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "platform data not found, us=
ing default\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &cma3000_default_pdata;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D dev->platform_data;
>> +
> and this becomes
>
> if (pdata =3D=3D NULL) {
> =A0 =A0 =A0 =A0dev_info(dev, "platform data not found, using default\=
n");
> =A0 =A0 =A0 =A0pdata =3D &cma3000_default_pdata;
> }
>
>> =A0 =A0 =A0 if (!pdata) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "platform data not found\n"=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> =A0 =A0 =A0 }
> This can't happen now so get rid of the test.
>>
>> -
>> =A0 =A0 =A0 /* if no IRQ return error */
>> =A0 =A0 =A0 if (irq =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>
>

Ready on the new version of the patch.


 Thanks again



--=20
Ricardo Ribalda
