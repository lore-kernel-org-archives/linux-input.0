From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 09/12] ASoC: wm9712: add ac97 new bus support
Date: Tue, 25 Jul 2017 11:20:57 +0100
Message-ID: <20170725102057.hblyopxycgz55mr7@localhost.localdomain>
References: <20170724204928.29505-1-robert.jarzmik@free.fr>
 <20170724204928.29505-10-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170724204928.29505-10-robert.jarzmik@free.fr>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 24, 2017 at 10:49:25PM +0200, Robert Jarzmik wrote:
> Add support for the new ac97 bus model, where devices are automatically
> discovered on AC-Links.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> +	} else {
> +		wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
> +						      WM9712_VENDOR_ID_MASK);
> +		if (IS_ERR(wm9712->ac97)) {
> +			ret = PTR_ERR(wm9712->ac97);
> +			dev_err(codec->dev,
> +				"Failed to register AC97 codec: %d\n", ret);
> +			return ret;
> +		}
> +
> +		regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
> +		if (IS_ERR(regmap)) {
> +			ret = PTR_ERR(regmap);
> +			goto err_free_ac97_codec;

For the 9713 you had this wrapped in an ifdef? Why did it need an
ifdef there but doesn't for this driver?

Thanks,
Charles
