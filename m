From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 09/12] Input: cros_ec_keyb - Make license text and
 module license match.
Date: Tue, 12 Jun 2018 16:30:34 -0700
Message-ID: <20180612233034.GE38773@dtor-ws>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-10-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606150900.8342-10-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 06, 2018 at 05:08:57PM +0200, Enric Balletbo i Serra wrote:
> The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
> GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
> boiler plate does not match, go for boiler plate license.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied, thank you.

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 79eb29550c34..9dd8c146699f 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -674,6 +674,6 @@ static struct platform_driver cros_ec_keyb_driver = {
>  
>  module_platform_driver(cros_ec_keyb_driver);
>  
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("ChromeOS EC keyboard driver");
>  MODULE_ALIAS("platform:cros-ec-keyb");
> -- 
> 2.17.1
> 

-- 
Dmitry
