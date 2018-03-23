From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Date: Fri, 23 Mar 2018 12:34:50 -0700
Message-ID: <6928c292-b10b-3056-af02-f1ab70d8f494@codeaurora.org>
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
 <240c6cbc-886f-94c6-cba4-3c4eb3ed0b45@codeaurora.org>
 <20180323192210.GE255819@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323192210.GE255819@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tirupathi Reddy <tirupath@codeaurora.org>, bjorn.andersson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

>>
>>
>> What happens if interrupts comes as soon as you have done the key_init(..)
>> here? I see that you are registering the input device after it, right? Looks
>> like you should do this at the end of probe?
> 
> It should be fine, input devices properly allocated (with
> input_allocate_device() or devm- version) are able to accept events even
> if input device has not been registered yet. It is and advertised
> feature:
> 
> drivers/input/input.c:
> 
> "
>   * input_event() - report new input event
> ...
>   * NOTE: input_event() may be safely used right after input device was
>   * allocated with input_allocate_device(), even before it is registered
>   * with input_register_device(), but the event will not reach any of the
>   * input handlers. Such early invocation of input_event() may be used
>   * to 'seed' initial state of a switch or initial position of absolute
>   * axis, etc.

Thanks. Looks good since input_allocate_device(...) is called before the 
init.

-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
