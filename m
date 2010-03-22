From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Mon, 22 Mar 2010 14:13:20 +0100
Message-ID: <201003221413.20841.marek.vasut@gmail.com>
References: <4BA70831.1040606@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:65249 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab0CVNN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 09:13:58 -0400
Received: by fg-out-1718.google.com with SMTP id l26so454449fgb.1
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 06:13:56 -0700 (PDT)
In-Reply-To: <4BA70831.1040606@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Graham Gower <graham.gower@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Dne Po 22. b=C5=99ezna 2010 07:03:29 Graham Gower napsal(a):
> Hi Marek,
> I wish to use the ucb1400_ts driver on my device. But I'm having trou=
ble
> passing the platform_data to the ucb1400_core driver.
>=20
> I couldn't see any in tree examples of this being done and my attempt=
s to
> do this via registering a platform_driver for ucb1400_core have faile=
d
> (probably since this driver is ac97_bus_type, not a platform_driver).
>=20
> Can you provide me with info regarding the correct method for passing=
 the
> irq to the driver?
>=20
> Thanks,
> -Graham
>=20

static struct ucb1400_pdata pdata =3D {
	.irq	=3D IRQ_GPIO(123),
};

static struct platform_device ucb1400_core =3D {
        .name   =3D "ucb1400_core",
        .id     =3D -1,
	.dev	=3D {
		.platform_data =3D &pdata,
	},
};

init() {
	platform_device_register(&ucb1400_core);
}

Like this ?

btw. you don't have to pass pdata at all ... the logic for auto-detecti=
ng IRQ is=20
still there and is active if no pdata are supplied.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
