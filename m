From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: mpu3050: add of_match table for device-tree probing
Date: Fri, 23 Dec 2011 01:22:46 -0800
Message-ID: <20111223092246.GA7120@core.coreip.homeip.net>
References: <1324607992-2919-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1324607992-2919-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Olof,

On Thu, Dec 22, 2011 at 06:39:52PM -0800, Olof Johansson wrote:
> Adding invn,mpu3050 as the initial id.
> 

I believe you also need to add this to
Documentation/devicetree/bindings/input/

Thanks!

> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> ---
>  drivers/input/misc/mpu3050.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
> index f71dc72..e9a57e3 100644
> --- a/drivers/input/misc/mpu3050.c
> +++ b/drivers/input/misc/mpu3050.c
> @@ -348,11 +348,18 @@ static const struct i2c_device_id mpu3050_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mpu3050_ids);
>  
> +static const struct of_device_id mpu3050_of_match[] = {
> +	{ .compatible = "invn,mpu3050", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mpu3050_of_match);
> +
>  static struct i2c_driver mpu3050_i2c_driver = {
>  	.driver	= {
>  		.name	= "mpu3050",
>  		.owner	= THIS_MODULE,
>  		.pm	= &mpu3050_pm,
> +		.of_match_table = mpu3050_of_match,
>  	},
>  	.probe		= mpu3050_probe,
>  	.remove		= __devexit_p(mpu3050_remove),
> -- 
> 1.7.8.GIT
> 

-- 
Dmitry
