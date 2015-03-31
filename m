From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Using gpio_keys with regmapped gpio?
Date: Tue, 31 Mar 2015 14:57:35 -0500
Message-ID: <551AFC2F.3060300@opensource.altera.com>
Reply-To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

I have a SPI gpio expander chip that is using the regmap framework. 
There are some pushbuttons that I'd like to use the gpio_keys framework 
for but only the first button press creates an input event.

It seems like my problem occurs because I'm only getting events on a 
button press.  The input_get_disposition() function toggles a local copy 
of the button state [__change_bit(code, dev->key);] in the input.c file. 
I think this function also needs to be called when the button is 
released to toggle the dev->key state and re-arm for the next button press.

I tried enabling autorepeat but that causes an infinite loop in the 
input_repeat_key() function.

In both cases, it seems like the button press condition must be cleared 
when the button is released. This seems like it should be common for all 
GPIOs so I'm probably missing something.

Which brings up my next question. Can the gpio_keys framework be used 
with a regmapped gpio? I haven't been able to find any examples of 
gpio_keys with an external gpio expander and maybe this isn't valid usage.

Thanks,

Thor


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
