From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/5] input: pmic8xxx-pwrkey: Add support for pm8018
 pwrkey
Date: Fri, 24 Jun 2016 15:07:48 -0700
Message-ID: <20160624220748.GB11719@dtor-ws>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-3-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466759887-25394-3-git-send-email-narmstrong@baylibre.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Fri, Jun 24, 2016 at 11:18:04AM +0200, Neil Armstrong wrote:
> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
> for the pm8018 pwrkey in pmic8xxx-pwrkey.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

NAK.

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

-- 
Dmitry
