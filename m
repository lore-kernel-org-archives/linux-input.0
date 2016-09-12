From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Revert "Input: bma150 - extend chip detection for bma180"
Date: Mon, 12 Sep 2016 16:44:06 +0200
Message-ID: <a156f29f-43db-6811-7f7e-ac2c7682d766@redhat.com>
References: <20160911164321.23122-1-hdegoede@redhat.com>
 <2C735D34-7559-4A62-A635-A5719C356D94@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758050AbcILOoM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Sep 2016 10:44:12 -0400
In-Reply-To: <2C735D34-7559-4A62-A635-A5719C356D94@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Lukas Maerdian <lukas@goldelico.com>

Hi,

On 12-09-16 16:31, H. Nikolaus Schaller wrote:
> Hi,
>
>> Am 11.09.2016 um 18:43 schrieb Hans de Goede <hdegoede@redhat.com>:
>>
>> This reverts commit ef3714fdbc8d ("Input: bma150 - extend chip
>> detection for bma180").
>>
>> The bma180 is not compatible with the bma150 at all, it has 14 bits
>> resolution instead of 10, and it has quite different control registers.
>>
>> Treating the bma180 as a bma150 wrt its data registers will just result
>> in throwing away the lowest 4 bits, which is not too bad. But the ctrl
>> registers are a different story.
>>
>> It may be that things happen to just work (I don't have a bma180 to
>> test with) but that certainly does not make this right.
>
> Yes, looks as if your observation is right. Thanks for pointing this out!
>
> This did need me some research to find an answer...
>
> If I remember correctly, the original patch was based on a recommendation
> from someone I don't remember, who said that the chips are the same in a
> different package. So we added the chip_id and it worked immediately as
> expected. It looks as if we did not check the data sheets. So we did not
> question this recommendation.
>
>>
>> Removing the bma180 id also removes overlap wrt the ids in the iio
>> bma180 driver which does treat the bma180 properly.
>
> Nack.
>
> The problem we get is that an iio driver is not an input driver and can't
> easily replace it.

Actually almost all accelerometer drivers in the Linux kernel are
iio drivers, the bma150 driver is the odd duck out, that is why
we've iio-sensor-proxy for apps which want the accelerometer
to behave as an input device:

https://github.com/hadess/iio-sensor-proxy

> An input driver can be used for gesture applications (e.g. detecting
> the device has been turned upside down) and can report X/Y/Z coordinates
> to e.g. X11 for games similar to a mouse or joystick (which the iio driver
> doesn't).

See above.

> So it should remain configurable which of both driver options is loaded,
> to match user space API needs.
>
> BTW: id overlap is only a problem if both drivers are configured in parallel.

Right, so it is "only" a problem to any generic distro which tries to
support both bma150 and bma250 accelerometers, as both the input
bma150 as well as the iio bma250 driver claim to be bma180 compatible.

> Next, I have tried to find out which devices really use the bma150 and bma180.
>
> It appears that no in-tree device uses the bma150 while the GTA04 uses
> the bma180 (in DT), but not in any defconfig (the GTA04 specific config
> is not upstreamable since omap2plus_defconfig exists).
>
> In user-space the GTA04 requires and actively uses this input driver for Replicant.
>
> So I would conclude that this revert does not improve/fix any device using a
> bma150 (if it exists at all), but breaks an existing device.
>
> What options do we have?
>
> a) add proper register number constants and choose conditionally (where they differ)
> b) drop bma150 support completely and change registers for bma180
> c) clone the bma150 input driver into an bma180 input driver and fix registers
> d) extend the bma180 iio driver to optionally provide an input device
> e) write a generic input/iio-accel wrapper (which should work with any iio accelerometer)
>
> I would favour approach e)

Good, because that solution already exists :) See:
https://github.com/hadess/iio-sensor-proxy

> but it has an issue I have no solution for:
>
> 	how to define in DT (or CONFIG?) which iio accelerometer(s) should
> 	be wrapped and presented as input device(s).

I believe currently iio-sensor-proxy simply wraps all accelerometers
it can find, which seems the right thing to do. Usually we're running
a generic desktop-ish OS / distro which wants these devices
to be available as input devices; for special cases like actual
robots and stuff running Linux, iio-sensor-proxy can simply be
disabled; or not installed at all.

So all in all I believe that this is a solved problem, since
solution e. from above is already implemented.

Regards,

Hans



>
> Well, it could be as simple as defining a virtual "input-iio-accel" wrapper
> driver with no real hardware behind and provide a reference to the iio DT node.
> But I think such virtual devices are against DT style.
>
> So I don't know how to implement it in an acceptable way.
>
> Ideas?
>
> BR and thanks,
> Nikolaus Schaller
>
>>
>> Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/input/misc/bma150.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
>> index b0d4453..cae4832 100644
>> --- a/drivers/input/misc/bma150.c
>> +++ b/drivers/input/misc/bma150.c
>> @@ -70,7 +70,6 @@
>> #define BMA150_CFG_5_REG	0x11
>>
>> #define BMA150_CHIP_ID		2
>> -#define BMA180_CHIP_ID		3
>> #define BMA150_CHIP_ID_REG	BMA150_DATA_0_REG
>>
>> #define BMA150_ACC_X_LSB_REG	BMA150_DATA_2_REG
>> @@ -539,7 +538,7 @@ static int bma150_probe(struct i2c_client *client,
>> 	}
>>
>> 	chip_id = i2c_smbus_read_byte_data(client, BMA150_CHIP_ID_REG);
>> -	if (chip_id != BMA150_CHIP_ID && chip_id != BMA180_CHIP_ID) {
>> +	if (chip_id != BMA150_CHIP_ID) {
>> 		dev_err(&client->dev, "BMA150 chip id error: %d\n", chip_id);
>> 		return -EINVAL;
>> 	}
>> @@ -643,7 +642,6 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
>>
>> static const struct i2c_device_id bma150_id[] = {
>> 	{ "bma150", 0 },
>> -	{ "bma180", 0 },
>> 	{ "smb380", 0 },
>> 	{ "bma023", 0 },
>> 	{ }
>> --
>> 2.9.3
>>
>
