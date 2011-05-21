From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add stubs for pwm operations
Date: Sat, 21 May 2011 20:00:27 +0530
Message-ID: <4DD7CC83.1020700@codeaurora.org>
References: <1305867584-31929-1-git-send-email-mpallaka@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:36221 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab1EUOac (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 May 2011 10:30:32 -0400
In-Reply-To: <1305867584-31929-1-git-send-email-mpallaka@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohan Pallaka <mpallaka@codeaurora.org>
Cc: dmitry.torokhov@gmail.com, linux@arm.linux.org.uk, rmk+kernel@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk

  On 5/20/2011 10:29 AM, Mohan Pallaka wrote:
> Chip drivers that support both pwm and non-pwm modes
> would encounter compilation errors if the platform doesn't
> have support for pwm, even though the chip is programmed
> to work in non-pwm mode. Add stubs for pwm functions to
> avoid compilation errors in these scenarios.
>
> Signed-off-by: Mohan Pallaka<mpallaka@codeaurora.org>
> ---
>   include/linux/pwm.h |   23 +++++++++++++++++++++++
>   1 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 7c77575..54877f6 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -3,6 +3,7 @@
>
>   struct pwm_device;
>
> +#if defined(CONFIG_HAVE_PWM)
>   /*
>    * pwm_request - request a PWM device
>    */
> @@ -28,4 +29,26 @@ int pwm_enable(struct pwm_device *pwm);
>    */
>   void pwm_disable(struct pwm_device *pwm);
>
> +#else
> +
> +struct pwm_device *pwm_request(int pwm_id, const char *label)
> +{
> +	return NULL;
> +}
> +
> +void pwm_free(struct pwm_device *pwm) { }
> +
> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +{
> +	return -EINVAL;
> +}
> +
> +int pwm_enable(struct pwm_device *pwm)
> +{
> +	return -EINVAL;
> +}
> +
> +void pwm_disable(struct pwm_device *pwm) { }
> +
> +#endif /* CONFIG_HAVE_PWM */
>   #endif /* __LINUX_PWM_H */
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
Hi Russell, please review this patch.

--Mohan
