From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/1] input: Add support for Kionix KXTJ9 accelerometer
Date: Mon, 16 May 2011 09:40:14 +0100
Message-ID: <4DD0E2EE.7010107@cam.ac.uk>
References: <1305310406-9870-1-git-send-email-chudson@kionix.com>	<1305310406-9870-2-git-send-email-chudson@kionix.com> <20110513192710.5b4791ca@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110513192710.5b4791ca@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Hudson <chudson@kionix.com>
List-Id: linux-input@vger.kernel.org

I'll leave taking a proper look until you have cleared up the issues Alan pointed out.
But as I was taking a quick look...

Firstly I concur entirely with Alan in that most of the sysfs stuff should be
platform data for an input driver.
...
> 
>> +	memcpy(tj9->pdata, client->dev.platform_data, sizeof(*tj9->pdata));
>> +	if (tj9->pdata->init) {
>> +		err = tj9->pdata->init();
>> +		if (err < 0)
>> +			goto err2;
>> +	}
>> +
>> +	tj9->irq = gpio_to_irq(tj9->pdata->gpio);
> 
> What if it's not on a gpio. Probably better any gpio and irq conversion is
> done by the platform callback/init code
Perfectly good irq element in i2c_board_info structure.  This is exactly what
it is normally used for.
> 
> 
> And the sysfs nodes need documentation.
Would be nice to have some docs on that platform data struct as well.
Most of it is fairly obvious, but data_odr_init etc aren't!
> 
> 
> Overall it looks like a lot of input drivers that get posted here
> 
> - Nobody has considered locking between actions and sysfs (or multiple
>   sysfs actions in parallel)
> - Enable/disable is implemented in blissful ignorance of what happens if
>   a disable occurs during a sysfs or other action
> 
> Most of the rest looks like it just needs a good polish.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
