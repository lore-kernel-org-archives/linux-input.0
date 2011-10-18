From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v6 3/3] Input: cyttsp - add support for Cypress TTSP
 touchscreen SPI bus interface
Date: Tue, 18 Oct 2011 10:48:11 +0200
Message-ID: <CAAwP0s0GhCXHUrVC2_PKC8pyTiRq_fdCZa3x6mStwuROLJOGQA@mail.gmail.com>
References: <4e99d2db.473ce30a.3c78.7a57@mx.google.com> <CAM=Q2cuHY3Xi_3J8y5iDoXnQZORv9WHhmthEX-GH1jXCd++8UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63509 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1JRIsc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 04:48:32 -0400
In-Reply-To: <CAM=Q2cuHY3Xi_3J8y5iDoXnQZORv9WHhmthEX-GH1jXCd++8UA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 18, 2011 at 10:27 AM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:
>
>
> On Sun, Oct 16, 2011 at 12:07 AM, <martinez.javier@gmail.com> wrote:
>>
>> From: Javier Martinez Canillas <martinez.javier@gmail.com>
>>
>> The driver is composed of a core driver that process the data sent b=
y
>> the contacts and a set of bus specific interface modules.
>>
>> This patch add supports for the Cypress TTSP SPI bus interface.
>>
>> Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
>> ---
>>
>> v2: Fix issues called out by Dmitry Torokhov
>> =C2=A0 =C2=A0 - Extract the IRQ from the spi client data and pass to
>> cyttsp_core_init()
>> =C2=A0 =C2=A0 - Remove the extra retries and limit the retries to th=
e cyttsp_core.c
>> =C2=A0 =C2=A0 =C2=A0 read/write block functions.
>> =C2=A0 =C2=A0 - Cleanup cyttsp_spi_xfer(), check ACK in write operat=
ion and fix
>> special
>> =C2=A0 =C2=A0 =C2=A0 EIO case to show its meaning.
>>
>> v3: Fix issues called out by Henrik Rydberg and Mohan Pallaka
>> =C2=A0 =C2=A0- Remove bus type info since it is not used.
>>
>> =C2=A0drivers/input/touchscreen/cyttsp/cyttsp_spi.c | =C2=A0295
>> +++++++++++++++++++++++++
>> =C2=A01 files changed, 295 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/input/touchscreen/cyttsp/cyttsp_spi=
=2Ec
>>
>> diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_spi.c
>> b/drivers/input/touchscreen/cyttsp/cyttsp_spi.c
>> new file mode 100644
>> index 0000000..66d6dc3
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/cyttsp/cyttsp_spi.c
>> @@ -0,0 +1,295 @@
>> +/*
>> + * Source for:
>> + * Cypress TrueTouch(TM) Standard Product (TTSP) SPI touchscreen dr=
iver.
>> + * For use with Cypress Txx3xx parts.
>> + * Supported parts include:
>> + * CY8CTST341
>> + * CY8CTMA340
>> + *
>> + * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
>> + * Copyright (C) 2011 Javier Martinez Canillas
>> <martinez.javier@gmail.com>
>> + *
>> + * Multi-touch protocol type B support and cleanups by Javier Marti=
nez
>> Canillas
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2, and only version 2, as published by the
>> + * Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See t=
he
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> along
>> + * with this program; if not, write to the Free Software Foundation=
,
>> Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
>> + *
>> + * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.co=
m>
>> + *
>> + */
>> +
>> +#include "cyttsp_core.h"
>> +
>> +#include <linux/spi/spi.h>
>> +#include <linux/delay.h>
>> +
>> +#define CY_SPI_WR_OP =C2=A0 =C2=A0 =C2=A00x00 /* r/~w */
>> +#define CY_SPI_RD_OP =C2=A0 =C2=A0 =C2=A00x01
>> +#define CY_SPI_CMD_BYTES =C2=A04
>> +#define CY_SPI_SYNC_BYTE =C2=A02
>> +#define CY_SPI_SYNC_ACK1 =C2=A00x62 /* from protocol v.2 */
>> +#define CY_SPI_SYNC_ACK2 =C2=A00x9D /* from protocol v.2 */
>> +#define CY_SPI_DATA_SIZE =C2=A0128
>> +#define CY_SPI_DATA_BUF_SIZE (CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
>> +#define CY_SPI_BITS_PER_WORD 8
>> +
>> +struct cyttsp_spi {
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_bus_ops bus_ops;
>> + =C2=A0 =C2=A0 =C2=A0 struct spi_device *spi_client;
>> + =C2=A0 =C2=A0 =C2=A0 void *ttsp_client;
>> + =C2=A0 =C2=A0 =C2=A0 u8 wr_buf[CY_SPI_DATA_BUF_SIZE];
>> + =C2=A0 =C2=A0 =C2=A0 u8 rd_buf[CY_SPI_DATA_BUF_SIZE];
>> +};
>> +
>> +static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0u8 reg, u8 *buf, int length)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
>> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfer[2];
>> + =C2=A0 =C2=A0 =C2=A0 u8 *wr_buf =3D ts->wr_buf;
>> + =C2=A0 =C2=A0 =C2=A0 u8 *rd_buf =3D ts->rd_buf;
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (length > CY_SPI_DATA_SIZE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->bus_o=
ps.dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 "%s: length %d is too big.\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__, length);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 memset(wr_buf, 0, CY_SPI_DATA_BUF_SIZE);
>> + =C2=A0 =C2=A0 =C2=A0 memset(rd_buf, 0, CY_SPI_DATA_BUF_SIZE);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 wr_buf[0] =3D 0x00; /* header byte 0 */
>> + =C2=A0 =C2=A0 =C2=A0 wr_buf[1] =3D 0xFF; /* header byte 1 */
>> + =C2=A0 =C2=A0 =C2=A0 wr_buf[2] =3D reg; =C2=A0/* reg index */
>> + =C2=A0 =C2=A0 =C2=A0 wr_buf[3] =3D op; =C2=A0 /* r/~w */
>> + =C2=A0 =C2=A0 =C2=A0 if (op =3D=3D CY_SPI_WR_OP)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(wr_buf + C=
Y_SPI_CMD_BYTES, buf, length);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 memset((void *)xfer, 0, sizeof(xfer));
>> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&msg);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 We set both TX and RX buffers because =
Cypress TTSP
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 requires full duplex operation.
>> + =C2=A0 =C2=A0 =C2=A0 */
>> + =C2=A0 =C2=A0 =C2=A0 xfer[0].tx_buf =3D wr_buf;
>> + =C2=A0 =C2=A0 =C2=A0 xfer[0].rx_buf =3D rd_buf;
>> + =C2=A0 =C2=A0 =C2=A0 if (op =3D=3D CY_SPI_WR_OP) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfer[0].len =3D l=
ength + CY_SPI_CMD_BYTES;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_message_add_t=
ail(&xfer[0], &msg);
>> + =C2=A0 =C2=A0 =C2=A0 } else if (op =3D=3D CY_SPI_RD_OP) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfer[0].len =3D C=
Y_SPI_CMD_BYTES;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_message_add_t=
ail(&xfer[0], &msg);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfer[1].rx_buf =3D=
 buf;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfer[1].len =3D l=
ength;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_message_add_t=
ail(&xfer[1], &msg);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D spi_sync(ts->spi_client, &msg);
>> + =C2=A0 =C2=A0 =C2=A0 if (retval < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->bus_o=
ps.dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 "%s: spi_sync() error %d, len=3D%d, op=3D%d\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__, retval, xfer[1].len, op);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* do not re=
turn here since was a bad ACK sequence
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* let the f=
ollowing ACK check handle any errors and
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* allow sil=
ent retries
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if ((rd_buf[CY_SPI_SYNC_BYTE] =3D=3D CY_SPI_S=
YNC_ACK1) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rd_buf[CY_SPI_SYNC_BYTE+1] =3D=
=3D CY_SPI_SYNC_ACK2))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i <=
 (CY_SPI_CMD_BYTES); i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_dbg(ts->bus_ops.dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s: test rd_buf[%d]:0x%02x\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, i, rd_buf[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i <=
 (length); i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_dbg(ts->bus_ops.dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s: test buf[%d]:0x%02x\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, i, buf[i]);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* signal ACK err=
or so silent retry */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static s32 ttsp_spi_read_block_data(void *handle, u8 addr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 length, void *d=
ata)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_spi *ts =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(hand=
le, struct cyttsp_spi, bus_ops);
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D cyttsp_spi_xfer(CY_SPI_RD_OP, ts, =
addr, data, length);
>> + =C2=A0 =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: ttsp_=
spi_read_block_data failed\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Do not print the above error if the d=
ata sync bytes were not
>> found.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is a normal condition for the bo=
otloader loader startup
>> and need
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* to retry until data sync bytes are fo=
und.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 if (retval > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D -EIO; =
=C2=A0/* now signal fail; so retry can be done
>> */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static s32 ttsp_spi_write_block_data(void *handle, u8 addr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 length, c=
onst void *data)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_spi *ts =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(hand=
le, struct cyttsp_spi, bus_ops);
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D cyttsp_spi_xfer(CY_SPI_WR_OP, ts, =
addr, (void *)data,
>> length);
>> + =C2=A0 =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: ttsp_=
spi_write_block_data failed\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Do not print the above error if the d=
ata sync bytes were not
>> found.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is a normal condition for the bo=
otloader loader startup
>> and need
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* to retry until data sync bytes are fo=
und.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 if (retval > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D -EIO; =
=C2=A0/* now signal fail; so retry can be done
>> */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static s32 ttsp_spi_tch_ext(void *handle, void *values)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_spi *ts =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(hand=
le, struct cyttsp_spi, bus_ops);
>> + =C2=A0 =C2=A0 =C2=A0 int retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: Add custom touch extension hand=
ling code here
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* set: retval < 0 for any returned syst=
em errors,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0retval =3D 0 if n=
ormal touch handling is required,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0retval > 0 if nor=
mal touch handling is *not* required
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>
> This is an empty function and could be removed?
>
>

Hi Shubhrajyoti,

Yes, I'll remove it and also fix the other issues called out by you
and resend the patch-set as v7.

Thanks a lot for the review and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
