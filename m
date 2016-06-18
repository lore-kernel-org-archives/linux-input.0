From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] input: pmic8xxx-pwrkey: Add support for
 pm8018 pwrkey
Date: Sat, 18 Jun 2016 09:21:23 -0700
Message-ID: <20160618162123.GA12210@dtor-ws>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-3-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDP6N55ZUYDRBB7KSW5QKGQEQH6PA5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1466158929-19524-3-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Neil,

On Fri, Jun 17, 2016 at 12:22:06PM +0200, Neil Armstrong wrote:
> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
> for the pm8018 pwrkey in pmic8xxx-pwrkey.

Why do we need a new compat string if IP block is compatible with 8921?

> 
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt | 1 +
>  drivers/input/misc/pmic8xxx-pwrkey.c                           | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
> index 588536c..9e530e2 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
> @@ -8,6 +8,7 @@ PROPERTIES
>  	Definition: must be one of:
>  		    "qcom,pm8058-pwrkey"
>  		    "qcom,pm8921-pwrkey"
> +		    "qcom,pm8018-pwrkey"
>  
>  - reg:
>  	Usage: required
> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> index 67aab86..f6f9b87 100644
> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> @@ -446,6 +446,7 @@ static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
> +	{ .compatible = "qcom,pm8018-pwrkey", .data = &pm8921_pwrkey_shutdown },
>  	{ .compatible = "qcom,pm8058-pwrkey", .data = &pm8058_pwrkey_shutdown },
>  	{ .compatible = "qcom,pm8921-pwrkey", .data = &pm8921_pwrkey_shutdown },
>  	{ }
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
