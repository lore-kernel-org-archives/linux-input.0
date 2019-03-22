From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [RESEND PATCH v6 09/11] leds: max77650: add LEDs support
Date: Fri, 22 Mar 2019 20:40:44 +0100
Message-ID: <f2963c2e-b4d0-1fae-3c7f-28fcdb545ee2@gmail.com>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-10-brgl@bgdev.pl> <20190322092124.GK27015@amd>
 <CAMRc=Mf1DxF1e63y+HsXtCFxZW8R0XWDLUXGy+4cp3zBS0_qhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=Mf1DxF1e63y+HsXtCFxZW8R0XWDLUXGy+4cp3zBS0_qhw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On 3/22/19 10:53 AM, Bartosz Golaszewski wrote:
> pt., 22 mar 2019 o 10:21 Pavel Machek <pavel@ucw.cz> napisał(a):
>>
>> On Mon 2019-03-18 18:42:26, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This adds basic support for LEDs for the max77650 PMIC. The device has
>>> three current sinks for driving LEDs.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>
>>> +             label = of_get_property(child, "label", NULL);
>>> +             if (!label) {
>>> +                     led->cdev.name = "max77650::";
>>> +             } else {
>>> +                     led->cdev.name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                                                     "max77650:%s", label);
>>> +                     if (!led->cdev.name)
>>> +                             return -ENOMEM;
>>> +             }
>>
>> I'd rather not have the "max77650:" prefix in the LED name (as it is
>> useless).
>>
> 
> I was instructed to do so by the LED subsystem maintainer.

Yes, let's keep things consistent, we will convert it to use generic
support for LED naming once that support is merged.

-- 
Best regards,
Jacek Anaszewski
