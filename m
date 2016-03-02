From: Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 12/14] keyboard: snvs-pwrkey: use __maybe_unused to hide
 pm functions
Date: Wed, 2 Mar 2016 16:04:46 +0000
Message-ID: <AMSPR04MB263BDF6CE19C8B5432ECAE588BC0@AMSPR04MB263.eurprd04.prod.outlook.com>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-13-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456934350-1389172-13-git-send-email-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Li <Frank.Li@freescale.com>, "b38343@freescale.com" <b38343@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, March 02, 2016 9:59 AM
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org; Arnd Bergmann <arnd@arndb.de>;
> Shawn Guo <shawnguo@kernel.org>; b38343@freescale.com; Javier
> Martinez Canillas <javier@osg.samsung.com>; Frank Li
> <Frank.Li@freescale.com>; linux-input@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 12/14] keyboard: snvs-pwrkey: use __maybe_unused to hide
> pm functions
> 
> The SNVS power key driver has suspend/resume functions that are accessed
> using SIMPLE_DEV_PM_OPS, which hide the reference when
> CONFIG_PM_SLEEP is not set, resulting in a warning about unused functions:
> 
> drivers/input/keyboard/snvs_pwrkey.c:183:12: error:
> 'imx_snvs_pwrkey_suspend' defined but not used [-Werror=unused-function]
> drivers/input/keyboard/snvs_pwrkey.c:194:12: error:
> 'imx_snvs_pwrkey_resume' defined but not used [-Werror=unused-function]
> 
> This adds __maybe_unused annotations to let the compiler know it can
> silently drop the function definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c
> b/drivers/input/keyboard/snvs_pwrkey.c
> index 9adf13a5864a..b0ffadeb208c 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -180,7 +180,7 @@ static int imx_snvs_pwrkey_probe(struct
> platform_device *pdev)
>  	return 0;
>  }
> 
> -static int imx_snvs_pwrkey_suspend(struct device *dev)
> +static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev); @@ -
> 191,7 +191,7 @@ static int imx_snvs_pwrkey_suspend(struct device *dev)
>  	return 0;
>  }
> 
> -static int imx_snvs_pwrkey_resume(struct device *dev)
> +static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> --
> 2.7.0
