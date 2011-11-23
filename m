From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
Date: Thu, 24 Nov 2011 00:04:03 +0100
Message-ID: <CA+gwMcehFsxhua4QTXmtj7dYio+bOKsniC096Gs6YxhoJMrNiw@mail.gmail.com>
References: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
	<1322088363.18388.13.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62695 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab1KWXEE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 18:04:04 -0500
Received: by qyd20 with SMTP id 20so867251qyd.19
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2011 15:04:03 -0800 (PST)
In-Reply-To: <1322088363.18388.13.camel@flow>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, eric.y.miao@gmail.com, mad_soft@inbox.ru, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com

On Wed, Nov 23, 2011 at 11:46 PM, Philipp Zabel <philipp.zabel@gmail.co=
m> wrote:
> Am Mittwoch, den 23.11.2011, 16:45 +0000 schrieb Paul Parsons:
>> Add support for the Synaptics NavPoint touchpad connected to a PXA27=
x SSP port
>> in SPI slave mode. The driver implements a simple navigation pad. Th=
e four
>> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre =
of the
>> touchpad is mapped to the ENTER button.
>
> Looked good on first glance, but a quick test run of those two patche=
s
> against v3.2-rc2 resulted in an Oops in navpoint_int as soon as I
> touched the navpoint:
>
> Unable to handle kernel paging request at virtual address 746e696f
> ...
> [<c0184f74>] (__dev_printk+0x24/0x88) from [<c018509c>] (dev_warn
> +0x34/0x48)
> [<c018509c>] (dev_warn+0x34/0x48) from [<c01c8c8c>] (navpoint_int
> +0xb0/0x1e0)
> ...
> (approximately, using CONFIG_FONT_MINI_4x6 from the
> magician_defconfig...)
>
> [...]
>> +static irqreturn_t navpoint_int(int irq, void *dev)
>> +{
>> + =A0 =A0 struct driver_data *drv_data =3D dev;
>> + =A0 =A0 struct ssp_device *ssp =3D drv_data->ssp;
>> + =A0 =A0 u32 status;
>> + =A0 =A0 irqreturn_t ret;
>> +
>> + =A0 =A0 status =3D pxa_ssp_read_reg(ssp, SSSR);
>> + =A0 =A0 ret =3D IRQ_NONE;
>> +
>> + =A0 =A0 if (status & sssr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "spurious interrupt: 0x%02x\=
n", status);
>
> I guess that's because you effectively pass drv_data into dev_warn as
> first argument here. Fix that and maybe rename the second parameter o=
f
> navpoint_int to void *dev_id to avoid confusion.

Or maybe a better way would be to really pass the device into
irq_request and use dev_get_drvdata like in the suspend/resume
functions.
And to call platform_set_drvdata before irq_request in case it fires
immediately.

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
