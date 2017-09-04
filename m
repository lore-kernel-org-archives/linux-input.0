From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v6 09/12] ASoC: wm9712: add ac97 new bus support
Date: Mon, 04 Sep 2017 15:14:40 +0200
Message-ID: <8760cyppvj.fsf@belgarion.home>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
        <20170902195414.3699-10-robert.jarzmik@free.fr>
        <20170904101849.7uefwhuqz4vtntrp@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904101849.7uefwhuqz4vtntrp@localhost.localdomain> (Charles
        Keepax's message of "Mon, 4 Sep 2017 11:18:49 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> On Sat, Sep 02, 2017 at 09:54:11PM +0200, Robert Jarzmik wrote:
>> Add support for the new ac97 bus model, where devices are automatically
>> discovered on AC-Links.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>> Since v4:
>>  - added #ifdef spotted by Charles
>> ---
>>  	snd_soc_codec_init_regmap(codec, regmap);
>> @@ -666,7 +677,8 @@ static int wm9712_soc_remove(struct snd_soc_codec *codec)
>>  	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
>>  
>>  	snd_soc_codec_exit_regmap(codec);
>> -	snd_soc_free_ac97_codec(wm9712->ac97);
>> +	if (!wm9712->mfd_pdata)
>> +		snd_soc_free_ac97_codec(wm9712->ac97);
>
> This bit is still missing the ifdef it has in the preceeding
> patch.
Damn, you're right, it's missing in both wm9705 and wm9712, but not in wm9713.
That will be for the hopefully last volley of this serie.

Thanks for spotting that.

Cheers.

-- 
Robert
