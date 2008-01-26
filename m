From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Sat, 26 Jan 2008 09:58:28 +0000 (UTC)
Message-ID: <fnf084$ju9$1@ger.gmane.org>
References: <20080121152402.GA7518@rakim.wolfsonmicro.main>
	<1200929100-17224-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757009AbYAZJ6w@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,
Mark Brown wrote:

> +#ifdef CONFIG_PM
> +int wm97xx_resume(struct device *dev)
> +{
> +	struct wm97xx *wm = dev_get_drvdata(dev);
> +
> +	/* restore digitiser and gpios */
> +	if (wm->id == WM9713_ID2) {
> +		wm97xx_reg_write(wm, AC97_WM9713_DIG1, wm->dig[0]);
> +		wm97xx_reg_write(wm, 0x5a, wm->misc);
> +		if (wm->ts_use_count) {
> +			u16 reg;
> +			reg = wm97xx_reg_read(wm, AC97_EXTENDED_MID) & 0x7fff;
> +			wm97xx_reg_write(wm, AC97_EXTENDED_MID, reg);
> +		}
> +	}

Won't compile as there is no ts_use_count in struct wm97xx.

-- 
With best wishes
Dmitry
