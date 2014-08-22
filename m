From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [RESEND PATCH 6/7] mfd: cros_ec: Instantiate sub-devices from
 device tree
Date: Fri, 22 Aug 2014 13:27:43 +0200
Message-ID: <53F7292F.2000705@collabora.co.uk>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk> <1408536812-7836-7-git-send-email-javier.martinez@collabora.co.uk> <20140821142542.GN4266@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140821142542.GN4266@lee--X1>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Lee,

On 08/21/2014 04:25 PM, Lee Jones wrote:
>>  
>>  static const struct mfd_cell cros_devs[] = {
>> -	{
>> -		.name = "cros-ec-keyb",
>> -		.id = 1,
>> -		.of_compatible = "google,cros-ec-keyb",
>> -	},
>> -	{
>> -		.name = "cros-ec-i2c-tunnel",
>> -		.id = 2,
>> -		.of_compatible = "google,cros-ec-i2c-tunnel",
>> -	},
>>  };
> 
> Why are you keeping this round if it's empty?
>

Right, I'll just remove it.

>>  	}
>> +#ifdef CONFIG_OF
>> +	/*
>> +	 * Add sub-devices declared in the device tree.  NOTE they should NOT be
>> +	 * declared in cros_devs
>> +	 */
>> +	for_each_child_of_node(dev->of_node, node) {
>> +		char name[128];
>> +		struct mfd_cell cell = {
>> +			.id = 0,
>> +			.name = name,
>> +		};
>> +
>> +		if (of_modalias_node(node, name, sizeof(name)) < 0) {
>> +			dev_err(dev, "modalias failure on %s\n",
>> +				node->full_name);
>> +			continue;
>> +		}
>> +		dev_dbg(dev, "adding MFD sub-device %s\n", node->name);
>> +		cell.of_compatible = of_get_property(node, "compatible", NULL);
>> +		err = mfd_add_devices(dev, ++id, &cell, 1, NULL, ec_dev->irq,
>> +				      NULL);
>> +		if (err)
>> +			dev_err(dev, "fail to add %s\n", node->full_name);
>> +	}
>> +#endif
> 
> This is grim!
> 
> Why don't you use of_platform_populate()?
>

Indeed, I think it may just work and all these is not needed.

Thanks for your feedback and best regards,
Javier
