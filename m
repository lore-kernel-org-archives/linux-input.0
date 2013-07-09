From: Ferruh Yigit <fery@cypress.com>
Subject: Re: Input: cyttsp4 - SPI driver for Cypress TMA4XX touchscreen devices
Date: Tue, 9 Jul 2013 10:12:00 +0300
Message-ID: <51DBB7C0.4010106@cypress.com>
References: <20130704235117.733726609A1@gitolite.kernel.org> <CAMuHMdXS=35MVinOPNRKi=bAzVpqvL-QEm+QsciO1Xe-BYzc4Q@mail.gmail.com>
Reply-To: <fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXS=35MVinOPNRKi=bAzVpqvL-QEm+QsciO1Xe-BYzc4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 07/07/2013 10:15 PM, Geert Uytterhoeven wrote:
> On Fri, Jul 5, 2013 at 1:51 AM, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>> +++ b/drivers/input/touchscreen/cyttsp4_spi.c
>
>> +static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
>> +                          u8 op, u8 reg, u8 *buf, int length)
>> +{
>
>> +       if (reg > 255)
>
> As "reg" is "u8", this is never true:
>
> drivers/input/touchscreen/cyttsp4_spi.c: In function =E2=80=98cyttsp_=
spi_xfer=E2=80=99:
> drivers/input/touchscreen/cyttsp4_spi.c:66: warning: comparison is
> always false due to limited range of data type
>
>> +               wr_buf[0] =3D op + CY_SPI_A8_BIT;
>> +       else
>> +               wr_buf[0] =3D op;
>
> Can the if-clause and the first branch just be removed, or is there a=
 real bug
> involved (e.g. wrong type for "reg")?

Yes there was a bug here, and already sent a patch for this, please
check https://patchwork.kernel.org/patch/2820561/

thanks,
ferruh


This message and any attachments may contain Cypress (or its subsidiari=
es) confidential information. If it has been received in error, please =
advise the sender and immediately delete this message.
