From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/15] iio: adc: at91_adc: Add support for touchscreens without TSMR
Date: Sun, 16 Mar 2014 20:28:54 +0000
Message-ID: <edf12bba-d0b3-4faf-8c0d-371474cbeb3b@email.android.com>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com> <1394040940-18246-5-git-send-email-alexandre.belloni@free-electrons.com> <5325EA96.9000907@kernel.org> <20140316191639.GJ3106@piout.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140316191639.GJ3106-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org



On March 16, 2014 7:16:39 PM GMT+00:00, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>On 16/03/2014 at 18:16:54 +0000, Jonathan Cameron wrote :
>> On 05/03/14 17:35, Alexandre Belloni wrote:
>> >Old ADCs, as present on the sam9rl and the sam9g45 don't have a TSMR
>register
>> >and the touchscreen support should be handled differently.
>> >
>> >Signed-off-by: Alexandre Belloni
><alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> One comment inline about handling of devices where the platform data
>doesn't
>> include the touchscreen type.  I'd expect zero to be the current
>default
>> rather than NONE...
>> >diff --git a/include/linux/platform_data/at91_adc.h
>b/include/linux/platform_data/at91_adc.h
>> >index fcf73879dbfe..7819fc787731 100644
>> >--- a/include/linux/platform_data/at91_adc.h
>> >+++ b/include/linux/platform_data/at91_adc.h
>> >@@ -7,6 +7,12 @@
>> >  #ifndef _AT91_ADC_H_
>> >  #define _AT91_ADC_H_
>> >
>> >+enum atmel_adc_ts_type {
>> This means that the default for existing touch screens (where the
>platform
>> data won't include setting this value) will be none.  Is that
>correct?
>> >+	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
>> >+	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
>> >+	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
>> >+};
>> >+
>
>This is actually just a snippet that I moved from at91_adc.c to
>at91_adc.h. I followed the current behavior.  Until now, using the
>touchscreen was only supported through device tree and touchscreen
>handling was not activated unless the atmel,adc-ts-wires property is
>present.  I guess this is the sane way to go because when you use the
>touchscreen, you lose the triggers.
Ah. Thanks for clearing that up. I missed that it previously existed entirely..

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
