From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/05] input: RMI4 F01 device control
Date: Thu, 31 Jan 2013 00:08:59 -0800
Message-ID: <20130131080859.GA4356@core.coreip.homeip.net>
References: <1358557965-29065-1-git-send-email-cheiny@synaptics.com>
 <1358557965-29065-5-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358557965-29065-5-git-send-email-cheiny@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-input@vger.kernel.org

Hi Chris,

On Fri, Jan 18, 2013 at 05:12:44PM -0800, Christopher Heiny wrote:
> In addition to the changes described in 0/0 of this patchset, this patch
> includes device serialization updated to conform to the latest RMI4
> specification.

I was looking at the various aspects of the RMI4 patchset, trying to
fix the issues that I see, but there is one big issue that I simply do
not have time to tackle - the driver is completely broken on big endian
architectures due to reliance on bitfileds when exchanging the data with
the device.

Consider the following structures:

>  struct f01_device_status {
> -	u8 status_code:4;
> +	enum rmi_device_status status_code:4;
>  	u8 reserved:2;
>  	u8 flash_prog:1;
>  	u8 unconfigured:1;
> @@ -159,4 +136,113 @@ struct f01_device_control_0 {
>  	u8 configured:1;
>  } __attribute__((__packed__));
>  
> +/**
> + * @reset - set this bit to force a firmware reset of the sensor.
> + */
> +struct f01_device_commands {
> +	u8 reset:1;
> +	u8 reserved:7;
> +};
> +

To make this work on BE boxes you either need to add #ifdefs to the
structures reversing the order of fields or use bit shifts and masks to
get/set specific bits in bytes.

I tried converting F01 code (you can see the [likely broken as I can't
test] result in my tree), but I really do not have time for F11.

Thanks.

-- 
Dmitry
