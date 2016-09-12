From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH] Revert "Input: bma150 - extend chip detection for bma180"
Date: Mon, 12 Sep 2016 19:20:59 +0200
Message-ID: <4809E76B-7BFE-4D95-8631-079262E958E2@goldelico.com>
References: <20160911164321.23122-1-hdegoede@redhat.com> <2C735D34-7559-4A62-A635-A5719C356D94@goldelico.com> <a156f29f-43db-6811-7f7e-ac2c7682d766@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a156f29f-43db-6811-7f7e-ac2c7682d766-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Lukas Maerdian <lukas-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

> Am 12.09.2016 um 16:44 schrieb Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>=20
> Hi,
>=20
> On 12-09-16 16:31, H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>>> Am 11.09.2016 um 18:43 schrieb Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>>>=20
>>> This reverts commit ef3714fdbc8d ("Input: bma150 - extend chip
>>> detection for bma180").
>>>=20
>>> The bma180 is not compatible with the bma150 at all, it has 14 bits
>>> resolution instead of 10, and it has quite different control =
registers.
>>>=20
>>> Treating the bma180 as a bma150 wrt its data registers will just =
result
>>> in throwing away the lowest 4 bits, which is not too bad. But the =
ctrl
>>> registers are a different story.
>>>=20
>>> It may be that things happen to just work (I don't have a bma180 to
>>> test with) but that certainly does not make this right.
>>=20
>> Yes, looks as if your observation is right. Thanks for pointing this =
out!
>>=20
>> This did need me some research to find an answer...
>>=20
>> If I remember correctly, the original patch was based on a =
recommendation
>> from someone I don't remember, who said that the chips are the same =
in a
>> different package. So we added the chip_id and it worked immediately =
as
>> expected. It looks as if we did not check the data sheets. So we did =
not
>> question this recommendation.
>>=20
>>>=20
>>> Removing the bma180 id also removes overlap wrt the ids in the iio
>>> bma180 driver which does treat the bma180 properly.
>>=20
>> Nack.
>>=20
>> The problem we get is that an iio driver is not an input driver and =
can't
>> easily replace it.
>=20
> Actually almost all accelerometer drivers in the Linux kernel are
> iio drivers,

Yes, that is a good move indeed to make them more general.

> the bma150 driver is the odd duck out,

Indeed it seems to be in /misc for some reason.

> that is why
> we've iio-sensor-proxy for apps which want the accelerometer
> to behave as an input device:
>=20
> https://github.com/hadess/iio-sensor-proxy

Does this provide an input device /dev/input/event?
=46rom a first look it seems to provide a D-Bus abstraction which is
not the same as an /dev/input/event.

What about latency?
A kernel driver can react on a sensor interrupt, queue results
and sleep.

Isn't a user-space process more resource hungry than a kernel thread?

>=20
>> An input driver can be used for gesture applications (e.g. detecting
>> the device has been turned upside down) and can report X/Y/Z =
coordinates
>> to e.g. X11 for games similar to a mouse or joystick (which the iio =
driver
>> doesn't).
>=20
> See above.
>=20
>> So it should remain configurable which of both driver options is =
loaded,
>> to match user space API needs.
>>=20
>> BTW: id overlap is only a problem if both drivers are configured in =
parallel.
>=20
> Right, so it is "only" a problem to any generic distro which tries to
> support both bma150 and bma250 accelerometers, as both the input
> bma150 as well as the iio bma250 driver claim to be bma180 compatible.

Well, it is only a problem if such a generic distro is really run on a =
device
which has a bma180 defined in DT. There do not seem to exist many of =
these.

>=20
>> Next, I have tried to find out which devices really use the bma150 =
and bma180.
>>=20
>> It appears that no in-tree device uses the bma150 while the GTA04 =
uses
>> the bma180 (in DT), but not in any defconfig (the GTA04 specific =
config
>> is not upstreamable since omap2plus_defconfig exists).
>>=20
>> In user-space the GTA04 requires and actively uses this input driver =
for Replicant.
>>=20
>> So I would conclude that this revert does not improve/fix any device =
using a
>> bma150 (if it exists at all), but breaks an existing device.
>>=20
>> What options do we have?
>>=20
>> a) add proper register number constants and choose conditionally =
(where they differ)
>> b) drop bma150 support completely and change registers for bma180
>> c) clone the bma150 input driver into an bma180 input driver and fix =
registers
>> d) extend the bma180 iio driver to optionally provide an input device
>> e) write a generic input/iio-accel wrapper (which should work with =
any iio accelerometer)
>>=20
>> I would favour approach e)
>=20
> Good, because that solution already exists :) See:
> https://github.com/hadess/iio-sensor-proxy

No, it is yet another option. I would formulate it as:

f) break user-space compatibility for existing systems and write / =
require=20
   a user-space workaround.

This is something which is the least favorite in my view.

Since we have no control over the user space people have installed and =
IMHO
a kernel shouldn't break APIs too often or only for really good reasons
(e.g. completely new functions).

And we have no means to force user-space developers to integrate such =
daemons :(

So we break a device by upgrading to 4.9-kernel but can't give a =
solution.

>=20
>> but it has an issue I have no solution for:
>>=20
>> 	how to define in DT (or CONFIG?) which iio accelerometer(s) =
should
>> 	be wrapped and presented as input device(s).
>=20
> I believe currently iio-sensor-proxy simply wraps all accelerometers
> it can find, which seems the right thing to do. Usually we're running
> a generic desktop-ish OS / distro which wants these devices
> to be available as input devices;
> for special cases like actual
> robots and stuff running Linux, iio-sensor-proxy can simply be
> disabled; or not installed at all.

Well, the GTA04 we talk about falls into a third category: a mobile =
device.

Which is not running a desktop-ish OS / distro. It is running Replicant,
QtMoko, SHR, FSO or other user spaces which partially rely on =
/dev/input/event
without starting a daemon. At least in current releases and we have =
little
influence to have them use a new daemon.

So I would strongly prefer if we can solve this in the kernel and keep =
the
user-space API for the bma180 input driver stable.

>=20
> So all in all I believe that this is a solved problem, since
> solution e. from above is already implemented.

Well it is also solved if we do not revert the patch at all, because it
works in practice (even if not exactly correct) and is compatible to
existing user-space.

In summary I don't like option f) because it creates more problems than
it solves.

If e) is ruled out, IMHO the second best option seems to be d) to add a
CONFIG_BMA180_INPUT_DEVICE and make it present some additional =
/dev/input/event
in parallel to the iio interface.

I already have a similar approach in my to-be-upstreamed queue for the =
tsc2007
touch screen driver to provide additional iio channels for raw values, =
chip
temperature and the auxiliary general purpose ADC (which is used as =
ambient
light sensor in the GTA04).

So let's develop some patch for drivers/iio/accel/bma180.c before we =
revert
this bma150 patch and have nothing.

BR,
Nikolaus Schaller

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>>=20
>> Well, it could be as simple as defining a virtual "input-iio-accel" =
wrapper
>> driver with no real hardware behind and provide a reference to the =
iio DT node.
>> But I think such virtual devices are against DT style.
>>=20
>> So I don't know how to implement it in an acceptable way.
>>=20
>> Ideas?
>>=20
>> BR and thanks,
>> Nikolaus Schaller
>>=20
>>>=20
>>> Cc: Dr. H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>> drivers/input/misc/bma150.c | 4 +---
>>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>>=20
>>> diff --git a/drivers/input/misc/bma150.c =
b/drivers/input/misc/bma150.c
>>> index b0d4453..cae4832 100644
>>> --- a/drivers/input/misc/bma150.c
>>> +++ b/drivers/input/misc/bma150.c
>>> @@ -70,7 +70,6 @@
>>> #define BMA150_CFG_5_REG	0x11
>>>=20
>>> #define BMA150_CHIP_ID		2
>>> -#define BMA180_CHIP_ID		3
>>> #define BMA150_CHIP_ID_REG	BMA150_DATA_0_REG
>>>=20
>>> #define BMA150_ACC_X_LSB_REG	BMA150_DATA_2_REG
>>> @@ -539,7 +538,7 @@ static int bma150_probe(struct i2c_client =
*client,
>>> 	}
>>>=20
>>> 	chip_id =3D i2c_smbus_read_byte_data(client, =
BMA150_CHIP_ID_REG);
>>> -	if (chip_id !=3D BMA150_CHIP_ID && chip_id !=3D BMA180_CHIP_ID) =
{
>>> +	if (chip_id !=3D BMA150_CHIP_ID) {
>>> 		dev_err(&client->dev, "BMA150 chip id error: %d\n", =
chip_id);
>>> 		return -EINVAL;
>>> 	}
>>> @@ -643,7 +642,6 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, =
bma150_suspend, bma150_resume, NULL);
>>>=20
>>> static const struct i2c_device_id bma150_id[] =3D {
>>> 	{ "bma150", 0 },
>>> -	{ "bma180", 0 },
>>> 	{ "smb380", 0 },
>>> 	{ "bma023", 0 },
>>> 	{ }
>>> --
>>> 2.9.3
>>>=20
>>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
