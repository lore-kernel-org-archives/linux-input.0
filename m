From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: haptics devices linux driver support
Date: Sun, 23 Aug 2009 13:45:40 +0900
Message-ID: <9c9fda240908222145j1938baa3v3ecf8c5899ce3850@mail.gmail.com>
References: <5d5443650908221004y5b893382m368dc18a38636c1b@mail.gmail.com>
	 <4A902904.2090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:62478 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbZHWEpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Aug 2009 00:45:39 -0400
In-Reply-To: <4A902904.2090008@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi,

There's three types as I know,

1) just GPIO enable motor
2) GPIO & PWM motor.
3) I2C based GPIO & PWM motor.

=46rankly we made a motor framework at kernel. but I 'm not sure motor
is right naming or not.
I think we need new framework. since it's not input device.

Thank you,
Kyungmin Park


On Sun, Aug 23, 2009 at 2:21 AM, Jiri Slaby<jirislaby@gmail.com> wrote:
> On 08/22/2009 07:04 PM, Trilok Soni wrote:
>> Does anyone know example Linux drivers for haptics devices?
>
> Yup, drivers/misc/phantom.c for Sensable Phantom (the old one over PC=
I).
> The rest needed (esp. floating point computation) is done in userspac=
e.
>
> Then, all force-feedack drivers under drivers/input and drivers/hid.
>
> What exactly do you want to know?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
