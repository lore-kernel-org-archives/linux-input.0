From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Subject: Re: Testing ti_am335x_adc continuous mode (WAS: Re: [PATCH 2/2]
Date: Mon, 7 Oct 2013 17:50:27 +0500
Message-ID: <20131007125025.GA4655@gmail.com>
References: <1379503383-17086-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379503383-17086-3-git-send-email-zubair.lutfullah@gmail.com>
 <20131007115317.GA6135@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:40094 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3JGMui (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2013 08:50:38 -0400
Content-Disposition: inline
In-Reply-To: <20131007115317.GA6135@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Felipe Balbi <balbi@ti.com>

On Mon, Oct 07, 2013 at 01:53:17PM +0200, Sebastian Andrzej Siewior wro=
te:
> Hi Zubair,
>=20
> I have here am335x-evm board. The output of voltage4 (via `cat
> /sys/bus/iio/devices/iio\:device0/in_voltage4_raw=C2=B4) returns valu=
es in
> the range 570=E2=80=A6580. I tested the continuous sampling mdoe by e=
xecuting
> the following commands:
>=20
> |echo 1 > /sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage4=
_en
> |echo 25 > /sys/bus/iio/devices/iio\:device0/buffer/length
> |echo 1 > /sys/bus/iio/devices/iio\:device0/buffer/enable
> |sleep 1
> |echo 0 > /sys/bus/iio/devices/iio\:device0/buffer/enable
> |cat /dev/iio\:device0 > iio
> |hexdump -C iio
>=20
> and the output is:
> |00000000  37 02 92 02 1f 07 0a 06  20 06 31 06 2f 07 2a 07
> |00000010  2b 07 2d 07 2c 07 28 07  2c 07 2b 07 2b 07 0c 06
> |00000020  21 06 32 06 2e 07 2c 07  2a 07 2a 07 2c 07 2b 07
> |00000030  29 07 27 07 28 07 29 07  2a 07 0d 06 21 06 35 06
>=20
> The first entry is in the range that I would expect. The second is
> slitghly higher. The third and following entries are out of range. Ha=
ve
> you observed something like that? Is my testing close to what you hav=
e
> done or did I make an mistake here?

I can't read the hex dump easily..

Keep in mind that the driver now uses 16 bit storage.=20

Also, I used generic_buffer.c after removing the trigger checks.

The driver would report stable values for 1.8V on one channel and gnd
on another channel.

Hope this helps
ZubairLK

>=20
> Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
