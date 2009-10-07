From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Wed, 7 Oct 2009 14:13:57 +0900
Message-ID: <9c9fda240910062213j12ff18d7x787041ef2217552a@mail.gmail.com>
References: <20091006074533.GA28889@july>
	 <5d5443650910061135t68d004e3r30715da062b74750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754861AbZJGFOg@vger.kernel.org>
In-Reply-To: <5d5443650910061135t68d004e3r30715da062b74750@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Wed, Oct 7, 2009 at 3:35 AM, Trilok Soni <soni.trilok@gmail.com> wro=
te:
> Hi Kyungmin,
>
> On Tue, Oct 6, 2009 at 1:15 PM, Kyungmin Park <kmpark@infradead.org> =
wrote:
>> This patch includes two haptic devices, isa1000 and isa1200
>> ISA1000 is gpio based haptic, but isa1200 is based on I2C
>> Both are working on Samsung SoCs and tested.
>>
>> To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
>> You can adjust the level by echo ${level} > /sys/class/haptic/${name=
}/enable
>> or
>> With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}/=
oneshot
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Many thanks for the posting the update and example drivers. Here are
> my suggestions to make it mainlined fast:
>
> 1. split these patches - probably in following order would be good
> =A0 a) haptics class
> =A0 b) haptics samsung pwm driver
> =A0 c) isa1200 haptics driver
> =A0 d) add maintainers entry in MAINTAINERS file under your name for =
haptics :)
> =A0 d) please add short documentation under Documentation/haptics ?
> directory describe what haptics class is all about, and atleast
> userspace interfaces which you are providing using sysfs file. We can
> use led class documentation as example here. Short documentation is
> fine to begin with.

Thank you for suggestion. I will split the patches. and resend.

> =A0 e) if possible create your own git haptics project tree at
> kernel.org and add it to linux-next, but I would also suggest that as
> no. of updates to these framework will be not so frequent, so we can
> also follow -mm route and let Andrew pick up your patches and get the=
m
> cooked under -mm.

I think no need to create new haptic tree. it's simple class to handle
haptic drivers.

>
>>
>> diff --git a/drivers/Kconfig b/drivers/Kconfig
>> index 48bbdbe..d44a601 100644
>> --- a/drivers/Kconfig
>> +++ b/drivers/Kconfig
>> @@ -62,6 +62,8 @@ source "drivers/power/Kconfig"
>>
>> =A0source "drivers/hwmon/Kconfig"
>>
>> +source "drivers/haptic/Kconfig"
>> +
>> =A0source "drivers/thermal/Kconfig"
>>
>> =A0source "drivers/watchdog/Kconfig"
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 6ee53c7..16b8f67 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -77,6 +77,7 @@ obj-$(CONFIG_PPS) =A0 =A0 =A0 =A0 =A0 =A0 +=3D pps=
/
>> =A0obj-$(CONFIG_W1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D w1/
>> =A0obj-$(CONFIG_POWER_SUPPLY) =A0 =A0 +=3D power/
>> =A0obj-$(CONFIG_HWMON) =A0 =A0 =A0 =A0 =A0 =A0+=3D hwmon/
>> +obj-$(CONFIG_HAPTIC) =A0 =A0 =A0 =A0 =A0 +=3D haptic/
>> =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0+=3D thermal/
>> =A0obj-$(CONFIG_WATCHDOG) =A0 =A0 =A0 =A0 +=3D watchdog/
>> =A0obj-$(CONFIG_PHONE) =A0 =A0 =A0 =A0 =A0 =A0+=3D telephony/
>> diff --git a/drivers/haptic/Kconfig b/drivers/haptic/Kconfig
>> new file mode 100644
>> index 0000000..9acb02a
>> --- /dev/null
>> +++ b/drivers/haptic/Kconfig
>> @@ -0,0 +1,31 @@
>> +menuconfig HAPTIC
>> + =A0 =A0 =A0 bool "HAPTIC support"
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Say Y to enalbe haptic support. It enables the hap=
tic and controlled
>
> s/enalbe/enable

=46ixed.

>
>> + =A0 =A0 =A0 =A0 from both userspace and kernel
>
> Please explain how from kernel? We are only providing sysfs interface
> for this framework, and I don't see in-kernel control of haptics
> driver in your patch. Also I don't see any need of in-kernel control
> of them though.

It's wrong description. It's handled from userspace not kernel.

>
>> +
>> +if HAPTIC
>> +
>> +config HAPTIC_CLASS
>> + =A0 =A0 =A0 tristate "Haptic Class Support"
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This option enables the haptic sysfs class in /sys=
/class/haptic.
>> +
>> +comment "Haptic drivers"
>> +
>> +config HAPTIC_SAMSUNG_PWM
>> + =A0 =A0 =A0 tristate "Haptic Support for SAMSUNG PWM-controlled mo=
tor (ISA1000)"
>> + =A0 =A0 =A0 depends on HAPTIC_CLASS && (ARCH_S3C64XX || ARCH_S5PC1=
XX)
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This options enables support for haptic connected =
to GPIO lines
>> + =A0 =A0 =A0 =A0 controlled by a PWM timer on SAMSUNG CPUs.
>> +
>> +comment "Haptic chips"
>> +
>> +config HAPTIC_ISA1200
>> + =A0 =A0 =A0 tristate "Haptic Motor"
>> + =A0 =A0 =A0 depends on HAPTIC_CLASS && I2C
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 The ISA1200 is a high performance enhanced haptic =
motor driver
>
> This chip also seems to support external pwm mode like isa1000, so yo=
u
> could explicitly add that this driver is about controlling it through
> i2c only, but there could be a possibility of writing the same throug=
h
> external pwm mode also.

Actually it supports both internal and external. but in my hardware it
connects with external.
So I implement it as previous isa1000 does.
Someone can implement it as internal.

>
>> +
>> +static int samsung_pwm_haptic_probe(struct platform_device *pdev)
>> +{
>
> __devinit?

=46ixed.

>
>> + =A0 =A0 =A0 struct haptic_platform_data *pdata =3D pdev->dev.platf=
orm_data;
>> + =A0 =A0 =A0 struct samsung_pwm_haptic *haptic;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 haptic =3D kzalloc(sizeof(struct samsung_pwm_haptic), =
GFP_KERNEL);
>> + =A0 =A0 =A0 if (!haptic) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No memory for dev=
ice\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 }
>> +static int samsung_pwm_haptic_remove(struct platform_device *pdev)
>> +{
>
> __devexit

=46ixed

>
>> +
>> +static int __devexit isa1200_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 return 0;
>
> nothing to remove?

Sorry I'm not yet implemented. Will fix it.

>
>> +}
>> +
>> +static int isa1200_suspend(struct i2c_client *client, pm_message_t =
mesg)
>> +{
>> + =A0 =A0 =A0 struct isa1200_chip *chip =3D i2c_get_clientdata(clien=
t);
>> + =A0 =A0 =A0 isa1200_chip_power_off(chip);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int isa1200_resume(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 isa1200_setup(client);
>> + =A0 =A0 =A0 return 0;
>> +}
>
> #ifdef CONFIG_PM checks please.

Of course.

Thank you,
Kyungmin Park
