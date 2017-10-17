From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Tue, 17 Oct 2017 11:40:01 +0200
Message-ID: <929df0d1-b9d9-de8a-3dd0-b95cb5e6be16@grinn-global.com>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
 <20171013180221.76b67869cf4eed7eeec3f56f@ao2.it>
 <1507912842.5910.39.camel@hadess.net>
 <20171013225843.2ejc2e5wzdckzxil@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013225843.2ejc2e5wzdckzxil@dtor-ws>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Antonio Ospite <ao2-qKGr9MkilAE@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,
Thanks everyone for review!

On 14.10.2017 00:58, Dmitry Torokhov wrote:
> <...snip...>
> My preference would be to assign constant chip data, such as register,
> to the relevant device ID structure (I2C or OF or ACPI) and reference it
> form where it is needed.
> 
> struct goodix_chip_data {
> 	u16	config_addr;
> };
> 
> ...
> 
> struct goodix_ts_data {
> 	...
> 	const struct goodix_chip_data *chip;
> 	...
> };
> 
> ...
> 
> static const goodix_chip_data gt1x_chip_data = {
> 	.config_addr	= GOODIX_GT1X_REG_CONFIG_DATA,
> };
> 
> static const goodix_chip_data gt9x_chip_data = {
> 	.config_addr	= GOODIX_GT9X_REG_CONFIG_DATA,
> };
> 
> static const struct of_device_id goodix_of_match[] = {
> 	{ .compatible = "goodix,gt1151", .data = &gt1x_chip_data },
> 	...
> };
> 
> and so on...
> 
> Thanks.
> 

This looks good to me. Together with config_addr I would put config_len
to struct goodix_chip_data (and remove cfg_len member from struct
goodix_ts_data).

The main problem I have is how to assign goodix_chip_data to a ACPI
device (I have very little knowledge about ACPI). I do not know from
where comes 'GDIX1001' ACPI ID and how it corresponds to OF compatible
strings. Can you help me with that?

I have something like that so far:

struct goodix_chip_data {
         u16 config_addr;
         int config_len;
         int config_checksum_len;
};

...

static const goodix_chip_data gt1x_chip_data = {
	.config_addr		= GOODIX_GT1X_REG_CONFIG_DATA,
	.config_len		= GOODIX_CONFIG_MAX_LENGTH,
	.config_checksum_len	= 2,
};

static const goodix_chip_data gt911_chip_data = {
	.config_addr		= GOODIX_GT9X_REG_CONFIG_DATA,
	.config_len		= GOODIX_CONFIG_911_LENGTH,
	.config_checksum_len	= 1,
};

static const goodix_chip_data gt967_chip_data = {
	.config_addr		= GOODIX_GT9X_REG_CONFIG_DATA,
	.config_len		= GOODIX_CONFIG_967_LENGTH,
	.config_checksum_len	= 1,
};

...

static const struct of_device_id goodix_of_match[] = {
	{ .compatible = "goodix,gt1151", .data = &gt1x_chip_data },
	{ .compatible = "goodix,gt911",  .data = &gt911_chip_data },
	{ .compatible = "goodix,gt9110", .data = &gt911_chip_data },
	{ .compatible = "goodix,gt912",  .data = &gt967_chip_data },
	{ .compatible = "goodix,gt927",  .data = &gt911_chip_data },
	{ .compatible = "goodix,gt9271", .data = &gt911_chip_data },
	{ .compatible = "goodix,gt928",  .data = &gt911_chip_data },
	{ .compatible = "goodix,gt967",  .data = &gt967_chip_data },
	{ }
};

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
