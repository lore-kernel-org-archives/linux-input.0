From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2] cap11xx: add LED support
Date: Thu, 11 Jun 2015 08:55:36 +0200
Message-ID: <557930E8.3020408@samsung.com>
References: <1433920083-31869-1-git-send-email-mranostay@gmail.com>
 <5577EF58.60706@samsung.com>
 <CAKzfze_+XEQB5VTiH6BcyU297OnEWc3JK0m2hLuVsqhykCfPAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <CAKzfze_+XEQB5VTiH6BcyU297OnEWc3JK0m2hLuVsqhykCfPAw@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 06/11/2015 12:07 AM, Matt Ranostay wrote:
[...]
>>>    static const struct cap11xx_hw_model cap11xx_devices[] = {
>>> -       [CAP1106] = { .product_id = 0x55, .num_channels = 6 },
>>> -       [CAP1126] = { .product_id = 0x53, .num_channels = 6 },
>>> -       [CAP1188] = { .product_id = 0x50, .num_channels = 8 },
>>> +       [CAP1106] = { .product_id = 0x55, .num_channels = 6, .num_leds = 0
>>> },
>>> +       [CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2
>>> },
>>> +       [CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8
>>> },
>>>    };
>>
>>
>> The number of LEDs should be determined by the number of DT child nodes
>> representing each LED. Please refer to
>> Documentation/devicetree/bindings/leds/common.txt and other LED
>> subsystem drivers to find out how it should be implemented.
>>
> Ok but this is still needed as a check so you don't "overflow" the
> number the chipset supports, correct?

Right, the above modification is correct then.

-- 
Best Regards,
Jacek Anaszewski
