From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Tue, 9 Feb 2010 09:07:31 +0800
Message-ID: <f17812d71002081707u7d65d42byc7a3914bf9e4cc36@mail.gmail.com>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:53368 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0BIBHw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 20:07:52 -0500
Received: by qw-out-2122.google.com with SMTP id 9so777142qwb.37
        for <linux-input@vger.kernel.org>; Mon, 08 Feb 2010 17:07:51 -0800 (PST)
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

Just noted the exhausted retries are for 0-005d, you sure this is
max7319 instead of something else, as I was seeing the max7319
address to be 0x6c in the setup above?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
