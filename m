From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC PATCH 0/1] input/touchscreen: Synaptics Touchscreen Driver
Date: Mon, 22 Mar 2010 20:04:09 -0700
Message-ID: <d6200be21003222004g2e2a1000ja65fc3f80f9fad78@mail.gmail.com>
References: <1269310058-10894-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:50041 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab0CWDEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 23:04:11 -0400
In-Reply-To: <1269310058-10894-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>

On Mon, Mar 22, 2010 at 7:07 PM, Christopher Heiny <cheiny@synaptics.co=
m> wrote:
=2E..
> There are two existing drivers for similar Synaptics devices in the
> current kernel tree (excluding the PS/2 touchpad driver). =A0These ar=
e:
>
> ./linux-2.6/drivers/input/mouse/synaptics_i2c.c
> =A0 =A0 =A0A driver for the Exeda 15mm touchpad, written by Mike Rapo=
port
> =A0 =A0 =A0<mike@compulab.co.il> and Igor Grinberg <grinberg@compulab=
=2Eco.il>
>
> ./linux-2.6/drivers/staging/dream/synaptics_i2c_rmi.c
> =A0 =A0 =A0A driver for the HTC Dream ClearPad, written by Arve Hj=F8=
nnev=E5g
> =A0 =A0 =A0<arve@android.com>
>
> We have not extended these drivers for a couple of reasons. =A0First,=
 the
> two drivers are specific to particular Synaptics products, and it is =
our
> desire to produce a general solution that takes advantage of the 'sel=
f
> describing' features of products that use the RMI protocol.
>

Do you plan to add platform data to align the reported touchscreen
data with the screen behind it, or do the new hardware allow the the
firmware handle this? In the past we even needed separate parameters
for different firmware versions (seen in
drivers/staging/dream/synaptics_i2c_rmi.h).

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
