From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Mon, 8 Feb 2010 08:36:13 +0100
Message-ID: <20100208073612.GV28972@buzzloop.caiaq.de>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
 <f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
 <bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:36845 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab0BHHg1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 02:36:27 -0500
Content-Disposition: inline
In-Reply-To: <bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jebediah Huang <jebediah.huang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 08, 2010 at 03:02:14PM +0800, Jebediah Huang wrote:
> On Mon, Feb 8, 2010 at 2:02 PM, Eric Miao <eric.y.miao@gmail.com> wro=
te:
> > On Mon, Feb 8, 2010 at 1:44 PM, Jebediah Huang <jebediah.huang@gmai=
l.com> wrote:
> >> static struct i2c_board_info i2c_board_info[] =3D
> >> {
> >> =A0 =A0 =A0 =A0{
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D "max7=
319",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.addr =A0 =A0 =A0 =A0 =A0 =3D 0x6C,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ=
_GPIO(105),
> >
> > This doesn't look correct, if max7319 is ever able to interrupt the=
 host
> > CPU, this should be something other than SDA.
>=20
> Thank you. I remove irq now. It is not used.

If you didn't wire an IRQ from the max7319 to your CPU, you can't easil=
y
use it as an input device. I2C is a polled bus, all transactions are
always initiated from the CPU side. So you would need to 'ask' the chip
constantly for its current state, which is not good.

The INT line should be connected to some GPIO on your PXA so the chip
can actively let the PXA know when any input line stated changed.
Everything else makes very little sense.

> I test hardware is ok. I test with this:
>  {
>         int fd, t;
>         int i;
>         char buf[512];
>         fd =3D open("/dev/i2c-0", O_RDWR);
>         printf("fd=3D%d\n",fd);
>         t =3D ioctl(fd, I2C_SLAVE, 0x6c);
>         printf("t=3D%d\n",t);
>         memset(buf,0,512);
>         t =3D read(fd,buf,512);
>         printf("t=3D%d\n",t);
>         for(i=3D0;i<t;i++) {
>         printf("0x%x,",buf[i]);
>         }
>         printf("\n");
>         exit(0);
> }
>=20
> output if max732x enabled is:
> # ./i2ctest
> [  184.070025] i2c: error: exhausted retries
> fd=3D3
> t=3D-1
> [  184.074256] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
> [  184.080428] i2c: ICR: 000007e0 ISR: 00000002
> [  184.080444] i2c: log: [00000006:00000000] [00000006:00000000]
> [00000006:00000000] [00000006:00000000] [00000006:00000000]
> [00000006:00000000] [00000006:00
> 000000] [00000006:00000000] [00000006:00000000] [00000006:00000000]
> [00000006:00000000] [00000007:00000000] [00000447:000007e0]
> t=3D-1

How do you enable/disable the chip? As Eric said, the error above
indicates an eletrical issue with the bus.=20

> disable max732x is:
> # ./i2ctest no button pressed

What are you testing without the chip?

Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
