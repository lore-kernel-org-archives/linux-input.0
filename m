From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] input: misc: soc_button_array: use
 platform_device_register_resndata()
Date: Tue, 20 Aug 2019 13:16:09 +0200
Message-ID: <6781780e-a01f-a9f4-62fa-c36e105a4b76@metux.net>
References: <1564410372-18506-1-git-send-email-info@metux.net>
 <20190729172313.GA755@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729172313.GA755@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 29.07.19 19:23, Dmitry Torokhov wrote:

Hi,

> I wonder if we should pass &pdev->dev instead of NULL here to form
> proper device hierarchy, now that we have this option.

good point, thanks, fixed in v2.


>> +		"gpio-keys",
>> +		PLATFORM_DEVID_AUTO,
>> +		NULL,
>> +		0,
>> +		gpio_keys_pdata,
>> +		sizeof(*gpio_keys_pdata));
>> +
>> +	if (IS_ERR(pd)) {
>> +		dev_err(&pdev->dev, "failed registering gpio-keys: %ld\n", PTR_ERR(pd));
>>   		goto err_free_mem;
> 
> Since you did not assign 'error' value here this goto will result in the
> function returning 0 even if platform_device_register_resndata() failed.

Uh, thanks. IMHO it's even worse: 'error' could be uninitialized.


I'm sending v2 separately.


Thanks for your review.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
