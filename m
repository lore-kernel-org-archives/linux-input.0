From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
Date: Wed, 23 Nov 2011 23:46:03 +0100
Message-ID: <1322088363.18388.13.camel@flow>
References: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49151 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab1KWWqI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 17:46:08 -0500
Received: by bke11 with SMTP id 11so2151923bke.19
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2011 14:46:07 -0800 (PST)
In-Reply-To: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, eric.y.miao@gmail.com, mad_soft@inbox.ru, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com

Am Mittwoch, den 23.11.2011, 16:45 +0000 schrieb Paul Parsons:
> Add support for the Synaptics NavPoint touchpad connected to a PXA27x SSP port
> in SPI slave mode. The driver implements a simple navigation pad. The four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the
> touchpad is mapped to the ENTER button.

Looked good on first glance, but a quick test run of those two patches
against v3.2-rc2 resulted in an Oops in navpoint_int as soon as I
touched the navpoint:

Unable to handle kernel paging request at virtual address 746e696f
...
[<c0184f74>] (__dev_printk+0x24/0x88) from [<c018509c>] (dev_warn
+0x34/0x48)
[<c018509c>] (dev_warn+0x34/0x48) from [<c01c8c8c>] (navpoint_int
+0xb0/0x1e0)
...
(approximately, using CONFIG_FONT_MINI_4x6 from the
magician_defconfig...)

[...]
> +static irqreturn_t navpoint_int(int irq, void *dev)
> +{
> +	struct driver_data *drv_data = dev;
> +	struct ssp_device *ssp = drv_data->ssp;
> +	u32 status;
> +	irqreturn_t ret;
> +
> +	status = pxa_ssp_read_reg(ssp, SSSR);
> +	ret = IRQ_NONE;
> +
> +	if (status & sssr) {
> +		dev_warn(dev, "spurious interrupt: 0x%02x\n", status);

I guess that's because you effectively pass drv_data into dev_warn as
first argument here. Fix that and maybe rename the second parameter of
navpoint_int to void *dev_id to avoid confusion.

I assume I hit this spurious interrupt because I was booting with haret
and you use the SDG bootloader?

best regards
Philipp

