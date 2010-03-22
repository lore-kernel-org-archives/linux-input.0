From: Graham Gower <graham.gower@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Tue, 23 Mar 2010 09:14:26 +1030
Message-ID: <4BA7F2CA.1060608@gmail.com>
References: <4BA70831.1040606@gmail.com> <201003221413.20841.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:6598 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0CVWog (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 18:44:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so696982fgg.1
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 15:44:34 -0700 (PDT)
In-Reply-To: <201003221413.20841.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org

Marek Vasut wrote:
> Dne Po 22. b=C5=99ezna 2010 07:03:29 Graham Gower napsal(a):
>> Hi Marek,
>> I wish to use the ucb1400_ts driver on my device. But I'm having tro=
uble
>> passing the platform_data to the ucb1400_core driver.
>>
>> I couldn't see any in tree examples of this being done and my attemp=
ts to
>> do this via registering a platform_driver for ucb1400_core have fail=
ed
>> (probably since this driver is ac97_bus_type, not a platform_driver)=
=2E
>>
>> Can you provide me with info regarding the correct method for passin=
g the
>> irq to the driver?
>>
>> Thanks,
>> -Graham
>>
>=20
> static struct ucb1400_pdata pdata =3D {
> 	.irq	=3D IRQ_GPIO(123),
> };
>=20
> static struct platform_device ucb1400_core =3D {
>         .name   =3D "ucb1400_core",
>         .id     =3D -1,
> 	.dev	=3D {
> 		.platform_data =3D &pdata,
> 	},
> };
>=20
> init() {
> 	platform_device_register(&ucb1400_core);
> }
>=20
> Like this ?

That is the first thing I tried and it doesn't work. I suggest you prin=
tk
the pdata in the ucb1400_core driver after having done this to confirm =
(I got
NULL). You don't need to register a platform driver for ucb1400_core_pr=
obe()
to be called anyway - presumably its enumerated from the ac97 bus.

>=20
> btw. you don't have to pass pdata at all ... the logic for auto-detec=
ting IRQ is=20
> still there and is active if no pdata are supplied.

This does not work for me. I have not yet investigated why.

-Graham

PS: I am on mips, not arm. Arm CC removed.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
