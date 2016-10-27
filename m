From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/9] Input: wm97xx: split out touchscreen registering
Date: Thu, 27 Oct 2016 10:02:33 +0100
Message-ID: <20161027090233.GF28180@localhost.localdomain>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-8-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1477510907-23495-8-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 26, 2016 at 09:41:45PM +0200, Robert Jarzmik wrote:
> wm97xx-core does several things in it initialization :
>  - touchscreen input device setup
>  - battery device creation
> 
> As the wm97xx is actually a multi-function device handling an audio
> codec, a touchscreen, a gpio block and an ADC, reshape the probing to
> isolate what is truly input/touchscreen specific from the remaining
> part.
> 
> This is only code shuffling, there is no functional change.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/input/touchscreen/wm97xx-core.c | 193 ++++++++++++++++++--------------
>  1 file changed, 112 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> index 83cf11312fd9..50a110e2988b 100644
<snip>
> +static void wm97xx_remove_battery(struct wm97xx *wm)
> +{
> +	platform_device_put(wm->battery_dev);
> +}
<snip>
> @@ -724,10 +757,8 @@ static int wm97xx_remove(struct device *dev)
>  {
>  	struct wm97xx *wm = dev_get_drvdata(dev);
>  
> -	platform_device_unregister(wm->battery_dev);
> -	platform_device_unregister(wm->touch_dev);
> -	input_unregister_device(wm->input_dev);
> -	kfree(wm);
> +	wm97xx_remove_battery(wm);

The commit message says this is just shifting code around but the
platform_device_unregister for the battery_dev seems to have
turned into a platform_device_put here.

Thanks,
Charles
