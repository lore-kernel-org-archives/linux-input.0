From: Graham Gower <graham.gower@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Tue, 23 Mar 2010 14:01:27 +1030
Message-ID: <4BA8360F.8080208@gmail.com>
References: <4BA70831.1040606@gmail.com> <0D753D10438DA54287A00B02708426976368DDD220@AUSP01VMBX24.collaborationhost.net> <4BA81BC7.9040107@gmail.com> <201003230401.48660.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f182.google.com ([209.85.221.182]:50769 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0CWDbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 23:31:52 -0400
Received: by qyk12 with SMTP id 12so3248988qyk.5
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 20:31:51 -0700 (PDT)
In-Reply-To: <201003230401.48660.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Marek Vasut wrote:
> Dne =C3=9At 23. b=C5=99ezna 2010 02:39:19 Graham Gower napsal(a):

>> The ucb1400_core is registered with driver_register.
>>
>> I have grepped my tree and the only places I see "ucb12400_core" are=
 in a
>>  couple of arm board files and in my board file. Mine is commented o=
ut, and
>>  I definitely still get the probe being called.
>>
>> I added dump_stack() to the probe function.
>>
>> [<80014f50>] dump_stack+0x8/0x34
>> [<801b1dec>] ucb1400_core_probe+0x48/0x1ac
>> [<801ab114>] driver_probe_device+0x128/0x254
>> [<801aa440>] bus_for_each_drv+0x60/0xb0
>> [<801ab3e4>] device_attach+0x60/0x88
>> [<801aa234>] bus_probe_device+0x30/0x54
>> [<801a8a74>] device_add+0x368/0x4f0
>> [<80210970>] snd_ac97_dev_register+0xa0/0xd8
>> [<801ef6e8>] snd_device_register_all+0x44/0x80
>> [<801eb2f4>] snd_card_register+0x64/0x18c
>> [<80216f3c>] snd_soc_instantiate_cards+0x368/0x5c4
>> [<80217214>] soc_probe+0x7c/0xc4
>> [<801ab114>] driver_probe_device+0x128/0x254
>> [<801aa440>] bus_for_each_drv+0x60/0xb0
>> [<801ab3e4>] device_attach+0x60/0x88
>> [<801aa234>] bus_probe_device+0x30/0x54
>> [<801a8a74>] device_add+0x368/0x4f0
>> [<801aca5c>] platform_device_add+0x14c/0x1b8
>> [<803813a4>] quokka_init+0x98/0xec
>> [<800180f0>] do_one_initcall+0x68/0x200
>> [<80371328>] kernel_init+0xc4/0x164
>> [<8001ac2c>] kernel_thread_helper+0x10/0x18
>=20
> Aren't you probing it from some driver or something ?

I register an ac97 platform driver from an arch_initcall function. It l=
ooks
like the ucb1400_core driver is probed once the ac97 device is found.


>> This has nothing to do with the irq number that I'm passing (which i=
s not
>>  123 anyway). The ucb1400_core's dev->platform_data pointer is NULL.
>=20
> We know it is NULL ... that's because you're not passing it.

When I attempt to pass it via a platform device with platform_add_devic=
es, it
is still NULL. I suspected that it was NULL because the ucb1400_core
isn't a platform_driver  - thus I commented out the platform device
for ucb1400_core in my arch_initcall and sure enough the probe was stil=
l
being called.

-Graham
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
