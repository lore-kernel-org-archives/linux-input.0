From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v6 09/12] ASoC: wm9712: add ac97 new bus
	support
Date: Mon, 4 Sep 2017 11:18:49 +0100
Message-ID: <20170904101849.7uefwhuqz4vtntrp@localhost.localdomain>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
 <20170902195414.3699-10-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170902195414.3699-10-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 02, 2017 at 09:54:11PM +0200, Robert Jarzmik wrote:
> Add support for the new ac97 bus model, where devices are automatically
> discovered on AC-Links.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v4:
>  - added #ifdef spotted by Charles
> ---
>  	snd_soc_codec_init_regmap(codec, regmap);
> @@ -666,7 +677,8 @@ static int wm9712_soc_remove(struct snd_soc_codec *codec)
>  	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
>  
>  	snd_soc_codec_exit_regmap(codec);
> -	snd_soc_free_ac97_codec(wm9712->ac97);
> +	if (!wm9712->mfd_pdata)
> +		snd_soc_free_ac97_codec(wm9712->ac97);

This bit is still missing the ifdef it has in the preceeding
patch.

Otherwise looks good to me.

Thanks,
Charles
