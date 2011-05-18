From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] pwm: Add stubs for pwm operations
Date: Tue, 17 May 2011 23:45:52 -0700
Message-ID: <20110518064552.GA31801@core.coreip.homeip.net>
References: <1305695926-25855-1-git-send-email-mpallaka@codeaurora.org>
 <1305695926-25855-2-git-send-email-mpallaka@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305695926-25855-2-git-send-email-mpallaka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohan Pallaka <mpallaka@codeaurora.org>
Cc: linux@arm.linux.org.uk, rmk+kernel@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk
List-Id: linux-input@vger.kernel.org

On Wed, May 18, 2011 at 10:48:45AM +0530, Mohan Pallaka wrote:
> Chip drivers that support both pwm and non-pwm modes
> would encounter compilation errors if the platform doesn't
> have support for pwm, even though the chip is programmed
> to work in non-pwm mode. Add stubs for pwm functions to
> avoid compilation errors in these scenarios.
> 
> Signed-off-by: Mohan Pallaka <mpallaka@codeaurora.org>
> ---
>  include/linux/pwm.h |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 7c77575..f0bc51f 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -3,6 +3,7 @@
>  
>  struct pwm_device;
>  
> +#if defined(CONFIG_PWM)

Shouldn't it be CONFIG_HAVE_PWM?

Thanks.

-- 
Dmitry
