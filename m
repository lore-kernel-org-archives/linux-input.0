From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Mon, 8 Feb 2010 14:02:20 +0800
Message-ID: <f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:42701 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0BHGCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 01:02:40 -0500
Received: by qw-out-2122.google.com with SMTP id 9so605629qwb.37
        for <linux-input@vger.kernel.org>; Sun, 07 Feb 2010 22:02:40 -0800 (PST)
In-Reply-To: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jebediah Huang <jebediah.huang@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 8, 2010 at 1:44 PM, Jebediah Huang <jebediah.huang@gmail.co=
m> wrote:
> Hello ,
>
> I have PXA166 board with MAX7319 GPIO expander connected with 8
> buttons. When any button is pressed, I want to get input event. Can
> this be done?
>
> I have read the littleton and aspenite code to try. The SDA is 105,
> SCL is 106. I use MAX732x driver. It is set as I2C slave at 0x6C. So =
I
> set up:
>
> static struct i2c_pxa_platform_data pwri2c_info __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.use_pio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 1,
> };
>
> static unsigned long peony_pin_config[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* i2c bus */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIO105_CI2C_SDA,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIO106_CI2C_SCL,
> }
>
> static struct max732x_platform_data max7319_data[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio_base =C2=
=A0 =C2=A0 =C2=A0=3D GPIO_EXT0(0),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> };
>
> static struct i2c_board_info i2c_board_info[] =3D
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D "max7319",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.addr =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x6C,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IRQ_GPIO(105),

This doesn't look correct, if max7319 is ever able to interrupt the hos=
t
CPU, this should be something other than SDA.

However, this isn't supposed to be the reason for the failure. The
failure looks like an I2C communication issue to me, which means:

1. the i2c host driver isn't setup correctly
2. pin setup
3. max7319 power supply and chip select
4. i2c bus (incorrect pull-up/down etc)
5. i2c device address

I'd recommend an oscilloscope/LA for the I2C protocol on the lines
to identify the real issue.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_data=
 =C2=A0=3D &max7319_data[0],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> };
>
> when bootup I see;
> <6>[ =C2=A0 =C2=A00.290770] I2C: i2c-0: PXA I2C adapter
> <6>[ =C2=A0 =C2=A00.307118] I2C: i2c-1: PXA I2C adapter
> <6>[ =C2=A0 =C2=A00.821709] hello pony_init
> <3>[ =C2=A0 =C2=A00.838559] platform_driver_register
> <6>[ =C2=A0 =C2=A00.868069] max732x_read: read g 1
> <6>[ =C2=A0 =C2=A00.881893] max732x_read: read g 0
> <4>[ =C2=A0 =C2=A00.898895] i2c: error: exhausted retries
> <4>[ =C2=A0 =C2=A00.911947] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
> <4>[ =C2=A0 =C2=A00.927509] i2c: ICR: 000007e0 ISR: 00000002
> <4>[ =C2=A0 =C2=A00.927526] i2c: log: [00000006:00000000] [00000006:0=
0000000]
> [00000006:00000000] [00000006:00000000] [00000006:00000000]
> [00000006:00000000] [0000000
> <3>[ =C2=A0 =C2=A01.167890] dummy 0-005d: failed reading
> <5>[ =C2=A0 =C2=A01.182585] SCSI subsystem initialized
>
> Maybe max732x driver is not getting correct data from my setup? No
> event when pressing button. If any ideas?
>
> Thank you very much!
> Jeb
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
