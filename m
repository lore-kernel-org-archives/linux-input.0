From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: question about v4l2_subdev
Date: Tue, 01 Jun 2010 16:04:13 +0200
Message-ID: <4C05135D.1080108@atmel.com>
References: <4C03D80B.5090009@atmel.com> <1275329947.2261.19.camel@localhost> <4C04C17D.8020702@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4C04C17D.8020702@atmel.com>
Sender: linux-media-owner@vger.kernel.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Andy Walls <awalls@md.metrocast.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Sorry to bother you again, but here is the situation:
I have 2 drivers: an ov2640 driver and my atmel driver.
Basically the ov2640 driver is the same as the ov7670 driver.

So what I don't know is how to call the ov2640 functions(such as set=20
format) in my atmel driver.

In the ov2640 I used the function: v4l2_i2c_subdev_init, and in the=20
atmel driver I used v4l2_device_register.

But I don't know where I should use the v4l2_i2c_new_subdev function,=20
and how to link my atmel video struct to the i2c sensor.

Is there any examples in linux?

Regards,
Sedji

Le 6/1/2010 10:14 AM, Sedji Gaouaou a =C3=A9crit :
> Hi,
>
>
>>
>> 1. Something first should call v4l2_device_register() on a v4l2_devi=
ce
>> object. (Typically there is only one v4l2_device object per "bridge"
>> chip between the PCI, PCIe, or USB bus and the subdevices, even if t=
hat
>> bridge chip has more than one I2C master implementation.)
>>
>> 2. Then, for subdevices connected to the bridge chip via I2C, someth=
ing
>> needs to call v4l2_i2c_new_subdev() with the v4l2_device pointer as =
one
>> of the arguments, to get back a v4l2_subdevice instance pointer.
>>
>> 3. After that, v4l2_subdev_call() with the v4l2_subdev pointer as on=
e of
>> the arguments can be used to invoke the subdevice methods.
>>
>> TV Video capture drivers do this work themselves. Drivers using a
>> camera framework may have the framework doing some of the work for t=
hem.
>>
>>
>> Regards,
>> Andy
>>
>>
>>
>
>
> Is there a sensor driver which is using this method?
>
> To write the ov2640 driver I have just copied the ov7670.c file, and =
I
> didn't find the v4l2_i2c_new_subdev in it...
>
> Regards,
> Sedji
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
