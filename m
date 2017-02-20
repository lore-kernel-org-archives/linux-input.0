From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [RFC/RFT PATCH 1/3] Input: ad7879 - convert to use regmap
Date: Mon, 20 Feb 2017 17:09:44 +0100
Message-ID: <f80e36c9-8fc5-2faf-dfa6-df356ec9d4d2@analog.com>
References: <20170217233152.31715-1-dmitry.torokhov@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:34880
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753493AbdBTQIf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 11:08:35 -0500
In-Reply-To: <20170217233152.31715-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 18.02.2017 00:31, Dmitry Torokhov wrote:
> Instead of rolling our own infrastructure to provide uniform access to I2C
> and SPI buses, let's switch to using regmap.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Michael,
>
> I am a bit (actually a lot) confused how this driver was working with SPI
> and Blackfin, which is, as far as I understand, little-endian, because from
> my reading of the spec the data on wire is big-endian. If this is not
> correct we need to change spi regmap config to be:
>
> static const struct regmap_config ad7879_spi_regmap_config = {
> 	.reg_bits = 16,
> 	.val_bits = 16,
> 	.max_register = 15,
> 	.read_flag_mask = AD7879_CMD_MAGIC | AD7879_CMD_READ,
> 	.write_flag_mask = AD7879_CMD_MAGIC,
> 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
> 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
> };
>
> Also, the original ad7879_spi_xfer was funky to tell the least. We
> allocated n+2 spi_transfer structures, then smashed the beginning of the
> first one with u16 command, then basically "restored" it???
>
> Anyway, if you could try it out (and fix ;) ), that would be great.

Hi Dimitry,

Thanks for doing this.
Overall looks great, but i definitely need to test this.
Your right this xfer functions looks awkward.
I'll review and get back to you.



-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
