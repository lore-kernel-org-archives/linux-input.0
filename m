From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 36/63] Input: atmel_mxt_ts - configure and use gpios as
 real gpios
Date: Fri, 23 Aug 2019 14:16:00 +0900
Message-ID: <eb362fc8-1859-01c7-c419-58684931a31b@mentor.com>
References: <20190816083525.19071-1-jiada_wang@mentor.com>
 <20190816083525.19071-2-jiada_wang@mentor.com>
 <20190816172422.GH121898@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816172422.GH121898@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry

On 2019/08/17 2:24, Dmitry Torokhov wrote:
> On Fri, Aug 16, 2019 at 05:34:58PM +0900, Jiada Wang wrote:
>> From: Kautuk Consul <kautuk_consul@mentor.com>
>>
>> The upstream Atmel mXT driver implementation seems to handle the
>> T19 GPIO/PWM object as a key pad. Keys can be defined in the
>> device tree ("linux,gpio-keymap") and will be transported as key
>> events to the Linux input device if GPIO state changes.
>>
>> With our hardware, the GPIO pins of the touch controller are
>> connected to a PWM/backlight controller and used as supervision
>> inputs. We like to read the status of the pins by a script or an
>> application in the sysfs.
>>
>> Adding newer sysfs entries which shall be placed in the input
>> class directory eg:
>> /sys/class/input/input<n>/backlight_error1
> 
> No, if you want to export GPIO lines for external use create a gpiochip
> instance and register it with GPIO subsystem. No ad-hoc sysfs please.
> 
Agree, I will drop this patch in v2 patch-set

Thanks,
Jiada
> Thanks.
> 
