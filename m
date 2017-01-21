From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: soc_button_array - Set input device name
Date: Sat, 21 Jan 2017 11:13:28 -0800
Message-ID: <20170121191328.GC36944@dtor-ws>
References: <20170109175707.12854-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35407 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdAUTNc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 14:13:32 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so7485583pfa.2
        for <linux-input@vger.kernel.org>; Sat, 21 Jan 2017 11:13:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170109175707.12854-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Mon, Jan 09, 2017 at 06:57:06PM +0100, Hans de Goede wrote:
> On some tablets using the soc_button_array driver the buttons do not
> follow the standard home, power, volume_up, volume_down, rotation_lock
> button order as published by Microsoft.
> 
> We can use the existing udev hwdb mechanism to fix this up, but then
> the created devices must have a unique name, therefor this commit adds
> a unique name for the 2 created gpio-keys input devices.

Why does it have to have unique name? You should be able to match on
other input device properties, for example ATTR{capabilities/ev} or
ATTR{capabilities/keys} to identify the device you want to adjust.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/misc/soc_button_array.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 9bc1b20..d2e5186 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -113,6 +113,11 @@ soc_button_device_create(struct platform_device *pdev,
>  	gpio_keys_pdata->nbuttons = n_buttons;
>  	gpio_keys_pdata->rep = autorepeat;
>  
> +	if (autorepeat)
> +		gpio_keys_pdata->name = "SoC Button Array (autorepeat buttons)";
> +	else
> +		gpio_keys_pdata->name = "SoC Button Array";
> +
>  	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
>  	if (!pd) {
>  		error = -ENOMEM;
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
