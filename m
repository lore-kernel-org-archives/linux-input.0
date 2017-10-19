From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Wed, 18 Oct 2017 17:47:41 -0700
Message-ID: <20171019004741.qdnbhkxtkuxnx2uw@dtor-ws>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
 <20171013180221.76b67869cf4eed7eeec3f56f@ao2.it>
 <1507912842.5910.39.camel@hadess.net>
 <20171013225843.2ejc2e5wzdckzxil@dtor-ws>
 <929df0d1-b9d9-de8a-3dd0-b95cb5e6be16@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:51003 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdJSArp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Oct 2017 20:47:45 -0400
Content-Disposition: inline
In-Reply-To: <929df0d1-b9d9-de8a-3dd0-b95cb5e6be16@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Oct 17, 2017 at 11:40:01AM +0200, Marcin Niestroj wrote:
> Hi,
> Thanks everyone for review!
> 
> On 14.10.2017 00:58, Dmitry Torokhov wrote:
> > <...snip...>
> > My preference would be to assign constant chip data, such as register,
> > to the relevant device ID structure (I2C or OF or ACPI) and reference it
> > form where it is needed.
> > 
> > struct goodix_chip_data {
> > 	u16	config_addr;
> > };
> > 
> > ...
> > 
> > struct goodix_ts_data {
> > 	...
> > 	const struct goodix_chip_data *chip;
> > 	...
> > };
> > 
> > ...
> > 
> > static const goodix_chip_data gt1x_chip_data = {
> > 	.config_addr	= GOODIX_GT1X_REG_CONFIG_DATA,
> > };
> > 
> > static const goodix_chip_data gt9x_chip_data = {
> > 	.config_addr	= GOODIX_GT9X_REG_CONFIG_DATA,
> > };
> > 
> > static const struct of_device_id goodix_of_match[] = {
> > 	{ .compatible = "goodix,gt1151", .data = &gt1x_chip_data },
> > 	...
> > };
> > 
> > and so on...
> > 
> > Thanks.
> > 
> 
> This looks good to me. Together with config_addr I would put config_len
> to struct goodix_chip_data (and remove cfg_len member from struct
> goodix_ts_data).
> 
> The main problem I have is how to assign goodix_chip_data to a ACPI
> device (I have very little knowledge about ACPI). I do not know from
> where comes 'GDIX1001' ACPI ID and how it corresponds to OF compatible
> strings. Can you help me with that?

Hmm, wait a second... Looking at the driver we can fetch the product ID
form the chip, so we do not really need to put this into OF or ACPI
tables, but rather set up the "chip" pointer dynamically when we probe
the device.

Thanks.

-- 
Dmitry
