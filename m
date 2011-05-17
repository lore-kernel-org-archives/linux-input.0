From: Mohan Pallaka <mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/2] pwm: Add __weak attributed functions for pwm	operations
Date: Tue, 17 May 2011 10:12:27 +0530
Message-ID: <4DD1FCB3.8040700@codeaurora.org>
References: <1305290602-29859-1-git-send-email-mpallaka@codeaurora.org> <1305290602-29859-2-git-send-email-mpallaka@codeaurora.org> <20110515080031.GA12911@core.coreip.homeip.net> <20110515105850.GH30539@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110515105850.GH30539-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWNrRvHsEVmBkkB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

  On 5/15/2011 4:28 PM, Russell King - ARM Linux wrote:
> On Sun, May 15, 2011 at 01:00:31AM -0700, Dmitry Torokhov wrote:
>> On Fri, May 13, 2011 at 06:13:21PM +0530, Mohan Pallaka wrote:
>>> For chip drivers that support both pwm and non-pwm modes
>>> would encounter compilation errors if the platform doesn't
>>> have support for pwm though the chip is programmed to work
>>> in non-pwm mode. Add __weak attributed pwm functions to avoid
>>> compilation issues in these scenarios.
>>>
>> Russell,
>>
>> You seem to have authored pwm.h, do you have any objections to this
>> change?
> This seems to be a recipe for an oops.  Have a look at how
> linux/regulator/consumer.h deals with this kind of problem, and notice
> that we have CONFIG_HAVE_PWM to indicate whether this interface is
> supported or not.
Thanks for the suggestion. I'll upload a new patch.

--Mohan.
