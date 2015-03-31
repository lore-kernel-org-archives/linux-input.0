From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: Using gpio_keys with regmapped gpio?
Date: Tue, 31 Mar 2015 16:06:11 -0500
Message-ID: <551B0C43.5000101@opensource.altera.com>
References: <551AFC2F.3060300@opensource.altera.com>
 <20150331201739.GA29015@dtor-ws>
Reply-To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150331201739.GA29015@dtor-ws>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org



On 03/31/2015 03:17 PM, Dmitry Torokhov wrote:
> On Tue, Mar 31, 2015 at 02:57:35PM -0500, Thor Thayer wrote:
>> Hi,
>>
>> I have a SPI gpio expander chip that is using the regmap framework.
>> There are some pushbuttons that I'd like to use the gpio_keys
>> framework for but only the first button press creates an input
>> event.
>>
>> It seems like my problem occurs because I'm only getting events on a
>> button press.  The input_get_disposition() function toggles a local
>> copy of the button state [__change_bit(code, dev->key);] in the
>> input.c file. I think this function also needs to be called when the
>> button is released to toggle the dev->key state and re-arm for the
>> next button press.
>
> Yes.
>
>>
>> I tried enabling autorepeat but that causes an infinite loop in the
>> input_repeat_key() function.
>>
>> In both cases, it seems like the button press condition must be
>> cleared when the button is released. This seems like it should be
>> common for all GPIOs so I'm probably missing something.
>
> It sounds like your expander does not generate interrupt when the button
> is released and so gpio-keys driver is not aware of it.
>
> Thanks.
>

Thanks for the quick reply. Is giving an interrupt on both press and 
release a requirement for gpio-keys? or is there another setup that I'm 
not aware of?

How does the gpio-key framework work with register mapped GPIOs that are 
rising-edge or falling-edge triggered? I tend to think of these IRQ 
states as the general case for GPIO.

Thanks


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
