From: Mohan Pallaka <mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/2] pwm: Add stubs for pwm operations
Date: Thu, 26 May 2011 17:01:13 +0530
Message-ID: <4DDE3A01.7010100@codeaurora.org>
References: <1305867584-31929-1-git-send-email-mpallaka@codeaurora.org> <4DD7CC83.1020700@codeaurora.org> <4DDB90D9.1020902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DDB90D9.1020902-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mohan Pallaka <mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

  Hi Russell, please let me know if this patch looks okay for you.

Thanks, Mohan.

On 5/24/2011 4:34 PM, Mohan Pallaka wrote:
>  Ping.
>
> Hi Russell, please take sometime to review this patch.
>
> Thanks, Mohan.
>
> On 5/21/2011 8:00 PM, Mohan Pallaka wrote:
>>  On 5/20/2011 10:29 AM, Mohan Pallaka wrote:
>>> Chip drivers that support both pwm and non-pwm modes
>>> would encounter compilation errors if the platform doesn't
>>> have support for pwm, even though the chip is programmed
>>> to work in non-pwm mode. Add stubs for pwm functions to
>>> avoid compilation errors in these scenarios.
>>>
>>> Signed-off-by: Mohan Pallaka<mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>   include/linux/pwm.h |   23 +++++++++++++++++++++++
>>>   1 files changed, 23 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>>> index 7c77575..54877f6 100644
>>> --- a/include/linux/pwm.h
>>> +++ b/include/linux/pwm.h
>>> @@ -3,6 +3,7 @@
>>>
>>>   struct pwm_device;
>>>
>>> +#if defined(CONFIG_HAVE_PWM)
>>>   /*
>>>    * pwm_request - request a PWM device
>>>    */
>>> @@ -28,4 +29,26 @@ int pwm_enable(struct pwm_device *pwm);
>>>    */
>>>   void pwm_disable(struct pwm_device *pwm);
>>>
>>> +#else
>>> +
>>> +struct pwm_device *pwm_request(int pwm_id, const char *label)
>>> +{
>>> +    return NULL;
>>> +}
>>> +
>>> +void pwm_free(struct pwm_device *pwm) { }
>>> +
>>> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>>> +{
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +int pwm_enable(struct pwm_device *pwm)
>>> +{
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +void pwm_disable(struct pwm_device *pwm) { }
>>> +
>>> +#endif /* CONFIG_HAVE_PWM */
>>>   #endif /* __LINUX_PWM_H */
>>> -- 
>>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>> Forum.
>> Hi Russell, please review this patch.
>>
>> --Mohan
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-arm-msm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
