From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Fri, 13 Oct 2017 15:58:43 -0700
Message-ID: <20171013225843.2ejc2e5wzdckzxil@dtor-ws>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
 <20171013180221.76b67869cf4eed7eeec3f56f@ao2.it>
 <1507912842.5910.39.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:47205 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbdJMW6q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 18:58:46 -0400
Content-Disposition: inline
In-Reply-To: <1507912842.5910.39.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Antonio Ospite <ao2@ao2.it>, Marcin Niestroj <m.niestroj@grinn-global.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Oct 13, 2017 at 06:40:42PM +0200, Bastien Nocera wrote:
> On Fri, 2017-10-13 at 18:02 +0200, Antonio Ospite wrote:
> > On Thu, 12 Oct 2017 17:04:42 +0200
> > Marcin Niestroj <m.niestroj@grinn-global.com> wrote:
> > 
> > > Support was added based on Goodix GitHub repo [1]. There are two
> > > major
> > > differences between gt1151 and currently supported devices (gt9x):
> > >  * CONFIG_DATA register has 0x8050 address instead of 0x8047,
> > >  * config data checksum has 16-bit width instead of 8-bit.
> > > 
> > > Also update goodix_i2c_test() function, so it reads ID register
> > > (which
> > > has the same address for all devices) instead of CONFIG_DATA
> > > (because
> > > its address is known only after reading ID of the device).
> > > 
> > > [1] https://github.com/goodix/gt1x_driver_generic
> > > 
> > > Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> > > ---
> > > Patch was developed and tested on top of 4.14-rc4 using custom
> > > board.
> > > 
> > 
> > Just a suggestion, you could use a function pointer for the
> > device-specific checksum routines and have the check on the device id
> > only once in goodix_ts_probe(), see below.
> 
> Function pointer is fine, but this is how I'd implement it:
> 
> typedef enum {
>   GOODIX_CONFIG_TYPE_GT911 = 0,
>   GOODIX_CONFIG_TYPE_GT1151
> } GoodixConfigType;
> 
> static func_pointer config_funcs[] = {
>   goodix_gt911_get_config,
>   goodix_gt1151_get_config
> };
> 
> Store the GoodixConfigType in the device structure, and access the
> function pointer as:
> config_funcs[config_type] (...
> 
> That's what I'd prefer, but whatever Dmitry prefers style-wise. This
> seems more extensible in case we have different functions needing
> similar changes in the future, allowing us to either extend the
> function pointer array, or use switch/case statements for smaller
> functions.

My preference would be to assign constant chip data, such as register,
to the relevant device ID structure (I2C or OF or ACPI) and reference it
form where it is needed.

struct goodix_chip_data {
	u16	config_addr; 
};

...

struct goodix_ts_data {
	...
	const struct goodix_chip_data *chip;
	...
};

...

static const goodix_chip_data gt1x_chip_data = {
	.config_addr	= GOODIX_GT1X_REG_CONFIG_DATA,
};

static const goodix_chip_data gt9x_chip_data = {
	.config_addr	= GOODIX_GT9X_REG_CONFIG_DATA,
};

static const struct of_device_id goodix_of_match[] = {
	{ .compatible = "goodix,gt1151", .data = &gt1x_chip_data },
	...
};

and so on...

Thanks.

-- 
Dmitry
