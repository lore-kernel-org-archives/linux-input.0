From: Graham Gower <graham.gower@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Tue, 23 Mar 2010 12:09:19 +1030
Message-ID: <4BA81BC7.9040107@gmail.com>
References: <4BA70831.1040606@gmail.com> <201003221413.20841.marek.vasut@gmail.com> <4BA7F2CA.1060608@gmail.com> <201003230159.19010.marek.vasut@gmail.com> <0D753D10438DA54287A00B02708426976368DDD220@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:49719 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab0CWBja (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 21:39:30 -0400
Received: by fxm23 with SMTP id 23so1467010fxm.21
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 18:39:28 -0700 (PDT)
In-Reply-To: <0D753D10438DA54287A00B02708426976368DDD220@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

H Hartley Sweeten wrote:
> On Monday, March 22, 2010 5:59 PM, Marek Vasut wrote:
>> Dne Po 22. b=C5=99ezna 2010 23:44:26 Graham Gower napsal(a):
>>> Marek Vasut wrote:
>>>> Dne Po 22. b=C5=99ezna 2010 07:03:29 Graham Gower napsal(a):
>>>>> Hi Marek,
>>>>> I wish to use the ucb1400_ts driver on my device. But I'm having =
trouble
>>>>> passing the platform_data to the ucb1400_core driver.
>>>>>
>>>>> I couldn't see any in tree examples of this being done and my att=
empts
>>>>> to do this via registering a platform_driver for ucb1400_core hav=
e
>>>>> failed (probably since this driver is ac97_bus_type, not a
>>>>> platform_driver).
>>>>>
>>>>> Can you provide me with info regarding the correct method for pas=
sing
>>>>> the irq to the driver?
>>>>>
>>>>> Thanks,
>>>>> -Graham
>>>> static struct ucb1400_pdata pdata =3D {
>>>> 	.irq	=3D IRQ_GPIO(123),
>>>> };
>>>>
>>>> static struct platform_device ucb1400_core =3D {
>>>>         .name   =3D "ucb1400_core",
>>>>         .id     =3D -1,
>>>> 	.dev	=3D {
>>>> 		.platform_data =3D &pdata,
>>>> 	},
>>>> };
>>>>
>>>> init() {
>>>> 	platform_device_register(&ucb1400_core);
>>>> }
>>>>
>>>> Like this ?
>>> That is the first thing I tried and it doesn't work. I suggest you =
printk
>>> the pdata in the ucb1400_core driver after having done this to conf=
irm (I
>>>  got NULL). You don't need to register a platform driver for
>>>  ucb1400_core_probe() to be called anyway - presumably its enumerat=
ed from
>>>  the ac97 bus.
>> Oh yes you have to, otherwise the pdata won't be passed. Besides, it=
's weird=20
>> probe()'s called if you didn't register it. But obviously whatever c=
alls it=20
>> doesn't pass the pdata.
>=20
> The driver is registered with platform_driver_register, as such it wi=
ll be tied
> to the platform bus not the ac97 bus.  Being a platform driver, you d=
o need a
> matching platform_device_register so that you get a device<->driver b=
inding.

I suspect we are looking at different files, or different versions of t=
he file.
I'm looking at drivers/mfd/ucb1400_core.c, which looks like this:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/mfd/ucb1400_core.c;hb=3DHEAD

The ucb1400_core is registered with driver_register.

I have grepped my tree and the only places I see "ucb12400_core" are in=
 a couple
of arm board files and in my board file. Mine is commented out, and I d=
efinitely
still get the probe being called.

I added dump_stack() to the probe function.

[<80014f50>] dump_stack+0x8/0x34
[<801b1dec>] ucb1400_core_probe+0x48/0x1ac
[<801ab114>] driver_probe_device+0x128/0x254
[<801aa440>] bus_for_each_drv+0x60/0xb0
[<801ab3e4>] device_attach+0x60/0x88
[<801aa234>] bus_probe_device+0x30/0x54
[<801a8a74>] device_add+0x368/0x4f0
[<80210970>] snd_ac97_dev_register+0xa0/0xd8
[<801ef6e8>] snd_device_register_all+0x44/0x80
[<801eb2f4>] snd_card_register+0x64/0x18c
[<80216f3c>] snd_soc_instantiate_cards+0x368/0x5c4
[<80217214>] soc_probe+0x7c/0xc4
[<801ab114>] driver_probe_device+0x128/0x254
[<801aa440>] bus_for_each_drv+0x60/0xb0
[<801ab3e4>] device_attach+0x60/0x88
[<801aa234>] bus_probe_device+0x30/0x54
[<801a8a74>] device_add+0x368/0x4f0
[<801aca5c>] platform_device_add+0x14c/0x1b8
[<803813a4>] quokka_init+0x98/0xec
[<800180f0>] do_one_initcall+0x68/0x200
[<80371328>] kernel_init+0xc4/0x164
[<8001ac2c>] kernel_thread_helper+0x10/0x18


>=20
>> And yes, I printk'd it when I was sending this patch in and it worke=
d for me ...=20
>> register the platform device and you should be ok.
>>>> btw. you don't have to pass pdata at all ... the logic for auto-de=
tecting
>>>> IRQ is still there and is active if no pdata are supplied.
>>> This does not work for me. I have not yet investigated why.
>> I'd better get rid of that autodetection stuff altogether, but fttb =
it can be=20
>> there.
>=20
> Another reason your irq might not be working is that its not valid.  =
Is gpio 123
> a valid IRQ producer on your platform?  IRQ_GPIO(123) might resolve t=
o
> (ucb->irq < 0) which would cause the probe to try auto detecting the =
irq.

This has nothing to do with the irq number that I'm passing (which is n=
ot 123
anyway). The ucb1400_core's dev->platform_data pointer is NULL.


>=20
> BTW, this driver looks a little scary.
>=20
> The 'platform data' that is passed to the driver is also the 'private=
 data' used
> by the driver.  Since the only data passed by the platform is the irq=
 it would
> probably be cleaner to pass a struct ucb1400_pdata to the driver and =
kzalloc
> the private struct ucb1400_ts data in the driver.
>=20
> Just my 0.02...
>=20
> Regards,
> Hartley

-Graham
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
