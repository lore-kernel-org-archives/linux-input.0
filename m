From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add support for Google Pixel 2
Date: Thu, 9 Apr 2015 09:29:56 -0700
Message-ID: <20150409162956.GA35815@dtor-ws>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
 <55265DBC.4020104@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36614 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbbDIQaB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Apr 2015 12:30:01 -0400
Content-Disposition: inline
In-Reply-To: <55265DBC.4020104@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Olof Johansson <olof@lixom.net>

Hi Nick,

On Thu, Apr 09, 2015 at 12:08:44PM +0100, Nick Dyer wrote:
> On 08/04/15 01:26, Dmitry Torokhov wrote:
> > This change allows atmel_mxt_ts to bind to ACPI-enumerated devices in
> > Google Pixel 2 (2015).
> 
> Can you point me to any instructions for testing this on the Pixel 2 we
> have here?

I just installed Fedora 21, updated fully, and rebuild 4.0+ kernel with
their default config file.

To install Fedora switch the unit into developer mode, then, in Chrome
OS do "sudo crossystem dev_boot_legacy=1"), reboot, and after hitting
"Ctrl-L" early in teh boot sequence it should offer you to boot form USB
stick (that you dd'ed Fedora's Live ISO image - x86_64 - onto) and you
can install from there.

> 
> > While newer version of ACPI standard allow use of device-tree-like
> > properties in device descriptions, the version of ACPI implemented in
> > Google BIOS does not support them, and we have to resort to DMI data to
> > specify exact characteristics of the devices (touchpad vs. touchscreen,
> > GPIO to button mapping, etc).
> > 
> > Pixel 1 continues to use i2c devices and platform data created by
> > chromeos-laptop driver, since ACPI does not enumerate them.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 149 +++++++++++++++++++++++++++----
> >  1 file changed, 134 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 2875ddf..dfc7309 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -14,6 +14,8 @@
> >   *
> >   */
> >  
> > +#include <linux/acpi.h>
> > +#include <linux/dmi.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/completion.h>
> > @@ -724,15 +726,15 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
> >  {
> >  	struct input_dev *input = data->input_dev;
> >  	const struct mxt_platform_data *pdata = data->pdata;
> > -	bool button;
> >  	int i;
> >  
> > -	/* Active-low switch */
> >  	for (i = 0; i < pdata->t19_num_keys; i++) {
> >  		if (pdata->t19_keymap[i] == KEY_RESERVED)
> >  			continue;
> > -		button = !(message[1] & (1 << i));
> > -		input_report_key(input, pdata->t19_keymap[i], button);
> > +
> > +		/* Active-low switch */
> > +		input_report_key(input, pdata->t19_keymap[i],
> > +				 !(message[1] & BIT(i)));
> >  	}
> >  }
> >  
> > @@ -2371,7 +2373,7 @@ static void mxt_input_close(struct input_dev *dev)
> >  }
> >  
> >  #ifdef CONFIG_OF
> > -static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> > +static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> >  {
> >  	struct mxt_platform_data *pdata;
> >  	u32 *keymap;
> > @@ -2379,7 +2381,7 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> >  	int proplen, i, ret;
> >  
> >  	if (!client->dev.of_node)
> > -		return ERR_PTR(-ENODEV);
> > +		return ERR_PTR(-ENOENT);
> >  
> >  	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> >  	if (!pdata)
> > @@ -2410,25 +2412,132 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> >  	return pdata;
> >  }
> >  #else
> > -static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> > +static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> >  {
> > -	dev_dbg(&client->dev, "No platform data specified\n");
> > -	return ERR_PTR(-EINVAL);
> > +	return ERR_PTR(-ENOENT);
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_ACPI
> > +
> > +struct mxt_acpi_platform_data {
> > +	const char *hid;
> > +	struct mxt_platform_data pdata;
> > +};
> > +
> > +static unsigned int samus_touchpad_buttons[] = {
> > +	KEY_RESERVED,
> > +	KEY_RESERVED,
> > +	KEY_RESERVED,
> > +	BTN_LEFT
> > +};
> > +
> > +static struct mxt_acpi_platform_data samus_platform_data[] = {
> > +	{
> > +		/* Touchpad */
> > +		.hid	= "ATML0000",
> > +		.pdata	= {
> > +			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
> > +			.t19_keymap	= samus_touchpad_buttons,
> > +		},
> > +	},
> > +	{
> > +		/* Touchscreen */
> > +		.hid	= "ATML0001",
> > +	},
> > +	{ }
> > +};
> 
> It seems a bit wrong to be putting this Pixel-specific platform data in the
> driver file.

Yes, I would love to avoid it, but it int not that we do not have
precedent. We are forced to use a lot of quirks in atkbd.c, synaptics.c
and host of other drivers to account for system quirks. In this
particular case I considered hacking chromeos-laptop to try to provide
platform data, but it is impossible to do cleanly, without leakig memory
all over :( This is because the devices are described in ACPI and so
i2c-core instantiated them for us; but there are no additional data in
ACPI similar to platform data, and ACPI HIDs are shared between all x86
Chromebooks produced so far. If/when we make new x86 ChromeOS
device with Atmel hardware we will make sure to use newer version of
ACPI allowing specifying arbitrary device properties, similar to DT. 

Thanks.

-- 
Dmitry
